#!/bin/bash

projects=$1
user=$2
repo=$3

cd $projects
git clone https://github.com/$repo.git
cd ..

db=user/projects.yml

proj="NAME"
short="SHORTCODE"
desc="DESC"

echo "- project: $proj" >> $db
echo "ping"
echo "  user: $user" >> $db
echo "  short: $short" >> $db
echo "  repo: $repo" >> $db
echo "  desc: $desc" >> $db
echo "" >> $db
echo "ping"