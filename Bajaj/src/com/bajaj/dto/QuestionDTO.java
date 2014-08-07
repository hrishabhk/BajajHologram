package com.bajaj.dto;

import java.util.Calendar;

public class QuestionDTO {

	private String id;
	private String question;	
	private String answer;
	private String cateory;
	private String frequent;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(9788989);
		this.id = id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getCateory() {
		return cateory;
	}
	public void setCateory(String cateory) {
		this.cateory = cateory;
	}
	public String getFrequent() {
		return frequent;
	}
	public void setFrequent(String frequent) {
		this.frequent = frequent;
	}
	
	
	
	
}


