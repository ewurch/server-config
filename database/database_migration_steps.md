# Dump current database into file
```bash
pg_dump database_name > database_name_20160527.sql
```


# Create new database
```sql
CREATE DATABASE yourdb;

CREATE USER youruser WITH ENCRYPTED PASSWORD 'yourpass';

ALTER DATABASE yourdb OWNER TO youruser;
```

# Restore dump
```bash
psql database_name < database_name_20160527.sql
```