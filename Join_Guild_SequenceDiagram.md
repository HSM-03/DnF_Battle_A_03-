```mermaid
sequenceDiagram
    autonumber
    actor 플레이어 as 플레이어
    participant UI as Join_Guild_UI
    participant 전투 as 전투
    participant 플레이어클래스 as 플레이어
    participant 길드 as 길드
    participant 캐릭터 as 캐릭터 (전사/마법사)

    플레이어->>UI: 길드 가입 요청<br>(플레이어id, 길드명)
    activate UI
    UI->>전투: 길드가입(플레이어id, 길드명)
    activate 전투

    전투->>플레이어클래스: 플레이어체크(플레이어id)
    activate 플레이어클래스
    플레이어클래스-->>전투: 체크 결과 (true / false)
    deactivate 플레이어클래스

    alt 플레이어id == "hero" (성공)
        note over 전투: 공유길드목록에서<br>해당 길드 객체 조회
        전투->>길드: 캐릭터가입(캐릭터)
        activate 길드

        alt 길드 현재원 < 5 (정원 여유)
            note over 길드: 캐릭터리스트에 추가 (Aggregation)
            길드-->>전투: 가입 성공 (true)
            전투-->>UI: 길드 가입 완료 메시지
        else 길드 현재원 >= 5 (정원 초과)
            길드-->>전투: 가입 실패 (false)
            deactivate 길드
            전투-->>UI: 길드 정원 초과 오류 메시지
        end

    else 플레이어id != "hero" (실패)
        전투-->>UI: 인증 실패 메시지
    end

    deactivate 전투
    UI-->>플레이어: 결과 화면 출력
    deactivate UI