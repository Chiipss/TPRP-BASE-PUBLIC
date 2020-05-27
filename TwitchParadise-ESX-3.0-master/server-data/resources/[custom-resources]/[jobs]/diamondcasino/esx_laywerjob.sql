INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('diamondcasino', 0, 'boss', 'Boss', 500, '', '');

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('diamondcasino', 'Diamond Casino', 1);

INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_casino','diamondcasino',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_casino','diamondcasino',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_casino', 'diamondcasino', 1)
;