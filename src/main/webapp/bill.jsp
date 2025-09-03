<%@ page import="java.sql.*, com.wipro.eb.service.EBCalculatorService, com.wipro.eb.bean.EBConsumerBean" %>
<%
Integer userId = (Integer) session.getAttribute("user_id");
String username = (String) session.getAttribute("username");
if(userId == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<html>
<head>
    <title>Electricity Bill System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        h2, h3 {
            text-align: center;
            color: #333;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .welcome {
            font-size: 14px;
            color: #555;
        }

        .logout-btn {
            background: #e74c3c;
            color: #fff;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: #c0392b;
        }

        form {
            margin: 20px 0;
            text-align: center;
        }

        label {
            font-weight: bold;
            color: #444;
        }

        input[type="number"] {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            width: 200px;
            margin-left: 10px;
            outline: none;
            transition: border 0.3s;
        }

        input[type="number"]:focus {
            border-color: #74b9ff;
        }

        input[type="submit"] {
            background: #0984e3;
            color: #fff;
            border: none;
            padding: 12px 20px;
            margin-left: 15px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
        }

        input[type="submit"]:hover {
            background: #74b9ff;
        }

        .message {
            text-align: center;
            margin: 15px 0;
            font-size: 16px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background: #0984e3;
            color: white;
        }

        tr:nth-child(even) {
            background: #f4f6f9;
        }

        tr:hover {
            background: #dfefff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <div class="welcome">
                Welcome, <b><%= username %></b>
            </div>
            <a href="logout.jsp" class="logout-btn">Logout</a>
        </div>

        <h2>Electricity Bill Calculator</h2>

        <form method="post">
            <label>Enter Units Consumed:</label>
            <input type="number" name="units" min="0" required />
            <input type="submit" value="Generate Bill" />
        </form>

        <%
        if(request.getParameter("units") != null) {
            int units = Integer.parseInt(request.getParameter("units"));

            EBConsumerBean bean = new EBConsumerBean();
            bean.setUnits(units);

            EBCalculatorService service = new EBCalculatorService();
            double amount = service.calculateBill(bean);

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebill_db", "root", "");
                
                String sql = "INSERT INTO bills(user_id, units, amount) VALUES(?,?,?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setInt(2, units);
                ps.setDouble(3, amount);
                int rows = ps.executeUpdate();
                
                if(rows > 0) {
                    out.println("<p class='message' style='color:green'>✔ Bill Saved! Amount: " + amount + "</p>");
                } else {
                    out.println("<p class='message' style='color:red'>✖ Bill not saved!</p>");
                }
                
                ps.close();
                conn.close();
            } catch(Exception e) { 
                out.println("<p class='message' style='color:red'>DB Error: " + e + "</p>"); 
            }
        }
        %>

        <h3>Your Bill History</h3>
        <table>
            <tr>
                <th>Bill ID</th>
                <th>Units</th>
                <th>Amount</th>
                <th>Date</th>
            </tr>
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebill_db", "root", "");
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM bills WHERE user_id=? ORDER BY bill_date DESC");
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                    out.println("<tr><td>"+rs.getInt("bill_id")+"</td><td>"+rs.getInt("units")+"</td><td>"+rs.getDouble("amount")+"</td><td>"+rs.getTimestamp("bill_date")+"</td></tr>");
                }
                rs.close();
                ps.close();
                conn.close();
            } catch(Exception e) { out.println("<tr><td colspan='4'>DB Fetch Error: " + e + "</td></tr>"); }
            %>
        </table>
    </div>
</body>
</html>
