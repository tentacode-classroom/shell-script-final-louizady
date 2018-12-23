
#Recupère les modifications depuis le depot git
git pull origin master

#Reinstalle Composer
composer i

#Installation des dependences de doctrine 
composer require --prod doctrine/doctrine-fixtures-bundle


#Npm install
npm i
npm run build

#Application de la migration doctrine
bin/console doctrine:migration:migrate