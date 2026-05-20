package DnF;

public class 전투 {
    private 플레이어 플레이어객체;
    private 캐릭터 생성된캐릭터;

    public 전투() {
        this.플레이어객체 = new 플레이어();
    }

    // 시퀀스 다이어그램 흐름 반영
    public boolean 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        // 1. 플레이어체크
        boolean 체크결과 = 플레이어객체.플레이어체크(플레이어id);
        
        if (체크결과) { // (성공) 플레이어id == "hero"
            // 2. 직업에 따른 생성 및 능력치 설정
            if (직업.equals("전사")) {
                생성된캐릭터 = new 전사(캐릭터명, 레벨);
            } else if (직업.equals("마법사")) {
                생성된캐릭터 = new 마법사(캐릭터명, 레벨);
            } else {
                return false;
            }
            // 3. UI로 생성 완료 상태 반환
            return true; 
        } else { // (실패) 플레이어id != "hero"
            // 3. UI로 인증 실패 상태 반환
            return false; 
        }
    }

    public String 몬스터공격(String 플레이어id, 캐릭터 선택된캐릭터) {
        // 1. 플레이어체크
        if (!플레이어객체.플레이어체크(플레이어id)) {
            return "[인증 실패] 플레이어 정보가 일치하지 않아 공격할 수 없습니다.";
        }

        if (선택된캐릭터 == null) {
            return "[오류] 선택된 캐릭터가 없습니다.";
        }

        // 2. 캐릭터 스킬 발동 (데미지 계산)
        double 데미지 = 선택된캐릭터.스킬발동();
        String 스킬명 = 선택된캐릭터.get스킬명();
        String 등급 = "";

        // 3. 데미지 등급 부여
        if (데미지 >= 200) {
            등급 = "S급";
        } else if (데미지 >= 100) {
            등급 = "A급";
        } else {
            등급 = "B급";
        }

        // 4. UI로 스킬명, 데미지, 등급 결과 전달
        return String.format("스킬명: [%s] | 데미지: %.1f | 등급: %s", 스킬명, 데미지, 등급);
    }
    
    public 캐릭터 get생성된캐릭터() {
        return 생성된캐릭터;
    }
}
