<?php

namespace App\Controller;

use App\Model\ItemManager;
use App\Model\RegionManager;

class HomeController extends AbstractController
{
    /**
     * Display home page
     */
    public function index(): string
    {
        return $this->twig->render('Home/index.html.twig');
    }

    public function addItem(): string
    {
        $errors = [];
        $regionManager = new RegionManager();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $item = array_map('trim', $_POST);
            $item = array_map('htmlentities', $item);
            $itemManager = new ItemManager();
            $itemManager->addItem($_POST);
            header('Location: /validation');
        }
        return $this->twig->render('Home/add_item.html.twig', [
            'regions' => $regionManager->selectAll(),
            'errors' => $errors
        ]);
    }

    public function validation(): string
    {
        return $this->twig->render('Home/validation.html.twig');
    }
}
