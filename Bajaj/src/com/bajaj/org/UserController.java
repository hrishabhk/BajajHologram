package com.bajaj.org;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
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
import com.google.gson.Gson;



@Controller
public class UserController {
	
	Gson mGson = new Gson();
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public void loginPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		RequestDispatcher rd = req.getRequestDispatcher("./");
		   rd.forward(req, resp);
	}
	@RequestMapping(value="/index.do")
	public String homePage(HttpServletRequest req, HttpServletResponse resp) {
//		try {
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
//				System.out.println("name - "+lResultSet.getString("firstName"));
//			 }
//			
//			 lConnection.close();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return "index";
	}
	@RequestMapping(value="/admin.do")
	public String abc()
	{
		return "admin";
	}

   @RequestMapping(value="/login.do", method=RequestMethod.POST)
   public void loginUser(HttpServletRequest req, HttpServletResponse resp, @RequestParam("username") String userName,  @RequestParam("password") String password) throws IOException, ServletException {
	
	   HashMap<String, Object> lUserDetail  		= new HashMap<String, Object>();
	   
	   try {
		   if(userName != null && !userName.equals("") && password!= null && !password.equals("")) {
			   
			   Boolean lValideUser = new UserTable().validateUserLogin(userName , password);
			   if(lValideUser) 
			   {
				   UserDTO lUser = new UserTable().getUserDataFromUserName(userName);
				   System.out.println(mGson.toJson(lUser));
				   req.getSession().setAttribute(GlobalVariables.RESPONSE, true);
				   req.getSession().setAttribute(GlobalVariables.FIRST_NAME, lUser.getFirstName());
				   req.getSession().setAttribute(GlobalVariables.LAST_NAME, lUser.getLastName());
				   req.getSession().setAttribute(GlobalVariables.USER_TYPE, lUser.getUserType());
				   req.getSession().setAttribute(GlobalVariables.ID, lUser.getId());
				   
				   if(lUser.getUserType().equals("admin")) 
				   {
					   req.getSession().setAttribute(GlobalVariables.ADMIN_LOGIN, true);
					   resp.sendRedirect("./admin.do");
				   }
				   else
					   resp.sendRedirect("./index.do");
				   req.getSession().setAttribute("loginFailed", "");
			   }
			   else 
			   {
				   lUserDetail.put(GlobalVariables.RESPONSE, false);
				   req.setAttribute("loginFailed", "has-warning");
				   RequestDispatcher rd = req.getRequestDispatcher("./");
				   rd.forward(req, resp);
				   System.out.println("Login Failed");
			   }
		   }
		   else 
		   {
			   lUserDetail.put(GlobalVariables.RESPONSE, false);
			   req.setAttribute("loginFailed", "has-warning");
			   RequestDispatcher rd = req.getRequestDispatcher("./");
			   rd.forward(req, resp);
			   System.out.println("Login Failed");
		   }
		   
	} catch (Exception e) {
		e.printStackTrace();
		req.setAttribute("loginFailed", "has-warning");
		RequestDispatcher rd = req.getRequestDispatcher("./");
		rd.forward(req, resp);
	}
	  
   }
   
   
   @RequestMapping(value={"/user.do","/saveUser.do"}, method= RequestMethod.POST)
   public @ResponseBody String signUpUser(HttpServletRequest req, HttpServletResponse resp, @RequestBody String pSignUpdata) {
	   
	   String lUuidUser 							= "u"+UUID.randomUUID().toString();
	   UserDTO user 								= null;
	   try {
		   user 									= mGson.fromJson(pSignUpdata, UserDTO.class);
		   System.out.println(pSignUpdata);
		   if(!user.getUserName().trim().equals("") && !user.getPassword().trim().equals("") && !user.getFirstName().trim().equals("") && !user.getLastName().trim().equals("") && !user.getUserType().trim().equals("")) 
		   {
			   if(user.getId().trim().equals(""))
			   {
				   user.setId(lUuidUser);
			   }
			   if(new UserTable().getUserDataFromUserName(user.getUserName()) != null) {
			      user = new UserTable().insertUserData(user);
			      user.setResponse(true);
			      user.setMessage(GlobalVariables.USER_SUCCESSFULLY_CREATED);
			   } else {
				  user.setResponse(false);
				  user.setMessage(GlobalVariables.USER_ALLREADY_EXISTS);
			   }
		   } 
		   else 
		   {
			   user.setResponse(false);
			   user.setMessage(GlobalVariables.SOMETHING_WENT_WRONG);
		   }
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	   return mGson.toJson(user);
   }
   
   
   @RequestMapping(value="/user.do", method= RequestMethod.GET)
   public @ResponseBody String getAllUser(HttpServletRequest req, HttpServletResponse resp) {
	   
	   List<UserDTO> lListOfUser 								= null;
	   try {
//		   if((boolean) req.getSession().getAttribute(GlobalVariables.ADMIN_LOGIN)) {
		       lListOfUser = new UserTable().getAllUserData();
//		   }
		       System.out.println(mGson.toJson(lListOfUser));
	   } catch (Exception e) {
		   e.printStackTrace();
	   }
	   return mGson.toJson(lListOfUser);
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
   
   @RequestMapping(value="/logout.do")
   public void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException
   {
	   req.getSession().invalidate();
	   resp.sendRedirect("./");
   }
}