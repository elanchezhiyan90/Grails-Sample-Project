

<g:set var="goalId" value="${goalRedeemModel}" />
<p>Funds Will Be Credited Back To Account Of Origin. You Want to Redeem Funds?</p>

<div class="fields">
<div class="fields"  id=divlookupType>
	<input type="button" value="Cancel" name="cancelTxn"
					onClick="$.fn.ceebox.closebox();" class="btn_next">
				<vayana:submitToRemote action="goalRedeemAction" controller="goal"
					value="Yes" 
					update="[failure:'messagesDiv',success:'divlookupType']"
					params="[goalId:goalId]"
					onSuccess="updateFormData1(data,textStatus)" />

</div>

</div>

<script>


function updateFormData1(data,textStatus){

<g:remoteFunction controller="goal" action="goalRedeemAction"  
	onSuccess="ontransactionTypeSuccess(data,textStatus);"  onFailure ="ontransactionTypeFailure();" />			
		

}

function ontransactionTypeSuccess(data,textStatus){
$.fn.ceebox.closebox();

}
</script>


