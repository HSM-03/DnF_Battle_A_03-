```mermaid
sequenceDiagram
    autonumber
    actor 플레이어 as 플레이어
    participant UI as Attack_Monster_UI
    participant 전투 as 전투
    participant 플레이어클래스 as 플레이어
    participant 캐릭터 as 캐릭터 (전사 / 마법사)

    플레이어->>UI: 몬스터 공격 요청 (캐릭터 선택)
    activate UI
    UI->>전투: 몬스터공격(캐릭터)
    activate 전투

    전투->>플레이어클래스: 플레이어체크()
    activate 플레이어클래스
    플레이어클래스-->>전투: 체크 결과 (true / false)
    deactivate 플레이어클래스

    alt 플레이어id == "hero" (성공)
        전투->>캐릭터: 스킬발동()
        activate 캐릭터
        note over 캐릭터: 전사: "검 휘두르기!" (공격력 * 1.5)<br>마법사: "파이어볼!" (공격력 * 2.0)
        캐릭터-->>전투: 계산된 데미지 반환
        deactivate 캐릭터

        note over 전투: 데미지 등급 부여<br>- 200 이상: S급<br>- 100 이상: A급<br>- 100 미만: B급
        전투-->>UI: 공격 스킬명, 데미지, 등급 결과 전달
    else 플레이어id != "hero" (실패)
        전투-->>UI: 인증 실패 메시지
    end

    deactivate 전투
    UI-->>플레이어: 전투 결과 화면 출력
    deactivate UI
    