#!/bin/bash


choice=$(
{

# ==================
# APPS CON ICONOS
# ==================

find /usr/share/applications ~/.local/share/applications \
-name "*.desktop" 2>/dev/null |
while read file
do

    name=$(grep -m1 "^Name=" "$file" | cut -d= -f2)
    icon=$(grep -m1 "^Icon=" "$file" | cut -d= -f2)

    [ -z "$name" ] && continue

    echo -en "$name\0icon\x1f$icon\n"

done


# ==================
# CARPETAS
# ==================

find "$HOME" \
-maxdepth 2 \
-type d 2>/dev/null |
while read dir
do

    name=$(basename "$dir")

    echo -en "$name\0icon\x1ffolder\n"

done


# ==================
# ARCHIVOS
# ==================

find "$HOME" \
-maxdepth 2 \
-type f 2>/dev/null |
while read file
do

    name=$(basename "$file")

    echo -en "$name\0icon\x1ftext-x-generic\n"

done



} | rofi \
    -dmenu \
    -i \
    -show-icons \
    -p "" \
    -mesg "Enter abrir  •  Esc salir" \
    -theme ~/.config/rofi/themes/floating-dmenu.rasi

)


[ -z "$choice" ] && exit



# ==================
# ABRIR APPS
# ==================

desktop=$(grep -ril "^Name=$choice$" \
/usr/share/applications \
~/.local/share/applications 2>/dev/null | head -1)


if [ -n "$desktop" ]
then

    gtk-launch "$(basename "$desktop" .desktop)"
    exit

fi



# ==================
# ABRIR ARCHIVOS
# ==================

found=$(find "$HOME" -name "$choice" 2>/dev/null | head -n 1)

if [ -n "$found" ]; then

    # Carpetas
    if [ -d "$found" ]; then
        nautilus "$found" &
        exit
    fi

    extension="${found##*.}"
    extension="${extension,,}"

    case "$extension" in

        # Imágenes
        jpg|jpeg|png|webp|gif|bmp|svg)
            imv "$found" &
            ;;

        # Videos
        mp4|mkv|webm|avi|mov|flv)
            mpv "$found" &
            ;;

        # Audio
        mp3|flac|wav|ogg|m4a)
            mpv "$found" &
            ;;

        # PDF
        pdf)
            libreoffice "$found" &
            ;;

        # Documentos
        odt|ods|odp|doc|docx|xls|xlsx|ppt|pptx)
            libreoffice "$found" &
            ;;

        # Código / texto
        txt|md|json|conf|css|html|js|py|sh|c|cpp|rs|toml|yaml|yml)
            kitty -e nvim "$found" &
            ;;

        # Comprimidos
        zip|rar|7z|tar|gz|xz)
            file-roller "$found" &
            ;;

        # Otro
        *)
            xdg-open "$found" &
            ;;

    esac

    exit

fi

    esac

    exit

fi



# ==================
# COMANDO
# ==================

$choice &