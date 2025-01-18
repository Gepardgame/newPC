function vpn() {
	local vpn_type configuration configurations
	OPTIND=1
	while getopts "v:c:" opt; do
		case $opt in
		v) vpn_type=$OPTARG ;;
		c) configuration=$OPTARG ;;
		\?) echo -e "${d_rot}-v for vpn type and -c for configuration" && return 1 ;;
		esac
	done

	if [ $(contains "openvpn wireguard" "$vpn_type") -ne 1 ]; then
		echo -e "${d_rot}Vpn Type is no available"
		return 1
	fi

	case $vpn_type in
	openvpn) configurations=$(ls /etc/openvpn/client 2>/dev/null | sed 's/\..*$//') ;;
	wireguard) echo -e "${d_rot}Not yet implemented!" && return 1 ;;
	esac

	echo $configurations

	if [ $(contains "$configurations" "$configuration") -ne 1 ]; then
		echo -e "${d_rot}Config is no available"
		return 1
	fi

	case $vpn_type in
	openvpn) sudo systemctl start openvpn-client@${configuration} ;;
	wireguard) echo -e "${d_rot}Not yet implemented!" && return 1 ;;
	esac

}
