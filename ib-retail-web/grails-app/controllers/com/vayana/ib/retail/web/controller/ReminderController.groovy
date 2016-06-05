package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController;

class ReminderController extends GenericController {

	def savereminder(){
		render template:"/dateline/templates/previousreminders",model:model;
	}
	
	def removereminder(){
		chain(controller: "dateline", action: "index")		
	}
	
	def updatereminderstatus(){
		
	}
	
	def getReminderMetaData(){
		render template:"/dateline/templates/${params.selectedReminderCategory}Reminder", model:model;
	}
	
	def getBillerInstructions(){
		render template : "/dateline/templates/BPInstruction", model:model;
	}
	def getBeneficiaryInstructions(){
		render  template : "/dateline/templates/FTInstruction", model:model;
	}
}
