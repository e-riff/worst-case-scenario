const unicorn = document.querySelectorAll("a[data-item]");

for (link of unicorn) {
    link.addEventListener('click', function (event) {
        event.preventDefault();
        event.stopPropagation();
        ajaxRequest(event.target.dataset.item, event.target.dataset.val);
    })
}

function ajaxRequest(itemId, newLikeValue) {
    url = `/likeOrDislike?itemId=${itemId}&newLikeValue=${newLikeValue}`;
    console.log(url);
    fetch(url)
        .then(function (response) {
            return response.json()
        })
        .then(function (json) {
            console.log(json)
            /*const images = document.querySelectorAll("a[data-add-to-fav='" + serieId + "'] > img")
            for (image of images) {
                        if (json.action === 'added') {
                            image.setAttribute("src", "/assets/images/fav.svg");
                        }
                        if (json.action === 'deleted') {
                            image.setAttribute("src", "/assets/images/not_fav.svg");
                        }
                    } */
        })
}
