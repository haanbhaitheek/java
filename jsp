<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Details</title>
</head>
<body>

<%
String operation = request.getParameter("operation");
String usn = request.getParameter("usn");

// Database connection details
String jdbcUrl = "jdbc:mysql://localhost:3306/shiva";
String dbUser = "root";
String dbPassword = "";

try {
// Load JDBC driver
Class.forName("com.mysql.jdbc.Driver");

// Establish database connection
Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

switch (operation) {
case "insert":
// Insert operation
String insertSql = "INSERT INTO rama (usn, name,gender,age) VALUES (?, ?,?,?)";
PreparedStatement insertStatement = connection.prepareStatement(insertSql);
insertStatement.setString(1,usn);
insertStatement.setString(2,request.getParameter("name"));
insertStatement.setString(3,request.getParameter("gender"));
insertStatement.setString(4,request.getParameter("age"));// Assuming a parameter named "name"
insertStatement.executeUpdate();
out.println("<h2>Data inserted successfully</h2>");
insertStatement.close();
break;

case "update":
// Update operation
String updateSql = "UPDATE rama SET name=? WHERE usn=?";
PreparedStatement updateStatement = connection.prepareStatement(updateSql);
updateStatement.setString(1,request.getParameter("name")); // Assuming a parameter named "name"
updateStatement.setString(2,usn);
//updateStatement.executeUpdate();
if (updateStatement.executeUpdate()>0)
{
out.println("<h2>Data updated successfully</h2>");
}
else
{
out.println("<h2>Invalid USN</h2>");
}
updateStatement.close();
break;

case "delete":
// Delete operation
String deleteSql = "DELETE FROM rama WHERE usn=?";
PreparedStatement deleteStatement = connection.prepareStatement(deleteSql);
deleteStatement.setString(1,usn);
// deleteStatement.executeUpdate();
if (deleteStatement.executeUpdate()>0)
{
out.println("<h2>Data deleted successfully</h2>");
}
else
{
out.println("<h2>Invalid USN</h2>");
}
deleteStatement.close();
break;

case "extract":
// Extract operation
String selectSql = "SELECT * FROM rama WHERE usn=?";
PreparedStatement selectStatement = connection.prepareStatement(selectSql);
selectStatement.setString(1,usn);
ResultSet resultSet = selectStatement.executeQuery();

if (resultSet.next()) {
%>
<h2>Student Details</h2>
<p><strong>USN:</strong> <%= resultSet.getString("usn") %></p>
<p><strong>Name:</strong> <%= resultSet.getString("name") %></p>
<p><strong>Gender:</strong> <%= resultSet.getString("gender") %></p>
<p><strong>Age:</strong> <%= resultSet.getString("age") %></p>
<%
} else {
%>
<p style="color: red;">Invalid USN. Student not found.</p>
<%
}

// Close resources
resultSet.close();
selectStatement.close();
break;

default:
out.println("<h2>Invalid operation</h2>");
}

// Close connection
connection.close();

} catch (ClassNotFoundException | SQLException e) {
e.printStackTrace();
}
%>

</body>
</html>
