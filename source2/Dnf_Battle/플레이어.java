package Dnf_Battle;

/**
 * 플레이어 클래스
 * - 행위: 플레이어체크 (플레이어id가 "hero"인지 검증)
 */
public class 플레이어 {

    private String 플레이어id;

    public 플레이어(String 플레이어id) {
        this.플레이어id = 플레이어id;
    }

    /**
     * 플레이어체크: 모든 행위 전에 반드시 호출되는 인증 메서드.
     * 요구사항상 플레이어id가 "hero"일 때만 true를 반환한다.
     */
    public boolean 플레이어체크(String 플레이어id) {
        return "hero".equals(플레이어id);
    }

    public String get플레이어id() {
        return 플레이어id;
    }
}
