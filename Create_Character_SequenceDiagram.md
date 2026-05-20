```mermaid
sequenceDiagram
    autonumber
    actor 플레이어 as 플레이어
    participant UI as Create_Character_UI
    participant 전투 as 전투
    participant 플레이어클래스 as 플레이어
    participant 전사 as 전사 (캐릭터 상속)
    participant 마법사 as 마법사 (캐릭터 상속)

    플레이어->>UI: 캐릭터 생성 요청<br>(플레이어id, 캐릭터명, 직업, 레벨)
    activate UI
    UI->>전투: 캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨)
    activate 전투
    
    전투->>플레이어클래스: 플레이어체크()
    activate 플레이어클래스
    플레이어클래스-->>전투: 체크 결과 (true / false)
    deactivate 플레이어클래스

    alt 플레이어id == "hero" (성공)
        alt 직업 == "전사"
            전투->>전사: 생성 및 능력치 설정<br>(HP=레벨*100, 공격력=레벨*15)
            activate 전사
            전사-->>전투: 전사 객체 반환
            deactivate 전사
        else 직업 == "마법사"
            전투->>마법사: 생성 및 능력치 설정<br>(HP=레벨*60, 공격력=레벨*25)
            activate 마법사
            마법사-->>전투: 마법사 객체 반환
            deactivate 마법사
        end
        전투-->>UI: 캐릭터 생성 완료 메시지
    else 플레이어id != "hero" (실패)
        전투-->>UI: 인증 실패 메시지
    end
    
    deactivate 전투
    UI-->>플레이어: 결과 화면 출력
    deactivate UI