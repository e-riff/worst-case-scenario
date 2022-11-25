<?php

namespace App\Controller;

use App\Model\ItemManager;
use App\Model\RegionManager;
use App\Model\CategoryManager;
use App\Model\UserManager;

class HomeController extends AbstractController
{
    /**
     * Display home page
     */
    public function index(): string
    {
        $catergoryManager = new CategoryManager();
        $categories = $catergoryManager->selectAll();
        $itemManager = new ItemManager();
        $items = $itemManager->selectAllWithLike();
        return $this->twig->render('Home/index.html.twig', ["categories" => $categories, "items" => $items]);
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

    public function login()
    {
        if ($_SERVER["REQUEST_METHOD"] === 'POST') {
            $userLog = array_map('trim', $_POST);
            $userLog = array_map('htmlentities', $userLog);

            $userManager = new UserManager();

            $userCheck = $userManager->selectByOneByPseudo($userLog['pseudo']);
            if ($userCheck && password_verify($userLog['password'], $userCheck['password'])) {
                $_SESSION['user_id'] = $userCheck['id'];
                header('Location: /');
            }
        }
    }

    public function validation(): string
    {
        return $this->twig->render('Home/validation.html.twig');
    }
}
