# --- prompt arch: only required sections---
# 언어/도구 버전 섹션 전부 제외 → subprocess 호출 제거 (지연 주범)
SPACESHIP_PROMPT_ORDER=(
  dir            # 현재 디렉토리
  git            # git branch/status (async)
  node           # node 버전 (프로젝트 감지 시만)
  golang         # go 버전
  python         # python venv/버전
  ruby           # ruby 버전
  docker         # docker 컨텍스트 (compose 파일 감지 시)
  terraform      # terraform workspace (.terraform 감지 시)
  aws            # AWS_PROFILE (멀티계정 실수 방지)
  line_sep
  jobs           # 백그라운드 job 수
  exit_code      # 직전 명령 exit code
  char           # 프롬프트 문자
)
# 우측 프롬프트 비움 (렌더 비용 절약)
SPACESHIP_RPROMPT_ORDER=()

# --- async 켜기 (느린 섹션 논블로킹) ---
SPACESHIP_PROMPT_ASYNC=true

# --- 시각/여백 ---
SPACESHIP_PROMPT_ADD_NEWLINE=true      # 줄 추가 안 함
SPACESHIP_PROMPT_SEPARATE_LINE=true     # 입력은 새 줄
SPACESHIP_CHAR_SYMBOL="➜ "

# --- dir: 경로 truncate (긴 경로 렌더 비용↓) ---
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_TRUNC_REPO=true

# --- git: status 무거움. branch만 빠르게, status는 async가 처리 ---
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_BRANCH_SHOW=true

# --- 안 쓰는/무거운 섹션 명시적 OFF (ORDER에서 빠졌어도 안전장치) ---
SPACESHIP_HOST_SHOW=false
SPACESHIP_USER_SHOW=false
SPACESHIP_TIME_SHOW=false
SPACESHIP_NODE_SHOW=true
SPACESHIP_GOLANG_SHOW=true
SPACESHIP_PYTHON_SHOW=true
SPACESHIP_RUBY_SHOW=true
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_KUBECTL_SHOW=false
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_AWS_SHOW=true
SPACESHIP_TERRAFORM_SHOW=true
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_EXEC_TIME_SHOW=false
