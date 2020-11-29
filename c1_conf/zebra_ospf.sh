ip netns exec c1 /usr/lib/frr/zebra --config_file c1_zebra.conf --pid_file c1_zebra.pid --daemon -N c1
ip netns exec c1 /usr/lib/frr/ospfd --config_file c1_ospfd.conf --pid_file c1_ospfd.pid --daemon -N c1
