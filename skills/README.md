# skills

Claude Code, Codex 등에서 쓰는 개인용 Agent Skills(SKILL.md) 모음이다.

사용할 skill을 아래 옵션을 사용해 repo에 적용할 수 있다.

## 옵션

```
<script> <agent> <target> [skill ...]
```

| 자리 | 값 | 설명 | 비고 |
|---|---|---|---|
| script | `./install.sh` / `.\install.ps1` | OS에 맞는 스크립트 선택 | `.sh`: linux/mac, `.ps1`: windows |
| agent | `claude` / `codex` | skill을 적용할 에이전트 |  |
| target | `global` / `<path>` | skill을 전역 또는 지정한 경로의 프로젝트에 적용 | 절대/상대경로 모두 지원 |
| skill | `<skill1> <skill2> ...` | 적용할 skill 선택 | 생략시 전체 skill 적용 |

## skill 목록

| skill | 설명 |
|---|---|
| [readme-writing](https://github.com/alstjrzzz/agent-kit/blob/main/skills/readme-writing/SKILL.md) | README.md 작성 |
| [tech-writing](https://github.com/alstjrzzz/agent-kit/blob/main/skills/tech-writing/SKILL.md) | 기술 문서 작성 |
| [fork-explore](https://github.com/alstjrzzz/agent-kit/blob/main/skills/fork-explore/SKILL.md) | 결론만 필요한 다단계 탐색을 fork로 격리 실행 |

## 많이 쓰는 조합

아래는 Windows + Claude 환경 기준 예시다. 다른 조합은 위 옵션표를 참고해 바꾸면 된다.

```powershell
# 전체 skill을 전역으로 적용
.\install.ps1 claude global
```

```powershell
# 기술 문서 작성 관련 skill 묶음을 전역으로 적용
.\install.ps1 claude global tech-writing readme-writing
```

```powershell
# git 워크플로우 관련 skill 묶음을 전역으로 적용
.\install.ps1 claude global pr-code-review commit-convention
```

```powershell
# Python 프로젝트 전용 skill 묶음 적용
.\install.ps1 claude <your-project-path> python-quality
```

```powershell
# Spring 프로젝트 전용 skill 묶음 적용
.\install.ps1 claude <your-project-path> spring-conventions
```
