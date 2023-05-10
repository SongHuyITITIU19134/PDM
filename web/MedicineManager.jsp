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
        <title>Medicine Manager</title>
    </head>
    
    
    <body>
    <<header>
      <nav>
        <ul>
          <li><a href="HomeManager.jsp">Homepage</a></li>
        </ul>
      </nav>
      <h1>Medicine List</h1>
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
          	 rs = statement.executeQuery("SELECT * FROM Medicine");	
         while (rs.next()) {
            }	//step 6
            rs.close();	//step 7
%>

<table>
        <thead>
          <tr>
            <th>Medicine ID</th>
            <th>Medicine Name</th> 
            <th>Medicine Price</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
      <%
  
        rs = statement.executeQuery("SELECT * FROM Medicine");	
%>
      
      <% while (rs.next()) {
       
     String id = rs.getString("MedicineID");
       String sid = rs.getString("MedicineName");
       String price = rs.getString("MedicinePrice");
      %>
     
    <tr>
        <td><%= rs.getString("MedicineID") %></td>  
        <td><a style="text-decoration: none" href="ViewMedicine.jsp?MedicineID=<%=id%>"><%= rs.getString("MedicineName")%></td>
        <td><%= rs.getString("MedicinePrice") %></td> 
        <td><a class="delete-link" href="DelMedicine.jsp?MedicineID=<%=id%>">Delete</a>
      <a class="edit-link" href="EditMedicine.jsp?MedicineID=<%=id%>&MedicineName=<%=sid%>">Edit</a>
        </td>
  </tr>
          <%
            }
            rs.close();
          %>
        </tbody>
      </table>
<br>     
    <button class="new-button"><a style="text-decoration: none" style="text-decoration: none" href="NewMedicine.jsp">New Medicine</a></button>

    </main>
        <footer>
      <hr>
      <p>&copy; 2023 HuyNguyen</p>
    </footer>
    
    </body>
</html>
