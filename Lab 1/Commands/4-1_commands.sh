#!/bin/bash

## 4.1 Commands ##

ip netns add examplens
ip link add veth0 type veth peer name veth1
ip link set veth1 netns examplens
ip netns exec examplens ip addr add 10.0.0.2/24 dev veth1
ip netns exec examplens ip link set dev veth1 up
ip addr add 10.0.0.1/24 dev veth0
ip link set dev veth0 up