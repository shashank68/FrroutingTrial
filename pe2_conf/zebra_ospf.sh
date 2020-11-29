ip netns exec pe2 /usr/lib/frr/zebra --config_file pe2_zebra.conf --pid_file pe2_zebra.pid --daemon -N pe2
ip netns exec pe2 /usr/lib/frr/ospfd --config_file pe2_ospfd.conf --pid_file pe2_ospfd.pid --daemon -N pe2
ip netns exec pe2 /usr/lib/frr/ldpd --config_file pe2_ldp.conf --pid_file pe2_ldp.pid --daemon -N pe2
