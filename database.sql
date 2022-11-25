CREATE TABLE `user` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pseudo` VARCHAR(45) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    UNIQUE KEY (`pseudo`)
);

INSERT INTO user (`id`, `pseudo`, `password`)
VALUES ('1', 'Nem', '$2y$10$Hd6KPuyV9B68VhL.ZSslWuYELv20Fe8NR0HUwzOkNJAFq0spg9lwi'),
('2', 'Meg', '$2y$10$Hd6KPuyV9B68VhL.ZSslWuYELv20Fe8NR0HUwzOkNJAFq0spg9lwi'),
('3', 'Axou', '$2y$10$Hd6KPuyV9B68VhL.ZSslWuYELv20Fe8NR0HUwzOkNJAFq0spg9lwi'),
('4', 'Nico', '$2y$10$Hd6KPuyV9B68VhL.ZSslWuYELv20Fe8NR0HUwzOkNJAFq0spg9lwi');


CREATE TABLE `item` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(255),
  `postcode` CHAR(15),
  `region_id` INT,
  `image` VARCHAR(255),
  `description` TEXT,
  `user_id` INT,
    CONSTRAINT fk_user_item FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE `like_or_dislike` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `good_or_bad` INT NOT NULL,
  CONSTRAINT fk_user_has_item1 FOREIGN KEY (user_id) REFERENCES user(id),
  CONSTRAINT fk_user_has_item2 FOREIGN KEY (item_id) REFERENCES item(id)
);


CREATE TABLE `review` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date` INT NOT NULL,
  `user_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  CONSTRAINT fk_user_review1 FOREIGN KEY (user_id) REFERENCES user(id),
  CONSTRAINT fk_user_review2 FOREIGN KEY (item_id) REFERENCES item(id)
);


CREATE TABLE `category` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(45) NOT NULL,
    `image` VARCHAR(255) NOT NULL
);

INSERT INTO `category` (`id`, `name`, `image`)
VALUES ('1', 'Les plus moches', ''),
('2', 'Les plus sales', ''),
('3', 'Les pires accueils', ''),
('4', 'Les plus bruyants', ''),
('5', 'Les pires spécialités', ''),
('6', 'Les pires traditions', '');


CREATE TABLE `item_category` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `item_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  CONSTRAINT fk_item_category1 FOREIGN KEY (item_id) REFERENCES item(id),
  CONSTRAINT fk_item_category2 FOREIGN KEY (category_id) REFERENCES category(id)
);

-- TABLE REGION
CREATE TABLE `region` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(60) NOT NULL
);

INSERT INTO region
VALUES (1, 'Auvergne-Rhône-Alpes'),
       (2, 'Bourgogne-Franche-Comté'),
       (3, 'Bretagne'),
       (4, 'Centre-Val de Loire'),
       (5, 'Corse'),
       (6, 'Grand Est'),
       (7, 'Hauts-de-France'),
       (8, 'Ile-de-France'),
       (9, 'Normandie'),
       (10, 'Nouvelle-Aquitaine'),
       (11, 'Occitanie'),
       (12, 'Pays de la Loire'),
       (13, "Provence-Alpes-Côte d'Azur");

INSERT INTO `item` (`id`, `name`, `address`, `postcode`, `image`, `description`)
VALUES
(1, 'Montalieu-Vercieu', 'Isère', '38390', 'montalieu.jpg', "En novembre 2021, le village de Montalieu-Vercieu, dans l'Isère, a été distingué par l'association Paysages de France par le Prix de la France moche, et a donc été classé parmi les villages les plus laids de l'Hexagone."),
(2, "L'espace Méditerranée de Perpignan", 'Perpignan', '66000', 'espace-perpignan.jpg', "Comme un ovni qui se serait posé là par hasard, on se demande vraiment ce que fabrique cette grosse boule rouge au milieu de palmiers et de cactus… Petit conseil à nos amis perpignanais : soyez prêts à recevoir les Aliens, il voudront récupérer leur truc un jour ou l’autre…"),
(3, 'Paris', 'Ile-de-France', '75000', 'paris.jpg', "La propreté ou plutôt la saleté est un vrai problème à Paris. En cinquante la poubelle des ménages a doublé de volume ! De plus, malgré les efforts des agents de la ville, les rues sont de vrais dépotoirs dans certains quartiers. Les poubelles s'entassent, les rats se baladent tranquillement. Les odeurs d’urine dans la capitale sont fréquentes et pourtant il n’est pas si compliqué de trouver des toilettes dans Paris."),
(4, 'Marseille', "Provence-Alpes-Côte d'Azur", '13000', 'marseille.jpeg', "Les habitants de Marseille ne sont pas réputés pour être des personnes qui respectent beaucoup l’environnement. Pour preuve, ils ignorent systématiquement la présence des poubelles dans leur ville. Cette culture est tellement ancrée en eux qu’ils sont capables de déposer leur ordure juste à côté d’une poubelle."),
(5, 'La Corse', '', '2A et 2B', 'corse.webp', "Les Corses aiment garder pour eux leur Île de Beauté, et on comprend bien pourquoi d’ailleurs. Du coup, l’accueil réservé aux Continentaux n’est pas toujours le plus aimable. Un peu glacial même voire carrément chambreur."),
(6, 'La Bretagne', '', '36110', 'bretagne.jpg', "Parmi toutes les régions de France, la Bretagne paraît austère de prime abord.  Le premier contact est souvent difficile avec un Breton, surtout pour les gars du Sud.  On lui tape pas sur l’épaule comme ça au Breton, on lui claque pas la bise non plus d’entrée. C’est bien connu, l’amitié d’un Breton, ça se mérite !"),
(7, 'La rue Gabriel-Péri', 'Toulouse', '31000', 'toulouse.jpg', "La rue Gabriel-Péri c'est un peu Docteur Jekyll et Mister Hyde, elle a un double visage. Avec une concentration massive d'établissements qui proposent souvent des boissons alcoolisées bon marché, elle attire une clientèle jeune, étudiante bien souvent, avide de fête et de consommations à petits prix. C'est la porte ouverte à toutes les dérives."),
(8, 'Batignolles', 'Paris', '75017', 'batignolles.jpg', "Cela peut sembler contre-intuitif mais du fait de la réverbération du bruit sur les façades, les étages élevés ne sont pas les plus calmes et Batignolles en paie les frais avec pas moins de 55,7 dB de nuisances sonores."),
(9, 'La tartine de camembert au café', 'Normandie', '', 'normandie.jpg', "La tartine de camembert trempée dans le café au petit dej demeure un mystère pour la plupart des papilles. Notons que la Normandie s’illustre déjà au palmarès des spécialités culinaires peu ragoûtantes avec les tripes à la mode de Caen. La petite particularité du camembert dans le café, c’est qu’il a fait l’objet de la création d’une véritable confrérie."),
(10, 'La sanguette de canard', 'Nouvelle-Aquitaine', '', 'nouvelle-aquitaine.webp', "Le Périgord nous a habitués à des plats de grande classe, surtout avec du canard. Foie gras, magrets… mais la sanguette est un peu l’exception qui confirme la règle. Qu’est-ce donc que cette diablerie ? Une galette de sang de canard coagulé cuite avec de l’ail, du persil et du lard.");
