# skills

Claude Code와 Codex에서 함께 쓰는 Agent Skill(SKILL.md) 모음.

## 스킬 목록

| skill | 설명 | 권장 스코프 |
|---|---|---|
| [clean-terminal](clean-terminal/SKILL.md) | 메인 대화의 터미널과 로그를 깔끔하게 유지하도록 시끄러운 실행을 Codex subagent로 격리 | 전역 |
| [readme-writing](readme-writing/SKILL.md) | README.md 작성 가이드 | 전역 |
| [tech-writing](tech-writing/SKILL.md) | 기술 문서 작성 가이드 | 전역 |

## 설치 (AI에게 맡김)

스킬 하나는 폴더 하나다. 그 폴더째 대상 위치로 복사하면 끝. 재작성하지 말고 복사한다.

- 전역: `<skill>/` → `~/.{agent}/skills/<skill>/`
- 프로젝트: `<skill>/` → `<project>/.{agent}/skills/<skill>/`

전역이 기본이다. 특정 프로젝트에서만 쓰고 싶은 스킬만 프로젝트 스코프로 넣는다.

예) "clean-terminal이랑 tech-writing 전역에 설치해줘"
→ 두 폴더를 `~/.claude/skills/`로 복사.

## 외부 스킬

Archify는 저장소에 복사하지 않고 별도로 설치한다. Codex, Claude Code 등 여러 에이전트에서 사용할 수 있는 외부 스킬이다.

```bash
npx skills add tt-a1i/archify -g
```

설치 후 새 Codex 세션에서 `archify`를 사용한다. Archify는 Node.js 18 이상이 필요하다.
