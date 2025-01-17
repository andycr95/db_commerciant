#!/bin/bash

# Directory
folder_scripts="scripts"

chmod +x scripts/*.sh

for script in "$folder_scripts"/*.sh; do
  echo "Ejecutando script: $script"

  bash "$script"

  if [[ $? -eq 0 ]]; then
    echo "Script $script ejecutado correctamente."
  else
    echo "Error al ejecutar el script $script."
  fi

  echo "--------OK--------"
done