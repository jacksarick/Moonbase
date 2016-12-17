#!/bin/bash

projects=$1
user=$2
repo=$3

cd $projects
git clone $repo