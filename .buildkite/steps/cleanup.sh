#!/bin/bash

set -euxo pipefail

kubectl delete ns petclinic --wait --timeout=90s --ignore-not-found
