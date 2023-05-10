<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Employee Specialist</title>
    <style>
        body {
            color: #2D2727;
            background-color: #A4BC92;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        main {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            box-sizing: border-box;
        }
        

        h1, h2, h3, h4, h5, h6 {
            margin-top: 0;
            
        }

        a {
            color: #000;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        label {
            display: block;
            margin-bottom: 10px;
          
        }

        input[type="text"] {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #3e8e41;
        }
       
    </style>
</head>
<body>
<header>
    <nav>
        <a href="HomeManager.jsp">Homepage</a>
    </nav>
</header>
<main>
    <h1>Update Employee Specialist</h1>
    <% String id = request.getParameter("EmployeeID");
       String connectionURL="jdbc:mysql://localhost:3306/Hospital";
       try {
            Connection connection = DriverManager.getConnection(connectionURL, "root", "SongHuy@512");
            String query = "SELECT * FROM Employees WHERE EmployeeID=?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                out.println("<h4>EmployeeID: " + rs.getString("EmployeeID") + "</h4>");
                out.println("<h4>EmployeeName: " + rs.getString("Name") + "</h4>");
                out.println("<h4>Specialist: " + rs.getString("Specialist") + "</h4>");
            }
            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <form method="POST" action="UpdateEmployee.jsp">
        <label for="id">Employee ID:</label>
        <input type="text" id="id" name="EmployeeID">
        <label for="newName"><strong>New Specialist :</strong></label>
        <input type="text" id="newName" name="newName">
        <input type="submit" value="Update">
    </form>
</main>
</body>
</html>