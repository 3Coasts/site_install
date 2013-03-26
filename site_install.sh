read -p "Database location: " db_location
read -p "Database name: " db_name
read -p "Database username: " db_user
read -p "Database password: " db_password

read -p "Name of site: " site_name
read -p "Site Email Address: " site_mail

read -p "Admin account name: " account_name
read -p "Admin account password: " account_password
read -p "Admin account email: " account_email

drush dl
mv drupal-*/* drupal-*/.htaccess ./
rm -Rf drupal-*/

drush site-install minimal --db-url=mysql://$db_user:$db_password@$db_location/$db_name --account-name=$account_name --account-mail=$account_email --account-pass=$account_password --site-name=$site_name --site-mail=$site_mail

rm -Rf CHANGELOG.txt INSTALL.sqlite.txt COPYRIGHT.txt INSTALL.mysql.txt INSTALL.pgsql.txt LICENSE.txt INSTALL.txt MAINTAINERS.txt README.txt web.config UPGRADE.txt install.php

drush en contextual field_ui file image list menu number openid options taxonomy -y

drush dl admin rubik tao devel views ctools panels omega omega_tools markdown libraries less
drush en admin devel views views_ui ctools omega_tools markdown libraries less -y

mkdir sites/all/libraries

drush vset admin_theme rubik

read -p "What would you like to name your omega subtheme: " subtheme
drush omega-subtheme "$subtheme"