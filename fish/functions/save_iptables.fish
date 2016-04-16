function save_iptables
	sudo iptables-save | sudo tee /etc/iptables/rules.v4
	sudo ip6tables-save | sudo tee /etc/iptables/rules.v6
end
