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
    <title>Patient Detail</title>
    <style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}

h1 {
    text-align: center;
    margin-top: 50px;
}

h2 {
    margin-top: 30px;
}

.contain {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: white;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
}

table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
    padding: 8px;
}

th {
    background-color: #4CAF50;
    color: white;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

button {
    float: right;
    margin-top: 20px;
    margin-right: 20px;
    padding: 10px 20px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

a {
    color: #4CAF50;
}

a:hover {
    text-decoration: none;
    color: #2E8B57;
}
</style>
</head>
<body>
    <div class="contain">

        <hr>
        <h1>Patient Detail</h1>
        <%
            String connectionURL="jdbc:mysql://localhost:3306/Hospital"; //step 2
            Connection connection = null;    //step 3
            Statement statement = null;    //step 4
            ResultSet rs = null; 
            String id = request.getParameter("PatientID");
            Class.forName("com.mysql.jdbc.Driver");    
            connection = DriverManager.getConnection(connectionURL, "root","SongHuy@512");
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM Patients WHERE PatientID="+id+";");    
            while (rs.next()) {
                out.println("<p><strong>Patient ID:</strong> " + rs.getString("PatientID") + "</p>");
                out.println("<p><strong>Patient Name:</strong> " + rs.getString("Name") + "</p>");
                out.println("<p><strong>Date of Birth:</strong> " + rs.getString("DateOfBirth") + "</p>");
                out.println("<p><strong>Room Number:</strong> " + rs.getString("RoomNumber") + "</p>");
            }
            rs.close();        
        %>

        <h2>Medicine</h2>
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
        <table>
            <thead>
                <tr>
                    <th>Medicine ID</th>
                    <th>Medicine Name</th>
                    <th>Medicine Price</th>
                </tr>
            </thead>
            <tbody>
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
                </tr>
                <%
                }
                rs.close();
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="2"><strong>Total Medicine Price:</strong></td>
                    <td><%=totalMedicinePrice%></td
                </tr>
</tfoot>
</table>
                
                 <h2>Doctor :</h2>
<%
    String sql1 = "SELECT Employees.EmployeeID, Employees.Name AS EmployeeName " +
    "FROM Patients " +
    "INNER JOIN PatientEmployee ON Patients.PatientID = PatientEmployee.PatientID " +
    "INNER JOIN Employees ON PatientEmployee.EmployeeID = Employees.EmployeeID " +
    "WHERE Patients.PatientID= ?";
PreparedStatement pstmt1 = connection.prepareStatement(sql1);
pstmt1.setString(1, id);
rs = pstmt1.executeQuery();

%>
      <table>
          <thead>
		<tr>
		<th>Employee ID</th>
		<th>Employee Name</th>
     
        
		</tr>            
          </thead>        
          <tbody>            
  <%                      
         while (rs.next()) {
           String EmployeeID = rs.getString("EmployeeID");
          String EmployeeName = rs.getString("EmployeeName"); 
    %>
    <tr>
	<td><%=EmployeeID%></td>
       <td><%=EmployeeName%></td>
 
</tr>
<%
}rs.close();
			%>
          </tbody>
            </table>
          <a href="Pay.jsp?PatientID=<%=id%>">Payment</a>
<p><a href="HomeManager.jsp">Back to homepage</a></p>
</div>
</body>
</html>