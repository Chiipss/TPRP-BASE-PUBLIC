USE `essentialmode`;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('boating', 'Boating License')
;

CREATE TABLE `boat_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `boat_categories` (name, label) VALUES
	('boat','Boats'),
	('subs','Submersibles')
;

CREATE TABLE `boats` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,
	PRIMARY KEY (`model`)
);

INSERT INTO `boats` (name, model, price, category) VALUES
	('Dinghy 4Seat', 'dinghy', 25000, 'boat'),
	('Dinghy 2Seat', 'dinghy2', 20000, 'boat'),
	('Dinghy Yacht', 'dinghy4', 25000, 'boat'),
	('Jetmax', 'jetmax', 38000, 'boat'),
	('Marquis', 'marquis', 64000, 'boat'),
	('Seashark', 'seashark', 10000, 'boat'),
	('Seashark Yacht', 'seashark3', 10000, 'boat'),
	('Speeder', 'speeder', 40000, 'boat'),
	('Squalo', 'squalo', 32000, 'boat'),
	('Suntrap', 'suntrap', 16000, 'boat'),
	('Toro', 'toro', 75000, 'boat'),
	('Toro Yacht', 'toro2', 81000, 'boat'),
	('Tropic', 'tropic', 27000, 'boat'),
	('Tropic Yacht', 'tropic2', 30000, 'boat'),
	('Kraken', 'submersible2', 760000, 'subs'),
	('Submarine', 'submersible', 395000, 'subs')
;
