<%-- 
    Document   : StudentManager
    Created on : Mar 8, 2023, 9:58:30 AM
    Author     : songhuy
--%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Patient Manager</title>
    </head>
    <body>
    <header>
      <nav>
        <ul>
          <li><a href="HomeManager.jsp">Homepage</a></li>
        </ul>
      </nav>
      <h1>Patient List</h1>
    </header>
       <main>
         <%
       
           
            String connectionURL="jdbc:mysql://localhost:3306/Hospital"; //step 2
            Connection connection = null;	//step 3
            Statement statement = null;	
            ResultSet rs = null; 

%>

<%
         
            Class.forName("com.mysql.jdbc.Driver");	
            connection = DriverManager.getConnection(connectionURL, "root","SongHuy@512");
            statement = connection.createStatement();
          	 rs = statement.executeQuery("SELECT * FROM Patients");	
         while (rs.next()) {
            }	//step 6
            rs.close();	//step 7
%>

<table>
        <thead>
          <tr>
            <th>Patient ID</th>
            <th>Patient Name</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
      <%
  
        rs = statement.executeQuery("SELECT * FROM Patients");	
%>
      
      <% while (rs.next()) {
       
     String id = rs.getString("PatientID");
       String sid = rs.getString("Name");
      %>
     
    <tr>
        <td><%= rs.getString("PatientID") %></td> 
        <td><a style="text-decoration: none" href="DetailPatient.jsp?PatientID=<%=id%>"><%= rs.getString("Name")%></td>
        <td>
            <a class="delete-link"href="DelPatient.jsp?PatientID=<%=id%>">Delete</a>
       <a class="edit-link" href="EditPatient.jsp?PatientID=<%=id%>&Name=<%=sid%>">Edit</a></td>
    </tr>
    <%
            }
            rs.close();
          %>
        </tbody>
      </table>

      <button class="new-button"><a style="text-decoration: none" href="NewPatient.jsp">Add New Patient</a></button>
    </main>

    <footer>
      <hr>
      <p>&copy; 2023 HuyNguyen</p>
    </footer>
  </body>
</html>