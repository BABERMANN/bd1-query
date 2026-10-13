# Databases 1 (DB1)

SQL scripts and exercises from my Databases 1 course, using PostgreSQL.

## Files

| File | Description |
|---|---|
| `my_dlm.sql` | Medical appointments tables: `convenio`, `paciente`, `medico`, `consulta` |
| `biblioteca_dlm.sql` | Library database: `categoria`, `livro`, `autor`, `livro_autor` (many-to-many), with table creation, `ALTER TABLE`, data manipulation and `ON DELETE CASCADE` tests |
| `store_dlm.sql` | Store database: `cliente`, `produto`, `pedido`, `item_pedido` (many-to-many), with constraints, `ALTER TABLE`, data manipulation, `ON DELETE CASCADE` and `ON DELETE SET NULL` |
| `script_ddl_revisao.sql` | DDL review: creating and altering tables |
| `script_revisao.sql` | Review with the `equipe` and `jogador` tables |
| `teacher_ correction.sql` | Teacher's correction |

## Topics covered

- Creating databases and tables with named constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `CHECK`, `DEFAULT`)
- Altering table structure: adding, renaming and changing columns, dropping and recreating constraints
- Inserting, updating, deleting and querying data
- Foreign key deletion rules: default behavior, `ON DELETE CASCADE` (including chained cascades) and `ON DELETE SET NULL`
- Dropping tables in the correct order

