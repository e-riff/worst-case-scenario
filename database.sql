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
  `postcode` INT,
  `region_id` INT,
  `category_id`INT,
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


-- CREATE TABLE `item_category` (
--   `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--   `item_id` INT NOT NULL,
--   `category_id` INT NOT NULL,
--   CONSTRAINT fk_item_category1 FOREIGN KEY (item_id) REFERENCES item(id),
--   CONSTRAINT fk_item_category2 FOREIGN KEY (category_id) REFERENCES category(id)
-- );

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
(2, "L'espace Méditerranée de Perpignan", 'Perpignan', '66000', 'espace-perpignan.jpg', "Comme un ovni qui se serait posé là par hasard, on se demande vraiment ce que fabrique cette grosse boule rouge au milieu de palmiers et de cactus… Petit conseil à nos amis perpignanais : soyez prêts à recevoir les Aliens, il voudront récupérer leur truc un jour ou l’autre…");
