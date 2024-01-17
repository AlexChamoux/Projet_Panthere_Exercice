<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\UserService;




class ServiceController extends AbstractController
{
    #[Route('/service', name: 'app_service')]
    public function index(): JsonResponse
    {
        return $this->json([
            'message' => 'Welcome to your new controller!',
            'path' => 'src/Controller/ServiceController.php',
        ]);
    }

    #[Route('/service/create', name: 'app_service_create')]
    public function createAction(EntityManagerInterface $em)
    {
        $user = new UserService();
        $user->setNom('Sophie');
        $user->setAge('55');

        $em->persist($user);
        $em->flush();

        return $this->json([
            'message' => 'New user',
            'value' => $user->getNom()
        ]);
    }

    #[Route('/service/search', name: 'app_service_search')]
    public function searchAction(EntityManagerInterface $em)
    {   
        $repo = $em->getRepository(UserService::class);
        // $users = $repo->findBy(['nom' => 'Sophie']);
        // $users = $repo->findOneBy(['nom' => 'Sophie']);
        $users = $repo->find('1');
        // $users = $repo->findAll();

        return $this->json([
            'message' => 'Repository',
            'value' => $users
        ]);
    }
}