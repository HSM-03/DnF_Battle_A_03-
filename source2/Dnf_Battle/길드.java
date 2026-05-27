package Dnf_Battle;

import java.util.ArrayList;
import java.util.List;

/**
 * 길드 클래스 (신규)
 * - 속성: 길드명, 캐릭터리스트, 최대인원(5명)
 * - 행위: 캐릭터가입
 * - 길드 ◇--- 캐릭터 (Aggregation, 1:N)
 *   : 길드는 외부에서 이미 생성된 객체이며, 길드가 해체되어도
 *     소속 캐릭터는 독립적으로 계속 존재한다.
 */
public class 길드 {

    private String 길드명;
    private List<캐릭터> 캐릭터리스트;   // Aggregation (참조만 보관)
    private int 최대인원;

    public 길드(String 길드명) {
        this.길드명 = 길드명;
        this.캐릭터리스트 = new ArrayList<>();
        this.최대인원 = 5;
    }

    /**
     * 캐릭터가입: 정원이 가득 차지 않은 경우에만 가입에 성공한다.
     * @return 가입 성공 여부
     */
    public boolean 캐릭터가입(캐릭터 캐릭터) {
        if (정원초과인가()) {
            return false;
        }
        캐릭터리스트.add(캐릭터);
        return true;
    }

    public boolean 정원초과인가() {
        return 캐릭터리스트.size() >= 최대인원;
    }

    public int 현재인원() {
        return 캐릭터리스트.size();
    }

    public String get길드명()              { return 길드명; }
    public List<캐릭터> get캐릭터리스트()    { return 캐릭터리스트; }
    public int get최대인원()               { return 최대인원; }
}
