#!/bin/bash
## 4.3 Commands ##

# Add R1 and R2 namespaces
ip netns add r1
ip netns add r2

# R1-R2 interface
ip link add r1.r2 type veth peer name r2.r1

ip link set r1.r2 netns r1
ip link set r2.r1 netns r2

ip netns exec r1 ip addr add 10.0.12.1/24 dev r1.r2
ip netns exec r1 ip link set dev r1.r2 up

ip netns exec r2 ip addr add 10.0.12.2/24 dev r2.r1
ip netns exec r2 ip link set dev r2.r1 up

# R1 namespace

# R1 - Net1 hosts configuration

ip netns add host1
ip link add veth1.10 type veth peer name vhost1.10
ip link set veth1.10 netns r1
ip link set vhost1.10 netns host1

ip netns exec r1 ip addr add 10.0.1.10/24 dev veth1.10
ip netns exec r1 ip link set dev veth1.10 up

ip netns exec host1 ip addr add 10.0.1.11/24 dev vhost1.10
ip netns exec host1 ip link set dev vhost1.10 up

ip netns add host2
ip link add veth1.20 type veth peer name vhost1.20
ip link set veth1.20 netns r1
ip link set vhost1.20 netns host2

ip netns exec r1 ip addr add 10.0.1.20/24 dev veth1.20
ip netns exec r1 ip link set dev veth1.20 up

ip netns exec host2 ip addr add 10.0.1.21/24 dev vhost1.20
ip netns exec host2 ip link set dev vhost1.20 up

# R1 - Net3 hosts configuration

ip netns add host5
ip link add veth3.50 type veth peer name vhost3.50
ip link set veth3.50 netns r1
ip link set vhost3.50 netns host5

ip netns exec r1 ip addr add 10.0.3.50/24 dev veth3.50
ip netns exec r1 ip link set dev veth3.50 up

ip netns exec host5 ip addr add 10.0.3.51/24 dev vhost3.50
ip netns exec host5 ip link set dev vhost3.50 up

ip netns add host6
ip link add veth3.60 type veth peer name vhost3.60
ip link set veth3.60 netns r1
ip link set vhost3.60 netns host6

ip netns exec r1 ip addr add 10.0.3.60/24 dev veth3.60
ip netns exec r1 ip link set dev veth3.60 up

ip netns exec host6 ip addr add 10.0.3.61/24 dev vhost3.60
ip netns exec host6 ip link set dev vhost3.60 up

ip netns add host7
ip link add veth3.70 type veth peer name vhost3.70
ip link set veth3.70 netns r1
ip link set vhost3.70 netns host7

ip netns exec r1 ip addr add 10.0.3.70/24 dev veth3.70
ip netns exec r1 ip link set dev veth3.70 up

ip netns exec host7 ip addr add 10.0.3.71/24 dev vhost3.70
ip netns exec host7 ip link set dev vhost3.70 up

# R2 namespace

# R2 - Net2 hosts configuration

ip netns add host3
ip link add veth2.30 type veth peer name vhost2.30
ip link set veth2.30 netns r2
ip link set vhost2.30 netns host3

ip netns exec r2 ip addr add 10.0.2.30/24 dev veth2.30
ip netns exec r2 ip link set dev veth2.30 up

ip netns exec host3 ip addr add 10.0.2.31/24 dev vhost2.30
ip netns exec host3 ip link set dev vhost2.30 up

ip netns add host4
ip link add veth2.40 type veth peer name vhost2.40
ip link set veth2.40 netns r2
ip link set vhost2.40 netns host4

ip netns exec r2 ip addr add 10.0.2.40/24 dev veth2.40
ip netns exec r2 ip link set dev veth2.40 up

ip netns exec host4 ip addr add 10.0.2.41/24 dev vhost2.40
ip netns exec host4 ip link set dev vhost2.40 up

# Routing rules

ip netns exec r1 ip route add 10.0.2.0/24 dev r1.r2 via 10.0.12.2
ip netns exec r2 ip route add 10.0.1.0/24 dev r2.r1 via 10.0.12.1
ip netns exec r2 ip route add 10.0.3.0/24 dev r2.r1 via 10.0.12.1

ip netns exec r1 ip route add 10.0.1.11 dev veth1.10 src 10.0.1.10
ip netns exec r1 ip route add 10.0.1.10 dev veth1.10 via 10.0.1.10
ip netns exec host1 ip route add default dev vhost1.10 via 10.0.1.10

ip netns exec r1 ip route add 10.0.1.21 dev veth1.20 src 10.0.1.20
ip netns exec r1 ip route add 10.0.1.20 dev veth1.20 via 10.0.1.20
ip netns exec host2 ip route add default dev vhost1.20 via 10.0.1.20

ip netns exec r1 ip route add 10.0.3.51 dev veth3.50 src 10.0.3.50
ip netns exec r1 ip route add 10.0.3.50 dev veth3.50 via 10.0.3.50
ip netns exec host5 ip route add default dev vhost3.50 via 10.0.3.50

ip netns exec r1 ip route add 10.0.3.61 dev veth3.60 src 10.0.3.60
ip netns exec r1 ip route add 10.0.3.60 dev veth3.60 via 10.0.3.60
ip netns exec host6 ip route add default dev vhost3.60 via 10.0.3.60

ip netns exec r1 ip route add 10.0.3.71 dev veth3.70 src 10.0.3.70
ip netns exec r1 ip route add 10.0.3.70 dev veth3.70 via 10.0.3.70
ip netns exec host7 ip route add default dev vhost3.70 via 10.0.3.70

ip netns exec r2 ip route add 10.0.2.31 dev veth2.30 src 10.0.2.30
ip netns exec r2 ip route add 10.0.2.30 dev veth2.30 via 10.0.2.30
ip netns exec host3 ip route add default dev vhost2.30 via 10.0.2.30

ip netns exec r2 ip route add 10.0.2.41 dev veth2.40 src 10.0.2.40
ip netns exec r2 ip route add 10.0.2.40 dev veth2.40 via 10.0.2.40
ip netns exec host4 ip route add default dev vhost2.40 via 10.0.2.40

ip netns exec r1 ip route del 10.0.1.0/24 dev veth1.10 proto kernel scope link src 10.0.1.10
ip netns exec r1 ip route del 10.0.1.0/24 dev veth1.20 proto kernel scope link src 10.0.1.20

ip netns exec r1 ip route del 10.0.3.0/24 dev veth3.50 proto kernel scope link src 10.0.3.50
ip netns exec r1 ip route del 10.0.3.0/24 dev veth3.60 proto kernel scope link src 10.0.3.60
ip netns exec r1 ip route del 10.0.3.0/24 dev veth3.70 proto kernel scope link src 10.0.3.70

# Activate IP forwarding for namespaces

ip netns exec r1 sysctl -w net.ipv4.ip_forward=1
ip netns exec r2 sysctl -w net.ipv4.ip_forward=1
ip netns exec host1 sysctl -w net.ipv4.ip_forward=1
ip netns exec host2 sysctl -w net.ipv4.ip_forward=1
ip netns exec host3 sysctl -w net.ipv4.ip_forward=1
ip netns exec host4 sysctl -w net.ipv4.ip_forward=1
ip netns exec host5 sysctl -w net.ipv4.ip_forward=1
ip netns exec host6 sysctl -w net.ipv4.ip_forward=1
ip netns exec host7 sysctl -w net.ipv4.ip_forward=1
