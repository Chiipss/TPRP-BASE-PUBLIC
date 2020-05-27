CREATE TABLE IF NOT EXISTS `dopeplants` (
  `owner` varchar(50) NOT NULL,
  `plant` longtext NOT NULL,
  `plantid` bigint(20) NOT NULL
);


INSERT INTO `items` (`name`,`label`,`limit`,`rare`,`can_remove`,`price`) VALUES
	('highgradefemaleseed', '(HG) Female Seed', -1, 0 ,1 , 0),
	('lowgradefemaleseed', '(LG) Female Seed', -1, 0 ,1 , 0),
	('highgrademaleseed', '(HG) Male Seed', -1, 0 ,1 , 0),
	('lowgrademaleseed', '(LG) Male Seed', -1, 0 ,1 , 0),
	('highgradefert', 'High-Grade Fertilizer', -1, 0 ,1 , 0),
	('lowgradefert', 'Low-Grade Fertilizer', -1, 0 ,1 , 0),
	('purifiedwater', 'Purified Water', -1, 0 ,1 , 0),
	('wateringcan', 'Watering Can', -1, 0 ,1 , 0),
	('plantpot', 'Plant Pot', -1, 0 ,1 , 0),
	('trimmedweed', 'Trimmed Weed', -1, 0 ,1 , 0),
	('dopebag', 'Ziplock Bag', -1, 0 ,1 , 0),
	('bagofdope', 'Bag of Dope', -1, 0 ,1 , 0),
	('drugscales', 'Scales', -1, 0 ,1 , 0);
