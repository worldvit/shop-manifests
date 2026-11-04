#!/bin/bash
# 정답 적용: overlays/<환경>에 order-api Rollout을 넣는다 — 사용법: bash solutions/day4/apply-rollout.sh dev
set -euo pipefail
cd "$(dirname "$0")/../.."
E=${1:?dev 또는 prod}; K=overlays/$E/kustomization.yaml
cp solutions/day4/order-api-rollout.yaml overlays/$E/
grep -q order-api-rollout.yaml $K || sed -i 's#^  - ../../base$#  - ../../base\n  - order-api-rollout.yaml#' $K
sed -i 's/{ name: order-api, count: [0-9]* }/{ name: order-api, count: 0 }/' $K
sed -n '/resources:/,/^labels/p;/replicas:/,/^#/p' $K
