#!/usr/bin/env cwl-runner

# this should produce a docker run of the form:
# docker run --rm -it -v /tmp/cosmic:/output -v ~/g2p-aggregator/harvester/CosmicMutantExport.tsv.gz:/g2p-aggregator/harvester/CosmicMutantExport.tsv.gz  cosmic-extract
# note: the swiftPath attribute is somewhat ad-hoc, there is no official support for openstack swift

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: cosmic-extract:latest
baseCommand: make-all.sh
inputs:
  /g2p-aggregator/harvester/CosmicMutantExport.tsv.gz:
    type: File
outputs:
  output:
    type: Directory
volumes:
 - name: output
   hostPath: /tmp/cosmic
   swiftPath: $OS_STORAGE_URL/etl-development/cosmic
 - name: /g2p-aggregator/harvester/CosmicMutantExport.tsv.gz
   hostPath: ~/g2p-aggregator/harvester/CosmicMutantExport.tsv.gz
   swiftPath: $OS_STORAGE_URL/etl-development/cosmic/CosmicMutantExport.tsv.gz
