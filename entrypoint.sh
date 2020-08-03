#!/bin/bash


echo "Launching master"
salt-master -d
echo "Launching minion"
salt-minion -d
echo "Waiting 2 seconds..."
sleep 2

case "$1" in
  test)
    salt container state.highstate --return highstate && exit 0
    echo "Couldnt execute highstate" >&2
    ;;
  *) exec "$@";;
esac
