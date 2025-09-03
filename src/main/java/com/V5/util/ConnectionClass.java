package com.V5.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionClass {
	public static Connection getConnect()
	{
		Connection con=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	
			System.out.println("driver class loaded");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ v5_cinemas", "root", "7410");
			System.out.println("connection Sucessful");
		} 
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
}
