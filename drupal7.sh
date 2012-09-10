#!/bin/env sh

git submodule add --branch 7.x-2.x http://git.drupal.org/project/libraries.git sites/all/modules/libraries
drush pm-enable -y libraries
git submodule add https://github.com/Graylog2/gelf-php.git sites/all/libraries/gelf-php
git submodule add --branch 7.x-1.x http://git.drupal.org/project/gelf.git sites/all/modules/gelf
drush pm-enable -y gelf
