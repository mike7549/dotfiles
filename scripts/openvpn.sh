#!/bin/bash

State=$(pgrep openvpn)

if [ -z "$State" ]; then
	sudo openvpn --config /home/michael/.tmp/vpn/client.ovpn
else
	sudo pkill openvpn
fi
