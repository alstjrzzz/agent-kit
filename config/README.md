# config

Claude Code 전역 설정 파일 모음. 전부 `~/.claude/`에 놓는다.

## 파일 목록

| 파일 | 설명 |
|---|---|
| `claude/settings.json` | 권한 모드, 훅, statusLine, 모델 기본값 |
| `claude/statusline-command.ps1` | 상태 줄(모델 / ctx / 브랜치) 렌더 스크립트 |
| `claude/notify.ps1` | Stop / Notification 훅용 OS 알림 |

## 설치 (AI에게 맡김)

1. `config/claude/`의 세 파일을 `~/.claude/`로 복사한다. 재작성하지 말고 복사한다.
2. `settings.json` 안의 `{{HOME}}`를 실제 홈 경로로 치환한다.
   Windows면 `C:\Users\<이름>`이고, JSON이라 백슬래시는 `\\`로 이스케이프한다.
3. 확인: powershell 호출에 `-ExecutionPolicy Bypass`가 들어있어야 한다.
   빠지면 실행 정책이 Restricted인 머신에서 statusLine 스크립트가 막혀 상태 줄이 안 뜬다.
