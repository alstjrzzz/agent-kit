# agent-skills

Claude Code, Codex 등에서 쓰는 개인용 Agent Skills(SKILL.md) 모음이다.

```
agent-skills/
├── skills/
│   ├── readme-writing/
│   └── writing-style/
├── install.sh
├── install.ps1
└── README.md
```

## 설치

```bash
git clone https://github.com/alstjrzzz/agent-skills.git
cd agent-skills
```

이 레포는 지정한 프로젝트 루트 경로에 skill을 복사해주는 스크립트를 제공한다. 아래 옵션을 참고해 자유롭게 적용한다.

## 옵션

아래 명령어는 agent-skills 폴더에서 실행한다.

```
<script> <agent> <target> [skill ...]
```

| 자리 | 값 | 설명 |
|---|---|---|
| script | `install.sh` / `install.ps1` | OS에 맞는 스크립트 선택 .sh: linux, .ps1: windows |
| agent | `claude` / `codex` | skill 사용 에이전트 |
| target | `global` / `<path>` | skill을 전역 또는 지정한 경로의 프로젝트에 적용 |
| skill | <skill1> <skill2> ... | 적용할 skill 선택. 생략하면 레포의 전체 skill 적용 |

## skill 목록

| skill | 설명 |
|---|---|
| `readme-writing` | 프로젝트 README.md 작성. 필수 섹션, 톤, 설치/실행 명령어 검증 규칙 |
| `writing-style` | 공부 정리, 트러블슈팅 기록 등 기술 문서의 톤과 구조 규칙 |

## 많이 쓰는 조합

아래는 Windows + Claude 환경 기준 예시다. 다른 조합은 위 옵션표를 참고해 바꾸면 된다.

전체 skill을 전역으로 적용한다. 어느 프로젝트를 열든 적용된다.

```powershell
.\install.ps1 claude global
```

기술 문서 작성 관련 skill 묶음 적용

```powershell
.\install.ps1 claude C:\path\to\my-project writing-style readme-writing
```

git 워크플로우 관련 skill 묶음 적용

```powershell
.\install.ps1 claude C:\path\to\my-project pr-code-review commit-convention
```
