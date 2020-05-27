CREATE TABLE `masks` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`owner` VARCHAR(255),
	`name` VARCHAR(55),
	`data` LONGTEXT,

	PRIMARY KEY (`id`)
);

CREATE TABLE `bags` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`owner` VARCHAR(255),
	`name` VARCHAR(55),
	`data` LONGTEXT,

	PRIMARY KEY (`id`)
);

CREATE TABLE `helmets` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`owner` VARCHAR(255),
	`name` VARCHAR(55),
	`data` LONGTEXT,

	PRIMARY KEY (`id`)
);

CREATE TABLE `glasses` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`owner` VARCHAR(255),
	`name` VARCHAR(55),
	`data` LONGTEXT,

	PRIMARY KEY (`id`)
);

CREATE TABLE `ears` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`owner` VARCHAR(255),
	`name` VARCHAR(55),
	`data` LONGTEXT,

	PRIMARY KEY (`id`)
);