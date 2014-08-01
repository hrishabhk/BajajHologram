package com.bajaj.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bajaj.dto.QuestionDTO;
import com.bajaj.utility.CommonUtility;
import com.mysql.jdbc.PreparedStatement;

public class QuestionTable {


	private static String SQL_QUES_TABLENAME 			= "ques_database";
	private static String QUES_ID     					= "_id";
	private static String QUESTION						= "_question";
	private static String ANSWER   						= "_answer";	
	private static String CATEGORY 						= "_category";
	private static String FREQUENT 						= "_frequent";
	
	
	private static String CREATE_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS "+SQL_QUES_TABLENAME+" ("+QUES_ID+" VARCHAR(50) , "+QUESTION+" VARCHAR(1000) ,"
												+ " "+ANSWER+" VARCHAR(1000),"+CATEGORY+" VARCHAR(50) "+FREQUENT+" VARCHAR(25))";
	
	
	/**
	 * @author abhishek
	 * @param pQuesAnswer
	 *  insert QuestionData by passing Question Object
	 */
	
	public Boolean insertQuesData(QuestionDTO pQuesAnswer) {
		Boolean lInserted = false;
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			lSmt.executeQuery(CREATE_TABLE_QUERY);
			
			String lQuery = "INSERT INTO "+SQL_QUES_TABLENAME+" VALUES ( '"+pQuesAnswer.getId()+"' , '"+pQuesAnswer.getQuestion()+"' , '"+pQuesAnswer.getAnswer()+"' ,"
					+ "'"+pQuesAnswer.getCateory()+"'"+ "'"+pQuesAnswer.getFrequent()+"')";
			
			PreparedStatement lPreparedStatment = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lCount = lPreparedStatment.executeUpdate(); 
			System.out.println("Rows inserted - "+lCount);
			if(lCount > 0){
				lInserted = true;
			} else {
				lInserted = false;
			}
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lInserted;
	}
	
	
	/**
	 * @author abhishek
	 * @param pQuestionStroke
	 * @return Question Object on passing Ques Stroke word.
	 */
	
	public QuestionDTO getQuesDetailFromQuesStroke(String pQuestionStroke) {
		
		QuestionDTO lQuesData = new QuestionDTO();
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			String lQuery 		 = "SELECT * FROM "+SQL_QUES_TABLENAME+" WHERE "+QUESTION+" LIKE '%"+pQuestionStroke+"%'";
			ResultSet lResultSet = lSmt.executeQuery(lQuery);
			
			while (lResultSet.next()) {
				lQuesData.setAnswer(lResultSet.getString(ANSWER));
				lQuesData.setCateory(lResultSet.getString(CATEGORY));
				lQuesData.setId(lResultSet.getString(QUES_ID));
			 }
			 lConnection.close();
			 CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lQuesData;
	}
	
	
	
	/**
	 * @author abhishek
	 * @param pQuesId
	 * @return
	 */
	
	public Boolean deleteQuestionById(String pQuesId) {
		
		Boolean lDeleted = false;
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			String lQuery 		 = "DELETE FROM "+SQL_QUES_TABLENAME+" WHERE "+QUES_ID+" = '"+pQuesId+"'";
			PreparedStatement lPreparedStatement = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lDeleteCount = lPreparedStatement.executeUpdate();
			
			if(lDeleteCount>0) {
				lDeleted = true;
			} else {
				lDeleted = false;
			}
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lDeleted;
	}
	
	
	public Boolean updateQuestionById(QuestionDTO pQuesDetail) {
		
		Boolean lUpdate = false;
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			String lQuery 		 = "UPDATE "+SQL_QUES_TABLENAME+" SET "+QUES_ID+" = '"+pQuesDetail.getId()+"' , "+QUESTION+" = '"+pQuesDetail.getQuestion()+"' ,"
					+ ANSWER + " = '"+pQuesDetail.getAnswer()+"', "+CATEGORY+" = '"+pQuesDetail.getCateory()+"', "+FREQUENT+" = '"+pQuesDetail.getFrequent()+"'";
			PreparedStatement lPreparedStatement = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lUpdateCount = lPreparedStatement.executeUpdate();
			
			if(lUpdateCount>0) {
				lUpdate = true;
			} else {
				lUpdate = false;
			}
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lUpdate;
	}
}

