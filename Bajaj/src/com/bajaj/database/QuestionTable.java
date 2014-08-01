package com.bajaj.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bajaj.dto.QuestionDTO;
import com.bajaj.utility.CommonUtility;

public class QuestionTable {


	private static String SQL_QUES_TABLENAME 			= "ques_database";
	private static String QUES_ID     					= "_id";
	private static String QUESTION						= "_question";
	private static String ANSWER   						= "_answer";	
	private static String CATEGORY 						= "_category";
	
	
	private static String CREATE_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS "+SQL_QUES_TABLENAME+" ("+QUES_ID+" VARCHAR(50) , "+QUESTION+" VARCHAR(1000) ,"
												+ " "+ANSWER+" VARCHAR(1000),"+CATEGORY+" VARCHAR(50))";
	
	
	/**
	 * @author abhishek
	 * @param pQuesAnswer
	 *  insert QuestionData by passing Question Object
	 */
	
	public void insertQuesData(QuestionDTO pQuesAnswer) {
		
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			lSmt.executeQuery(CREATE_TABLE_QUERY);
			
			String lQuery = "INSER INTO "+SQL_QUES_TABLENAME+" VALUES ( '"+pQuesAnswer.get_id()+"' , '"+pQuesAnswer.get_question()+"' , '"+pQuesAnswer.get_answer()+"' ,"
					+ "'"+pQuesAnswer.get_category()+"')";
			lSmt.executeQuery(lQuery);
			
			lConnection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
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
			
			lSmt.executeQuery(CREATE_TABLE_QUERY);
			String lQuery 		 = "SELECT * FROM "+SQL_QUES_TABLENAME+" WHERE "+QUESTION+" LIKE '%"+pQuestionStroke+"%')";
			ResultSet lResultSet = lSmt.executeQuery(lQuery);
			
			while (lResultSet.next()) {
				lQuesData.set_answer(lResultSet.getString(ANSWER));
				lQuesData.set_category(lResultSet.getString(CATEGORY));
				lQuesData.set_id(lResultSet.getString(QUES_ID));
			 }
			 lConnection.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lQuesData;
	}
}
