
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles1.css">
    <title>New Medicine</title>
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
    <form method="post" action="NewMedicine.jsp">
        <label>Medicine ID:</label>
        <input type="text" name="MedicineID"><br>
        <label>Medicine Name:</label>
        <input type="text" name="MedicineName"><br>
        <label>Medicine Price:</label>
          <input type="text" name="MedicinePrice"><br>
        <input type="submit" value="Add Medicine">
    </form>
    <%
        String connectionURL = "jdbc:mysql://localhost:3306/Hospital";
        String username = "root";
        String password = "SongHuy@512";
        Connection connection = null;
        PreparedStatement insertPstmt = null;
        String MedicineID = request.getParameter("MedicineID");
        String MedicineName = request.getParameter("MedicineName");
        String MedicinePrice = request.getParameter("MedicinePrice");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, username, password);

            String insertSql = "INSERT INTO Medicine (MedicineID, MedicineName, MedicinePrice) VALUES (?, ?, ?)";
            insertPstmt = connection.prepareStatement(insertSql);
            insertPstmt.setString(1, MedicineID);
            insertPstmt.setString(2, MedicineName);
            insertPstmt.setString(3, MedicinePrice);
     
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
