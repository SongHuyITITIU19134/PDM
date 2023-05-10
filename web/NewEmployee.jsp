<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>New Employee</title>
    <link rel="stylesheet" href="styles1.css">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="HomeManager.jsp">Homepage</a></li>
            </ul>
        </nav>
        <h1>New Employee</h1>
    </header>
    <main>
        <form method="post" action="NewEmployee.jsp">
            <label for="EmployeeID">Employee ID:</label>
            <input type="text" id="EmployeeID" name="EmployeeID">
            <label for="Name">Employee Name:</label>
            <input type="text" id="Name" name="Name">
            <label for="PhoneNumber">Phone Number:</label>
            <input type="text" id="PhoneNumber" name="PhoneNumber">
            <label for="Specialist">Specialist:</label>
            <input type="text" id="Specialist" name="Specialist">
            <input type="submit" value="Add Employee">
        </form>
        <% String connectionURL = "jdbc:mysql://localhost:3306/Hospital";
        String username = "root";
        String password = "SongHuy@512";
        Connection connection = null;
        PreparedStatement insertPstmt = null;
        String id = request.getParameter("EmployeeID");
        String EmployeeName = request.getParameter("Name");
        String PhoneNumber = request.getParameter("PhoneNumber");
        String Specialist = request.getParameter("Specialist");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, username, password);

            String insertSql = "INSERT INTO Employees(EmployeeID, Name, PhoneNumber, Specialist) VALUES (?, ?, ?, ?)";
            insertPstmt = connection.prepareStatement(insertSql);
            insertPstmt.setString(1,id);
            insertPstmt.setString(2, EmployeeName);
            insertPstmt.setString(3, PhoneNumber);
            insertPstmt.setString(4, Specialist);
            insertPstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (insertPstmt != null) {
                insertPstmt.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        %>
    </main>
    <footer>
        <hr>
        <p>&copy; 2023 Hospital</p>
    </footer>
</body>
</html>
