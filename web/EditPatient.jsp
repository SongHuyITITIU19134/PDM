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
<meta charset="UTF-8" />
<title>Update Patient Information</title>
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
<a href="HomeManager.jsp">Homepage</a><br>
<hr>

<body >
    <main>
<h1>Patient's Detail</h1>
<%
    String id = request.getParameter("PatientID");
    String connectionURL="jdbc:mysql://localhost:3306/Hospital";
    try {
        Connection connection = DriverManager.getConnection(connectionURL, "root", "SongHuy@512");
        String query = "SELECT * FROM Patients WHERE PatientID=?";
        PreparedStatement pstmt = connection.prepareStatement(query);
        pstmt.setString(1, id);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            out.println("PatientID: " + rs.getString("PatientID") + "<br>");
            out.println("Name: " + rs.getString("Name"));
        }
        rs.close();
        pstmt.close();
        connection.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<h1>Update Patient Information</h1>
<form method="POST" action="UpDatePatient.jsp">
    <label for="id">Patient ID:</label>
    <input type="text" id="id" name="PatientID"><br>
    <label for="newName">New Name:</label>
    <input type="text" id="newName" name="newName"><br> 
    <label for="newName">New Symptom:</label>
    <input type="text" id="new" name="newSymptom"><br>
    <input type="submit" value="Update">
</form>
    </main>
</body>
</html>
