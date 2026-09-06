---
name: "mermaid-diagram"
description: "다이어그램·그림·도식(구조, 흐름, 시퀀스, 상태, ERD 등)을 그려달라는 요청에 쓰는 스킬. mermaid 코드를 작성하고 이미지로 렌더해서, 코드와 이미지를 함께 준다."
---

## 무엇을 하나

다이어그램 요청이 오면 mermaid로 그린다. 결과로 **mermaid 코드와 렌더된 이미지를 둘 다** 준다. 코드는 사용자가 직접 고치고 GitHub·마크다운에서 바로 렌더하는 용도, 이미지는 지금 눈으로 확인하는 용도. 사용자가 이어서 수정할 수 있게 코드를 본문에도 보여준다.

## 종류에 맞는 타입 고르기

- 구조·흐름 → `flowchart` (선형 파이프라인은 `LR`이 자연스럽다)
- 순차 상호작용 → `sequenceDiagram`
- 상태 전이 → `stateDiagram-v2`
- 데이터 모델 → `erDiagram`
- 그 외 필요하면: `classDiagram`, `gantt`, `mindmap`, `timeline`, `gitGraph` 등

시스템을 자연스럽게 읽히는 대로 그린다. 양방향 관계는 화살표 하나(`<-->`)로, 엣지 라벨은 짧게, 노드 라벨은 `<br/>`로 줄바꿈.

## 아이콘 (선택)

강제 아님. 필요할 때만 갖다 쓴다.

- 일반 flowchart: FontAwesome — `A["fa:fa-server 서버"]`. minlag 이미지에 폰트가 내장돼 그대로 렌더된다.
- 클라우드/브랜드 로고: `architecture-beta` + Iconify 팩. AWS 등은 `logos:aws-*`.
  ```
  architecture-beta
    service db(logos:aws-dynamodb)[DynamoDB]
  ```
  렌더할 때 `--iconPacks @iconify-json/logos`를 붙이고 네트워크가 필요하다(팩을 npm에서 받음). Iconify 아이콘은 `architecture-beta`에서만 되고, 이 타입은 아직 beta라 레이아웃이 단순하다.

## 렌더

mermaid-cli(docker)로 만든다. pull·렌더 로그가 시끄러우니 [[fork-explore]]로 격리하고 결과 파일만 받는다.

```bash
MSYS_NO_PATHCONV=1 docker run --rm -v "<디렉토리>:/data" minlag/mermaid-cli \
  -i /data/<이름>.mmd -o /data/<이름>.svg -t neutral -b transparent
```

- **문서용은 SVG를 기본으로**(`-o *.svg`) — 벡터라 확대해도 깨끗하고 GitHub에서 렌더된다. 래스터가 필요할 때만 `.png` + `--scale 3`.
- 테마 `-t default|neutral|forest|dark`, 배경 `-b transparent|white`. 특정 다이어그램만 테마 바꾸려면 코드 상단에 `%%{init: {'theme':'neutral'}}%%`.
- 아이콘 팩을 쓰면 `--iconPacks @iconify-json/logos`를 추가한다.
- Docker가 없으면 렌더는 건너뛰고 코드만 준다. GitHub·마크다운·Claude 아티팩트에서 그대로 렌더된다.
- 파싱 에러가 나면 `.mmd`를 최소 수정하고 재렌더한다.

## 자주 걸리는 것

- `end`는 flowchart 예약어 — 노드 id로 쓰면 깨진다. 대문자 `End`나 따옴표 `["end"]`로 피한다.
- 특수문자(`()`, `:`, `,`, `#`, `<>`)가 든 라벨은 따옴표로 감싼다: `A["gRPC (:50051)"]`.
- `%%`는 주석.
