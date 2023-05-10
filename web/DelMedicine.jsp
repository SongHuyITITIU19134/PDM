<%@page import="java.sql.SQLException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<button><a href="HomeManager.jsp">Homepage</a></button><br>
<hr>

<body style="background-color:#CCCCFF">
<%
String MedicineID = request.getParameter("MedicineID");
String connectionURL = "jdbc:mysql://localhost:3306/Hospital";
Connection connection = null;
PreparedStatement statement = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    connection = DriverManager.getConnection(connectionURL, "root", "SongHuy@512");
    String query = "DELETE FROM Medicine WHERE MedicineID = ?";
    statement = connection.prepareStatement(query);
    statement.setString(1, MedicineID);
    int rowsAffected = statement.executeUpdate();
    
    if (rowsAffected > 0) {
        out.println("Successfully deleted Medicine.");
    } else {
        out.println("Failed to delete Medicine.");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { statement.close(); } catch (Exception e) { /* ignored */ }
    try { connection.close(); } catch (Exception e) { /* ignored */ }
}
%>
</body>
