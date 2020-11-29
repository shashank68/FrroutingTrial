ip netns exec c2 /usr/lib/frr/zebra --config_file c2_zebra.conf --pid_file c2_zebra.pid --daemon -N c2
ip netns exec c2 /usr/lib/frr/ospfd --config_file c2_ospfd.conf --pid_file c2_ospfd.pid --daemon -N c2
