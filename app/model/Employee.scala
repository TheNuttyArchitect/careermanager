package model

import anorm._
import java.util.Date
import play.api.db._
import play.api.Play._

case class Employee (id:Int,personId:Int,firstName:String,lastName:String,title:String,hireDate:Date,terminationDate:Option[Date],isActive:Boolean)

object Employees {
	//select e.employee_id, e.person_id,p.first_name,p.last_name,e.title,e.hire_date,e.termination_date,e.is_active from Employee e join Person p on e.person_id = p.person_id where e.employee_id={employee_id}
  def getSummary(id:Int):Employee = {
    DB.withConnection(implicit connect =>
    	SQL("select e.employee_id, e.person_id,p.first_name,p.last_name,e.title,e.hire_date,e.termination_date,e.is_active " +
    	    "from Employee e join Person p on e.person_id = p.person_id where e.employee_id={employee_id}")
    	   .on("employee_id" -> id)
    	   .apply()
    	   .map(row => Employee(row[Int]("employee_id"),row[Int]("person_id"),row[String]("first_name"),row[String]("last_name"),
    	               row[String]("title"),row[Date]("hire_date"),row[Option[Date]]("termination_date"),row[Boolean]("is_active")))
    	   .toList.head
    )
  }
}