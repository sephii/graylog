#!/bin/env sh

test ! -e sites/all/modules/libraries && git submodule add --branch 6.x-1.x http://git.drupal.org/project/libraries.git sites/all/modules/libraries
drush pm-list --pipe --status='enabled'|grep -qx libraries || drush pm-enable -y libraries

test ! -e sites/all/libraries/gelf-php && git submodule add https://github.com/Graylog2/gelf-php.git sites/all/libraries/gelf-php
# Use our version of the gelf module until http://drupal.org/node/1781116 gets
# merged
test ! -e sites/all/modules/gelf && git submodule add --branch 6.x-1.x https://github.com/sephii/gelf.git sites/all/modules/gelf
drush pm-list --pipe --status='enabled'|grep -qx gelf || drush pm-enable -y gelf

if [ -f modules.enabled ]; then
    grep -qx gelf modules.enabled || echo gelf >> modules.enabled
    grep -qx libraries modules.enabled || echo libraries >> modules.enabled
fi
