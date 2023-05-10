
<%@page import="java.sql.SQLException"%>
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
    <meta charset="UTF-8">
    <title>Employee Detail</title>
  <link rel="stylesheet" href="styles2.css">
  </head>
  <body>
    <header>
      <nav>
        <ul>
          <li><a href="HomeManager.jsp">Homepage</a></li>
        </ul>
      </nav>
    </header>
    <main>
      <section>
        <h1>Employee's Detail</h1>
        <div class="employee-details">
         <%
       
           
            String connectionURL="jdbc:mysql://localhost:3306/Hospital"; //step 2
            Connection connection = null;	//step 3
            Statement statement = null;	//step 4
            ResultSet rs = null; 

%>

<%
          String id = request.getParameter("EmployeeID");
            Class.forName("com.mysql.jdbc.Driver");	
            connection = DriverManager.getConnection(connectionURL, "root","SongHuy@512");
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM Employees WHERE EmployeeID="+id+";");	
         while (rs.next()) {
            out.println("EmployeeID:"+rs.getString("EmployeeID")+"<br>");
                out.println("EmployeeName:"+rs.getString("Name"));

            }   rs.close();		
            
%>
        </div>
      </section>
      <section>
        <h2>Select Patient</h2>
        <div class="select-patient">
          <form method="post" action="ADDPatient.jsp">
            <input type="hidden" name="EmployeeID" value="<%=id%>">
            <select name="courseList">
              <option value="">--Select Patient--</option>
              <% //retrieve course list from database
        String MedicineSql = "SELECT * FROM Patients";
        PreparedStatement coursePstmt = connection.prepareStatement(MedicineSql);
        ResultSet courseRs = coursePstmt.executeQuery();
        while(courseRs.next()) {
            String PatientID = courseRs.getString("PatientID");
            String PatientName = courseRs.getString("Name");
            %>
            <option value="<%=PatientID%>"><%=PatientName%></option>
            <%
        }
        courseRs.close();
        coursePstmt.close();
        %>
            </select>
            <input type="submit" name="ADD" value="Add Patient">
          </form>
        </div>
      </section>
        <h2>Patient was added :</h2>
      
       <%
    String sql = "SELECT Patients.PatientID, Patients.Name " +
    "FROM Employees " +
    "INNER JOIN PatientEmployee ON Employees.EmployeeID = PatientEmployee.EmployeeID " +
    "INNER JOIN Patients ON PatientEmployee.PatientID = Patients.PatientID " +
    "WHERE Employees.EmployeeID= ?";
PreparedStatement pstmt = connection.prepareStatement(sql);
pstmt.setString(1, id);
rs = pstmt.executeQuery();

%>
   
          <table border="1">
		<tr>
		<th>Patient ID</th>
		<th>Patient Name</th>
                <th>Action</th>
		</tr>            
                   
  <%                      
  while (rs.next()) {
           String PatientID = rs.getString("PatientID");
          String PatientName = rs.getString("Name"); 
              	
    %>
    
                        
    <tr>
	<td><%=PatientID%></td>
       <td><%=PatientName%></td>
       
       <td>
        <a href="DelPatient.jsp?PatientID=<%=PatientID%>&EmployeeID=<%=id%>">Delete</a>
       </td>
       
</tr>
<%
}rs.close();
			%>
          </table>
    </main>
    <footer>
      <hr>
      <p>&copy; 2023 Hospital Inc.</p>
    </footer>
  </body>
</html>
