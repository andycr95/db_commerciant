#!/bin/bash

CONTAINER_NAME="oracle-db"
DB_USER="com_user"
SQL_FILE_PACKAGE="/pkg_users_user.sql"
SQL_FILE_PACKAGE_COM="/pkg_com_com.sql"
DB_PASSWORD="password"
DB_SERVICE="XEPDB1"


# Verificar si el contenedor está en ejecución
if ! docker ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
  echo "El contenedor ${CONTAINER_NAME} no está en ejecución. Por favor, inicia el contenedor y vuelve a intentarlo."
  exit 1
fi

# Copiar el archivo SQL al contenedor
echo "Copiando el archivo SQL al contenedor..."
docker cp ./seeds/pkg_users_user.sql "${CONTAINER_NAME}:${SQL_FILE_PACKAGE}"
docker cp ./seeds/pkg_com_com.sql "${CONTAINER_NAME}:${SQL_FILE_PACKAGE_COM}"


# Ejecutar el script dentro del contenedor
echo "Ejecutando el script de la base de datos..."
docker exec -it "${CONTAINER_NAME}" bash -c "
  echo 'Conectando a la base de datos y ejecutando el script...';
  echo 'SET FEEDBACK ON;' > temp_script.sql;
  echo 'SET SERVEROUTPUT ON;' >> temp_script.sql;
  echo '@${SQL_FILE_PACKAGE};' >> temp_script.sql;
  echo '@${SQL_FILE_PACKAGE_COM};' >> temp_script.sql;
  echo 'EXIT;' >> temp_script.sql;
  sqlplus ${DB_USER}/${DB_PASSWORD}@localhost/${DB_SERVICE} @temp_script.sql
"

# Limpiar el archivo temporal dentro del contenedor
docker exec -it "${CONTAINER_NAME}" rm -f temp_script.sql .${SQL_FILE_PACKAGE}

echo "Prueba de paquete completada."
