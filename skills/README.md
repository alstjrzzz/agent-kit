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

## 렌더 MCP (mermaid-diagram용)

`mermaid-diagram` 스킬은 [`mcp-mermaid`](https://github.com/hustcc/mcp-mermaid) MCP로 다이어그램을 이미지로 렌더한다. 전역으로 한 번 설치한다(Node.js ≥ 18 필요).

```bash
npm i -g mcp-mermaid
MSYS_NO_PATHCONV=1 claude mcp add mermaid -s user -- cmd /c mcp-mermaid
```

설치 후 `claude mcp list`에 `mermaid ... ✔ Connected` 확인. 새 MCP는 Claude Code를 재시작해야 세션에 뜬다.

주의 (둘 다 Windows/git bash에서 실제로 겪은 실패):
- `MSYS_NO_PATHCONV=1`을 빼면 git bash가 `cmd /c`의 `/c`를 `C:/`로 바꿔 등록이 깨진다. 반드시 붙인다.
- `npx -y mcp-mermaid`로 바로 등록하면 첫 실행 다운로드가 30초 연결 타임아웃을 넘겨 실패한다. `npm i -g`로 먼저 깔고 바이너리를 직접 부르면 즉시 연결된다.
- MCP가 없거나 실패해도 스킬은 mermaid 코드만은 준다(GitHub·마크다운·Claude 아티팩트에서 렌더).
