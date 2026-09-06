# skills

Claude Code용 Agent Skill(SKILL.md) 모음.

## 스킬 목록

| skill | 설명 | 권장 스코프 |
|---|---|---|
| [fork-explore](fork-explore/SKILL.md) | 조사·빌드·테스트를 fork로 격리하고 결론만 보고 | 전역 |
| [mermaid-diagram](mermaid-diagram/SKILL.md) | mermaid로 다이어그램을 그려 코드+이미지로 제공 | 전역 |
| [readme-writing](readme-writing/SKILL.md) | README.md 작성 가이드 | 전역 |
| [tech-writing](tech-writing/SKILL.md) | 기술 문서 작성 가이드 | 전역 |

## 설치 (AI에게 맡김)

스킬 하나는 폴더 하나다. 그 폴더째 대상 위치로 복사하면 끝. 재작성하지 말고 복사한다.

- 전역: `<skill>/` → `~/.claude/skills/<skill>/`
- 프로젝트: `<skill>/` → `<project>/.claude/skills/<skill>/`

전역이 기본이다. 특정 프로젝트에서만 쓰고 싶은 스킬만 프로젝트 스코프로 넣는다.

예) "fork-explore랑 tech-writing 전역에 설치해줘"
→ 두 폴더를 `~/.claude/skills/`로 복사.
