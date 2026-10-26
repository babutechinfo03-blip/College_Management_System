import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class VerifyFix {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/college_erp_v2";
        String user = "root";
        String pass = "Sanjai@2005";

        try (Connection conn = DriverManager.getConnection(url, user, pass);
                Statement stmt = conn.createStatement()) {

            String sql = "SELECT username, role, LENGTH(password) as hash_len FROM users WHERE role = 'STUDENT' LIMIT 5";
            try (ResultSet rs = stmt.executeQuery(sql)) {
                System.out.println("--- Student Password Verification ---");
                boolean found = false;
                while (rs.next()) {
                    found = true;
                    int len = rs.getInt("hash_len");
                    System.out.println("User: " + rs.getString("username") + " | HashLen: " + len
                            + (len == 60 ? " (OK)" : " (TRUNCATED)"));
                }
                if (!found)
                    System.out.println("No students found in database.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
