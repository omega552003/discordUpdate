#! /bin/bash
#-----------------------------------------------------------------------------#
# Script to manually install discord from the tar.gz offering. Tested on
# Fedora 39, 40
#-----------------------------------------------------------------------------#

# Setup Variables
TMP=~/Downloads/tmp
INSTALL=/usr/lib64

# Find file
FILE=`find ~/Downloads -type f -iname "discord*.tar.gz" | sort | tail -n1`
echo "Found: $FILE"

# Setup Dir
if [ ! -d "$TMP" ]; then
    mkdir "$TMP"
fi

# Extract file
tar -xzf $FILE -C $TMP
mv "$TMP/Discord" "$TMP/discord"

# Move files
if [ -d "$INSTALL" ]; then
    if [ -d "$INSTALL/discordBAK" ]; then
        sudo chmod -R 777 "$INSTALL/discordBAK"
        sudo rm -rf "$INSTALL/discordBAK"
    fi
    sudo mv "$INSTALL/discord" "$INSTALL/discordBAK"
    sudo cp -r "$TMP/discord" "$INSTALL"
fi

# Cleanup
rm -r "$TMP"
sudo rm -r "$INSTALL/discordBAK"
FILE=
INSTALL=
TMP=
