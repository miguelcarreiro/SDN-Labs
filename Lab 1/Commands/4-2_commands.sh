#!/bin/bash

## 4.2 Commands ##

# Near namespace

ip netns add near
ip link add veth1 type veth peer name veth2
ip link set veth2 netns near

ip netns exec near ip addr add 10.0.11.2/24 dev veth2
ip netns exec near ip link set dev veth2 up

ip addr add 10.0.11.1/24 dev veth1
ip link set dev veth1 up

# Far namespace

ip netns add far
ip link add veth3 type veth peer name veth4
ip link set veth3 netns near
ip link set veth4 netns far

ip netns exec near ip addr add 10.0.12.1/24 dev veth3
ip netns exec near ip link set dev veth3 up

ip netns exec far ip addr add 10.0.12.2/24 dev veth4
ip netns exec far ip link set dev veth4 up

ip netns exec far ip addr add 10.0.13.1/24 dev lo
ip netns exec far ip link set dev lo up

# Routing rules

ip netns exec near ip route add 10.0.12.1 dev veth3 via 10.0.12.1
ip netns exec near ip route add 10.0.11.2 dev veth2 via 10.0.11.2
ip netns exec near ip route add 10.0.13.0/24 dev veth3 via 10.0.12.2
ip netns exec far ip route add 10.0.11.0/24 dev veth4 via 10.0.12.1

ip route add 10.0.12.0/24 dev veth1 via 10.0.11.2
ip route add 10.0.13.0/24 dev veth1 via 10.0.11.2

# Activate IP forwarding for namespaces

ip netns exec near sysctl -w net.ipv4.ip_forward=1
ip netns exec far sysctl -w net.ipv4.ip_forward=1
