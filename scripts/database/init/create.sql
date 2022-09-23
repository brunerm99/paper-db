-- Create database 
SELECT 'CREATE DATABASE paperdb'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'paperdb')\gexec

-- Initialize tables
CREATE TABLE IF NOT EXISTS papers(
       "timestamp" timestamptz NOT NULL,
       title text NOT NULL,
       doi INT NULL,
       path TEXT NOT NULL,
       CONSTRAINT time_symbol UNIQUE (title, path)
);