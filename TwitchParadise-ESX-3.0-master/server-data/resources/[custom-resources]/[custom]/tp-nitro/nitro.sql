CREATE TABLE `nitro_vehicles` (
	`plate` varchar(50) NOT NULL,
    `amount` int(11) NOT NULL DEFAULT 100,
	PRIMARY KEY (`plate`)
);

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES 
('nitrocannister', 'NOS', 1, 0, 1),
('wrench', 'Wrench', 1, 0, 1)
;