# HOWTO INSTALL MAYA ON UBUNTU


# installs maya 201x
# makes ~/maya/201x configs
# should make /usr/autodesk/maya201x (not maya/201x/)
# runs /usr/autodesk/maya201x/bin/maya.bin

#OVERVIEW
# 1. Configure the setup here
# 2. Automatic scripts
# 3. Error messages and some solutions

# ACKS
# Based on https://linuxhint.com/install_autodesk_maya_ubuntu_1804/
# Based on https://gist.github.com/heiths/3250500
# Based on https://drz-twickey.ethz.ch/Main/MayaOnUbuntu



###############################################################################
# Configure the setup here
###############################################################################

# choose one of the versions
# manually download the package (google links doesnt wget)
# 

export DIR_INSTALLER='maya2017Installer'
export DIR_USR_BIN='/usr/autodesk/maya2017'
export DIR_CONFIG='~/maya/2017'
export URL='http://edutrial.autodesk.com/NET17SWDLD/2017/MAYA/ESD/Autodesk_Maya_2017_EN_JP_ZH_Linux_64bit.tgz'
export PACKAGE='Autodesk_Maya_2017_EN_JP_ZH_Linux_64bit.tgz'


export DIR_INSTALLER='maya2018Installer'
export DIR_USR_BIN='/usr/autodesk/maya2018'
export DIR_CONFIG='~/maya/2018'
export DIR_CONFIG='/home/hayko/maya/2018'
export PACKAGE='Autodesk_Maya_2018_EN_Linux_64bit.tgz'
export URL='https://doc-04-b0-docs.googleusercontent.com/docs/securesc/0pvu6j6pp3g0njcqrnfa2skpd7qj1ued/p639br12ptdris9a7fv9mi3o8lgfrufp/1551686400000/05850646042357046283/10637644739295237966/0Byl-OOkamOEIUXRyQjctSmZPdk0?e=download&nonce=o74srm7sbrepa&user=10637644739295237966&hash=gif7vf4gnl5j76isnfa5lc0926fggvkh'

echo $DIR_INSTALLER
echo $DIR_USR_BIN
echo $DIR_CONFIG



###############################################################################
# Automatic scripts
###############################################################################

echo "starting the script..."
echo ""


#In this article I will show you how to install Autodesk Maya 2017 on Ubuntu 18.04. Let’s get started.
#Adding Additional Repositories
#Some of the libraries that Maya depends on are not available in the official package repository of Ubuntu 18.04. But it is available in the official package repository of Ubuntu 16.04. So you have to add it to your Ubuntu 18.04 with the following command:

echo 'deb http://archive.ubuntu.com/ubuntu xenial main restricted universe multiverse' |
sudo tee /etc/apt/sources.list.d/xenial.list


#Now update the package repository cache with the following command:

sudo apt-get update

#The package repository cache should be updated.


#Installing Dependencies
#Maya needs some development package in order to work. Install them with the following command:

sudo apt-get install -y libtbb-dev libtiff5-dev libssl-dev libpng12-dev libssl1.0.0 gcc libjpeg62
  

#To install Maya, you must convert some rpm to deb file. Alien can be used to do that. Run the following command to install Alien:
sudo apt-get install -y alien elfutils
  

#Now install the required multimedia libraries with the following command:

sudo apt-get install -y libaudiofile-dev libgstreamer-plugins-base0.10-0
  

#Install the required graphics libraries with the following command:

sudo apt-get install -y libglw1-mesa libglw1-mesa-dev mesa-utils
  

#Install the required fonts with the following command:

sudo apt-get install -y xfonts-100dpi xfonts-75dpi ttf-mscorefonts-installer fonts-liberation
    

#Some of the other packages required by Maya can be installed with the following command:

sudo apt-get install -y csh tcsh libfam0 libfam-dev xfstt
 

#Download and install libxp6 with the following commands:
#cd /tmp
wget http://launchpadlibrarian.net/183708483/libxp6_1.0.2-2_amd64.deb
sudo dpkg -i libxp6_1.0.2-2_amd64.deb


#Downloading and Configuring Maya Installer
#Navigate to ~/Downloads directory with the following command:

#cd ~/Downloads
#Now download Maya installer with the following command:
#wget http://edutrial.autodesk.com/NET17SWDLD/2017/MAYA/ESD/Autodesk_Maya_2017_EN_JP_ZH_Linux_64bit.tgz
#wget https://doc-04-b0-docs.googleusercontent.com/docs/securesc/0pvu6j6pp3g0njcqrnfa2skpd7qj1ued/p639br12ptdris9a7fv9mi3o8lgfrufp/1551686400000/05850646042357046283/10637644739295237966/0Byl-OOkamOEIUXRyQjctSmZPdk0?e=download&nonce=o74srm7sbrepa&user=10637644739295237966&hash=gif7vf4gnl5j76isnfa5lc0926fggvkh
#lynx https://drive.google.com/file/d/0Byl-OOkamOEIUXRyQjctSmZPdk0/view
#wget $URL

echo "manually downloaded the URL?"
read RUNNOW
case "$RUNNOW" in
	n*|N*)
	echo "ugh. do it then..."
	exit 0;
esac


#Once the download is completed, you should see Autodesk_Maya_201*_Linux_64bit.tgz file in the ~/Downloads directory.


#Now create a new directory $DIR_INSTALLER/ with the following command:
mkdir -p $DIR_INSTALLER


#Now run the following command to extract the Maya installer to the $DIR_INSTALLER/ directory:

tar xvzf $PACKAGE -C $DIR_INSTALLER



#Now navigate to the $DIR_INSTALLER/ directory with the following command:

cd $DIR_INSTALLER/


#Now run the following commands to create an executable that always returns true:

# update: not required for this version
# hack: due to error chmod
# use real rpm due to chmod -/-/
# sudo apt-get --reinstall --only-upgrade install ^{lib,}rpm

# hack: skip rpm issue watch for crash
#sudo mv -v /usr/bin/rpm /usr/bin/rpm_backup
#echo "int main (void) {return 0;}" > mayainstall.c
#gcc mayainstall.c
#sudo cp -v a.out /usr/bin/rpm


#The Maya installer packages are all rpm files. Run the following command to convert them to deb file:

sudo alien -cv *.rpm 

# alternative version 
#for i in *.rpm; do sudo alien -cv $i; done

#It should take a very long time to complete. So sit back and relax.

#Now install the deb files with the following command:

sudo dpkg -i *.deb
 


#Linking Library Files
#Now you have to make some symbolic link of library files that Maya 2017 depends on, otherwise Maya 2017 won’t work. Run the following command to do that:

sudo ln -s /usr/lib/x86_64-linux-gnu/libtbb.so /usr/lib/x86_64-linux-gnu/libtbb_preview.so.2
sudo ln -s /usr/lib/x86_64-linux-gnu/libtiff.so /usr/lib/libtiff.so.3
sudo ln -s /usr/lib/x86_64-linux-gnu/libssl.so $DIR_USR_BIN/lib/libssl.so.10
sudo ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so $DIR_USR_BIN/lib/libcrypto.so.10


#Starting Maya Installer
#Run the following command to make the Maya installer executable:

chmod +x setup

#Now start Maya 2017 installer with the following command:

sudo ./setup


#The Maya installer should start. Click on Continue.

#Select your Country or Region, then click on I ACCEPT and then click on Continue.

#Now enter your Maya 2017 serial number and product key and then click on Continue. You should be able to find it on your account in the official website of Autodesk Maya.

#Click on Continue.

#Now click on Done.

#Now we have to make some additional directories for Maya.

#Make /usr/tmp with the following command:

sudo mkdir -p /usr/tmp


#Change the permission of /usr/tmp:

sudo chmod 777 /usr/tmp


#Now make some directories for Maya configuration file with the following command:

mkdir -p $DIR_CONFIG $DIR_CONFIG/syncColor/Shared


#Run the following command to fix segmentation fault errors:

echo "MAYA_DISABLE_CIP=1" >>$DIR_CONFIG/Maya.env


#Run the following command to fix color management errors:

echo "LC_ALL=C" >>$DIR_CONFIG/Maya.env


#Now change the permission of everything in the ~/maya directory with the following command:

# ~/maya is some issue if sudo ... /~/maya/
chmod -Rfv 777 $DIR_CONFIG/.. #~/maya
 

#Configuring Fonts
#Now run the following commands to configure the fonts for Maya:

xset +fp /usr/share/fonts/X11/100dpi/
xset +fp /usr/share/fonts/X11/75dpi/
xset fp rehash


#Fix Maya Camera Modifier Key
#Now fix the Maya camera modified key with the following command:

gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"


#Restoring rpm Utilities
#Run the following command to restore rpm utilities:

#sudo rm -v /usr/bin/rpm
#sudo mv -v /usr/bin/rpm_backup /usr/bin/rpm

#Running Maya
#Now that everything is configured, you can run Maya 2017 with the following command:


#Everything should work now... 
echo "installation complete."
echo ""
echo "start maya now?"
read RUNNOW
case "$RUNNOW" in
	n*|N*)
	echo "You can run maya any time by typing $DIR_USR_BIN/bin/maya.bin into the terminal"
	exit 0;
esac

$DIR_USR_BIN/bin/maya.bin


#Click on I Agree.

#Maya 2017 should be loading as you can see in the screenshot below.
#This is the Maya 2017 main window.
#That’s how you install Maya 2017 on Ubuntu 18.04. Thanks for reading this article.




###############################################################################
# 3. Error messages and some solutions
###############################################################################

# error License server fails to install
# make sure to edit these files accorindg to the drz wiki
# sudo joe /var/flexlm/maya.lic
# sudo joe /usr/autodesk/maya2018/bin/License.env


#./maya.bin
#maya: Autodesk Maya 2017Licensing ErrorA licensing error occurred that Autodesk systems were not able to handle for you. Please contact Autodesk Customer Support for help in resolving this error.GetFeatureAuthorizationStatus 1 (Failure)

#./maya or ./maya2017
#Segmentation fault (core dumped)

#./mayapy
#ImportError: /usr/autodesk/maya2017/bin/../lib/libOGSGraphics-16.so: undefined symbol: EVP_CIPHER_CTX_cleanup



# this should only occur when mixing the setup with maya2014
# error composite-2014
#sudo apt-get install -f
#sudo dpkg-reconfigure composite-2014
#sudo apt-get --purge remove composite-2014



#Just "Fake" /usr/autodesk/Composite_2014/etc/configure.py
# hack: composite-2014 fails
#Setting up composite-2014 (2014.0-862716) ...
#python: can't open file '/usr/autodesk/Composite_2014/etc/configure.py': [Errno 2] No such file or directory
#dpkg: error processing package composite-2014 (--install):
#Errors were encountered while processing:
# composite-2014

#sudo mkdir -p /usr/autodesk/Composite_2014/etc
#echo " " >/usr/autodesk/Composite_2014/etc/configure.py




# screwed up rpm because of the empty c code?# fix rpm
# https://ubuntuforums.org/archive/index.php/t-2123884.html
# sudo apt-get --reinstall --only-upgrade install ^{lib,}rpm

