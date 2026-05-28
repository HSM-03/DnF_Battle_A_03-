package Dnf_Battle;

/**
 * 아이템 클래스 (신규)
 * - 속성: 아이템명, 타입, 가치, 등급
 * - 등급은 생성 시 가치에 따라 자동 부여된다.
 *   전설(Legendary): 가치 1000 이상
 *   희귀(Rare)     : 가치 500 이상
 *   일반(Common)   : 가치 500 미만
 */
public class 아이템 {

    private String 아이템명;
    private String 타입;     // 무기, 방어구, 물약
    private int 가치;
    private String 등급;

    public 아이템(String 아이템명, String 타입, int 가치) {
        this.아이템명 = 아이템명;
        this.타입 = 타입;
        this.가치 = 가치;
        this.등급 = 등급계산(가치);
    }

    private String 등급계산(int 가치) {
        if (가치 >= 1000) {
            return "전설(Legendary)";
        } else if (가치 >= 500) {
            return "희귀(Rare)";
        } else {
            return "일반(Common)";
        }
    }

    public String 아이템명_가져오기() { return 아이템명; }
    public String 타입_가져오기()   { return 타입; }
    public int    가치_가져오기()   { return 가치; }
    public String 등급_가져오기()   { return 등급; }

    @Override
    public String toString() {
        return String.format("[%s] %s (타입: %s, 가치: %d)", 등급, 아이템명, 타입, 가치);
    }
}
