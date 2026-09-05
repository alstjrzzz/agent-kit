# agent-kit

Claude Code에서 쓰는 개인용 Agent Skill과 설정 모음.

```
agent-kit/
├── skills/    # Agent Skills (SKILL.md) — 전역 또는 프로젝트별로 설치
└── config/    # Claude Code 전역 설정 (settings.json, statusline, notify)
```

## 설치

설치 스크립트는 없다. AI(Claude Code)에게 이 README를 읽히고 설치를 맡긴다.
스크립트와 달리 AI는 현재 머신 상태(실행 정책, 홈 경로 등)에 맞춰 적응한다.

```
이 레포 clone하고 README 보고 전역에 설치해줘
```

기본(전역) 설치는 아래 셋을 전부 처리한다.

1. **스킬** → `~/.claude/skills/`로 복사. 상세: [skills/README.md](skills/README.md)
2. **설정** → `~/.claude/`로 복사 + `{{HOME}}` 치환. 상세: [config/README.md](config/README.md)
3. **외부 아키텍처 도구** → 전역 설치. 아래 참고.

스킬만 특정 프로젝트에 넣고 싶으면 [skills/README.md](skills/README.md)의 프로젝트 스코프 참고.

## 외부 아키텍처 도구 (전역)

프로젝트 아키텍처를 C4로 문서화할 때 쓰는 도구. 이 레포에 포함하지 않고 각 원본에서 설치한다.
전부 전역(유저/머신 단위) 설치라 프로젝트 스코프는 없다.
원칙: AI는 Structurizr DSL 텍스트만 생성하고, 좌표/렌더는 결정론적 툴에 맡긴다(Mermaid 직접 그리기 금지).

### c4-skill (단일 플러그인, 수동 설치)

`/c4` 커맨드로 `workspace.dsl` 생성. clone 경로 고정 필수
(`c4.md`가 이 경로 기준으로 SKILL.md/참고문서를 찾음 — 다른 곳에 두면 깨짐).

```bash
git clone https://github.com/bitsmuggler/c4-skill.git ~/.claude/c4-skill
mkdir -p ~/.claude/commands
ln -s ~/.claude/c4-skill/commands/c4.md ~/.claude/commands/c4.md
```

렌더링/검증이 필요할 때만 Docker(선택):

```bash
docker pull structurizr/structurizr && docker pull plantuml/plantuml
```

Docker 없이 미리보기: `workspace.dsl` 내용을 playground.structurizr.com 에 붙여넣으면 된다.

### agent-chisels (마켓플레이스)

ADR 등 아키텍처 플러그인 모음. `modeling-c4-diagrams`, `document-architectural-decisions` 포함.

```
/plugin marketplace add lhohan/agent-chisels
/plugin install <플러그인명>@agent-chisels
```

### 참고

- https://github.com/bitsmuggler/c4-skill
- https://github.com/lhohan/agent-chisels
