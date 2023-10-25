#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
cd $CI_WORKSPACE/ci_scripts || exit 1

# Write a JSON File containing all the environment variables and secrets.
printf "{\"STRIPE_KEY\":\"%s\"}" "$STRIPE_KEY" >> ../Cosmofy/Cosmofy/SupportingFiles/secrets.json

echo "Wrote secrets.json file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
