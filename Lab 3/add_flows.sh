# Add flows
curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d @flows.json 'http://localhost:8181/onos/v1/flows' --user onos:rocks

# Delete flow
curl -X DELETE --header 'Accept: application/json' 'http://localhost:8181/onos/v1/flows/of%3A0000000000000003/49821071350773381' --user onos:rocks

# Not needed
curl -X POST -H "content-type:application/json" http://localhost:8181/onos/v1/network/configuration -d @onos-config.json --user onos:rocks


