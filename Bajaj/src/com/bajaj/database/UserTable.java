package com.bajaj.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bajaj.dto.UserDTO;
import com.bajaj.utility.CommonUtility;
import com.mysql.jdbc.PreparedStatement;

public class UserTable {

	private static String SQL_USER_TABLENAME 			= "user_database";
	private static String ID     						= "_id";
	private static String USERNAME						= "_userName";
	private static String PASSWORD   					= "_password";	
	private static String FIRST_NAME 					= "_firstName";
	private static String LAST_NAME						= "_lastName";
	private static String USER_TYPE						= "_userType";
	
	
	private static String CREATE_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS "+SQL_USER_TABLENAME+" ("+ID+" VARCHAR(50) , "+USERNAME+" VARCHAR(50) ,"
												+ " "+PASSWORD+" VARCHAR(50),"+FIRST_NAME+" VARCHAR(50), "+LAST_NAME+" VARCHAR(50) ,"
												+ " "+USER_TYPE+" VARCHAR(50) )";
	
	
	/**
	 * @author abhishek
	 * @param pUser
	 * insert data by passing User object
	 */
	
	public UserDTO insertUserData(UserDTO pUser) {
		
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			lSmt.executeUpdate(CREATE_TABLE_QUERY);
			
			String lQuery = "INSERT INTO "+SQL_USER_TABLENAME+" VALUES ( '"+pUser.getId()+"' , '"+pUser.getUserName()+"' , '"+pUser.getPassword()+"' ,"
					+ "'"+pUser.getFirstName()+"' , '"+pUser.getLastName()+"' , '"+pUser.getUserType()+"')";
			
			PreparedStatement lPreparedStatment = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lCount = lPreparedStatment.executeUpdate(); 
			System.out.println("Rows updated - "+lCount);
			if(!(lCount > 0))
			{
				pUser = null;
			}
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pUser;
	}
	
	
	/**
	 * @author abhishek
	 * @param pUserName
	 * @param pPassword
	 * @return Boolean for validating user
	 */
	
	public Boolean validateUserLogin(String pUserName , String pPassword) {
		Boolean lLoginExist = false;
		String lPassword 		= "";
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			lSmt.executeQuery(CREATE_TABLE_QUERY);
			String lQuery 		 = "SELECT "+PASSWORD+" FROM "+SQL_USER_TABLENAME+" WHERE "+USERNAME+" = "+pUserName+")";
			ResultSet lResultSet = lSmt.executeQuery(lQuery);
			while (lResultSet.next()) {
				 lPassword = lResultSet.getString(PASSWORD);
			 }
			 lConnection.close();
			 CommonUtility.deRegistarDriverManager();
			 
			 if(pPassword.equals(lPassword)){
				lLoginExist = true;
			 } else {
				lLoginExist = false;
			 }
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lLoginExist;
	}
	
	
	/**
	 * @author abhishek
	 * @param pUserName
	 * @return User Object on passing username
	 */
	
	public UserDTO getUserDataFromUserName(String pUserName) {
		
		UserDTO lUserData = new UserDTO();
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			lSmt.executeQuery(CREATE_TABLE_QUERY);
			String lQuery 		 = "SELECT * FROM "+SQL_USER_TABLENAME+" WHERE "+USERNAME+" = "+pUserName+")";
			ResultSet lResultSet = lSmt.executeQuery(lQuery);
			
			while (lResultSet.next()) {
				lUserData.setFirstName(lResultSet.getString(FIRST_NAME));
				lUserData.setLastName(lResultSet.getString(LAST_NAME));
				lUserData.setUserType(lResultSet.getString(USER_TYPE));
				lUserData.setId(lResultSet.getString(ID));
			 }
			 lConnection.close();
			 CommonUtility.deRegistarDriverManager();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lUserData;
	}
	
	
	public String getPasswordFromUsername(String pUserName) {
		
		String lPassword 		= "";
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			lSmt.executeQuery(CREATE_TABLE_QUERY);
			String lQuery 		 = "SELECT "+PASSWORD+" FROM "+SQL_USER_TABLENAME+" WHERE "+USERNAME+" = "+pUserName+")";
			ResultSet lResultSet = lSmt.executeQuery(lQuery);
			while (lResultSet.next()) {
				 lPassword = lResultSet.getString(PASSWORD);
			 }
			 lConnection.close();
			 CommonUtility.deRegistarDriverManager();
			 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lPassword;
	}
	
	
	
}
