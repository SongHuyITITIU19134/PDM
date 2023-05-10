<%-- 
    Document   : Detal
    Created on : Mar 7, 2023, 9:58:44 PM
    Author     : songhuy
--%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail</title>
         <link rel="stylesheet" href="styles3.css">
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
        <h1>Medicine's Detail</h1>
         <div class="employee-details">   
                      <%
       
           
            String connectionURL="jdbc:mysql://localhost:3306/Hospital"; //step 2
            Connection connection = null;	//step 3
            Statement statement = null;	//step 4
            ResultSet rs = null; 

%>

<%
          String id = request.getParameter("MedicineID");
            Class.forName("com.mysql.jdbc.Driver");	
            connection = DriverManager.getConnection(connectionURL, "root","SongHuy@512");
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM Medicine WHERE MedicineID="+id+";");	
         while (rs.next()) {
            out.println("MedicineID:"+rs.getString("MedicineID")+"<br>");
                out.println("MedicineName:"+rs.getString("MedicineName"));

            }   rs.close();		
            
%>

</div>
    </section>


<h2>Patient was added :</h2>
<%
    String sql = "SELECT Patients.PatientID, Patients.Name,Medicine.MedicineID " +
    "FROM Medicine " +
    "INNER JOIN MedicinePatient ON Medicine.MedicineID = MedicinePatient.MedicineID " +
    "INNER JOIN Patients ON MedicinePatient.PatientID = Patients.PatientID " +
    "WHERE Medicine.MedicineID = ?";
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
        <a href="DelPatient.jsp?PatientID=<%=PatientID%>&MedicineID=<%=id%>">Delete</a>
       </td>
       
</tr>
<%
}rs.close();
			%>
            </table>
  </main>
    <footer>
      <hr>
      <p>&copy; 2023 HuyNguyen</p>
    </footer>
  </body>
</html>
