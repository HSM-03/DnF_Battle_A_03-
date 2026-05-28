package Dnf_Battle;

import java.util.HashMap;
import java.util.Map;

/**
 * 전투 클래스 (Control)
 * - 행위: 캐릭터생성, 몬스터공격, 아이템획득, 길드가입
 * - 모든 행위는 시작 시 반드시 플레이어체크로 인증한다.
 * - 생성된 캐릭터는 플레이어id를 키로 관리한다.
 * - 길드는 외부에서 생성되어 길드등록()으로 주입된다 (Aggregation).
 */
public class 전투 {

    private 플레이어 플레이어;
    private Map<String, 캐릭터> 캐릭터맵;   // 플레이어id -> 캐릭터
    private Map<String, 길드> 길드맵;       // 길드명 -> 외부 생성 길드

    public 전투() {
        this.플레이어 = new 플레이어("hero");
        this.캐릭터맵 = new HashMap<>();
        this.길드맵 = new HashMap<>();
    }

    // ────────────────────────────────────────────
    // [Phase 1] 캐릭터생성
    // ────────────────────────────────────────────
    public boolean 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        if (!플레이어.플레이어체크(플레이어id)) {
            System.out.println(">> 인증 실패: 올바른 플레이어가 아닙니다.");
            return false;
        }

        캐릭터 새캐릭터;
        if ("전사".equals(직업)) {
            새캐릭터 = new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            새캐릭터 = new 마법사(캐릭터명, 레벨);
        } else {
            System.out.println(">> 존재하지 않는 직업입니다: " + 직업);
            return false;
        }

        캐릭터맵.put(캐릭터명, 새캐릭터);
        System.out.printf(">> 캐릭터 생성 완료: %s (%s, Lv.%d) | HP=%d, 공격력=%.1f | 빈 인벤토리(0/%d) 생성%n",
                새캐릭터.캐릭터명_가져오기(), 직업, 레벨,
                새캐릭터.HP_가져오기(), 새캐릭터.공격력_가져오기(),
                새캐릭터.인벤토리_가져오기().최대용량_가져오기());
        return true;
    }

    public boolean 캐릭터존재여부(String 캐릭터명) {
        return 캐릭터맵.containsKey(캐릭터명);
    }

    // ────────────────────────────────────────────
    // [Phase 1] 몬스터공격
    // ────────────────────────────────────────────
    public String 몬스터공격(String 플레이어id, 캐릭터 캐릭터) {
        if (!플레이어.플레이어체크(플레이어id)) {
            return "❌ 인증 실패: 올바른 플레이어가 아닙니다.";
        }
        if (캐릭터 == null) {
            return "❌ 공격할 캐릭터가 존재하지 않습니다.";
        }

        double 데미지 = 캐릭터.스킬발동();
        String 스킬명 = 캐릭터.스킬명_가져오기();
        String 등급 = 데미지등급계산(데미지);
        
        String 결과 = String.format("✅ %s 공격! 데미지 = %.1f | 등급 = %s",
                스킬명, 데미지, 등급);
        System.out.println(">> " + 캐릭터.캐릭터명_가져오기() + " : " + 결과);
        return 결과;
    }

    private String 데미지등급계산(double 데미지) {
        if (데미지 >= 200)      return "S급";
        else if (데미지 >= 100) return "A급";
        else                    return "B급";
    }

    // ────────────────────────────────────────────
    // [신규 1] 아이템획득 (Composition: 캐릭터의 인벤토리에 추가)
    // ────────────────────────────────────────────
    public boolean 아이템획득(String 플레이어id, String 캐릭터명, String 아이템명, String 타입, int 가치) {
        if (!플레이어.플레이어체크(플레이어id)) {
            System.out.println(">> 인증 실패: 올바른 플레이어가 아닙니다.");
            return false;
        }

        캐릭터 캐릭터 = 캐릭터맵.get(캐릭터명);
        if (캐릭터 == null) {
            System.out.println(">> 아이템을 획득할 캐릭터가 존재하지 않습니다.");
            return false;
        }

        인벤토리 인벤토리 = 캐릭터.인벤토리_가져오기();
        if (인벤토리.가득찼는가()) {
            System.out.printf(">> 인벤토리가 가득 찼습니다(%d/%d). '%s' 획득 실패.%n",
                    인벤토리.현재개수(), 인벤토리.최대용량_가져오기(), 아이템명);
            return false;
        }

        아이템 새아이템 = new 아이템(아이템명, 타입, 가치);
        boolean 성공 = 인벤토리.아이템추가(새아이템);
        if (성공) {
            System.out.printf(">> 아이템 획득: %s | 인벤토리(%d/%d)%n",
                    새아이템.toString(), 인벤토리.현재개수(), 인벤토리.최대용량_가져오기());
        }
        return 성공;
    }

    // ────────────────────────────────────────────
    // [신규 2] 길드가입 (Aggregation: 기존 길드에 가입)
    // ────────────────────────────────────────────
    public boolean 길드가입(String 플레이어id, String 캐릭터명, String 길드명) {
        if (!플레이어.플레이어체크(플레이어id)) {
            System.out.println(">> 인증 실패: 올바른 플레이어가 아닙니다.");
            return false;
        }

        캐릭터 캐릭터 = 캐릭터맵.get(캐릭터명);
        if (캐릭터 == null) {
            System.out.println(">> 길드에 가입할 캐릭터가 존재하지 않습니다.");
            return false;
        }

        길드 길드 = 길드맵.get(길드명);
        if (길드 == null) {
            System.out.println(">> 존재하지 않는 길드입니다: " + 길드명);
            return false;
        }
        if (길드.정원초과인가()) {
            System.out.printf(">> 길드 '%s' 정원이 가득 찼습니다(%d/%d). 가입 실패.%n",
                    길드.길드명_가져오기(), 길드.현재인원(), 길드.최대인원_가져오기());
            return false;
        }

        boolean 성공 = 길드.캐릭터가입(캐릭터);
        if (성공) {
            System.out.printf(">> '%s' 캐릭터가 길드 '%s'에 가입했습니다. 길드 인원(%d/%d)%n",
                    캐릭터.캐릭터명_가져오기(), 길드.길드명_가져오기(), 길드.현재인원(), 길드.최대인원_가져오기());
        }
        return 성공;
    }

    // ────────────────────────────────────────────
    // 보조 메서드
    // ────────────────────────────────────────────

    /** 외부에서 생성된 길드를 시스템에 등록한다 (Aggregation). */
    public void 길드등록(길드 길드) {
        길드맵.put(길드.길드명_가져오기(), 길드);
    }

    public 캐릭터 캐릭터_가져오기(String 플레이어id) {
        return 캐릭터맵.get(플레이어id);
    }

    public Map<String, 캐릭터> 캐릭터맵_가져오기() {
        return 캐릭터맵;
    }

    public Map<String, 길드> 길드맵_가져오기() {
        return 길드맵;
    }
}
