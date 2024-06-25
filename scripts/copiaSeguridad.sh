#!/bin/bash

# Comprobar que se ha pasado un parámetro
if [ -z "$1" ]; then
  echo "Debe proporcionar el nombre de un usuario."
  exit 1
fi

# Comprobar que el usuario existe en el sistema
if ! id "$1" &>/dev/null; then
  echo "El usuario $1 no existe."
  exit 1
fi

# Obtener el directorio personal del usuario
HOME_DIR=$(getent passwd "$1" | cut -d: -f6)
BACKUP_DIR="/backup/$1"

# Crear el directorio de backup si no existe
if [ -d "$BACKUP_DIR" ]; then
  read -p "El directorio de backup ya existe. ¿Desea eliminarlo y crear uno nuevo? (s/n): " RESP
  if [ "$RESP" != "s" ]; then
    echo "Operación cancelada."
    exit 0
  fi
  sudo rm -rf "$BACKUP_DIR"
fi

sudo mkdir -p "$BACKUP_DIR"
sudo cp -a "$HOME_DIR/." "$BACKUP_DIR/"
sudo chown -R root:root "$BACKUP_DIR"
sudo chmod -R 444 "$BACKUP_DIR"

echo "Copia de seguridad realizada con éxito en $BACKUP_DIR"

