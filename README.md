# MI CONFIGURACION DE SWAY

recuerda que todo va en la carpeta .config y alli pones un carpeta con el nombre de lo que haras

#  Aqui dejo mi configuracion de sway en español, leean antes de instlarla, es la primera vez que hago esto asi que se aceptan comentarios
#  Esto es todo lo que tengo como parte de mi configuracion

# Sway config

sudo pacman -S sway kitty rofi-wayland nautilus firefox mako \
blueman bluez bluez-utils grim slurp satty \
neovim playerctl brightnessctl \
pipewire pipewire-pulse wireplumber awww

sudo pacman -S swaylock swayidle (OPCIONALES)

# Waybar

sudo pacman -S waybar pavucontrol \
network-manager-applet gnome-calendar \
xdg-desktop-portal \
xdg-desktop-portal-wlr \
xdg-desktop-portal-gtk jq

# AUR

yay -S wlogout

# Launcher

LAUNCHER.SH NECESITA PERMISOS, DÁCELOS:

chmod +x ~/.config/rofi/scripts/launcher.sh

# Servicios

sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service
