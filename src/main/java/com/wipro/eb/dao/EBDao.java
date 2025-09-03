package com.wipro.eb.dao;
import com.wipro.eb.bean.*;
import java.sql.*;

public class EBDao {
	public String saveBill(EBConsumerBean bean) {
		String status = "Bill not Save";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebill_db", "root", "");
			PreparedStatement ps = con.prepareStatement("INSERT INTO bills(units,TotalAmount) VALUES(?,?)");
			ps.setInt(3, bean.getUnits());
			ps.setDouble(4, bean.getTotalAmount());
			
			int rows = ps.executeUpdate();
			if(rows>0)
				status = "Bill Saved Successfully!";
			con.close();
		} catch (Exception e) {
		    e.printStackTrace();  // shows full error in Eclipse console
		    status = "Error: " + e.getMessage();
		}

		return status;
	}
}
