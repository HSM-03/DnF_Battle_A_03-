package DnF;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected double 공격력;

    public 캐릭터(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
    }

    public abstract double 스킬발동();
    public abstract String get스킬명(); 
    
    public int getHP() { return HP; }
    public double get공격력() { return 공격력; }
    public String get캐릭터명() { return 캐릭터명; }
}