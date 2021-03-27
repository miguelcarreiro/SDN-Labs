#!/bin/bash

## 4.2 Commands ##

# Near namespace

ip netns add near
ip link add one type veth peer name two
ip link set two netns near

ip netns exec near ip addr add 10.0.11.2/24 dev two
ip netns exec near ip link set dev two up

ip addr add 10.0.11.1/24 dev one
ip link set dev one up

# Far namespace

ip netns add far
ip link add three type veth peer name four
ip link set three netns near
ip link set four netns far

ip netns exec near ip addr add 10.0.12.1/24 dev three
ip netns exec near ip link set dev three up

ip netns exec far ip addr add 10.0.12.2/24 dev four
ip netns exec far ip link set dev four up

ip netns exec far ip addr add 10.0.13.1/24 dev lo
ip netns exec far ip link set dev lo up

# Routing rules

ip netns exec near ip route add 10.0.12.1 dev three via 10.0.12.1
ip netns exec near ip route add 10.0.11.2 dev two via 10.0.11.2
ip netns exec near ip route add 10.0.13.0/24 dev three via 10.0.12.2
ip netns exec far ip route add 10.0.11.0/24 dev four via 10.0.12.1

ip route add 10.0.12.0/24 dev one via 10.0.11.2
ip route add 10.0.13.0/24 dev one via 10.0.11.2

# Activate IP forwarding for namespaces

ip netns exec near sysctl -w net.ipv4.ip_forward=1
ip netns exec far sysctl -w net.ipv4.ip_forward=1
