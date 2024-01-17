<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\TeamRepository;
use App\Entity\Team;
use Doctrine\ORM\EntityManagerInterface;

class DefaultController extends AbstractController
{
    private $em;

    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    #[Route('/default', name: 'app_default')]
    public function index(TeamRepository $teamRepository): Response
    {
        $this->updateEmployeeHierarchy();

        $employees = $teamRepository->findBy(['Status' => 1]);

        $organigram = $this->buildOrganigram($employees, null);

        return $this->render('default/index.html.twig', [
            'message' => 'Voici mon site en symfony',
            'team' => $teamRepository->findBy([], ['id' => 'asc']),
            'organigram' => $organigram,
        ]);
    }

    private function buildOrganigram(array $employees, ?int $parentId, string $pathPrefix = ''): array
    {
        $organigram = [];

        foreach ($employees as $employee) {

            if ($employee->getParentId() === $parentId) {
                $path = $pathPrefix . ($pathPrefix !== '' ? ':' : '') . $employee->getId();
                $subordinates = $this->buildOrganigram($employees, $employee->getId());
                $positions = [];

                $employee->setPath($path);
    
                foreach ($employee->getPositions() as $position) {
                    $positions[] = $position->getLabel();
                }
                $employeeData = [
                    'id' => $employee->getId(),
                    'firstname' => $employee->getFirstname(),
                    'lastname' => $employee->getLastname(),
                    'positions' => $positions,
                    'subordinates' => $subordinates,
                    'photo' => $employee->getPhoto(),
                ];
                $organigram[] = $employeeData;
            }
        }

        return $organigram;
    }

    #[Route('/employee/{id}', name: 'employee_details')]
    public function employeeDetails(int $id, TeamRepository $teamRepository): Response
    {
        $employee = $teamRepository->find($id);

        if (!$employee) {
            throw $this->createNotFoundException('Employé non trouvé');
        }

        return $this->render('default/employee_details.html.twig', [
            'employee' => $employee,
        ]);
    }

    private function updateEmployeeHierarchy()
{
    $teamRepository = $this->em->getRepository(Team::class);
    $exitingEmployees = $teamRepository->findBy(['Status' => 2]);

    foreach ($exitingEmployees as $exitingEmployee) {
        $exitingEmployee->setStatus(0);
        $this->updateSubordinates($teamRepository, $exitingEmployee->getId(), $exitingEmployee->getParentId());
    }

    $this->em->flush();
}

private function updateSubordinates(TeamRepository $teamRepository, $parentId, $newParentId)
{
    $subordinateEmployees = $teamRepository->findBy(['parent_id' => $parentId]);

    foreach ($subordinateEmployees as $subordinateEmployee) {
        // Update the parent ID for subordinates
        $subordinateEmployee->setParentId($newParentId);

        // Update the path for subordinates
        $parentEmployee = $teamRepository->find($newParentId);
        $newPath = $parentEmployee->getPath() . ':' . $subordinateEmployee->getId();
        $subordinateEmployee->setPath($newPath);

        // Recurse for further subordinates
        $this->updateSubordinates($teamRepository, $subordinateEmployee->getId(), $subordinateEmployee->getId());
    }
}

}


