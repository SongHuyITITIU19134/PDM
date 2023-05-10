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
 
 <body >
        <header>
      <nav>
        <ul>
          <li><a href="HomeManager.jsp">Homepage</a></li>
        </ul>
      </nav>
    </header>
     <main>
      <section>
        <h1>Patient's Detail</h1>
        <div class="employee-details">
           
                      <%
       
           
            String connectionURL="jdbc:mysql://localhost:3306/Hospital"; //step 2
            Connection connection = null;	//step 3
            Statement statement = null;	//step 4
            ResultSet rs = null; 

%>

<%
          String id = request.getParameter("PatientID");
            Class.forName("com.mysql.jdbc.Driver");	
            connection = DriverManager.getConnection(connectionURL, "root","SongHuy@512");
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM Patients WHERE PatientID="+id+";");	
         while (rs.next()) {
            out.println("PatientID:"+rs.getString("PatientID")+"<br>");
         
                out.println("PatientName:"+rs.getString("Name"));

            }   rs.close();		
            
%>
 </div>
      </section>
      <section>
        <h2>Select Patient</h2>
  <div class="contain">
          <div class="text">
                        Medicine: 
            </div>
                                
<div class="select-patient">
   <form method="post" action="ADD.jsp">
    <input type="hidden" name="PatientID" value="<%=id%>">
    <select name="courseList">
        <option value="">--Select Medicine--</option>
        <% //retrieve course list from database
        String MedicineSql = "SELECT * FROM Medicine";
        PreparedStatement coursePstmt = connection.prepareStatement(MedicineSql);
        ResultSet courseRs = coursePstmt.executeQuery();
        while(courseRs.next()) {
            String MedicineID = courseRs.getString("MedicineID");
            String MedicineName = courseRs.getString("MedicineName");
            %>
            <option value="<%=MedicineID%>"><%=MedicineName%></option>
            <%
        }
        courseRs.close();
        coursePstmt.close();
        %>
    </select>
    <input type="submit" name="ADD" value="Add Medicine">
</form>
     </div>
 </section>

<h2>Medicine was added :</h2>
<%
    String sql = "SELECT Medicine.MedicineID, Medicine.MedicineName, Medicine.MedicinePrice " +
    "FROM Patients " +
    "INNER JOIN MedicinePatient ON Patients.PatientID = MedicinePatient.PatientID " +
    "INNER JOIN Medicine ON MedicinePatient.MedicineID = Medicine.MedicineID " +
    "WHERE Patients.PatientID = ?";
PreparedStatement pstmt = connection.prepareStatement(sql);
pstmt.setString(1, id);
rs = pstmt.executeQuery();
 double totalMedicinePrice = 0.0; 
%>


            <table border="1">
		<tr>
		<th>Medicine ID</th>
		<th>Medicine Name</th>
                <th>Medicine Price</th>
                <th>Action</th>
		</tr>            
                        
                        
  <%                      
         while (rs.next()) {
           String MedicineID = rs.getString("MedicineID");
          String MedicineName = rs.getString("MedicineName"); 
          String MedicinePrice = rs.getString("MedicinePrice");
         totalMedicinePrice += Double.parseDouble(MedicinePrice);	
    %>
    <tr>
	<td><%=MedicineID%></td>
       <td><%=MedicineName%></td>
         <td><%=MedicinePrice%></td>
       <td>
        <a class="delete" href="DelMedicine.jsp?MedicineID=<%=MedicineID%>&PatientID=<%=id%>">Delete</a>
       </td>
       
</tr>
<%
}rs.close();
			%>
            </table>
            <p>Total Medicine Price: <%=totalMedicinePrice%></p>
    </main>
    <footer>
      <hr>
      <p>&copy; 2023 Hospital Inc.</p>
      <a class="view" href="View.jsp?PatientID=<%=id%>">View Result </a>
    </footer>
  </body>
</html>

