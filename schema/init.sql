-- Create database 
SELECT 'CREATE DATABASE paperdb'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'paperdb')\gexec