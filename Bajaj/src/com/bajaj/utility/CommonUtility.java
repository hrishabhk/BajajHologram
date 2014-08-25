package com.bajaj.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.bajaj.constant.GlobalVariables;
import com.bajaj.database.QuestionTable;
import com.bajaj.database.UserTable;
import com.bajaj.dto.QuestionDTO;
import com.mysql.jdbc.PreparedStatement;

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
	
	public void createAllDataBaseTables() {
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			lSmt.executeUpdate(UserTable.CREATE_TABLE_QUERY);
			lSmt.executeUpdate(QuestionTable.CREATE_TABLE_QUERY);
			
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
