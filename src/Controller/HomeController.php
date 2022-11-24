<?php

namespace App\Controller;

use App\Model\CategoryManager;

class HomeController extends AbstractController
{
    /**
     * Display home page
     */
    public function index(): string
    {
        $catergoryManager = new categoryManager();
        $categories = $catergoryManager->selectAll();
        return $this->twig->render('Home/index.html.twig', ["categories" => $categories]);
    }
}
