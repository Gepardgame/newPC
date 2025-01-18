#!/bin/bash

_vpn_completion() {
	local cur prev vpn_types configs

	# Current and previous word
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD - 1]}"

	# Supported VPN types
	vpn_types="openvpn wireguard"

	case "$prev" in
	-v) # Autocomplete VPN types
		COMPREPLY=($(compgen -W "$vpn_types" -- "$cur"))
		return 0
		;;
	-c) # Autocomplete configurations based on VPN type
		# Find the VPN type from previous options
		local vpn_type=$(echo "${COMP_WORDS[@]}" | grep -oP '(?<=-v )\S+')

		case "$vpn_type" in
		openvpn)
			# List configurations from /etc/openvpn/client
			configs=$(ls /etc/openvpn/client 2>/dev/null | sed 's/\..*$//')
			;;
		wireguard)
			# Placeholder for wireguard configurations
			configs="NotImplemented"
			;;
		*)
			configs=""
			;;
		esac

		COMPREPLY=($(compgen -W "$configs" -- "$cur"))
		return 0
		;;
	*)
		# Default case if the user hasn't typed any valid option
		if [[ ${COMP_CWORD} -eq 1 ]]; then
			# First argument, only show -v option
			COMPREPLY=($(compgen -W "-v" -- "$cur"))
		else
			# After -v, show -c option
			COMPREPLY=($(compgen -W "-c" -- "$cur"))
		fi
		return 0
		;;
	esac
}

# Register the completion function for the `vpn` command
complete -F _vpn_completion vpn
