dnaDoormanager version 1.0
Coded By Darklandz

This resource is part of my own custom framework, but can be easyly adapted for your needs.

A big thanks to the user wpgn for teaching me some of the server side stuff.



MySql DataBase Table that stores the status of doors (locked or unlocked)

CREATE TABLE IF NOT EXISTS `city_doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locked` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

id = the door id
locked = if 1 the door is locked / 0 is unlocked


You can add more doors/gates, to find the object names use the tool called codewalker.

