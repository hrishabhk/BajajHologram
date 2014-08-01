package com.bajaj.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.bajaj.constant.GlobalVariables;

public class CommonUtility {

	
	public static Connection getSqlConnection() {
		Connection lConnection = null;
		try {
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			lConnection = DriverManager.getConnection(GlobalVariables.SQL_URL, GlobalVariables.SQL_USERNAME, GlobalVariables.SQL_PASSWORD);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lConnection;
	}
	
	public static void deRegistarDriverManager() {
		try {
			DriverManager.deregisterDriver(new com.mysql.jdbc.Driver());
		} catch (SQLException e) {
			e.printStackTrace();
		};
	}
}
