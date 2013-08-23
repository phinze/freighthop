#!/bin/bash


HIERA_BASE="/etc/vagrant_on_rails/hiera_data"

APP_HIERA_DATA_SOURCE="${1}/.vagrant_on_rails.json"
APP_HIERA_DATA_TARGET="${HIERA_BASE}/app.json"

VAGRANT_HIERA_DATA_SOURCE="/vagrant/data"
VAGRANT_HIERA_DATA_TARGET="${HIERA_BASE}/vagrant"

if [ ! -d "$HIERA_BASE" ]; then
  mkdir -p $HIERA_BASE
fi

if [ ! -h "$VAGRANT_HIERA_DATA_TARGET" ]; then
  ln -s $VAGRANT_HIERA_DATA_SOURCE $VAGRANT_HIERA_DATA_TARGET
fi

if [ ! -h "$APP_HIERA_DATA_TARGET" ]; then
  ln -s $APP_HIERA_DATA_SOURCE $APP_HIERA_DATA_TARGET
fi
