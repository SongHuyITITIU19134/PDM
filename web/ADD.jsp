<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<button><a href="HomeManager.jsp">Homepage</a></button>
               <%
       
           
            String connectionURL="jdbc:mysql://localhost:3306/Hospital"; //step 2
            Connection connection = null;	//step 3
            Statement statement = null;	//step 4
            ResultSet rs = null; 

%>

<%
          String value = request.getParameter("PatientID");
            Class.forName("com.mysql.jdbc.Driver");	
            connection = DriverManager.getConnection(connectionURL, "root","SongHuy@512");
            statement = connection.createStatement();           
%>

<%
String studentID = request.getParameter("PatientID");
String courseID = request.getParameter("courseList");

String insertSql = "INSERT INTO MedicinePatient(PatientID, MedicineID) VALUES (?, ?)";
PreparedStatement insertPstmt = connection.prepareStatement(insertSql);
insertPstmt.setString(1, studentID);
insertPstmt.setString(2, courseID);
insertPstmt.executeUpdate();
insertPstmt.close();

response.sendRedirect("DetailPatient.jsp?PatientID=" + studentID);
%>


