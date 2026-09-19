# config

Claude Code와 Codex에서 쓰는 개인용 설정 파일 모음이다. 설치 스크립트는 제공하지 않는다.

## claude 설정 목록

| 파일 | 설명 |
|---|---|
| `settings.json` | 권한 모드, 훅, statusline, 모델 기본값 등 전역 설정 |
| `statusline-command.ps1` | 상태 줄에 model / ctx usage / branch / rate limit 을 표시하는 렌더링 스크립트 |
| `notify.ps1` | Stop / Notification 훅에서 OS 알림을 띄우는 스크립트 |

`settings.json`의 `{{HOME}}` 플레이스홀더는 실제 홈 경로로 치환한 뒤 `config/claude/`의 파일을 `~/.claude/`에 복사한다. Windows 경로는 JSON에서 백슬래시를 `\\`로 이스케이프한다.

## codex 설정 목록

| 파일 | 설명 |
|---|---|
| `config.toml` | sandbox와 TUI status line 설정 조각 |

`config.toml`은 기존 `~/.codex/config.toml`을 덮어쓰지 말고 필요한 키만 병합한다.
