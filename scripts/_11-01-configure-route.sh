#!/bin/bash
# Run in each worker

set -euo pipefail

# sudo pacman -Sy --noconfirm
# sudo pacman -S net-tools --noconfirm # for route command

case "${HOSTNAME}" in
node-0)
	sudo route add -net 10.200.1.0/24 gw 10.240.0.21
	;;
node-1)
	sudo route add -net 10.200.0.0/24 gw 10.240.0.20
	;;
*)
	echo "invalid hostname"
	;;
esac


