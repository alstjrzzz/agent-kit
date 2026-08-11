# config

Claude Code 등에서 쓰는 개인용 설정 파일 모음이다.

아래 옵션을 사용해 OS에 맞는 스크립트를 홈에 전역으로 설정한다.

## 옵션

```
<script> <agent>
```

| 자리 | 값 | 설명 | 비고 |
|---|---|---|---|
| script | `./install.sh` / `.\install.ps1` | OS에 맞는 스크립트 선택 | `.sh`: linux/mac, `.ps1`: windows |
| agent | `claude` | 적용할 에이전트 (현재는 claude만 지원) |  |

## claude 설정 목록

| 파일 | 설명 |
|---|---|
| `settings.json` | 권한 모드, 훅, statusline, 모델 기본값 등 전역 설정 |
| `statusline-command.ps1` | 상태 줄에 model / ctx usage / branch / rate limit 을 표시하는 렌더링 스크립트 |
| `notify.ps1` | Stop / Notification 훅에서 OS 알림을 띄우는 스크립트 |

> `settings.json`의 훅 경로는 `{{HOME}}` 플레이스홀더로 되어 있고, 설치 스크립트가 복사 시점에 이걸 실제 홈 디렉터리 경로로 자동 치환한다. 수동으로 고칠 필요 없음.

## 빠른 명령어

```powershell
# windows + claude
.\install.ps1 claude
```

```powershell
# windows + codex
.\install.ps1 codex
```

```bash
# linux + claude
./install.sh claude
```

```bash
# linux + codex
./install.sh codex
```
