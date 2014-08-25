package com.bajaj.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bajaj.dto.QuestionDTO;
import com.bajaj.utility.CommonUtility;
import com.mysql.jdbc.PreparedStatement;

public class QuestionTable {


	private static String SQL_QUES_TABLENAME 			= "question_database";
	private static String QUES_ID     					= "_id";
	private static String QUESTION						= "_question";
	private static String ANSWER   						= "_answer";	
	private static String CATEGORY 						= "_category";
	private static String FREQUENT 						= "_frequent";
	
	
	public static String CREATE_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS "+SQL_QUES_TABLENAME+" ("+QUES_ID+" VARCHAR(50) , "+QUESTION+" VARCHAR(1000) ,"
												+ " "+ANSWER+" VARCHAR(1000),"+CATEGORY+" VARCHAR(50) , "+FREQUENT+" VARCHAR(25))";
	

	/**
	 * @author abhishek
	 * @param pQuesAnswer
	 *  insert QuestionData by passing Question Object
	 */
	
	public QuestionDTO insertQuesData(QuestionDTO pQuesAnswer) {
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			System.out.println(CREATE_TABLE_QUERY);
			lSmt.executeUpdate(CREATE_TABLE_QUERY);
			
			String lQuery = "INSERT INTO "+SQL_QUES_TABLENAME+" VALUES ( '"+pQuesAnswer.getId()+"' , '"+pQuesAnswer.getQuestion()+"' , '"+pQuesAnswer.getAnswer()+"' ,"
					+ "'"+pQuesAnswer.getCateory()+"' , "+ "'"+pQuesAnswer.getFrequent()+"')";
			
			PreparedStatement lPreparedStatment = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lCount = lPreparedStatment.executeUpdate(); 
			System.out.println("Rows inserted - "+lCount);
			if(lCount > 0){
				
			} else 
			{
				pQuesAnswer = null;
			}
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} 
		catch (SQLException e) 
		{
			pQuesAnswer = null;
			e.printStackTrace();
		}
		return pQuesAnswer;
	}
	
	
	/**
	 * @author abhishek
	 * @param pQuestionStroke
	 * @return Question Object on passing Ques Stroke word.
	 */
	
	public List<QuestionDTO> getQuesDetailFromQuesStroke(String pQuestionStroke) {
		
		List<QuestionDTO> resultList = null;
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			String lQuery 		 = "SELECT * FROM "+SQL_QUES_TABLENAME+" WHERE "+QUESTION+" LIKE '%"+pQuestionStroke.replaceAll("\"", "")+"%'";
			System.out.println(lQuery);
			ResultSet lResultSet = lSmt.executeQuery(lQuery);
			resultList = new ArrayList<QuestionDTO>();
			while (lResultSet.next()) {
				QuestionDTO lQuesData = new QuestionDTO();
				lQuesData.setAnswer(lResultSet.getString(ANSWER));
				lQuesData.setCateory(lResultSet.getString(CATEGORY));
				lQuesData.setId(lResultSet.getString(QUES_ID));
				lQuesData.setQuestion(lResultSet.getString(QUESTION));
				lQuesData.setFrequent(lResultSet.getString(FREQUENT));
				resultList.add(lQuesData);
			 }
			 lConnection.close();
			 CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultList;
	}
	
	/**
	 * @author abhishek
	 * @param pQuestionStroke
	 * @return
	 */
	
   public List<QuestionDTO> getAllFrequentQuestion(String pIndex) {
		
		List<QuestionDTO> lQuesDataList = new  ArrayList<>();
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			String lQuery 		 = "SELECT * FROM "+SQL_QUES_TABLENAME+" WHERE "+FREQUENT+" = '1' LIMIT "+pIndex+" , 10";
			ResultSet lResultSet = lSmt.executeQuery(lQuery);
			System.out.println(lQuery);
			while (lResultSet.next()) {
				QuestionDTO lQuesData = new QuestionDTO();
				lQuesData.setAnswer(lResultSet.getString(ANSWER));
				lQuesData.setCateory(lResultSet.getString(CATEGORY));
				lQuesData.setId(lResultSet.getString(QUES_ID));
				lQuesData.setQuestion(lResultSet.getString(QUESTION));
				lQuesDataList.add(lQuesData);
			 }
			 lConnection.close();
			 CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lQuesDataList;
	}
	
	
	
	/**
	 * @author abhishek
	 * @param pQuesId
	 * @return
	 */
	
	public String deleteQuestionById(String pQuesId) {
		
		
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			String lQuery 		 = "DELETE FROM "+SQL_QUES_TABLENAME+" WHERE "+QUES_ID+" = '"+pQuesId+"'";
			PreparedStatement lPreparedStatement = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lDeleteCount = lPreparedStatement.executeUpdate();
			
			if(lDeleteCount==0) {
				pQuesId = null;
			}
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pQuesId;
	}
	/**
	 * @author abhishek
	 * @param pQuesDetail
	 * @return
	 */
	
	public QuestionDTO updateQuestionById(QuestionDTO pQuesDetail) {
		
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			String lQuery 		 = "UPDATE "+SQL_QUES_TABLENAME+" SET "+QUESTION+" = '"+pQuesDetail.getQuestion()+"' ,"
					+ ANSWER + " = '"+pQuesDetail.getAnswer()+"', "+CATEGORY+" = '"+pQuesDetail.getCateory()+"', "+FREQUENT+" = '"+pQuesDetail.getFrequent()+"' WHERE "+QUES_ID+" = '"+pQuesDetail.getId()+"'";
			PreparedStatement lPreparedStatement = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lUpdateCount = lPreparedStatement.executeUpdate();
			
			if(lUpdateCount==0) {
				pQuesDetail = null;
			} 
			lConnection.close();
			CommonUtility.deRegistarDriverManager();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pQuesDetail;
	}
	
	
	
}

