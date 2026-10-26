import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class VerifyUser {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/college_erp_v2";
        String user = "root";
        String pass = "Sanjai@2005";
        String[] usersToCheck = args.length > 0 ? args
                : new String[] { "2025IT001", "2025ECE001", "2025EEE001", "STF-IT001" };

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            String sql = "SELECT username, password, role FROM users WHERE username = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                for (String username : usersToCheck) {
                    pstmt.setString(1, username);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            System.out.println("User: " + rs.getString("username") + " | Role: " + rs.getString("role")
                                    + " | HashLen: " + rs.getString("password").length());
                        } else {
                            System.out.println("User [" + username + "] NOT found.");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
