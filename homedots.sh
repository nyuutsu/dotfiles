#!/usr/bin/env zsh

read "?🚨 Are you sure you want to overwrite your config & dotfiles? 🚨 "
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  local user=$(whoami)
  local parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
  cp -Rs --remove-destination $parent_path/nyuu/. /home/$user
fi