#!/bin/bash
##############################################################################################
#																							 #
#                 mpls_encap->              pop                <-mpls_encap                  #
# (c1) ------------ [pe1] ----------------- [p] ------------------ [pe2] -------------- (c2) #
# (1.1.1.1   1.1.1.2) | (11.1.1.1  11.1.1.2) | (22.1.1.2   22.1.1.1) | (2.1.1.2   2.1.1.1)   #
#																							 #	
##############################################################################################
ip netns add c1
ip netns e c1 ip link set lo up
ip netns add c2
ip netns e c2 ip link set lo up

ip netns add pe1
ip netns e pe1 ip link set lo up
ip link add c1-pe1-eth type veth peer name pe1-c1-eth
ip link set c1-pe1-eth netns c1
ip netns e c1 ip link set c1-pe1-eth up
ip netns e c1 ip addr add 1.1.1.1/30 dev c1-pe1-eth
ip link set pe1-c1-eth netns pe1
ip netns e pe1 ip link set pe1-c1-eth up
ip netns e pe1 ip addr add 1.1.1.2/30 dev pe1-c1-eth


ip netns add pe2
ip netns e pe2 ip link set lo up
ip link add c2-pe2-eth type veth peer name pe2-c2-eth
ip link set c2-pe2-eth netns c2
ip netns e c2 ip link set c2-pe2-eth up
ip netns e c2 ip addr add 2.1.1.1/30 dev c2-pe2-eth
ip link set pe2-c2-eth netns pe2
ip netns e pe2 ip link set pe2-c2-eth up
ip netns e pe2 ip addr add 2.1.1.2/30 dev pe2-c2-eth

ip netns add p
ip netns e p ip link set lo up

ip link add p-pe1-eth type veth peer name pe1-p-eth
ip link set p-pe1-eth netns p
ip netns e p ip link set p-pe1-eth up
ip netns e p ip addr add 11.1.1.2/30 dev p-pe1-eth
ip link set pe1-p-eth netns pe1
ip netns e pe1 ip link set pe1-p-eth up
ip netns e pe1 ip addr add 11.1.1.1/30 dev pe1-p-eth

ip link add p-pe2-eth type veth peer name pe2-p-eth
ip link set p-pe2-eth netns p
ip netns e p ip link set p-pe2-eth up
ip netns e p ip addr add 22.1.1.2/30 dev p-pe2-eth
ip link set pe2-p-eth netns pe2
ip netns e pe2 ip link set pe2-p-eth up
ip netns e pe2 ip addr add 22.1.1.1/30 dev pe2-p-eth

################################################################
# Routing

modprobe mpls_router

ip netns exec p sysctl -w net.mpls.platform_labels=10000
ip netns exec pe1 sysctl -w net.mpls.platform_labels=10000
ip netns exec pe2 sysctl -w net.mpls.platform_labels=10000

# ip netns e pe1 sysctl -w net.mpls.conf.pe1-c1-eth.input=1
# ip netns e pe2 sysctl -w net.mpls.conf.pe2-c2-eth.input=1
ip netns e pe1 sysctl -w net.mpls.conf.pe1-p-eth.input=1
ip netns e pe2 sysctl -w net.mpls.conf.pe2-p-eth.input=1
ip netns e p sysctl -w net.mpls.conf.p-pe1-eth.input=1
ip netns e p sysctl -w net.mpls.conf.p-pe2-eth.input=1

# ip netns e c1 ip route add default via 1.1.1.2 dev c1-pe1-eth
# ip netns e c2 ip route add default via 2.1.1.2 dev c2-pe2-eth

ip netns e pe1 sysctl -w net.ipv4.ip_forward=1
# ip netns e pe1 ip route add 2.1.1.0/30 encap mpls 100 via 11.1.1.2
# #

ip netns e pe2 sysctl -w net.ipv4.ip_forward=1
# ip netns e pe2 ip route add 1.1.1.0/30 encap mpls 200 via 22.1.1.2
# #

ip netns e p sysctl -w net.ipv4.ip_forward=1

# ip netns e p ip -f mpls route add 100 via inet 22.1.1.1
# ip netns e p ip -f mpls route add 200 via inet 11.1.1.1
