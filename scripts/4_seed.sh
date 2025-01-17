#!/bin/bash

CONTAINER_NAME="oracle-db"
DB_USER="pacificode_user"
SQL_FILE_DROP_SEED="/drop_seed.sql"
SQL_FILE_INIT_SEED="/init_seed.sql"
SQL_FILE_DATA_SEED="/data_seed.sql"
SQL_FILE_USERS_SEED="/users_seed.sql"
DB_PASSWORD="password"
DB_SERVICE="XEPDB1"

# Verificar si el contenedor está en ejecución
if ! docker ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
  echo "El contenedor ${CONTAINER_NAME} no está en ejecución. Por favor, inicia el contenedor y vuelve a intentarlo."
  exit 1
fi

# Copiar el archivo SQL al contenedor
echo "Copiando el archivo SQL al contenedor..."
docker cp ./seeds/drop.sql "${CONTAINER_NAME}:${SQL_FILE_DROP_SEED}"
docker cp ./seeds/data.sql "${CONTAINER_NAME}:${SQL_FILE_DATA_SEED}"
docker cp ./seeds/users.sql "${CONTAINER_NAME}:${SQL_FILE_USERS_SEED}"
docker cp ./seeds/init.sql "${CONTAINER_NAME}:${SQL_FILE_INIT_SEED}"


# Ejecutar el script dentro del contenedor
echo "Ejecutando el script de init seed en la base de datos..."
docker exec -it "${CONTAINER_NAME}" bash -c "
  echo 'Conectando a la base de datos y ejecutando el script...';
  echo 'SET FEEDBACK ON;' > temp_script.sql;
  echo 'SET SERVEROUTPUT ON;' >> temp_script.sql;
  echo '@${SQL_FILE_DROP_SEED};' >> temp_script.sql;
  echo '@${SQL_FILE_DATA_SEED};' >> temp_script.sql;
  echo '@${SQL_FILE_USERS_SEED};' >> temp_script.sql;
  echo '@${SQL_FILE_INIT_SEED};' >> temp_script.sql;
  echo 'EXIT;' >> temp_script.sql;
  sqlplus ${DB_USER}/${DB_PASSWORD}@localhost/${DB_SERVICE} @temp_script.sql
"

# Limpiar el archivo temporal dentro del contenedor
docker exec -it "${CONTAINER_NAME}" rm -f temp_script.sql .${SQL_FILE_DROP_SEED} .${SQL_FILE_DATA_SEED} .${SQL_FILE_USERS_SEED} .${SQL_FILE_INIT_SEED}

echo "Migración completada."
