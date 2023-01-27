#!/bin/bash

#####################################################################
### Please set the paths accordingly. In case you don't have all  ###
### the listed folders, just keep that line commented out.        ###
#####################################################################
### Path to your config folder you want to backup
config_folder=~/klipper_config

### Path to your Klipper folder, by default that is '~/klipper'
klipper_folder=~/klipper

### Path to your Moonraker folder, by default that is '~/moonraker'
moonraker_folder=~/moonraker

### Path to your Mainsail folder, by default that is '~/mainsail'
mainsail_folder=~/mainsail

### Path to your KlipperScreen folder, by default that is '~/KlipperScreen'
#klipperscreen_folder=~/KlipperScreen

### Path to your Fluidd folder, by default that is '~/fluidd'
#fluidd_folder=~/fluidd

### Path to your Z Calibration folder, by default that is '~/z_calibration'
#z_calibration_folder=~/klipper_z_calibration

#####################################################################
#####################################################################


#####################################################################
################ !!! DO NOT EDIT BELOW THIS LINE !!! ################
#####################################################################
grab_version(){
  if [ ! -z "$klipper_folder" ]; then
    cd "$klipper_folder"
    klipper_commit=$(git rev-parse --short=7 HEAD)
    m1="Klipper on commit: $klipper_commit"
    cd ..
  fi
  if [ ! -z "$moonraker_folder" ]; then
    cd "$moonraker_folder"
    moonraker_commit=$(git rev-parse --short=7 HEAD)
    m2="Moonraker on commit: $moonraker_commit"
    cd ..
  fi
  if [ ! -z "$mainsail_folder" ]; then
    mainsail_ver=$(head -n 1 $mainsail_folder/.version)
    m3="Mainsail version: $mainsail_ver"
  fi
  if [ ! -z "$fluidd_folder" ]; then
    fluidd_ver=$(head -n 1 $fluidd_folder/.version)
    m4="Fluidd version: $fluidd_ver"
  fi
  if [ ! -z "$klipperscreen_folder" ]; then
    cd "$klipperscreen_folder"
    klipperscreen_commit=$(git rev-parse --short=7 HEAD)
    m5="KlipperScreen on commit: $klipperscreen_commit"
    cd ..
  fi
  if [ ! -z "$z_calibration_folder" ]; then
    cd "$z_calibration_folder"
    z_calibration_commit=$(git rev-parse --short=7 HEAD)
    m6="Z Calibration on commit: $z_calibration_commit"
    cd ..
  fi
}

push_config(){
  cd $config_folder
  git pull
  git add .
  current_date=$(date +"%Y-%m-%d %T")
  git commit -m "Autocommit from $current_date" -m "$m1" -m "$m2" -m "$m3" -m "$m4" -m "$m5" -m "$m6"
  git push
}

grab_version
push_config
