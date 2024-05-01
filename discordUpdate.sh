#! /bin/bash
#-----------------------------------------------------------------------------#
# Script to manually install discord from the tar.gz offering. Tested on
# Fedora 39, 40
#-----------------------------------------------------------------------------#

# Find current Discord install
INSTALL=`readlink -f `which Discord` | xargs dirname | sed 's/\/discord//'`

# Find file
FILE=`find ~/Downloads -type f -iname "discord*.tar.gz" | sort | tail -n1`
echo "Found: $FILE"

# Setup Dir
TMP=~/Downloads/tmp
if [ ! -d "$TMP" ]; then
    mkdir "$TMP"
fi

# Extract file
tar -xzf $FILE -C $TMP
mv "$TMP/Discord" "$TMP/discord"

# Move files
if [ -d "$INSTALL" ]; then
    echo "Found install at $INSTALL"
    if [ -d "$INSTALL/discordBAK" ]; then
        # Unknown if the following line is necessary
        sudo chmod -R 777 "$INSTALL/discordBAK"
        # Not sure if -f is needed
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
