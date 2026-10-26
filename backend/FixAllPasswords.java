import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class FixAllPasswords {
    public static void main(String[] args) {
        String[] dbs = { "college_erp", "college_erp_v2" };
        String user = "root";
        String pass = "Sanjai@2005";
        String hash = "$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy"; // Demo@1234

        for (String db : dbs) {
            String url = "jdbc:mysql://localhost:3306/" + db;
            try (Connection conn = DriverManager.getConnection(url, user, pass);
                    Statement stmt = conn.createStatement()) {

                String sql = "UPDATE users SET password = '" + hash + "', visible_password = 'Demo@1234'";
                int rows = stmt.executeUpdate(sql);
                System.out.println("[" + db + "] Updated " + rows + " users.");

            } catch (Exception e) {
                System.err.println("[" + db + "] Error: " + e.getMessage());
            }
        }
    }
}
