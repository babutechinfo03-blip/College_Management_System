import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class CheckDB {
    public static void main(String[] args) {
        String[] dbs = { "college_erp", "college_erp_v2" };
        String user = "root";
        String pass = "Sanjai@2005";

        for (String db : dbs) {
            String url = "jdbc:mysql://localhost:3306/" + db;
            try (Connection conn = DriverManager.getConnection(url, user, pass);
                    Statement stmt = conn.createStatement()) {

                System.out.println("--- DB: " + db + " ---");
                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users")) {
                    if (rs.next())
                        System.out.println("User count: " + rs.getInt(1));
                }

                // Check for 2025IT001
                try (ResultSet rs = stmt
                        .executeQuery("SELECT username, password FROM users WHERE username = '2025IT001'")) {
                    if (rs.next()) {
                        System.out.println("Found 2025IT001. Hash: " + rs.getString(2));
                    } else {
                        System.out.println("2025IT001 NOT found.");
                    }
                }
            } catch (Exception e) {
                System.err.println("[" + db + "] Error: " + e.getMessage());
            }
        }
    }
}
