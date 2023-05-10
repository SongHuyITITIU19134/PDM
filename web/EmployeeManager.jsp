
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Manager</title>
    <link rel="stylesheet" href="styles.css">
  </head>
  <body>
    <header>
      <nav>
        <ul>
          <li><a href="HomeManager.jsp">Homepage</a></li>
        </ul>
      </nav>
      <h1>Employee List</h1>
    </header>

    <main>
        <%
			String connectionURL="jdbc:mysql://localhost:3306/Hospital";
			Connection connection = null;
			Statement statement = null;
			ResultSet rs = null;
		
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(connectionURL, "root","SongHuy@512");
			statement = connection.createStatement();
			rs = statement.executeQuery("SELECT * FROM Employees");
		%>
      <table>
        <thead>
          <tr>
            <th>Employee ID</th>
            <th>Employee Name</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <%
            while (rs.next()) {
              String id = rs.getString("EmployeeID");
              String name = rs.getString("Name");
          %>
          <tr>
            <td><%= id %></td>
            <td><a style="text-decoration: none" href="DetailEmployee.jsp?EmployeeID=<%=id%>"><%= name %></a></td>
            <td>
              <a class="edit-link" href="EditEmployee.jsp?EmployeeID=<%=id%>&Name=<%=name%>">Edit</a>
              <a class="delete-link" href="DelEmployee.jsp?EmployeeID=<%=id%>">Delete</a>
            </td>
          </tr>
          <%
            }
            rs.close();
          %>
        </tbody>
      </table>

      <button class="new-button"><a style="text-decoration: none" href="NewEmployee.jsp">Add New Employee</a></button>
    </main>

    <footer>
      <hr>
      <p>&copy; 2023 HuyNguyen</p>
    </footer>
  </body>
</html>
