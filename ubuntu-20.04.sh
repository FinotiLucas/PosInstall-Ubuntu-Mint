#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #


DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
DOWNLOADS="$HOME/Downloads"
DIRETORIO_DEVELOPMENT="$HOME/development"
PROGRAMAS_PARA_INSTALAR=(
	snap
	snapd
	gnome-tweaks
	gparted
	git
	curl
	unace
	rar
	unrar
	p7zip-rar
	p7zip
	wine winetricks
	steam
	openjdk-14-jre
	ubuntu-restricted-extras 
	libdvd-pkg 
	ubuntu-restricted-addons
	flatpak
	gnome-software-plugin-flatpak
	winff
	guvcview
	virtualbox
	flameshot
	ratbagd
	gparted
	git
	curl
	unace
	rar
	unrar
	p7zip-rar
	p7zip
	sharutils
	uudeview
	mpack
	arj
	cabextract
	lzip
	lunzip
	plzip
	default-jre
	default-jdk
	libdvd-pkg
	dpkg-reconfigure libdvd-pkg
	gufw
	openvpn
	network-manager-openvpn-gnome
	resolvconf
	fonts-firacode
	github-desktop
	docker.io
	flatpak
	fonts-firacode
)
# ---------------------------------------------------------------------- #


wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc > /dev/null
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'



# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock


# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt-get update -y



# ----------------------------- CASO EXISTA,  ----------------------------- #

## Fix Broken Packages ##
sudo apt update --fix-missing
sudo apt install -f
sudo dpkg --configure -a
sudo apt clean
sudo apt update
# ---------------------------------------------------------------------- #


# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt-get install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done


## Instalando pacotes Flatpak ##
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


flatpak install flathub com.spotify.Client -y
flatpak install flathub io.mrarm.mcpelauncher -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.github.micahflee.torbrowser-launcher -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub com.visualstudio.code -y
flatpak install flathub org.chromium.Chromium -y
flatpak install flathub org.inkscape.Inkscape -y
flatpak install flathub io.dbeaver.DBeaverCommunity -y
flatpak install flathub rest.insomnia.Insomnia -y
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub com.getpostman.Postman -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.stremio.Stremio -y
flatpak install flathub nz.mega.MEGAsync -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub org.signal.Signal -y
flatpak install flathub org.mozilla.Thunderbird -y
flatpak install flathub io.bit3.WhatsAppQT -y
flatpak install flathub net.cozic.joplin_desktop -y




## Instalando pacotes Snap ##
sudo snap install docker

# ---------------------------------------------------------------------- #

sudo systemctl enable --now docker
sudo usermod -aG docker finoti

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

sudo apt-get upgrade -y

npm install -g yarn
