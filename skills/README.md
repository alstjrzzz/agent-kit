# skills

Claude Code와 Codex에서 함께 쓰는 Agent Skill(SKILL.md) 모음.

## 스킬 목록

| skill | 설명 | 권장 스코프 |
|---|---|---|
| [clean-terminal](clean-terminal/SKILL.md) | 메인 대화의 터미널과 로그를 깔끔하게 유지하도록 시끄러운 실행을 subagent로 격리 | 전역 |
| [readme-writing](readme-writing/SKILL.md) | README.md 작성 가이드 | 전역 |
| [tech-writing](tech-writing/SKILL.md) | 기술 문서 작성 가이드 | 전역 |
| [git-workflow](git-workflow/SKILL.md) | branch, commit, rebase, push, PR 작업 규칙 | 전역 설치 후 사용자 확인 |

## 원칙

스킬 원본은 한 곳에만 두고, 에이전트별 스킬 폴더에는 복사본을 만들지 않는다. Codex는 `.agents/skills/`, Claude Code는 `.claude/skills/`만 읽으므로 복사본을 두면 한쪽에서 고친 내용이 다른 쪽에 반영되지 않는다.

- 원본은 이 저장소의 `skills/<skill>/`이다. 스킬 수정은 여기서 하고 커밋한다.
- `~/.agents/skills/<skill>`은 이 저장소 폴더를 가리키는 링크다.
- `~/.claude/skills/<skill>`은 `~/.agents/skills/<skill>`을 가리키는 링크다. `npx skills`로 설치한 외부 스킬도 같은 구조다.
- `~/.claude/skills/`에 실제 폴더를 만들거나 링크를 거쳐 들어간 파일을 따로 복사하지 않는다.

에이전트가 관리하는 폴더는 건드리지 않는다.

- `~/.claude/skills/synced/`: claude.ai 계정에서 동기화되는 스킬
- `~/.codex/skills/.system/`: Codex 내장 스킬

## 전역 설치 (AI에게 맡김)

OS마다 링크를 거는 명령이 다르다. 링크는 설치하는 기기에만 생기고 이 저장소에는 남지 않는다.

Windows (PowerShell). Junction은 관리자 권한이나 개발자 모드 없이 폴더 링크를 만든다.

```powershell
New-Item -ItemType Junction -Path "$HOME\.agents\skills\<skill>" -Target "<agent-kit>\skills\<skill>"
New-Item -ItemType Junction -Path "$HOME\.claude\skills\<skill>" -Target "$HOME\.agents\skills\<skill>"
```

macOS, Linux, WSL:

```bash
ln -s "<agent-kit>/skills/<skill>" ~/.agents/skills/<skill>
ln -s ~/.agents/skills/<skill> ~/.claude/skills/<skill>
```

- Windows의 Git Bash에서 `ln -s`는 링크 대신 복사본을 만들 수 있으므로 PowerShell 명령을 쓴다.
- WSL은 Windows와 홈 디렉터리가 다르다. WSL 안에서도 따로 설치하고, Windows에 clone한 저장소를 `/mnt/c/...` 경로로 가리키면 두 환경이 같은 원본을 쓴다.
- 대상 위치에 같은 이름의 폴더가 이미 있으면 이 저장소 버전과 비교해서 사용자에게 알린 뒤 링크로 바꾼다.
- 설치 후 새 세션에서 스킬 목록에 보이는지 확인한다.

## 프로젝트 설치

특정 프로젝트에서만 쓰는 스킬은 그 프로젝트 저장소에 커밋한다. 다른 기기와 OS에서 clone해도 동작해야 하므로 링크를 쓰지 않는다.

- 원본: `<project>/.agents/skills/<skill>/`에 폴더째 복사한다. 프로젝트에 맞게 고쳐도 된다. 이 저장소에는 반영하지 않는다.
- Claude Code용: `<project>/.claude/skills/<skill>/SKILL.md`에 원본과 같은 `name`, `description` frontmatter만 두고, 본문에는 `.agents/skills/<skill>/SKILL.md`를 읽고 따르라고 적는다.

### git-workflow

먼저 다른 스킬처럼 전역으로 설치한다. 설치한 뒤 사용자에게 전역으로 유지할지, 특정 저장소에만 적용할지 묻는다. 특정 저장소에만 쓰기로 하면 전역 링크를 지우고 그 저장소에 프로젝트 스코프로 설치한다.

저장소에 이미 Git 규칙(`AGENTS.md`, `CLAUDE.md`, Git 관련 스킬)이 있어도 따로 병합하지 않는다. git-workflow는 저장소 규칙을 먼저 찾아서 충돌하면 저장소 규칙을 따르도록 되어 있다. 설치할 때 기존 규칙이 있다는 사실만 사용자에게 알린다.

## 외부 스킬

Archify는 저장소에 복사하지 않고 별도로 설치한다. 다이어그램 작성은 Archify를 쓴다.

```bash
npx skills add tt-a1i/archify -g
```

`~/.agents/skills/`에 설치되고, 선택한 에이전트(Claude Code 등)의 스킬 폴더에는 링크가 걸린다. Node.js 18 이상이 필요하다.
