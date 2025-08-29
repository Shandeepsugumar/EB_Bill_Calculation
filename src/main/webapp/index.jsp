<%@ page import="com.wipro.eb.bean.EBConsumerBean, com.wipro.eb.service.EBCalculatorService, com.wipro.eb.util.InvalidUnitException" %>
<html>
<head>
    <title>EB Bill Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #83a4d4, #b6fbff);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 400px;
            margin: 60px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #444;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            background: #007bff;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
        .result {
            margin-top: 20px;
            padding: 15px;
            border-radius: 6px;
            font-size: 16px;
        }
        .success {
            background: #e0ffe0;
            color: #2e7d32;
            border: 1px solid #2e7d32;
        }
        .error {
            background: #ffe0e0;
            color: #b71c1c;
            border: 1px solid #b71c1c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2> EB Bill Calculator </h2>
        <form method="post">
            <label>Consumer Number</label>
            <input type="text" name="cno" required />

            <label>Name</label>
            <input type="text" name="name" required />

            <label>Units Consumed</label>
            <input type="number" step="1" min="0" name="units" required />

            <input type="submit" value="Calculate Bill"/>
        </form>

        <%
            if(request.getParameter("cno") != null) {
                EBConsumerBean bean = new EBConsumerBean();
                bean.setConsumerNumber(request.getParameter("cno"));
                bean.setConsumerName(request.getParameter("name"));
                try {
                    bean.setunits(Integer.parseInt(request.getParameter("units")));

                    EBCalculatorService service = new EBCalculatorService();
                    String result = service.calculateBill(bean);

                    out.println("<div class='result success'><b>" + result + "</b></div>");
                } catch (NumberFormatException e) {
                    out.println("<div class='result error'>Invalid input! Please enter whole number units.</div>");
                } catch (InvalidUnitException e) {
                    out.println("<div class='result error'>" + e.toString() + "</div>");
                }
            }
        %>
    </div>
</body>
</html>
