ip netns exec p /usr/lib/frr/zebra --config_file p_zebra.conf --pid_file p_zebra.pid --daemon -N p
ip netns exec p /usr/lib/frr/ospfd --config_file p_ospfd.conf --pid_file p_ospfd.pid --daemon -N p
ip netns exec p /usr/lib/frr/ldpd --config_file p_ldp.conf --pid_file p_ldp.pid --daemon -N p
