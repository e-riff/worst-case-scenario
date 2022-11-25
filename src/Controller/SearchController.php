<?php

namespace App\Controller;

use App\Model\SearchManager;

class SearchController extends AbstractController
{
    public function getResearch($research)
    {
        $searchManager = new SearchManager();
        $searchResults = htmlentities(trim($research));
        $searchResults = $searchManager->searchEngine($research);
        return $this->twig->render('Include/index.html.twig', [
            'searchResults' => $searchResults
        ]);
    }
}
