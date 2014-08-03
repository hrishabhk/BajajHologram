package com.bajaj.org;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bajaj.constant.GlobalVariables;
import com.bajaj.database.QuestionTable;
import com.bajaj.database.UserTable;
import com.bajaj.dto.QuestionDTO;
import com.bajaj.dto.UserDTO;
import com.bajaj.utility.CommonUtility;
import com.google.gson.Gson;
import com.mysql.jdbc.PreparedStatement;



@Controller
public class UserController {
	
	Gson mGson = new Gson();
	
	
	@RequestMapping(value="/index.do")
	public String homePage(HttpServletRequest req, HttpServletResponse resp) {
		try {
			Connection lConnection = CommonUtility.getSqlConnection();
			java.sql.Statement lSmt = lConnection.createStatement();
			
			String lQuery 		 = "INSERT INTO Persons VALUES (1 ,'kumar', 'abhi' , 'velachery' , 'chennai')";
			PreparedStatement lPreparedStatment = (PreparedStatement) lConnection.prepareStatement(lQuery);
			int lCount = lPreparedStatment.executeUpdate(); 
			System.out.println("count updated -" +lCount);
			
			String lQuery2 		 = "SELECT * FROM Persons WHERE LastName LIKE '%kum%'";
			ResultSet lResultSet = lSmt.executeQuery(lQuery2);
			
			while (lResultSet.next()) {
				System.out.println("name - "+lResultSet.getString("firstName"));
			 }
			
			 lConnection.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}
	@RequestMapping(value="/admin.do")
	public String abc()
	{
		return "admin";
	}

   @RequestMapping(value="/login.do")
   public  @ResponseBody String loginUser(HttpServletRequest req, HttpServletResponse resp, @RequestBody HashMap<String, Object> pLogindata) {
	
	   HashMap<String, Object> lUserDetail  		= new HashMap<String, Object>();
	   String lDataToPost 							="";
	   
	   try {
		   String lUserName							= (String)pLogindata.get(GlobalVariables.USER_NAME);
		   String lPassword 						= (String)pLogindata.get(GlobalVariables.PASSWORD);
			
		   if(!lUserName.equals("") && !lPassword.equals("")) {
			   
			   Boolean lValideUser = new UserTable().validateUserLogin(lUserName , lPassword);
			   if(lValideUser) {
				   UserDTO lUser = new UserTable().getUserDataFromUserName((String)pLogindata.get(GlobalVariables.USER_NAME));
				   lUserDetail.put(GlobalVariables.RESPONSE, true);
				   lUserDetail.put(GlobalVariables.FIRST_NAME, lUser.getFirstName());
				   lUserDetail.put(GlobalVariables.LAST_NAME, lUser.getLastName());
				   lUserDetail.put(GlobalVariables.USER_TYPE, lUser.getUsertype());
				   lUserDetail.put(GlobalVariables.ID, lUser.getId());
			   } else {
				   lUserDetail.put(GlobalVariables.RESPONSE, false);
			   }
		   }
		   lDataToPost = mGson.toJson(lUserDetail);
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return lDataToPost;
   }
   
   
   @RequestMapping(value="/signup.do")
   public @ResponseBody Boolean signUpUser(HttpServletRequest req, HttpServletResponse resp, @RequestBody HashMap<String, Object> pSignUpdata) {
	
	   UserDTO lUserDetail  						= new UserDTO();
	   Boolean lSignUpSuccess						= false;
	   String lUuidUser 							= "u"+UUID.randomUUID().toString();
	   
	   try {
		   String lUserName							= (String)pSignUpdata.get(GlobalVariables.USER_NAME);
		   String lPassword 						= (String)pSignUpdata.get(GlobalVariables.PASSWORD);
		   String lFirstName						= (String)pSignUpdata.get(GlobalVariables.FIRST_NAME);
		   String lLastName 						= (String)pSignUpdata.get(GlobalVariables.LAST_NAME);
		   String lUserType 						= (String)pSignUpdata.get(GlobalVariables.USER_TYPE);
			
		   if(!lUserName.equals("") && !lPassword.equals("")) {
			   lUserDetail.setFirstName(lFirstName);
			   lUserDetail.setLastName(lLastName);
			   lUserDetail.setUserName(lUserName);
			   lUserDetail.setPassword(lPassword);
			   lUserDetail.setUsertype(lUserType);
			   lUserDetail.setId(lUuidUser);
			   lSignUpSuccess = new UserTable().insertUserData(lUserDetail);
		   } else {
			   lSignUpSuccess = false;
		   }
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return lSignUpSuccess;
   }
   
   
   
   @RequestMapping(value="/searchQuestion.do", method = RequestMethod.GET)
   public @ResponseBody String searchQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestParam("query") String pQuestionStroke) {
	   List<QuestionDTO> responseList = null;
	   System.out.println("query stroke : "+pQuestionStroke);
		if(!pQuestionStroke.equals(""))
		{
			responseList =  new QuestionTable().getQuesDetailFromQuesStroke(pQuestionStroke);
			if(responseList.isEmpty())
			{
				QuestionDTO defaultResult = new QuestionDTO();
				defaultResult.setId("none");
				defaultResult.setAnswer("");
				defaultResult.setQuestion("no result Found");
				defaultResult.setCateory("none");
				responseList.add(defaultResult);
			}
		}
		 System.out.println(mGson.toJson(responseList)); 
	   return mGson.toJson(responseList);
   }
   
   @RequestMapping(value="/questionAnswer.do", method = RequestMethod.GET)
   public @ResponseBody String getAllFrequentQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestParam("index") String lIndex) {
	  
	   String lDataToPost							 		  = "";
	   try {
		if(lIndex.equals("")) {
			lIndex = "0";
		 }
		   List<QuestionDTO> lQuesDetailList = new QuestionTable().getAllFrequentQuestion(lIndex);
		   lDataToPost = mGson.toJson(lQuesDetailList);
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return lDataToPost;
   }
   
   @RequestMapping(value="/questionAnswer.do", method = RequestMethod.POST)
   public  @ResponseBody String addQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestBody String pQuesdata) {
	  System.out.println(pQuesdata);
	   QuestionDTO lAdded     							= null;
	   try 
	   {
		   	String lUuidQues 		= "q"+UUID.randomUUID().toString();
		   	lAdded 					= mGson.fromJson(pQuesdata, QuestionDTO.class);
		   	
			lAdded.setId(lUuidQues);
			lAdded = new QuestionTable().insertQuesData(lAdded);
		   
	   	} 
	   catch (Exception e) {
		   
		e.printStackTrace();
	   }
	return mGson.toJson(lAdded);
   }
   
   @RequestMapping(value="/questionAnswer.do/delete.do", method = RequestMethod.POST)
   public  @ResponseBody String delQuestion(HttpServletRequest req, HttpServletResponse resp, @PathVariable(value="questionId") String pQuesId) {
		  
	   try {
		   if(!pQuesId.equals("")) {
			   pQuesId = new QuestionTable().deleteQuestionById(pQuesId);
		   }
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	return pQuesId;
   }
   
   
   @RequestMapping(value="/questionAnswer.do/update.do", method = RequestMethod.POST)
   public @ResponseBody String updateQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestBody String pQuesAnswer) {
		  
	  
	  QuestionDTO lQuesAnswer = mGson.fromJson(pQuesAnswer, QuestionDTO.class); 
	   try {
		   lQuesAnswer = new QuestionTable().updateQuestionById(lQuesAnswer);
	   } catch (Exception e) {
		e.printStackTrace();
	   }
	return mGson.toJson(lQuesAnswer);
   }


   @RequestMapping(value="/getpassword.do")
   public String getPasswordByUserName(HttpServletRequest req, HttpServletResponse resp, @RequestBody String pUserName) {
	
    String lPassword = "";
	try {
		lPassword = new UserTable().getPasswordFromUsername(pUserName);   
	} catch (Exception e) {
		e.printStackTrace();
	}
	return lPassword;
   }

}