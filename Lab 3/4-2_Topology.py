"""4.2 Topology

Adding the 'topos' dict with a key/value pair to generate our newly defined
topology enables one to pass in '--topo=mytopo' from the command line.
"""

from mininet.topo import Topo
from mininet.link import TCLink

class ThreeNodeTopo( Topo ):
    "Simple topology example."

    def build( self ):
        "Create custom topo."

        # Add hosts and switches
        h1, h2, h3, h4 = [ self.addHost( h ) for h in ( 'h1', 'h2', 'h3', 'h4' ) ]

        s1, s2, s3 = [ self.addSwitch( s ) for s in ( 's1', 's2', 's3' ) ]

        # Link custom params
        stdLink = {
            'cls': TCLink,
            'bw': 1000,
        }

        sw1sw3 = {
            'cls': TCLink,
            'bw': 100,
            'delay': '10ms',
        }

        # Add links
        self.addLink( s1, s2, **stdLink )
        self.addLink( s1, s3, **sw1sw3 )
        self.addLink( s2, s3, **stdLink )
        self.addLink( s1, h1, **stdLink )
        self.addLink( s2, h2, **stdLink )
        self.addLink( s3, h3, **stdLink )
        self.addLink( s3, h4, **stdLink )


topos = { 'mytopo': ( lambda: ThreeNodeTopo() ) }
