package Dnf_Battle;
import java.lang.reflect.Method;

public class MethodChecker {
    public static void main(String[] args) {
        try {
            Class<?> clazz = Class.forName("Dnf_Battle.캐릭터");
            for (Method m : clazz.getDeclaredMethods()) {
                System.out.println(m.getName());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
