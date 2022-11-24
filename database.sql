CREATE TABLE `user` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pseudo` VARCHAR(45) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    UNIQUE KEY (`pseudo`)
);

INSERT INTO `user` (`id`, `pseudo`, `password`)
VALUES ('1', 'Nem', 'mdp'),
('2', 'Meg', 'mdp'),
('3', 'Axou', 'mdp'),
('4', 'Nico', 'mdp');


CREATE TABLE `item` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `adresse` VARCHAR(255),
  `zip_code` VARCHAR(255),
  `region` VARCHAR(10),
  `image` VARCHAR(255),
  `description` LONGTEXT,
  `creator` INT,
    CONSTRAINT fk_user_item FOREIGN KEY (creator) REFERENCES user(id)
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
