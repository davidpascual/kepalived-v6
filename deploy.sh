#!/bin/bash

set -ex

# The image can't be looked up from the config map, so we have to manually
# insert it into the daemonset spec.
image="quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:3e96c1755163ecb2827bf4b4d1dfdabf2a125e6aeef620a0b8ba52d0c450432c"
sed -e "s|@KEEPALIVED_IMAGE|$image|" keepalived_daemonset.tmpl > keepalived_daemonset.yaml

oc apply -f ./namespace.yaml
oc apply -f ./user_config.yaml
oc apply -f ./scc.yaml
oc adm policy add-scc-to-user privileged -n keepalived-v6 -z cluster-hosted-keepalived
oc apply -f keepalived_config.yaml
oc apply -f keepalived_daemonset.yaml
