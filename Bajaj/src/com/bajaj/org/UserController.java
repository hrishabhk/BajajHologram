package com.bajaj.org;

import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

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
		   String lUserName							= (String)pLogindata.get("username");
		   String lPassword 						= (String)pLogindata.get("password");
			
		   if(!lUserName.equals("") && !lPassword.equals("")) {
			   
			   Boolean lValideUser = new UserTable().validateUserLogin(lUserName , lPassword);
			   if(lValideUser) {
				   UserDTO lUser = new UserTable().getUserDataFromUserName((String)pLogindata.get("username"));
				   lUserDetail.put("response", true);
				   lUserDetail.put("firstname", lUser.get_firstName());
				   lUserDetail.put("lastname", lUser.get_lastName());
				   lUserDetail.put("usertype", lUser.get_usertype());
				   lUserDetail.put("id", lUser.get_id());
			   } else {
				   lUserDetail.put("response", false);
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
		   String lUserName							= (String)pSignUpdata.get("username");
		   String lPassword 						= (String)pSignUpdata.get("password");
		   String lFirstName						= (String)pSignUpdata.get("firstname");
		   String lLastName 						= (String)pSignUpdata.get("lastname");
		   String lUserType 						= (String)pSignUpdata.get("usertype");
			
		   if(!lUserName.equals("") && !lPassword.equals("")) {
			   lUserDetail.set_firstName(lFirstName);
			   lUserDetail.set_lastName(lLastName);
			   lUserDetail.set_userName(lUserName);
			   lUserDetail.set_password(lPassword);
			   lUserDetail.set_usertype(lUserType);
			   lUserDetail.set_id(lUuidUser);
			   lSignUpSuccess = new UserTable().insertUserData(lUserDetail);
		   } else {
			   lSignUpSuccess = false;
		   }
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return lSignUpSuccess;
   }
   
   
   
   @RequestMapping(value="/search.do")
   public String searchQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestBody String pQuestionStroke) {
	  
	   String lDataToPost							 = "";
	   HashMap<String, Object> lQuestiomnDetail      = new HashMap<String, Object>();
	   
	   try {
		if(!pQuestionStroke.equals("")) {
			   
			   QuestionDTO lQuesDetail = new QuestionTable().getQuesDetailFromQuesStroke(pQuestionStroke);
			   if(lQuesDetail != null) {
				   lQuestiomnDetail.put("response", true);
				   lQuestiomnDetail.put("firstname", lQuesDetail.get_question());
				   lQuestiomnDetail.put("lastname", lQuesDetail.get_answer());
				   lQuestiomnDetail.put("usertype", lQuesDetail.get_category());
				   lQuestiomnDetail.put("id", lQuesDetail.get_id());
			   } else {
				   lQuestiomnDetail.put("response", false);
			   }
		   }
		   lDataToPost = mGson.toJson(lQuestiomnDetail);
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return lDataToPost;
   }
   
   
   public Boolean addQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestBody HashMap<String, Object> pQuesdata) {
	  
	   Boolean lAdded     							= false;
	   try {
		   String lUuidQues 						= "q"+UUID.randomUUID().toString();
		   QuestionDTO  lQuesAns 					= new QuestionDTO();
		   
		   if(pQuesdata != null) {
			   lQuesAns.set_id(lUuidQues);
			   lQuesAns.set_question((String) pQuesdata.get("question"));
			   lQuesAns.set_answer((String) pQuesdata.get("answer"));
			   lQuesAns.set_category((String) pQuesdata.get("category"));
			   lAdded = new QuestionTable().insertQuesData(lQuesAns);
		   } else {
			   lAdded = false;
		   }
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	return lAdded;
   }
   
   
   public Boolean delQuestion(HttpServletRequest req, HttpServletResponse resp, @RequestBody String pQuesId) {
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