#!/bin/bash
# ==============================================================================
# FUNCIÓN PARA BÚSQUEDA DE CONTENIDO INTERACTIVA CON FZF Y RIPGREP
#
# Comando: fsearch
#
# Propósito:
#   Busca recursivamente una cadena de texto dentro de los archivos del
#   directorio actual y muestra los resultados en una lista interactiva de fzf.
#   Al seleccionar un resultado, devuelve la ruta completa del archivo.
#
# Dependencias:
#   1. fzf: El motor de búsqueda interactiva.
#   2. ripgrep (rg): El buscador de contenido. Es mucho más rápido que grep.
#   3. bat (opcional, pero muy recomendado): Para una previsualización
#      con resaltado de sintaxis. Si no está instalado, usará 'cat'.
#
# Instalación de dependencias (ejemplo en Ubuntu/Debian):
#   sudo apt update
#   sudo apt install fzf ripgrep bat
#
#   En Arch Linux:
#   sudo pacman -S fzf ripgrep bat
#
#   En macOS (con Homebrew):
#   brew install fzf ripgrep bat
#
# Cómo usarlo:
#   1. Añade esta función a tu archivo ~/.bashrc o ~/.zshrc
#   2. Reinicia tu terminal o ejecuta 'source ~/.bashrc'
#   3. Escribe 'fsearch' y presiona Enter.
#   4. Comienza a escribir para filtrar los resultados.
#   5. Presiona Enter sobre una línea para obtener la ruta del archivo.
# ==============================================================================

  # 1. Verificar si 'rg' (ripgrep) está instalado.
  if ! command -v rg &> /dev/null; then
    echo "Error: 'ripgrep' (rg) no está instalado. Por favor, instálalo para continuar."
    return 1
  fi

  # 2. Comando principal de ripgrep.
  #    Busca en todos los archivos, mostrando el número de línea, sin encabezado
  #    y siempre con colores para que fzf lo pueda interpretar.
  #    El '.*' inicial es un truco para que muestre todos los resultados al principio.
  RG_COMMAND="rg --line-number --no-heading --color=always --smart-case '.*' ."

  # 3. Comando de previsualización.
  #    Usa 'bat' si está disponible para un resaltado de sintaxis increíble.
  #    Si no, usa 'cat' como una alternativa simple y universal.
  PREVIEW_COMMAND="cat {}" # Comando por defecto
  if command -v bat &> /dev/null; then
    # {1} es el nombre del archivo (primera columna del delimitador)
    # {2} es el número de línea (segunda columna)
    PREVIEW_COMMAND="bat --color=always --highlight-line {2} {1}"
  fi

  # 4. Ejecutar fzf.
  #    - Le pasamos los resultados de ripgrep.
  #    - --ansi: para interpretar los colores de rg.
  #    - --delimiter ':': para separar el nombre_archivo:numero_linea:contenido.
  #    - --preview: para mostrar la ventana de previsualización.
  #    - --preview-window: para configurar la posición y apariencia de la ventana.
  #    - El resultado se pasa a 'awk' para extraer solo la primera columna (la ruta del archivo).
  eval "$RG_COMMAND" | fzf \
    --ansi \
    --delimiter ':' \
    --preview "$PREVIEW_COMMAND" \
    --preview-window 'up,60%,border-bottom' \
    --bind 'enter:become(echo {1})' # Al presionar Enter, se convierte en un comando que imprime la ruta.

  # Otra forma de obtener la ruta al final (más tradicional):
  # | awk -F: '{print $1}'

