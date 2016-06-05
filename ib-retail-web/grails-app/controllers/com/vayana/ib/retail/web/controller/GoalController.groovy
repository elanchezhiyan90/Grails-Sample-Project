package com.vayana.ib.retail.web.controller
import grails.converters.JSON
import com.vayana.bm.core.api.model.user.UserLoginProfile
import com.vayana.ib.retail.web.controller.common.GenericController


class GoalController extends GenericController{
	
	def goalMaster() {
		render view:"/goals/goalMaster",model:model;
	}	
	
	def addNewGoal() {
		render template:"/goals/templates/addNewGoal",model:model;
	}
	
	def addNewGoalConfirm() {
		render template:"/goals/templates/addGoalConfirm",model:model;
	}
	
	def saveGoal() {
		
		render template:"/goals/templates/successGoal",model:model;
	}
	
	
	def goalEditAction() {
		
		render template:"/goals/templates/editGoal",model:model;
		
		
	}
	
	def updateownGoal() {
		
		render template:"/goals/templates/editSuccessGoal",model:model;
		
		
	}
	
	def goalDetail() {
		
		render template:"/goals/templates/goalDetail",model:model;
		
		
	}
	
	def goalRedeem() {
		render template:"/goals/templates/goalRedeem",model:model;
		
		
	}
	
	
	
	def editconfirmGoal() {
		render template:"/goals/templates/editGoalConfirm",model:model;
	}
	
	
  def deleteGoal() {
		render template:"/goals/templates/goalList",model:model;
	}	
  
  def showUserGoalDetails(){
	  render template : params.viewUrl,model:model;
  }

  def updateSharedUserGoalStatus(){
	  render template:"/goals/templates/acceptedMessage",model:model;
  }
  
  def suspendConfirmGoal(){
	  render template:"/goals/templates/suspendGoalConfirm",model:model;
  }
  def supendGoal(){
	  render template:"/goals/templates/suspendGoalSuccess",model:model;
  }
  
  def resumeConfirmGoal(){
	  render template:"/goals/templates/resumeGoalConfirm",model:model;
  }
 
  def resumeGoal(){
	  render template:"/goals/templates/resumeGoalSuccess",model:model;
  }
  
  def getAutoPopulateAmount(){
	  render template:"/goals/templates/autoPopulatedAmt",model:model;
  }
  
  def getEditAutoPopulateAmount(){
	  render template:"/goals/templates/editAutoPopulatedAmt",model:model;
  }
  
  def goalRedeemAction(){
	  render template:"/goals/templates/successRedeemGoal",model:model;
	  
	  
  }
  
  
}


