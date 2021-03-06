sh sudo ovs-ofctl add-flow s1 dl_dst=00:00:00:00:00:02,actions=output:1
sh sudo ovs-ofctl add-flow s1 dl_dst=00:00:00:00:00:04,actions=output:1
sh sudo ovs-ofctl add-flow s1 dl_dst=00:00:00:00:00:03,actions=output:2
sh sudo ovs-ofctl add-flow s1 dl_dst=00:00:00:00:00:01,actions=output:3

sh sudo ovs-ofctl add-flow s2 dl_dst=00:00:00:00:00:01,actions=output:3
sh sudo ovs-ofctl add-flow s2 dl_dst=00:00:00:00:00:01,actions=output:1
sh sudo ovs-ofctl add-flow s2 dl_dst=00:00:00:00:00:04,actions=output:2
sh sudo ovs-ofctl add-flow s2 dl_dst=00:00:00:00:00:02,actions=output:3


sh sudo ovs-ofctl add-flow s3 dl_dst=00:00:00:00:00:03,actions=output:3
sh sudo ovs-ofctl add-flow s3 dl_dst=00:00:00:00:00:04,actions=output:4

sh sudo ovs-ofctl add-flow s3 in_port=3,actions=output:1
sh sudo ovs-ofctl add-flow s3 in_port=4,actions=output:2

sh sudo ovs-ofctl add-flow s1 priority=500,in_port=1,dl_src=00:00:00:00:00:01,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s1 priority=500,in_port=2,dl_src=00:00:00:00:00:01,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s1 priority=400,dl_dst=ff:ff:ff:ff:ff:ff,actions=output:2,3

sh sudo ovs-ofctl add-flow s2 priority=500,in_port=1,dl_src=00:00:00:00:00:02,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s2 priority=500,in_port=2,dl_src=00:00:00:00:00:02,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s2 priority=400,dl_dst=ff:ff:ff:ff:ff:ff,actions=output:1,3

sh sudo ovs-ofctl add-flow s3 priority=500,in_port=1,dl_src=00:00:00:00:00:03,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s3 priority=500,in_port=2,dl_src=00:00:00:00:00:03,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s3 priority=500,in_port=1,dl_src=00:00:00:00:00:04,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s3 priority=500,in_port=2,dl_src=00:00:00:00:00:04,dl_dst=ff:ff:ff:ff:ff:ff,actions=drop
sh sudo ovs-ofctl add-flow s3 priority=400,dl_dst=ff:ff:ff:ff:ff:ff,actions=output:2,3,4

sh sudo ovs-ofctl add-flow s1 priority=500,dl_dst=33:33:00:00:00:01,actions=drop
sh sudo ovs-ofctl add-flow s2 priority=500,dl_dst=33:33:00:00:00:01,actions=drop
sh sudo ovs-ofctl add-flow s3 priority=500,dl_dst=33:33:00:00:00:01,actions=drop
sh sudo ovs-ofctl add-flow s1 priority=500,dl_dst=33:33:00:00:00:02,actions=drop
sh sudo ovs-ofctl add-flow s2 priority=500,dl_dst=33:33:00:00:00:02,actions=drop
sh sudo ovs-ofctl add-flow s3 priority=500,dl_dst=33:33:00:00:00:02,actions=drop
sh sudo ovs-ofctl add-flow s1 priority=500,dl_dst=33:33:00:00:00:16,actions=drop
sh sudo ovs-ofctl add-flow s2 priority=500,dl_dst=33:33:00:00:00:16,actions=drop
sh sudo ovs-ofctl add-flow s3 priority=500,dl_dst=33:33:00:00:00:16,actions=drop