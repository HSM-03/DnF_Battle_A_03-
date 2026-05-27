package Dnf_Battle;

import java.util.ArrayList;
import java.util.List;

/**
 * 인벤토리 클래스 (신규)
 * - 속성: 아이템리스트, 최대용량(10칸)
 * - 행위: 아이템추가
 * - 인벤토리 ◆--- 아이템 (Composition, 1:N)
 *   : 인벤토리가 삭제되면 보유 아이템도 함께 소멸한다.
 */
public class 인벤토리 {

    private List<아이템> 아이템리스트;
    private int 최대용량;

    public 인벤토리() {
        this.아이템리스트 = new ArrayList<>();
        this.최대용량 = 10;
    }

    /**
     * 아이템추가: 인벤토리가 가득 차지 않은 경우에만 추가에 성공한다.
     * @return 추가 성공 여부
     */
    public boolean 아이템추가(아이템 아이템) {
        if (가득찼는가()) {
            return false;
        }
        아이템리스트.add(아이템);
        return true;
    }

    public boolean 가득찼는가() {
        return 아이템리스트.size() >= 최대용량;
    }

    public int 현재개수() {
        return 아이템리스트.size();
    }

    public List<아이템> get아이템리스트() {
        return 아이템리스트;
    }

    public int get최대용량() {
        return 최대용량;
    }
}
