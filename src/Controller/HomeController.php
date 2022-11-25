<?php

namespace App\Controller;

use App\Model\ItemManager;
use App\Model\RegionManager;
use App\Model\CategoryManager;
use App\Model\UserManager;
use App\Model\AddOrDislikeManager;

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

        $likeController = new AddOrDislikeManager();
        $items = $likeController->sumLike($items);
        return $this->twig->render(
            'Home/index.html.twig',
            ["categories" => $categories, "items" => $items]
        );
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

            $this->validateByField($item, 'title', 'titre', $errors);
            $this->validateByField($item, 'region', 'region', $errors);
            $this->validateByField($item, 'address', 'adresse', $errors);
            $this->validateByField($item, 'postcode', 'code postal', $errors);
            $this->validateByField($item, 'description', 'description', $errors);
            $this->validateByField($item, 'category', 'catégorie', $errors);

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
        $itemManager = new ItemManager();
        return $this->twig->render('Home/item_details.html.twig', [
            'item' => $itemManager->selectOneById($_GET['id'])
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

    private function validateByField(
        array $item,
        string $field,
        string $filedName,
        array &$errors,
    ): void {
        if (empty($item[$field])) {
            $errors[$field] = 'Le champ ' . $filedName . ' est obligatoire.';
        }
    }

    public function validation(): string
    {
        return $this->twig->render('Home/validation.html.twig');
    }
}
