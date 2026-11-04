#!/bin/bash
# overlay의 이미지 주소·태그 변경 — 사용법: bash set-images.sh <dev|prod> <태그> [서비스 ...]
# 예) bash set-images.sh dev 2a8393d             → 3서비스 모두
#     bash set-images.sh prod 2a8393d order-api  → order-api만
set -euo pipefail
cd "$(dirname "$0")"
ENV=${1:?dev 또는 prod}; TAG=${2:?이미지 태그}; shift 2
SVCS=${*:-frontend product-api order-api}
ACCOUNT=${ACCOUNT_ID:-$(aws sts get-caller-identity --query Account --output text)}
REG=$ACCOUNT.dkr.ecr.ap-northeast-2.amazonaws.com
F=overlays/$ENV/kustomization.yaml
for s in $SVCS; do
  # "- name: shop/<서비스>" 다음 두 줄(newName, newTag)만 바꾼다
  sed -i "/- name: shop\/$s\$/{n;s#newName: .*#newName: $REG/shop/$s#;n;s#newTag: .*#newTag: \"$TAG\"#}" $F
done
grep -A2 'name: shop/' $F
