<%@ page import="java.sql.*" %>
<html>
<head>
    <title>User Registration</title>
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

        .message {
            margin-top: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Account</h2>
        <form method="post" action="register.jsp">
            <label>Username:</label>
            <input type="text" name="username" required />
            
            <label>Password:</label>
            <input type="password" name="password" required />
            
            <input type="submit" value="Register" />
        </form>
        <p>
            Already have an account? 
            <a href="login.jsp">Login here!</a>
        </p>

        <%
        if(request.getParameter("username") != null) {
            String uname = request.getParameter("username");
            String pass = request.getParameter("password");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebill_db", "root", "");

                Statement st = conn.createStatement();
                st.executeUpdate("CREATE TABLE IF NOT EXISTS users (" +
                                 "user_id INT AUTO_INCREMENT PRIMARY KEY," +
                                 "username VARCHAR(100) UNIQUE," +
                                 "password VARCHAR(100))");

                PreparedStatement ps = conn.prepareStatement("INSERT INTO users (username, password) VALUES (?, ?)");
                ps.setString(1, uname);
                ps.setString(2, pass);
                int rows = ps.executeUpdate();

                if(rows > 0) {
                    out.println("<p class='message' style='color:green'>✔ Registration successful! <a href='login.jsp'>Login Here</a></p>");
                }

                conn.close();
            } catch(Exception e) {
                out.println("<p class='message' style='color:red'>✖ Error: " + e + "</p>");
            }
        }
        %>
    </div>
</body>
</html>
