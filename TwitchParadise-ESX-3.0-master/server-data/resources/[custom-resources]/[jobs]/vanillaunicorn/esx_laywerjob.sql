INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('vanillaunicorn', 0, 'boss', 'Boss', 500, '', '');

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('vanillaunicorn', 'vanillaunicorn', 1);

INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_vanilla','vanillaunicorn',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_vanilla','vanillaunicorn',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_vanilla', 'vanillaunicorn', 1)
;
