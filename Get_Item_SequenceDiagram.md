```mermaid
sequenceDiagram
    autonumber
    actor 플레이어 as 플레이어
    participant UI as Add_Item_UI
    participant 전투 as 전투
    participant 플레이어클래스 as 플레이어
    participant 캐릭터 as 캐릭터 (전사/마법사)
    participant 인벤토리 as 인벤토리
    participant 아이템 as 아이템

    플레이어->>UI: 아이템 획득 요청<br>(플레이어id, 아이템명, 타입, 가치)
    activate UI
    UI->>전투: 아이템획득(플레이어id, 아이템명, 타입, 가치)
    activate 전투

    전투->>플레이어클래스: 플레이어체크(플레이어id)
    activate 플레이어클래스
    플레이어클래스-->>전투: 체크 결과 (true / false)
    deactivate 플레이어클래스

    alt 플레이어id == "hero" (성공)
        전투->>캐릭터: get캐릭터인벤토리()
        activate 캐릭터
        캐릭터-->>전투: 인벤토리 객체 반환
        deactivate 캐릭터

        전투->>아이템: 생성(아이템명, 타입, 가치)
        activate 아이템
        note over 아이템: 등급 평가 부여<br>- 1000 이상: 전설<br>- 500 이상: 희귀<br>- 500 미만: 일반
        아이템-->>전투: 아이템 객체 생성 완료
        deactivate 아이템

        전투->>인벤토리: 아이템추가(아이템)
        activate 인벤토리
        
        alt 인벤토리 수량 < 10 (공간 있음)
            note over 인벤토리: 아이템리스트에 추가 (Composition)
            인벤토리-->>전투: 추가 성공 (true)
            전투-->>UI: 아이템 획득 및 등급 안내 메시지
        else 인벤토리 수량 >= 10 (가득 참)
            인벤토리-->>전투: 추가 실패 (false)
            deactivate 인벤토리
            전투-->>UI: 인벤토리 용량 초과 오류 메시지
        end
        
    else 플레이어id != "hero" (실패)
        전투-->>UI: 인증 실패 메시지
    end

    deactivate 전투
    UI-->>플레이어: 결과 화면 출력
    deactivate UI