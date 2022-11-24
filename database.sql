CREATE TABLE `user` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pseudo` VARCHAR(45) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    UNIQUE KEY (`pseudo`)
);

INSERT INTO user (`id`, `pseudo`, `password`)
VALUES ('1', 'Nem', 'mdp'),
('2', 'Meg', 'mdp'),
('3', 'Axou', 'mdp'),
('4', 'Nico', 'mdp');


CREATE TABLE `item` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(255),
  `postcode` INT,
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
VALUES ('1', 'Les plus moches', 'mdp'),
('2', 'Les plus sales', 'mdp'),
('3', 'Les pire accueils', 'mdp'),
('4', 'Les plus bruyants', 'mdp'),
('5', 'Les pires spécialités', 'mdp'),
('6', 'Les pires traditions', 'mdp');


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
