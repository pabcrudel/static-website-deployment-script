#!/bin/bash
#
# Script de asistencia al despligue del proyectos web staticos en GitHub Pages. Procesos que realiza:
# - Minificar los archivos .html, .css y .js
# - Crear la carpeta "dist" respetando el arbol de directorios original.
# - Mover los archivos minificados y otros elementos como imagenes y binarios a dicha carpeta.
# - Iniciar un nuevo repositorio en dicha carpeta y subirlo a la rama "gh-pages" del repositorio actual.
#
# --------------------------------------------------------------------
# Author: Pablo Cru
# GitHub: https://github.com/pabcrudel
# --------------------------------------------------------------------


# --------------- Funciones --------------- #

# Verificar si un paquete está instalado y, si no lo está, instalarlo
f_check_packages() {
  echo Verificando instalacion de paquetes necesarios...
  echo
  # Lista de paquetes a verificar e instalar
  packages=("uglify-js" "clean-css-cli" "html-minifier")

  # Iterar sobre la lista de paquetes
  for package in "${packages[@]}"
  do
    # Verifica si el paquete está instalado
    if ! npm ls "$package" > /dev/null; then
      echo "$package no encontrado. Instalando..."
      # Instala el paquete usando npm
      npm install "$package" --save-dev --silent
    else
      echo "$package ya está instalado."
    fi
  done
  echo
  echo
}

# Verificar el estado del directorio "dist".
# - si existe, elimina su contenido.
# - si no exite, lo crea.
f_check_output() {
  dir=dist

  echo Verificando estado del directorio $dir...
  echo
  if [ ! -d $dir ]; then
    echo "No exite." 
    echo "Creando directorio..."
    mkdir -p $dir
  elif [ ! -z "$(ls -A $dir)" ]; then
    echo "No esta vacio."
    echo "Limpiando el contenido..."
    rm -r $dir/*
  else
    echo "$dir esta vacio."
  fi
  echo
  echo
}