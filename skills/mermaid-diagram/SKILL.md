---
name: "mermaid-diagram"
description: "다이어그램·그림·도식(아키텍처 구조, 흐름, 시퀀스, 상태, ERD 등)을 그려달라는 요청에 쓰는 스킬. mermaid 코드를 작성하고 이미지(PNG)로 렌더해서, 코드와 이미지를 함께 준다."
---

## 무엇을 하나

다이어그램 요청이 오면 mermaid로 그린다. 결과로 **mermaid 코드와 렌더된 PNG를 둘 다** 준다. 코드는 사용자가 직접 고치고 GitHub·마크다운에서 바로 렌더하는 용도, 이미지는 지금 눈으로 확인하는 용도.

## 원칙

- **규약을 강요하지 않는다.** C4 같은 격식(Person/System/Container 위계, 경계 박스, `[기술]` 라벨 형식)은 오히려 그림을 뻣뻣하게 만들고 실제 구조를 가린다. 시스템을 자연스럽게 읽히는 대로 그린다.
- **종류에 맞는 mermaid 타입을 고른다:**
  - 구조·흐름 → `flowchart` (선형 파이프라인은 `LR`이 자연스럽다)
  - 순차 상호작용 → `sequenceDiagram`
  - 상태 전이 → `stateDiagram-v2`
  - 데이터 모델 → `erDiagram`
- **자동 레이아웃의 한계를 인정한다.** mermaid는 배치를 알고리즘이 정한다. "내 의도대로 정확히 여기·저기"가 필요하면 그건 mermaid가 아니라 수동 캔버스(Excalidraw/Figma) 영역이다. 억지로 mermaid를 비틀지 않는다.
- 양방향 관계는 화살표 하나(`<-->`)로, 엣지 라벨은 짧게. 노드 라벨은 `<br/>`로 줄바꿈, 색은 옅게.

## 렌더

mermaid-cli(docker)로 PNG를 만든다. 이미지 pull·렌더 로그가 시끄러우니 [[fork-explore]]로 격리하고 결과 파일만 받는다.

```bash
MSYS_NO_PATHCONV=1 docker run --rm -v "<디렉토리>:/data" minlag/mermaid-cli \
  -i /data/<이름>.mmd -o /data/<이름>.png -t default -b white --scale 3
```

- `--scale 3` 고해상도, `-b white` 배경 흰색.
- 파싱 에러가 나면 `.mmd`를 최소 수정하고 재렌더한다.
- Docker가 없으면 렌더는 건너뛰고 mermaid 코드만 준다. GitHub·마크다운·Claude 아티팩트에서 그대로 렌더된다.

## 출력

- `.mmd`(코드)와 `.png`(이미지)를 함께 준다. 이미지는 SendUserFile로 보낸다.
- 사용자가 이어서 수정할 수 있게 mermaid 코드를 본문에도 보여준다.
