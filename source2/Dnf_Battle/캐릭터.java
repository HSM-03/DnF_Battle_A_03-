package Dnf_Battle;

/**
 * 캐릭터 추상클래스
 * - 속성: 캐릭터명, 레벨, HP, 공격력, 인벤토리
 * - 행위: 스킬발동 (추상 - 전사/마법사가 각자 구현)
 * - 캐릭터 ◆--- 인벤토리 (Composition)
 *   : 캐릭터 생성 시 빈 인벤토리가 자동으로 함께 생성되며,
 *     캐릭터가 삭제되면 인벤토리도 함께 소멸한다.
 */
public abstract class 캐릭터 {

    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected double 공격력;
    protected 인벤토리 인벤토리;   // Composition

    public 캐릭터(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
        this.인벤토리 = new 인벤토리();   // 캐릭터 생성과 동시에 빈 인벤토리 생성
    }

    /** 직업별로 스킬명과 데미지 계산식이 다르게 구현된다. */
    public abstract String 스킬명_가져오기();
    public abstract double 스킬발동();

    public String 캐릭터명_가져오기() { return 캐릭터명; }
    public int    레벨_가져오기()   { return 레벨; }
    public int    HP_가져오기()    { return HP; }
    public double 공격력_가져오기() { return 공격력; }
    public 인벤토리 인벤토리_가져오기() { return 인벤토리; }
}
