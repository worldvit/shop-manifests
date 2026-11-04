#!/bin/bash
# 장애 훈련 ④: overlay의 order-api에 BREAK_ORDERS=1 환경 변수를 넣는다 (주문 목록만 500, 헬스 체크는 정상)
# 사용법: bash solutions/day4/break-orders.sh dev   → 커밋·push 후 카나리로 배포된다. 되돌리기는 git revert.
set -euo pipefail
cd "$(dirname "$0")/../.."
K=overlays/${1:?dev 또는 prod}/kustomization.yaml
grep -q BREAK_ORDERS $K && { echo "이미 들어 있음"; exit 0; }
cat >> $K <<'P'
# 장애 훈련 ④ — 이 블록을 지우거나 git revert하면 정상 버전으로 돌아간다
patches:
  - target: { kind: Deployment, name: order-api }
    patch: |-
      - op: add
        path: /spec/template/spec/containers/0/env
        value: [{ name: BREAK_ORDERS, value: "1" }]
P
tail -8 $K
