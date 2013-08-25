package controllers

import play.api._
import play.api.mvc._
import model.People
import model.Employees

object Application extends Controller {
  
  def index = {
    getEmployeeSummary(1)
  }
  
  def allPeople = Action {
    //val transactions = Transaction.findLatestTransactions()

    //val grouped = transactions.groupBy(tx => tx.id)
    //val keys = grouped.keys.toSeq.sortBy(-_)
    //Ok(views.html.auditTrail(keys.map(grouped.get(_).get).toSeq))
    val people = People.findAllPeople().toSeq
    //Ok(views.html.)
    //views.html.
    Ok(views.html.allPeople(people))
  }
  
  def getEmployeeSummary(employeeId:Int) = Action { 
    val employee:model.Employee = Employees.getSummary(employeeId)
    Ok(views.html.index(employee))
  }
  
}