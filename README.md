# Deployment instructions

Run the following commands:

- oc apply -f namespace.yaml
- Edit user_config.yaml file
- oc apply -f user_config.yaml
- oc apply -f scc.yaml
- oc adm policy add-scc-to-user privileged -n keepalived-v6  -z cluster-hosted-keepalived
- oc apply -f keepalived_config.yaml
- oc apply -f keepalived_daemonset.yaml
