#!/bin/bash

set -euxo pipefail

image=$(buildkite-agent meta-data get "image")

kubectl create ns petclinic --dry-run -oyaml | kubectl apply -f-
sed "s|ttl.sh/bmo:1h|$image|" manifest.yml | kubectl apply -n petclinic -f-
kubectl rollout status deployment petclinic -n petclinic --timeout=90s

function cleanup {
    kubectl delete ns petclinic --wait --timeout=90s --ignore-not-found
}
trap cleanup EXIT

curl --no-progress-meter petclinic.petclinic
