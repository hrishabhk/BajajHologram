package com.bajaj.constant;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.TimeZone;

//
//import java.util.TimeZone;
//
//public class Test {
//
//	public static void main(String[] args) 
//	{
//		TimeZone tz = TimeZone.getTimeZone("America/Denver");
//		
//		System.out.println(tz);
//	}
//
//}

 class Student  {
    private String studentname;
    private Long rollno;
    private int studentage;

    public String getStudentname() {
		return studentname;
	}
	public void setStudentname(String studentname) {
		this.studentname = studentname;
	}
	public Long getRollno() {
		return rollno;
	}
	public void setRollno(Long rollno) {
		this.rollno = rollno;
	}
	public int getStudentage() {
		return studentage;
	}
	public void setStudentage(int studentage) {
		this.studentage = studentage;
	}
	public Student(Long rollno, String studentname, int studentage) {
        this.rollno = rollno;
        this.studentname = studentname;
        this.studentage = studentage;
    }
    //getter and setter methods same as the above example 
    @Override
    public String toString() {
        return "[ rollno=" + rollno + ", name=" + studentname + ", age=" + studentage + "]";
    }
}
public class Test
{
	public static Comparator<Student> StuNameComparator = new Comparator<Student>() {

		public int compare(Student s1, Student s2) {
		   Long StudentName1 = s1.getRollno();
		   Long StudentName2 = s2.getRollno();

		   //ascending order
		   return StudentName1.compareTo(StudentName2);

		   //descending order
		   //return StudentName2.compareTo(StudentName1);
	    }};
    public static void main(String args[]){
 	   ArrayList<Student> arraylist = new ArrayList<Student>();
 	   arraylist.add(new Student( 223L, "Chaitanya", 26));
 	   arraylist.add(new Student(245L, "Rahul", 24));
 	   arraylist.add(new Student(209L, "Ajeet", 32));

 	  Collections.sort(arraylist, Test.StuNameComparator);

 	   for(Student str: arraylist){
 			System.out.println(str);
 	   }
 	  TimeZone tz = TimeZone.getTimeZone("America/Denver");
//		
//		System.out.println(tz);
 	  
 	}
}