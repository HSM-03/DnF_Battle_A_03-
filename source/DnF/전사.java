package DnF;

public class 전사 extends 캐릭터 {
    public 전사(String 캐릭터명, int 레벨) {
        super(캐릭터명, 레벨);
        this.HP = 레벨 * 100;
        this.공격력 = 레벨 * 15;
    }

    @Override
    public double 스킬발동() {
        return this.공격력 * 1.5; // 계산된 데미지만 반환
    }

    @Override
    public String get스킬명() {
        return "검 휘두르기!";
    }
}