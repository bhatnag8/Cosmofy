#!/bin/sh
# -----------------------------------------------------------------------------
# Script Name: ci_pre_xcodebuild.sh
# Description: This script is executed before the Xcode build process. It
#              updates the Info.plist file with the provided API key for the
#              debug environment.
# -----------------------------------------------------------------------------
# Usage:
#   Ensure that API_KEY_DEBUG environment variable is set before running
#   this script.
# -----------------------------------------------------------------------------
# Exit Codes:
#   0 - Success
#   1 - Failure (if any command fails) - [Disabled]
# -----------------------------------------------------------------------------
# Author: [Arryan Bhatnagar]
# Project: [Cosmofy]
# -----------------------------------------------------------------------------

echo "Stage: PRE-Xcode Build is activated .... "
 
# Navigate to the 'Cosmofy iOS' directory from current path
cd ../'Cosmofy iOS'/
# Replace the API_KEY_DEBUG value in Info.plist
plutil -replace API_KEY_DEBUG -string $API_KEY_DEBUG Info.plist
# Print the contents of Info.plist to verify the change
plutil -p Info.plist

# Navigate to the 'Cosmofy watchOS' directory from current path
cd ../'Cosmofy watchOS'/
# Replace the API_KEY_DEBUG value in Info.plist
plutil -replace API_KEY_DEBUG -string $API_KEY_DEBUG Info.plist
# Print the contents of Info.plist to verify the change
plutil -p Info.plist

# Navigate to the 'Cosmofy tvOS' directory from current path
cd ../'Cosmofy tvOS'/
# Replace the API_KEY_DEBUG value in Info.plist
plutil -replace API_KEY_DEBUG -string $API_KEY_DEBUG Info.plist
# Print the contents of Info.plist to verify the change
plutil -p Info.plist


echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
