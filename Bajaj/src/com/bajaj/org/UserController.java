package com.bajaj.org;

import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bajaj.constant.GlobalVariables;
import com.bajaj.database.QuestionTable;
import com.bajaj.database.UserTable;
import com.bajaj.dto.QuestionDTO;
import com.bajaj.dto.UserDTO;
import com.google.gson.Gson;



@Controller
public class UserController {
	
	
	Gson mGson = new Gson();
	
	
	@RequestMapping(value="/index.do")
	public String homePage(HttpServletRequest req, HttpServletResponse resp) {
		try {
//			Connection lConnection = CommonUtility.getSqlConnection();
//			java.sql.Statement lSmt = lConnection.createStatement();
//			
//			String lQuery 		 = "INSERT INTO Persons VALUES (1 ,'kumar', 'abhi' , 'velachery' , 'chennai')";
//			PreparedStatement lPreparedStatment = (PreparedStatement) lConnection.prepareStatement(lQuery);
//			int lCount = lPreparedStatment.executeUpdate(); 
//			System.out.println("count updated -" +lCount);
//			
//			String lQuery2 		 = "SELECT * FROM Persons WHERE LastName LIKE '%kum%'";
//			ResultSet lResultSet = lSmt.executeQuery(lQuery2);
//			
//			while (lResultSet.next()) {
//				System.out.println("name - "+lResultSet.getString("FirstName"));
//			 }
//			
//			 lConnection.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}

   @RequestMapping(value="/login.do")
   public String loginUser(HttpServletRequest req, HttpServletResponse resp, @RequestBody HashMap<String, Object> pLogindata) {
	
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
   public Boolean signUpUser(HttpServletRequest req, HttpServletResponse resp, @RequestBody HashMap<String, Object> pSignUpdata) {
	
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
   public String searchQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestBody String pQuestionStroke) {
	  
	   String lDataToPost							 = "";
	   HashMap<String, Object> lQuestiomnDetail      = new HashMap<String, Object>();
	   
	   try {
		if(!pQuestionStroke.equals("")) {
			   
			   QuestionDTO lQuesDetail = new QuestionTable().getQuesDetailFromQuesStroke(pQuestionStroke);
			   if(lQuesDetail != null) {
				   lQuestiomnDetail.put(GlobalVariables.RESPONSE, true);
				   lQuestiomnDetail.put(GlobalVariables.QUESTION, lQuesDetail.getQuestion());
				   lQuestiomnDetail.put(GlobalVariables.ANSWER, lQuesDetail.getAnswer());
				   lQuestiomnDetail.put(GlobalVariables.CATEGORY, lQuesDetail.getCateory());
				   lQuestiomnDetail.put(GlobalVariables.ID, lQuesDetail.getId());
				   lQuestiomnDetail.put(GlobalVariables.FREQUENT, lQuesDetail.getFrequent());
			   } else {
				   lQuestiomnDetail.put(GlobalVariables.RESPONSE, false);
			   }
		   }
		   lDataToPost = mGson.toJson(lQuestiomnDetail);
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return lDataToPost;
   }
   
   @RequestMapping(value="/questionAnswer.do", method = RequestMethod.POST)
   public Boolean addQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestBody HashMap<String, Object> pQuesdata) {
	  
	   Boolean lAdded     							= false;
	   try {
		   String lUuidQues 						= "q"+UUID.randomUUID().toString();
		   QuestionDTO  lQuesAns 					= new QuestionDTO();
		   
		   if(pQuesdata != null) {
			   lQuesAns.setId(lUuidQues);
			   lQuesAns.setQuestion((String) pQuesdata.get(GlobalVariables.QUESTION));
			   lQuesAns.setAnswer((String) pQuesdata.get(GlobalVariables.ANSWER));
			   lQuesAns.setCateory((String) pQuesdata.get(GlobalVariables.CATEGORY));
			   lQuesAns.setFrequent((String) pQuesdata.get(GlobalVariables.FREQUENT));
			   lAdded = new QuestionTable().insertQuesData(lQuesAns);
		   } else {
			   lAdded = false;
		   }
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	return lAdded;
   }
   
   @RequestMapping(value="/questionAnswer.do/{questionId}", method = RequestMethod.DELETE)
   public Boolean delQuestion(HttpServletRequest req, HttpServletResponse resp, @PathVariable(value="questionId") String pQuesId) {
		  Boolean lIsDeleted 		= false;
	   try {
		   if(!pQuesId.equals("")) {
			   lIsDeleted = new QuestionTable().deleteQuestionById(pQuesId);
		   }
	} catch (Exception e) {
		e.printStackTrace();
	}
	return lIsDeleted;
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