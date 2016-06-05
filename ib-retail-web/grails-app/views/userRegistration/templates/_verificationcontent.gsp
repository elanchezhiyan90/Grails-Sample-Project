<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'userregistration.templates.identificationcontent.h2.text') }
			</h2>
			<p>
				${message(code:'userregistration.templates.verificationcontent.information.label') }
			</p>
			<br>
<%--			<div class="mandi-note">--%>
<%--				<span class="mandi"></span>--%>
<%--				<p>--%>
<%--					${message(code:'userregistration.templates.verificationcontent.mandatoryfields.text') }--%>
<%--				</p>--%>
<%--			</div>--%>
			<g:render template="/common/security/templates/securityUtils" />
			<g:render template="/userRegistration/templates/verificationInfo"/>
		</section>
	</div>

</div>
<g:javascript>
$(document).ready(function () {
            $('.card_split').on("keyup", function (e) { 
                if ($(this).val().length > 3) {
                $(this).next('.card_split').removeAttr('disabled');  
                    $(this).next('.card_split').focus();
                }
            });
               
        });
        $( ".vkey").on("click",function(e){
        	$("#card1").focus(); 
        
        });
      
</g:javascript>