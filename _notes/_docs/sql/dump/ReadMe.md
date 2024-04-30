What we will need:
full:
   `mariadb-dump --user=root --password=root --lock-tables --all-databases=true > full-db-backup.sql`
selected:
    `mariadb-dump --user=root --password=root --lock-tables --databases DownQuark DevQon > dq-db.sql`
   ```
   fldr="_notes/_docs/sql/dump/${$(date +%Y%m%d%H%M)}" \
   && mkdir -p $fldr \
   && mariadb-dump --user=root --password=root --lock-tables --dump-date --routines --databases DownQuark DevQon QrxAggregate QrxJoin > "${fldr}/dq-devqon-db.sql"
   ```

## https://mariadb.com/kb/en/clients-utilities/

> https://mariadb.com/kb/en/mariadb-upgrade/
> > https://stackoverflow.com/questions/27918764/cannot-load-from-mysql-proc-the-table-is-probably-corrupted
```bash
brew upgrade mariadb
mariadb -V
mariadb-upgrade --verbose --verbose -u mlnck -p
```

```sql
-- Useful
The `_rowid` pseudo column is mapped to the primary key in the related table.

-- PROCEDURES
DROP PROCEDURE IF EXISTS CreatePaths;
DELIMITER ~!~

CREATE PROCEDURE CreatePaths ( proj_id UUID )
BEGIN
  DECLARE project_iteration_done INT DEFAULT FALSE;
  DECLARE concat_path_done INT DEFAULT FALSE;

DECLARE dev_control_int INT DEFAULT 0;

DECLARE fetch_project_id UUID;
DECLARE fetch_path_part VARCHAR(50);
DECLARE fetch_proj_parent UUID;

DECLARE file_path VARCHAR(255) DEFAULT "";
DECLARE proj_name VARCHAR(50);

  DECLARE cursor_dq_projects CURSOR FOR
    SELECT DISTINCT(uuid)
    FROM `downquark`.`_dq_projects`
    WHERE
        (proj_id IS NOT NULL AND uuid = proj_id)
        OR (proj_id IS NULL AND 1);

DECLARE CONTINUE HANDLER FOR NOT FOUND SET project_iteration_done = TRUE;

IF ISNULL(proj_id) THEN -- allows TO append IF id IS passed AS argument
  DROP TABLE IF EXISTS `QrxAggregate`.`dq_devqon_project`;
END IF;
CREATE TABLE IF NOT EXISTS `QrxAggregate`.`dq_devqon_project` (
  `pid` uuid NOT NULL,
  `pname` varchar(50) DEFAULT NULL,
  `pth` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `pname` (`pname`),
  CONSTRAINT `dq_devqon_project__dq_projects_FK` FOREIGN KEY (`pid`) REFERENCES `DownQuark`.`_dq_projects` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

  OPEN cursor_dq_projects;
    loop_project_uuids: LOOP
    
    FETCH cursor_dq_projects INTO fetch_project_id;
    IF project_iteration_done THEN LEAVE loop_project_uuids; END IF;

############ INNER ##############

-- FIRST run - BEFORE iterations
  -- - store the static data & config_file name
SELECT project_id,path_os_config_file
    INTO proj_name,file_path
  FROM `downquark`.`_dq_projects` dq
  WHERE `uuid` = fetch_project_id;

-- needed for initial select statement to find a match
SET fetch_proj_parent = fetch_project_id;

repeat_concat_file_path: REPEAT

  SELECT `parent`,`path_os_config_dir`
      INTO fetch_proj_parent, fetch_path_part
    FROM `downquark`.`_dq_projects` dq
    WHERE `dq`.`uuid` = fetch_proj_parent;

  SET file_path = CONCAT_WS( "/", fetch_path_part, file_path);

UNTIL ISNULL(fetch_proj_parent)
  END REPEAT repeat_concat_file_path;

############ END INNER ##############

INSERT INTO `QrxAggregate`.`dq_devqon_project` (pid,pname,pth) VALUES (fetch_project_id,proj_name,file_path);

-- DEV+DEBUG BELOW
-- SET dev_control_int = dev_control_int + 1;
-- IF dev_control_int>=5 THEN SET project_iteration_done = TRUE; END IF;

    END LOOP loop_project_uuids;
  CLOSE cursor_dq_projects;

END; ~!~

DELIMITER ;

-- CALL CreatePaths('362b79ae-f0a4-11ee-96c2-c29d42d3cfc8');
-- CALL CreatePaths ('4e4beb7e-f0a2-11ee-96c2-c29d42d3cfc8'); -- ROOT: DOWNQUARK
CALL CreatePaths(NULL); -- run ON ALL rows

SELECT * FROM `QrxAggregate`.`dq_devqon_project`;
```
