What we will need:
full:
   `mariadb-dump --user=root --password=root --lock-tables --all-databases=true > full-db-backup.sql`
selected:
    `mariadb-dump --user=root --password=root --lock-tables --databases DownQuark DevQon > dq-db.sql`