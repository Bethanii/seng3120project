-- this is a sql comment
-- these commands add the desired user
-- password is in the clear here though, so that is bad
-- SQL commands can be lower case
create user 'bethanyhampton'@'%' identified by 'abc123';
grant all privileges on *.* to 'bethanyhampton'@'%';
create user 'bethanyhampton'@'localhost' identified by 'abc123';
grant all privileges on *.* to 'bethanyhampton'@'localhost';

-- the next commands do the same thing as the mysql_secure_installation command
-- mysql_secure_installation is just a bash shell script. so dig into it and see
-- what db commands it run in response to the user's input
-- just run the commands needed

-- don't change the root user password, so no command for that, then:
-- delete the anonymous user
-- SQL commands can be upper case too...doesn't matter
DELETE FROM mysql.user WHERE User='';

-- don't let root log in remotely (good idea)
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- drop the test db
DROP DATABASE IF EXISTS test;

-- remove test db privileges
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- flush privileges so new users and privileges are active
FLUSH PRIVILEGES;