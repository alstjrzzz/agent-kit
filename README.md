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

기본(전역) 설치는 아래 둘을 처리한다.

1. **스킬** → `~/.claude/skills/`로 복사. 상세: [skills/README.md](skills/README.md)
2. **설정** → `~/.claude/`로 복사 + `{{HOME}}` 치환. 상세: [config/README.md](config/README.md)

스킬만 특정 프로젝트에 넣고 싶으면 [skills/README.md](skills/README.md)의 프로젝트 스코프 참고.
