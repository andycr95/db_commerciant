#!/bin/bash

CONTAINER_NAME="oracle-db"
SQL_FILE="/init.sql"
DB_USER="sys"
DB_PASSWORD="password"
DB_SERVICE="XEPDB1"
SYSDBA_OPTION="as sysdba"

# Verificar si el contenedor está en ejecución
if ! docker ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
  echo "El contenedor ${CONTAINER_NAME} no está en ejecución. Por favor, inicia el contenedor y vuelve a intentarlo."
  exit 1
fi

# Copiar el archivo SQL al contenedor
echo "Copiando el archivo SQL al contenedor..."
docker cp init.sql "${CONTAINER_NAME}:${SQL_FILE}"


# Ejecutar el script de migración dentro del contenedor
echo "Ejecutando el script de migración en la base de datos..."
docker exec -it "${CONTAINER_NAME}" bash -c "
  echo 'Conectando a la base de datos y ejecutando el script...';
  echo 'SET FEEDBACK ON;' > temp_script.sql;
  echo 'SET SERVEROUTPUT ON;' >> temp_script.sql;
  echo '@${SQL_FILE};' >> temp_script.sql;
  echo 'EXIT;' >> temp_script.sql;
  sqlplus ${DB_USER}/${DB_PASSWORD}@localhost/${DB_SERVICE} ${SYSDBA_OPTION} @temp_script.sql
"

# Limpiar el archivo temporal dentro del contenedor
docker exec -it "${CONTAINER_NAME}" rm -f temp_script.sql

echo "Migración completada."
