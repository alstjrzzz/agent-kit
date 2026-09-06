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

## 쓸만한 기능 (필요할 때 참고)

- **시퀀스**: 다단계 흐름이면 `autonumber`를 거의 항상 켠다(단계 번호 자동). 활성화 막대 `A->>+B` / `B-->>-A`, 분기·반복은 `alt`/`opt`/`loop`/`par`, 한 시스템에 속한 참가자는 `box rgb(...) 이름 ... end`로 묶는다.
- **flowchart**: 반복되는 색·스타일은 `classDef`로 한 번 정의해 `노드:::클래스`로 재사용. DB·문서·큐 등은 v11 시맨틱 도형 `db@{ shape: cyl }`(cyl/doc/hex/stadium…). 엣지는 `===`(굵게)·`-.->`(점선)로 종류를 구분. `subgraph 이름 ... end`로 묶고 안에서 `direction LR` 지정(단, 그 안 노드가 밖으로 연결되면 무시됨).
- **파일 상단 frontmatter**로 제목·테마를 박아둔다(CLI 플래그 대신, 버전관리됨):
  ```
  ---
  title: ...
  config: { theme: neutral }
  ---
  ```
- 색을 팔레트로 통일하려면 `base` 테마 + `themeVariables`(primaryColor / lineColor / primaryTextColor …).
- 라벨에 볼드·줄바꿈은 마크다운 문자열 `A["**Media** Server<br/>Node.js"]`.

## 아이콘 (선택)

강제 아님. 필요할 때만 갖다 쓴다.

- 일반 flowchart: FontAwesome — `A["fa:fa-server 서버"]`. minlag 이미지에 폰트가 내장돼 그대로 렌더된다.
- 클라우드/브랜드 로고: `architecture-beta` + Iconify 팩. AWS 등은 `logos:aws-*`.
  ```
  architecture-beta
    service db(logos:aws-dynamodb)[DynamoDB]
  ```
  Iconify 아이콘은 `architecture-beta`에서만 되고, 이 타입은 아직 beta라 레이아웃이 단순하다. 이 아이콘 렌더는 MCP에서 안 될 수 있어, 그때는 아래 렌더 섹션의 docker fallback을 쓴다.

## 렌더

mermaid MCP(`mcp-mermaid`)로 렌더한다. 다이어그램 텍스트를 넘기면 이미지를 바로 돌려주므로 docker·fork 없이 툴 호출 한 번이면 된다.

- `outputType`: 기본 `svg`(인라인 벡터, 문서에 깔끔). URL만 필요하면 `png_url`/`svg_url`(mermaid.ink 호스티드). 래스터 파일이 필요하면 `png`/`file`.
- `theme`(default/neutral/forest/dark)·`backgroundColor` 지정 가능. 특정 다이어그램만 테마 바꾸려면 코드 상단에 `%%{init: {'theme':'neutral'}}%%`.
- 결과가 인라인이면 그대로 보여주고, 파일로 저장되면 SendUserFile로 보낸다. 코드도 본문에 함께 보여준다.
- MCP가 없거나 실패하면 렌더는 건너뛰고 코드만 준다 — GitHub·마크다운·Claude 아티팩트에서 그대로 렌더된다.
- 파싱 에러가 나면 코드를 최소 수정하고 재렌더한다.

아이콘 팩(`architecture-beta` + Iconify)이 MCP에서 안 먹으면, 그때만 mermaid-cli(docker)로 fallback한다. pull·렌더 로그가 시끄러우니 [[fork-explore]]로 격리한다:

```bash
MSYS_NO_PATHCONV=1 docker run --rm -v "<디렉토리>:/data" minlag/mermaid-cli \
  -i /data/<이름>.mmd -o /data/<이름>.svg --iconPacks @iconify-json/logos
```

## 자주 걸리는 것

- `end`는 flowchart 예약어 — 노드 id로 쓰면 깨진다. 대문자 `End`나 따옴표 `["end"]`로 피한다.
- 특수문자(`()`, `:`, `,`, `#`, `<>`)가 든 라벨은 따옴표로 감싼다: `A["gRPC (:50051)"]`.
- `%%`는 주석. 단 주석 안에 `{}`를 넣으면 파서가 헷갈린다.

## 참고

문법이 헷갈리면 공식 문서를 확인한다: https://mermaid.js.org/intro/syntax-reference.html
