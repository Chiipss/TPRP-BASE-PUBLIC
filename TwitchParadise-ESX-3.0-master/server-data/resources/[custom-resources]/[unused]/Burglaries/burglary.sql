CREATE TABLE `player_burglaries` (
	`identifier` varchar(50) NOT NULL,
    `burglaries` longtext COLLATE utf8mb4_bin NOT NULL,
	PRIMARY KEY (`identifier`)
);

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('watch', 'Watch', -1, 0, 1),
	('rose', 'Rose', 10, 0, 1, 0),
    ('umbrella', 'Umbrella', 10, 0, 1),
    ('ring', 'Ring', -1, 0, 1)
;