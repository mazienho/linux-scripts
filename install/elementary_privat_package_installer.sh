#!/bin/bash
#
# mbo 
# install-script for elementary os
# v.0.4 :  2015-07-21 - Changed Spotify keyserver
# v.0.3 :  2014-12-15 - Removed nixnote; GTK-3 scrollbar patch
# v.0.2 :  2014-10-31 - Add insync repository
# v.0.1 :  2014-10-20 - initial version of the script
#
###############################################################################
# + + + + + ToDo + + + + +
#
# TODO: docker - yumi
#
# Missing programs / packages
#	+ Komodo edit
#
#
# Install Guake-Patch
# Perform some configurations automatically
#	+ List of configuration
#		- synaptics_touchpad
#		- thunderbird-config
#		- synapse-config
#		- autokey-config
#		- evolution-config ?
#
# Optional config
#	+ conky
#	+ vpn
#	+ keepass2
#	
#
#
###############################################################################
# + + + + + List of installed packages to remove + + + + +
# geary
# midori-granite
# noise
# software-center
# scratch-text-editor
#
###############################################################################
# + + + + + List of packages to install + + + + + +
# aptitude
# autokey-gtk
# bluefish bluefish-plugins
# btsync-gui
# ccrypt
# cherrytree
# chromium-browser chromium-browser-l10n
# conky conky-all conky-manager
# dconf-editor
# docker (lxc-docker)
# dropbox # http://wiki.ubuntuusers.de/Dropbox + python-gpgme
# elementary-tweaks
# filezilla
# firefox firefox-locale-de
# flashplugin-installer
# gdebi
# gedit + gedit-plugins
# gimp
# git
# gitg
# google-chrome
# gparted
# gpicview
# gsynaptics
# guake
# guayadeque
# hddtemp
# insync
# java # -->openjdk-7-jre openjdk-7-jdk
# keepass2
# labyrinth	# mind mapping tool
# libreoffice libreoffice-l10n-de
# lm-sensors
# mc # Midnight Commander
# meld
# openjdk-7-jdk
# openjdk-7-jre
# openvpn
# pdftk
# pepperflashplugin-nonfree
# pinta
# pm-utils
# poedit
# pv # Durchsatzmessung von Pipes
# rdesktop
# remmina
# shutter
# skype  
# spotify-client
# sshfs
# structorizer
# sublime-text
# subversion
# synapse
# synaptic
# sysv-rc-conf
# teamviewer
# thunderbird thunderbird-locale-de
# transmission
# vim
# virtualbox
# vlc
# xbindkeys xbindkeys-config xkbset # For keyboard manipulation (e.g. "CapsLock=MidMouse")
# xfburn # replacing brasero <-- doesn't work on elementary 
# youtube-dl
# yumi
#
###############################################################################
START=`date`
#
# Variables
#
bashrc=~/.bashrc
bashali=~/.bash_aliases
fehler=0
dir=`pwd`
#
###############################################################################
echo "Install frequently used software for Ubuntu based Linux Distros"
echo ""
echo "Step 1: Check for config files"
echo "Step 2: Update & upgrade packages"
echo "Step 3: Remove non used packages"
echo "Step 4: Add repos"
echo "Step 5: Install packages"
echo ""
echo "Let's start!"
echo ""
echo "Step 1: Checking for the config files"
echo ""
if [ ! -f $dir/guake.patch ]; then
	echo "File 'guake.patch' does not exist in your homedir"
	echo "Put file into homedir and run the script again."
	echo ""
	fehler=1
fi
echo ""
if [ ! -f $dir/gtk_scrollbar.patch ]; then
	echo "File 'gtk_scrollbar.patch' does not exist in your homedir"
	echo "Put file into homedir and run the script again."
	echo ""
	fehler=1
fi
echo ""
if [ ! -f $dir/gtk-3-widgets-css.patch ]; then
	echo "File 'gtk-3-widgets-css' does not exist in your homedir"
	echo "Put file into homedir and run the script again."
	echo ""
	fehler=1
fi
echo ""
if [ ! -f $dir/vimrc ]; then
	echo "File 'vimrc' does not exist in your homedir"
	echo "Put file into homedir and run the script again."
	echo ""
	fehler=1
fi
echo ""
if [ ! -f $dir/bash_aliases ]; then
	echo "File 'bash_aliases (not the original hidden!!!)' does not exist in your homedir"
	echo "Put file into homedir and run the script again."
	echo ""
	fehler=1
fi
echo ""
if [ ! -f $dir/middle-click.sh ]; then
	echo "File 'middle-click.sh' does not exist in your homedir"
	echo "Put file into homedir and run the script again."
	echo ""
	fehler=1
fi
if [ $fehler -ne 0 ]; then
	echo ""
	echo "One or more errors occured."
	echo "Copy files to your homedir and try to run this script again"
	echo "Stop installation (y/[n])?"
	read input
	if [ "$input" == "y" ]; then
		echo "Aborted."
		echo "Start: $START"
		END=`date`
		echo "Ende: $END"
		exit 1
	fi
fi

# First we will update the system
echo "Step 2: Update System"
sudo apt-get update
sudo apt-get -y dist-upgrade

# Add all of the additional repositories
echo "Step 3: Add Repos"
echo ""
# Birdie - Twitter client
echo "Adding Birdie - Twitter Client"
sudo apt-add-repository -y ppa:birdie-team/stable
# BitTorrent Sync
echo "Adding BitTorrent Sync"
sudo apt-add-repository -y ppa:tuxpoldo/btsync
# Cherry tree
echo "Adding Cherry tree"
sudo add-apt-repository -y ppa:vincent-c/cherrytree
# Conky Manager
echo "Adding Conky Manager"
sudo apt-add-repository -y ppa:teejee2008/ppa
# Dropbox
echo "Adding Dropbox"
sudo apt-add-repository -y 'deb http://linux.dropbox.com/ubuntu trusty main'
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
# Docker
echo "Adding Docker"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
# Elementary Tweaks
echo "Adding Elementary Tweaks"
sudo apt-add-repository -y ppa:mpstark/elementary-tweaks-daily
echo "Adding Elementary Daily"
sudo apt-add-repository -y ppa:elementary-os/daily
echo "Adding Google Chrome"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# Insync
echo "Adding Insync"
wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | sudo apt-key add -
sudo echo "#Add Insync Repository" >> /etc/apt/sources.list.d/insync.list
sudo echo "deb http://apt.insynchq.com/ubuntu trusty non-free contrib" >> /etc/apt/sources.list.d/insync.list
# LibreOffice
echo "Addinng new LibreOffice"
sudo apt-add-repository -y ppa:libreoffice/ppa
# Plank Themes
sudo add-apt-repository -y ppa:noobslab/apps
# Skype
echo "Adding Skype"
sudo apt-add-repository -y 'deb http://archive.canonical.com/ubuntu/ trusty partner'
sudo apt-add-repository -y 'deb-src http://archive.canonical.com/ubuntu/ trusty partner'
# Spotify
echo "Adding Spotify"
sudo apt-add-repository -y 'deb http://repository.spotify.com/ stable non-free' 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 13B00F1FD2C19886
# Structorizer
sudo apt-add-repository -y ppa:vgk/vestix
# Sublime text editor
echo "Adding Sublime Text Editor"
sudo apt-add-repository -y ppa:webupd8team/sublime-text-2
# Synapse - testing // no errors occured until now
echo "Adding Synapse"
sudo apt-add-repository -y ppa:synapse-core/testing

sudo apt-get update
echo ""
# Let's install the bunch of the new nice <<required>> software
echo "Step 4: INSTALLATION"
echo ""
sudo apt-get -y install aptitude autokey-gtk bluefish bluefish-plugins btsync-gui ccrypt cherrytree chromium-browser chromium-browser-l10n conky conky-all conky-manager dconf-editor dropbox elementary-tweaks flashplugin-installer filezilla firefox firefox-locale-de gedit gedit-plugins gdebi gimp git gitg google-chrome-stable gparted gpicview gsynaptics guake guayadeque hddtemp insync keepass2 labyrinth lm-sensors mc meld openjdk-7-jre openjdk-7-jdk openvpn pdftk pepperflashplugin-nonfree pinta plank-themer playonlinux pm-utils poedit pv python-gpgme rdesktop remmina remmina-plugin-rdp remmina-plugin-vnc shutter skype spotify-client sshfs structorizer sublime-text subversion synapse synaptic sysv-rc-conf thunderbird thunderbird-locale-de transmission vim virtualbox vlc xbindkeys xbindkeys-config xfburn xkbset youtube-dl
# For plank themer
cd /tmp/ && ./Replace.sh;cd
#echo ""
#echo "Fix for missing Dropbox indicator"
#echo "export DROPBOX_USE_LIBAPPINDICATOR=1" >> ~/.xsessionrc
echo ""
sudo dpkg --add-architecture i386
echo "Install Teamviewer"
wget -O ~/Downloads/teamviewer.deb http://www.teamviewer.com/download/teamviewer_linux.deb
sudo gdebi -n ~/Downloads/teamviewer.deb
echo ""
echo "Install Google Music Manager"
wget -O ~/Downloads/googlemusic.deb https://dl.google.com/linux/direct/google-musicmanager-beta_current_amd64.deb
sudo gdebi -n ~/Downloads/googlemusic.deb
echo ""

# Let's get rid of unnecessary software packages
echo "Step 5:  remove unnecessary software packages"
sudo apt-get purge -y midori-granite
sudo apt-get purge -y noise
# disable automatically deinstallion of geary for testing mail indicator!
#sudo apt-get purge -y geary 
sudo apt-get purge -y software-center
sudo apt-get purge -y scratch-text-editor
sudo apt-get purge -y brasero

sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo ""
# Unhandled dependencies?
sudo apt-get -y install -f
echo ""
echo "Patching Guake"
sudo patch /usr/bin/guake < $dir/guake.patch
#rm ~/guake.patch
echo ""
echo "Patching gtk scrollbar width"
sudo patch /usr/share/themes/elementary/gtk-2.0/gtkrc < $dir/gtk_scrollbar.patch
#rm ~/gtk_scrollbar.patch
echo ""
echo "Patching gtk 3 scrollbar width"
sudo patch /usr/share/themes/elementary/gtk-3.0/gtk-widgets.css < $dir/gtk-3-widgets-css.patch
#rm ~/gtk-3-widgets-css.patch
echo "Moving vim config"
sudo mv $dir/vimrc /etc/vim/
echo ""
#echo "Customizing bash"
#cp $dir/bashrc /.bashrc
#cp $dir/bash_aliases ~/.bash_aliases
echo ""
#echo "Downloading neighbor note - please install manually."
#wget -O ~/Downloads/neighbornote-0.5.3-linux-x64-installer.run http://iij.dl.sourceforge.jp/neighbornote/62335/neighbornote-0.5.3-linux-x64-installer.run

sudo apt-get -y install libreoffice libreoffice-l10n-de

echo "All tasks done. Have fun!"


END=`date`

echo ""
echo "Start: $START"
echo "Ende: $END"
echo ""
exit 0
