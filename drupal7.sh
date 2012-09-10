#!/bin/env sh

test ! -e sites/all/modules/libraries && git submodule add --branch 7.x-2.x http://git.drupal.org/project/libraries.git sites/all/modules/libraries
drush pm-list --pipe --status='enabled'|grep -qx libraries || drush pm-enable -y libraries

test ! -e sites/all/libraries/gelf-php && git submodule add https://github.com/Graylog2/gelf-php.git sites/all/libraries/gelf-php
test ! -e sites/all/modules/gelf && git submodule add --branch 7.x-1.x http://git.drupal.org/project/gelf.git sites/all/modules/gelf
drush pm-list --pipe --status='enabled'|grep -qx gelf || drush pm-enable -y gelf

if [ -f modules.enabled ]; then
    cat modules.enabled|grep -qx gelf || echo gelf >> modules.enabled
    cat modules.enabled|grep -qx libraries || echo libraries >> modules.enabled
fi
