# shop-manifests

CI/CD 실습용 쿠버네티스 매니페스트 저장소 (GitOps). 강사 템플릿 저장소이며, 수강생은 **Use this template**으로 자기 GitHub에 복제해 쓴다.

- 앱 코드와 이미지 빌드는 [shop-app](https://github.com/worldvit/shop-app) 저장소가 맡는다.
- 이 저장소는 "클러스터에 무엇이 떠 있어야 하는가"만 적는다. Argo CD가 이 내용을 EKS에 맞춘다.
- Jenkins는 새 이미지를 만든 뒤 이 저장소의 이미지 태그만 고쳐 커밋한다.

| 폴더 | 내용 |
|---|---|
| `base/` | 3서비스 공통 매니페스트 (Deployment·Service) |
| `overlays/dev`, `overlays/prod` | 환경별 차이 (복제본 수, 이미지 태그) |
| `argocd/` | Argo CD Application 정의 |

매니페스트 본문은 실습 Day 3에서 채운다.
