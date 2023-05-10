<%@ page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
	
</head>
<button><a href="HomeManager.jsp">Homepage</a></button><br>
<hr>
<center>
<body style="background-color:#CCCCFF">
	<h1>Update Employee Specialist</h1>
	<%
		String id = request.getParameter("EmployeeID");
		String newName = request.getParameter("newName");

		String dbUrl = "jdbc:mysql://localhost:3306/Hospital";
		String dbUser = "root";
		String dbPassword = "SongHuy@512";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			String sql = "UPDATE Employees SET Specialist = ? WHERE EmployeeID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newName);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			out.println("<p>Specialist updated successfully!</p>");
		} catch (Exception e) {
			e.printStackTrace();
			out.println("<p>Error: " + e.getMessage() + "</p>");
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					// Ignore
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					// Ignore
				}
			}
		}
	%>
	
</body>
</center>
</html>
