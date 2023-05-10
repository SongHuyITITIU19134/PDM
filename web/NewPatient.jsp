
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <link rel="stylesheet" href="styles1.css">
    <title>New Patient</title>
</head>

<body>
  <header>
        <nav>
            <ul>
                <li><a href="HomeManager.jsp">Homepage</a></li>
            </ul>
        </nav>
        <h1>New Patient</h1>
    </header>
       <main>
    <form method="post" action="NewPatient.jsp">
        <label>Patient ID:</label>
        <input type="text" name="PatientID"><br>
        <label>Patient Name:</label>
        <input type="text" name="Name"><br>
        <label>Date of Birth:</label>
        <input type="text" name="DateOfBirth"><br>
        <label>Address:</label>
        <input type="text" name="Address"><br>
        <label>Phone Number:</label>
        <input type="text" name="PhoneNumber"><br>
        <label>Room Number:</label>
        <input type="text" name="RoomNumber"><br>
        <input type="submit" value="Add Patient">
    </form>
    <%
        String connectionURL = "jdbc:mysql://localhost:3306/Hospital";
        String username = "root";
        String password = "SongHuy@512";
        Connection connection = null;
        PreparedStatement insertPstmt = null;
        String PatientID = request.getParameter("PatientID");
        String PName = request.getParameter("Name");
        String DOB = request.getParameter("DateOfBirth");
        String Address = request.getParameter("Address");
        String PhoneNumber = request.getParameter("PhoneNumber");
        String RoomNumber = request.getParameter("RoomNumber");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, username, password);

            String insertSql = "INSERT INTO Patients (PatientID, Name, DateOfBirth, Address, PhoneNumber, RoomNumber) VALUES (?, ?, ?, ?, ?, ?)";
            insertPstmt = connection.prepareStatement(insertSql);
            insertPstmt.setString(1, PatientID);
            insertPstmt.setString(2, PName);
            insertPstmt.setString(3, DOB);
            insertPstmt.setString(4, Address);
            insertPstmt.setString(5, PhoneNumber);
            insertPstmt.setString(6, RoomNumber);
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
        <p>&copy; 2023 HuyNguyen</p>
    </footer>
</body>
</html>
