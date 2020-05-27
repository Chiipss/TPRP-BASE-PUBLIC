ALTER TABLE `owned_vehicles`
	ADD COLUMN `finance` INT(32) NOT NULL DEFAULT '0',
	ADD COLUMN `financetimer` INT(32) NOT NULL DEFAULT '0' AFTER `finance`;
