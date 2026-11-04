# shop-manifests

CI/CD 실습용 쿠버네티스 매니페스트 저장소 (GitOps). 강사 템플릿 저장소이며, 수강생은 **Use this template**으로 자기 GitHub에 복제해 쓴다.

- 앱 코드와 이미지 빌드는 [shop-app](https://github.com/worldvit/shop-app) 저장소가 맡는다.
- 이 저장소는 "클러스터에 무엇이 떠 있어야 하는가"만 적는다. Argo CD가 이 내용을 EKS에 맞춘다.
- Jenkins는 새 이미지를 만든 뒤 `set-images.sh`로 overlay의 이미지 태그만 고쳐 커밋한다.

| 경로 | 내용 |
|---|---|
| `base/` | 3서비스 Deployment·Service + 경로 라우터(gateway) |
| `overlays/dev` | 네임스페이스 shop-dev, 복제본 2, 이미지 주소·태그 |
| `overlays/prod` | 네임스페이스 shop-prod, 복제본 3, 이미지 주소·태그 |
| `argocd/` | Argo CD Application 정의 (`repoURL`의 GITHUB_USER를 내 아이디로 바꿔 사용) |
| `set-images.sh` | overlay 이미지 태그 변경 스크립트 (Jenkins와 사람이 함께 사용) |

```bash
bash set-images.sh dev 2a8393d          # dev의 3서비스를 2a8393d 태그로
kubectl kustomize overlays/dev          # 최종 매니페스트 미리 보기
```
