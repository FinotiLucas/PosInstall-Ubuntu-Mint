#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_LIBRATBAG="ppa:libratbag-piper/piper-libratbag-git"
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"
URL_MEGA="https://mega.nz/linux/MEGAsync/xUbuntu_19.04/amd64/megasync-xUbuntu_19.04_amd64.deb"
URL_FLUTTER="https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
DOWNLOADS="$HOME/Downloads"
DIRETORIO_DEVELOPMENT="$HOME/development"
PROGRAMAS_PARA_INSTALAR=(
  snapd
  mint-meta-codecs
  winff
  guvcview
  virtualbox
  flameshot
  nemo-dropbox
  steam-installer
  steam-devices
  steam:i386
  ratbagd
  piper
  lutris
  libvulkan1
  libvulkan1:i386
  libgnutls30:i386
  libldap-2.4-2:i386
  libgpg-error0:i386
  libxml2:i386
  libasound2-plugins:i386
  libsdl2-2.0-0:i386
  libfreetype6:i386
  libdbus-1-3:i386
  libsqlite3-0:i386
  telegram-desktop
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

)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y

## Adicionando repositórios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo apt-add-repository "$PPA_LIBRATBAG" -y
sudo add-apt-repository "$PPA_LUTRIS" -y
wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE bionic main"
# ---------------------------------------------------------------------- #



# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"

wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MEGA"                -P "$DIRETORIO_DOWNLOADS"


## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## Instalando o Flutter


mkdir "$DIRETORIO_DEVELOPMENT"
wget -c "$URL_FLUTTER"              -P "$DOWNLOADS"
cd "$DIRETORIO_DEVELOPMENT"
tar xf ~/Downloads/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz
cd
# ---------------------------------------------------------------------- #

##Instalando o Brave Browser
sudo apt install apt-transport-https curl -y

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

sudo apt update

sudo apt install brave-browser

# ---------------------------------------------------------------------- #


# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

## Instalando pacotes Flatpak ##
flatpak install flathub com.obsproject.Studio -y

## Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install slack --classic
sudo snap install skype --classic
sudo snap install photogimp
sudo snap install ubuntu-make --classic
sudo snap install inkscape
sudo snap install android-studio --classic
sudo snap install code --classic
sudo snap install bitwarden
sudo snap install electron-mail
sudo snap install whatsdesk
sudo snap install discord
sudo snap install vlc
sudo snap install signal-desktop
sudo snap install riseup-vpn --classic
sudo snap install electronplayer
sudo snap install retroarch
# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
