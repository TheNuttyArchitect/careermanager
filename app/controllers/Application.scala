package controllers

import play.api._
import play.api.mvc._
import model.People

object Application extends Controller {
  
  def index = Action {
    //Ok(views.html.index("Your new application is ready."))
    val people = People.findAllPeople().toSeq
    Ok(views.html.index(people))
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
  
}