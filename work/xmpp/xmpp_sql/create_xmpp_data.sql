
-- Switch to XMPP database
USE mongooseim;

-- Insert XMPP init data
INSERT INTO users (username, password, created_at) VALUES ('bot1', '12345', '2015-01-01 00:00:00');
INSERT INTO users (username, password, created_at) VALUES ('bot2', '12345', '2015-01-01 00:00:00');
