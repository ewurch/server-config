# Dump current database into file
```bash
pg_dump -U database_owner database_name > database_name_20160527.sql
```


# Create new database
```sql
DROP DATABASE IF EXISTS yourdb;

CREATE DATABASE yourdb;

CREATE USER youruser WITH ENCRYPTED PASSWORD 'yourpass';

ALTER DATABASE yourdb OWNER TO youruser;
```

# Restore dump
```bash
psql -U database_owner database_name < database_name_20160527.sql
```