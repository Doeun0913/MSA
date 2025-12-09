#!/bin/bash

# Git 자동 커밋 및 푸시 스크립트
# 파일 변경을 감시하고 자동으로 커밋 및 푸시합니다

REPO_PATH="/root/Microservices-with-Spring-Boot-and-Spring-Cloud-2E"
COMMIT_INTERVAL=10  # 10초마다 확인

cd "$REPO_PATH"

echo "✓ Git 자동 커밋/푸시 감시 시작..."
echo "  저장소: $REPO_PATH"
echo "  확인 주기: ${COMMIT_INTERVAL}초"
echo "  중지하려면 Ctrl+C를 누르세요"
echo ""

while true; do
    # 변경사항 확인
    if ! git diff-index --quiet HEAD --; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 변경사항 감지됨. 커밋 중..."
        
        # 모든 파일 스테이징
        git add -A
        
        # 커밋 메시지 생성 (타임스탐프 포함)
        COMMIT_MSG="Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
        
        # 커밋
        if git commit -m "$COMMIT_MSG"; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] ✓ 커밋 성공"
            
            # 푸시
            if git push origin main; then
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] ✓ 푸시 성공"
            else
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] ✗ 푸시 실패"
            fi
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] ✗ 커밋 실패 (변경사항 없음)"
        fi
        echo ""
    fi
    
    # 지정된 간격으로 대기
    sleep $COMMIT_INTERVAL
done
