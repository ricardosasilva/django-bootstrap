#!/bin/bash

DJANGO_BOOTSTRAP_PATH=/home/ricardo/projects/salamandra/django-bootstrap
PROJECT_ROOT=$HOME/projects/salamandra

PROJECT=$1
IDE="aptana-studio-3.0"

mkdir -p $PROJECT_ROOT/$PROJECT/sources/python
mkdir -p $PROJECT_ROOT/$PROJECT/sources/static
mkdir -p $PROJECT_ROOT/$PROJECT/workspaces/$IDE
mkdir -p $PROJECT_ROOT/$PROJECT/__output__/static/
mkdir -p $PROJECT_ROOT/$PROJECT/__output__/userfiles/

source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv $PROJECT --no-site-packages
workon $PROJECT
cdvirtualenv
echo "$PROJECT_ROOT/$PROJECT/sources" > .project
cd bin

sed -e "s/\$PROJECT/$PROJECT/g" $DJANGO_BOOTSTRAP_PATH/templates/postactivate > postactivate

chmod 755 postactivate
cdproject

pip install django
cd python
django-admin.py startproject $PROJECT
cd $PROJECT
rm settings.py
mkdir settings
cd settings
touch __init__.py

sed -e "s/\$PROJECT/$PROJECT/g" $DJANGO_BOOTSTRAP_PATH/templates/dev.py > dev.py
sed -e "s/\$PROJECT/$PROJECT/g" $DJANGO_BOOTSTRAP_PATH/templates/base.py > base.py
