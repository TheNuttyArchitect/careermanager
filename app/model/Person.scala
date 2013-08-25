package model

import anorm._
import play.api.db._
import play.api.Play._

case class Person (id:Int,firstName:String,lastName:String)

object People {
	def findAllPeople() = {
		DB.withConnection { implicit connection =>
		  SQL("select person_id, first_name, last_name from Person order by last_name, first_name")
		  	.apply()
		  	.map(row =>
		  	  	Person(row[Int]("person_id"), row[String]("first_name"), row[String]("last_name"))
		  	  ).toList
		}
	}
}