#!/bin/bash


if [ "$1" = "test-patch" ]; then
  echo "Patching returner"
  sed -i 's/if value:/if type(value) == bool or value:/' /usr/lib/python3/dist-packages/salt/returners/__init__.py;
fi

echo "Launching master"
salt-master -d
echo "Launching minion"
salt-minion -d
echo "Waiting 2 seconds..."
sleep 2

case "$1" in
  test*)
    salt container state.highstate --return highstate && exit 0
    echo "Couldnt execute highstate" >&2
    ;;
  *) exec "$@";;
esac
