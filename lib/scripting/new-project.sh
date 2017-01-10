#!/bin/bash

username=$1
repo=$2

data=https://api.github.com/users/$username/repos

cd site/$projects
git clone https://github.com/$username/$repo.git
cd $repo
./setup
cd ../..

db=user/projects.yml

proj="NAME"
short="SHORTCODE"
desc="DESC"

echo "- project: $proj" >> $db
echo "ping"
echo "  user: $user" >> $db
echo "  short: $short" >> $db
echo "  repo: https://github.com/$username/$repo" >> $db
echo "  desc: $desc" >> $db
echo "" >> $db
echo "ping"