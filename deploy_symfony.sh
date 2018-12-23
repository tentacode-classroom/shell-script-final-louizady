#!/bin/bash 


# ====== CLONE GIT =====

#clone le projet git@github.com:etc dans le dossier Symfony
mkdir ../Symfony
git clone https://github.com/tentacode-classroom/project-shopping-redwappin.git ../Symfony

if [[ ! $? ]]
then 
    exit
fi 

# ====== INSTALL DEPENDENCIES =====
#installation de composer
composer install
composer require --prod doctrine/doctrine-fixtures-bundle

#installation de npm
npm install 


# ====== .env CREATION =====
echo "Quel est votre nom d'utilisateur MySQL ?"
read DDB_USER 
echo "Quel est votre mot de passe MySQL ?"
read DDB_PWD 
echo "Quel est le nom de la base de données ?"
read DDB_NAME

DOTENV=../Symfony/.env

if [[ -e $DOTENV ]]
then 
    echo le fichier env existe
    cat $DOTENV | sed -e s/"DATABASE_URL=mysql://db_user:db_password@127.0.0.1:3306/db_name"/"DATABASE_URL=mysql://$DDB_USER:$DDB_PWD@127.0.0.1:3306/$DDB_NAME"
else
    cd ../Symfony
    touch .env 
    echo "DATABASE_URL=mysql://$DDB_USER:$DDB_PWD@127.0.0.1:3306/$DDB_NAME" >> $DOTENV
fi


# ====== DATABASE =====
# au cas ou il y aurait déjà une base de donnée
`bin/console doctrine:database:drop --force --if-exists`

# création de la base de donnée
bin/console doctrine:database:create 

# création des migrations
bin/console doctrine:make:migration 

# application des migrations
bin/console doctrine:migration:migrate

# application des fixtures
bin/console doctrine:fixtures:load