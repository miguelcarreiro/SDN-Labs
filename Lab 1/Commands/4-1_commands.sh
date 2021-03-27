#!/bin/bash

## 4.1 Commands ##

ip netns add examplens
ip link add external type veth peer name internal
ip link set internal netns examplens

ip netns exec examplens ip addr add 10.0.0.2/24 dev internal
ip netns exec examplens ip link set dev internal up

ip addr add 10.0.0.1/24 dev external
ip link set dev external up
