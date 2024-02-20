#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# for future reference
# 

cd ../Cosmofy/

plutil -replace API_KEY_DEBUG -string $API_KEY_DEBUG Info.plist

plutil -p Info.plist

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
