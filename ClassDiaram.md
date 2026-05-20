```mermaid
classDiagram
direction TB

class Create_Character_UI {
    <<boundary>>
}

class Attack_Monster_UI {
    <<boundary>>
}

class 플레이어 {
    -플레이어id : String
    +플레이어체크(플레이어 id: String) boolean
}

class 전투 {
    +캐릭터생성(플레이어id: String, 캐릭터명: String, 직업: String, 레벨: int) boolean
    +몬스터공격() void
}

class 캐릭터 {
    <<abstract>>
    -캐릭터명 : String
    -레벨 : int
    -HP : int
    -공격력 : double
    +스킬발동()* double
}

class 전사 {
    +스킬발동() double
}

class 마법사 {
    +스킬발동() double
}

Create_Character_UI ..> 전투 : 요청
Attack_Monster_UI ..> 전투 : 요청
전투 --> 플레이어 : 플레이어체크
전투 --> 캐릭터 : 생성
전사 --|> 캐릭터 : 상속
마법사 --|> 캐릭터 : 상속