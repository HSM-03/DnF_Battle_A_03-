## AI 전투 시스템 Class Diagram

```mermaid
classDiagram
direction TB

    %% [Boundary 클래스]
    class Create_Character_UI {
        <<boundary>>
    }
    class Attack_Monster_UI {
        <<boundary>>
    }
    class Add_Item_UI {
        <<boundary>>
    }
    class Join_Guild_UI {
        <<boundary>>
    }

    %% [기존 및 신규 도메인 클래스]
    class 플레이어 {
        -플레이어id : String
        +플레이어체크(플레이어id: String) boolean
    }

    class 전투 {
        +캐릭터생성(플레이어id: String, 캐릭터명: String, 직업: String, 레벨: int) boolean
        +몬스터공격(플레이어id: String, 캐릭터: 캐릭터) void
        +아이템획득(플레이어id: String, 아이템명: String, 타입: String, 가치: int) boolean
        +길드가입(플레이어id: String, 길드명: String) boolean
    }

    class 캐릭터 {
        <<abstract>>
        -캐릭터명 : String
        -레벨 : int
        -HP : int
        -공격력 : double
        -인벤토리 : 인벤토리
        +스킬발동()* double
    }

    class 전사 {
        +스킬발동() double
    }

    class 마법사 {
        +스킬발동() double
    }

    class 인벤토리 {
        -아이템리스트 : List~아이템~
        -최대용량 : int
        +아이템추가(아이템: 아이템) boolean
    }

    class 아이템 {
        -아이템명 : String
        -타입 : String
        -가치 : int
        -등급 : String
    }

    class 길드 {
        -길드명 : String
        -캐릭터리스트 : List~캐릭터~
        -최대인원 : int
        +캐릭터가입(캐릭터: 캐릭터) boolean
    }

    %% [의존 및 UI 흐름 관계]
    Create_Character_UI ..> 전투 : 요청
    Attack_Monster_UI ..> 전투 : 요청
    Add_Item_UI ..> 전투 : 요청
    Join_Guild_UI ..> 전투 : 요청
    
    전투 --> 플레이어 : 플레이어체크
    전투 --> 캐릭터 : 생성 및 제어

    %% [상속 관계]
    전사 --|> 캐릭터 : 상속
    마법사 --|> 캐릭터 : 상속

    %% [복합객체 관계 반영 - 문법 오류 수정 완료]
    캐릭터 "1" *-- "1" 인벤토리 : 캐릭터_삭제시_인벤토리도_삭제
    인벤토리 "1" *-- "*" 아이템 : 인벤토리_삭제시_아이템도_삭제
    길드 "1" o-- "*" 캐릭터 : 길드_해체시에도_캐릭터는_존재```