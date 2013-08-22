package model

import anorm._
import play.api.db._
import play.api.Play._

case class Person (id:Int,firstName:String,lastName:String)

object People {
	def findAllPeople() = {
		DB.withConnection { implicit connection =>
		  SQL("select id, first_name, last_name from Person order by last_name, first_name")
		  	.apply()
		  	.map(row =>
		  	  	Person(row[Int]("id"), row[String]("first_name"), row[String]("last_name"))
		  	  ).toList
		}
	}
}



/*
  def findNearestFacilities(latitude:Double, longitude:Double, treatmentGroupId:Int, limit:Int = 20) : Seq[FacilityRanking] = {
    DB.withConnection { implicit connection =>
      SQL("select f.id, name, address, city, state, zip, latitude, longitude, outcome_rank, avg(average_total_payments) as charges, " +
          "ST_Distance(ST_Point({longitude},{latitude}), geo_point)/1000 as distance_km from patient_charges pc join facilities f on pc.facility_id=f.id " +
          "where treatment_id in (select id from treatments where treatment_group_id={treatmentGroupId}) " +
          "group by f.id, f.geo_point order by distance_km asc limit {limit}")
        .on("latitude" -> latitude)
        .on("longitude" -> longitude)
        .on("treatmentGroupId" -> treatmentGroupId)
        .on("limit" -> limit)
        .apply()
        .map( row =>
        FacilityRanking(Facility(row[Int]("id"), row[String]("name"), row[String]("address"), row[String]("city"), row[String]("state"), row[String]("zip"),
          row[Double]("latitude"), row[Double]("longitude"), row[Double]("outcome_rank")), row[Double]("charges"), row[Double]("distance_km"))
      ).toList
    }
*/