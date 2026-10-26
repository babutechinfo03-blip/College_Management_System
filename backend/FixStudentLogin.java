import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class FixStudentLogin {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/college_erp_v2";
        String user = "root";
        String pass = "Sanjai@2005";
        String hash = "$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy"; // Demo@1234

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            String sql = "UPDATE users SET password = ?, visible_password = 'Demo@1234' WHERE role = 'STUDENT'";
            try (PreparedStatement ts = conn.prepareStatement(sql)) {
                ts.setString(1, hash);
                int rows = ts.executeUpdate();
                System.out.println("Updated " + rows + " students.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
