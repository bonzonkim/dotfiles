#!/bin/bash

# 현재 입력 소스 정보를 시스템 설정에서 읽어옵니다.
SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)

# 간단한 로직: 출력 결과에 "Korean"이 포함되어 있으면 한글, 아니면 영문으로 간주
if echo "$SOURCE" | grep -q "Korean"; then
    LABEL="한"
    ICON="ㄱ"
else
    LABEL="A"
    ICON="a"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"
