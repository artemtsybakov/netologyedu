SELECT USER FROM mysql.user;

CREATE USER 'sys_temp'@'localhost' IDENTIFIED BY 'qwerty';

SHOW GRANTS FOR 'sys_temp'@'localhost';

GRANT ALL ON *.* TO 'sys_temp'@'localhost';

SHOW GRANTS FOR CURRENT_USER;

SELECT USER();

SELECT CURRENT_USER();