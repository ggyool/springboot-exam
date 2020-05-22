#!/usr/bin/env bash

ABSPATH=$(readlink -f $0) # stop.sh 절대경로
ABSDIR=$(dirname $ABSPATH) # stop.sh 의 상위 폴더
source=${ABSDIR}/profile.sh # java로 보면 일종의 import (profile.sh 함수를 사용하기 위해)

IDLE_PORT=$(find_idle_port)
echo "> $IDLE_PORT 에서 구동 중인 애플리케이션 pid 확인"
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT}) # list open file

if [ -z ${IDLE_PID} ]
then
  echo "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $IDLE_PID"
  kill -15 ${IDLE_PID}
  sleep 5
fi

