<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<g:form name="setnamesequence">
		<h2>
			${message(code:'setnamesequence.personalization.display')}
		</h2>
		<div class="setnameseq-btnset">
			<div class="fields" id="selectOption">
				<p>
					<g:radio name="personalizeAccounts" id="accounts" value="A"
						required="required" checked="true" />
					<label for="accounts"> ${message(code:'setnamesequence.accounts.label') }
					</label>
					<g:radio name="personalizeAccounts" id="creditcards" value="C"
						required="required" />
					<label for="creditcards"> ${message(code:'setnamesequence.creditcard.label') }
					</label>
				</p>
			</div>
		</div>	
		
		<div id="updateNickSeq">
			<g:render template="/userProfile/templates/personalizeAccounts" />
		</div>
		<g:hiddenField name="rowIndexCount" value="0" />
	</g:form>
	<script>
	$(document).ready(function () 
	{
	     $("#setnamesequence").dynamicfieldupdate();
	     $(".setnameseq-btnset").buttonset();
	});

	function checkFormValidity()
		{
			if(!$("#setnamesequence").checkValidity())
		 	{
			 	return true;
		 	}else
		 	{
			 	return false;
		 	}
	 	}
	 	
	 	function getRowCount()
	 	{
		var vRowIndexCnt = $("#nicknamegrid tr").length;
		$("#rowIndexCount").val(vRowIndexCnt);
		}

		$("#accounts").click(function() {
			<g:remoteFunction controller="userProfile" action="personalizeaccounts" update="updateNickSeq" onSuccess="updateNickSeqSuccess()" onFailure="updateNickSeqFailure()" params="{'productType':'A'}" />
			$("#rowIndexCount").val("0");
			$(":radio[name=accounts][value=A]").attr("checked", true);
			$(".setnameseq-btnset").buttonset();
		});	

		// On Click of Charge Type VARIABLE
		$("#creditcards").click(function() {
			<g:remoteFunction controller="userProfile" action="personalizecreditcards" update="updateNickSeq" onSuccess="updateNickSeqSuccess()" onFailure="updateNickSeqFailure()" params="{'productType':'C'}" />
			$("#rowIndexCount").val("0");
			$(":radio[name=creditcards][value=C]").attr("checked", true);
			$(".setnameseq-btnset").buttonset();
		});
	
	function updateNickSeqSuccess()
	 {
		 $("#updateNickSeq").dynamicfieldupdate();
		 getRowCount();
	 }

	 function updateNickSeqFailure()
	 {
		 $("#updateNickSeq").empty();
	 }
	 
	 
</script>
</body>