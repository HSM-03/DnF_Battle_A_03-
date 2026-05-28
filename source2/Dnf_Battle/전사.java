package Dnf_Battle;

/**
 * 전사 클래스 (캐릭터 상속)
 * - HP = 레벨 × 100, 공격력 = 레벨 × 15
 * - 스킬발동: "검 휘두르기!" → 데미지 = 공격력 × 1.5
 */
public class 전사 extends 캐릭터 {

    public 전사(String 캐릭터명, int 레벨) {
        super(캐릭터명, 레벨);
        this.HP = 레벨 * 100;
        this.공격력 = 레벨 * 15;
    }

    @Override
    public String 스킬명_가져오기() {
        return "검 휘두르기!";
    }

    @Override
    public double 스킬발동() {
        return 공격력 * 1.5;
    }
}
