<?php

namespace App\Controller;

use App\Model\ItemManager;
use App\Model\RegionManager;
use App\Model\CategoryManager;

class HomeController extends AbstractController
{
    /**
     * Display home page
     */
    public function index(): string
    {
        $categoryManager = new categoryManager();
        $categories = $categoryManager->selectAll();
        return $this->twig->render('Home/index.html.twig', ["categories" => $categories]);
    }

    public function addItem(): string
    {
        $errors = [];
        $categoryManager = new categoryManager();
        $categories = $categoryManager->selectAll();
        $regionManager = new RegionManager();

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $item = array_map('trim', $_POST);
            $item = array_map('htmlentities', $item);
            $itemManager = new ItemManager();

            if (empty($errors)) {
                $this->validateFile($errors, $item);
                if (empty($errors)) {
                    $itemManager->addItem($item);
                    header('Location: /validation');
                }
            }
        }
        return $this->twig->render('Home/add_item.html.twig', [
            'regions' => $regionManager->selectAll(),
            'categories' => $categories,
            'errors' => $errors,
        ]);
    }


    public function itemDetails()
    {
        $itemManager = new ItemManager;
        return $this->twig->render('Home/item_details.html.twig', [
            'item' => $itemManager->selectOneById(1)
        ]);
    }

    private function validateFile(array &$errors, array &$item): void
    {
        if (isset($_FILES['file'])) {
            $tmpName = $_FILES['file']['tmp_name'];
            $name = $_FILES['file']['name'];
            $size = $_FILES['file']['size'];

            $uploadDir = '/../../public/uploads/';
            $extension = pathinfo($name, PATHINFO_EXTENSION);
            $fileName = pathinfo($name, PATHINFO_FILENAME) . '-' . uniqid() . "." . $extension;
            $uploadFile = $uploadDir . $fileName;
            $authorizedExtensions = ['jpg', 'gif', 'png', 'webp'];
            $maxFileSize = 5000000;

            if ((!in_array($extension, $authorizedExtensions))) {
                $errors['file_extension'] = 'Veuillez sélectionner une image de type JPG, PNG, GIF ou WEBP';
            }

            if (file_exists($tmpName) && filesize($tmpName) > $maxFileSize) {
                $errors[$size] = "Veuillez choisir un fichier de moins de 5Mo !";
            }
            if (empty($errors)) {
                if (move_uploaded_file($tmpName, __DIR__ . $uploadFile)) {
                    $item['file'] = $fileName;
                }
            }
        }
    }

    public function validation(): string
    {
        return $this->twig->render('Home/validation.html.twig');
    }
}
