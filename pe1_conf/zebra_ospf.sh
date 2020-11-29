ip netns exec pe1 /usr/lib/frr/zebra --config_file pe1_zebra.conf --pid_file pe1_zebra.pid --daemon -N pe1
ip netns exec pe1 /usr/lib/frr/ospfd --config_file pe1_ospfd.conf --pid_file pe1_ospfd.pid --daemon -N pe1
ip netns exec pe1 /usr/lib/frr/ldpd --config_file pe1_ldp.conf --pid_file pe1_ldp.pid --daemon -N pe1
