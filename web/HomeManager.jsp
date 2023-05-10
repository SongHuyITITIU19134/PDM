<%-- 
    Document   : home
    Created on : Mar 7, 2023, 9:49:59 PM
    Author     : songhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Hospital Manager Demo</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Hospital Manager Demo</h1>
  </header>
  <main>
    <form action="DetailPatient.jsp" method="post">
      <label for="patient-id">Patient ID:</label>
      <input type="text" id="patient-id" name="PatientID">
      <button type="submit">Submit</button>
    </form>
    <h2>Manager</h2>
    <div class="box">
        <div class="element1">
         <button class="btn">
   <a style="text-decoration: none" href="PatientManager.jsp">Patient Manager</a>
</button>
      </div>
      <div class="element2">
               <button class="btn">
   <a style="text-decoration: none" href="MedicineManager.jsp">Medicine Manager</a>
</button>
       
      </div>
      <div class="element2">
             <button class="btn">
   <a style="text-decoration: none"  href="EmployeeManager.jsp">Employee Manager</a>
</button>
 
      </div>
    </div>
  </main>
</body>
</html>

