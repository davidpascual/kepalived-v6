#!/bin/bash

set -ex

# The image can't be looked up from the config map, so we have to manually
# insert it into the daemonset spec.
image="quay.io/openshift/origin-keepalived-ipfailover:4.9"
sed -e "s|@KEEPALIVED_IMAGE|$image|" keepalived_daemonset.tmpl > keepalived_daemonset.yaml

oc apply -f ./namespace.yaml
oc apply -f ./user_config.yaml
oc apply -f ./scc.yaml
oc adm policy add-scc-to-user privileged -n keepalived-v6 -z cluster-hosted-keepalived
oc apply -f keepalived_config.yaml
oc apply -f keepalived_daemonset.yaml
