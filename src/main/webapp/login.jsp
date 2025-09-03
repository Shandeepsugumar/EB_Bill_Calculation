<%@ page import="java.sql.*" %>
<%
    // Handle login only if form is submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String uname = request.getParameter("username").trim();
        String pass = request.getParameter("password").trim();

        if(uname != null && pass != null && !uname.isEmpty() && !pass.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/ebill_db", "root", "");

                PreparedStatement ps = conn.prepareStatement(
                        "SELECT user_id, username FROM users WHERE username=? AND password=?");
                ps.setString(1, uname);
                ps.setString(2, pass);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    session.setAttribute("user_id", rs.getInt("user_id"));
                    session.setAttribute("username", rs.getString("username"));
                    conn.close();

                    response.sendRedirect("bill.jsp");
                    return;
                } else {
                    request.setAttribute("errorMsg", "Invalid username or password!");
                }

                conn.close();
            } catch (Exception e) {
                request.setAttribute("errorMsg", "Database Error: " + e.getMessage());
            }
        } else {
            request.setAttribute("errorMsg", "Username and Password are required!");
        }
    }
%>

<html>
<head>
    <title>User Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"], 
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: border 0.3s;
        }

        input[type="text"]:focus, 
        input[type="password"]:focus {
            border-color: #74b9ff;
        }

        input[type="submit"] {
            background: #0984e3;
            color: #fff;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
        }

        input[type="submit"]:hover {
            background: #74b9ff;
        }

        p {
            margin-top: 15px;
            color: #444;
        }

        a {
            color: #0984e3;
            font-weight: bold;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .error {
            margin-bottom: 15px;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome Back</h2>

        <!-- Show error message if exists -->
        <%
            String err = (String) request.getAttribute("errorMsg");
            if (err != null) {
                out.println("<p class='error'>✖ " + err + "</p>");
            }
        %>

        <form method="post" action="login.jsp">
            <label>Username:</label>
            <input type="text" name="username" required />
            
            <label>Password:</label>
            <input type="password" name="password" required />
            
            <input type="submit" value="Login" />
        </form>
        <p>
            Don't have an account? 
            <a href="register.jsp">Create Account</a>
        </p>
    </div>
</body>
</html>
