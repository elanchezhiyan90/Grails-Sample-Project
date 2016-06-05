		<div class="fields">
				<p>
				<g:each in="${userSecretQuestionModel}" var="userSecretQuestion">
            		<div class="fields">
						<p>	
						<label for="ibUserSecretAnswer">${userSecretQuestion?.questionBasketDetail?.question?.description}</label> 
						<input type="text" name=ibUserSecretAnswer
						id="ibUserSecretAnswer"
						placeholder="${message(code:'userregistration.templates.secretinfocontent.secretanswer.placeholder.text') }"
						autocomplete="off" 
						required="required" />
						<g:hiddenField name="ibUserSecretQuestion" value="${userSecretQuestion?.questionBasketDetail?.id}"/>
				</p>
                    </div>
            </g:each>
				</p>
				<vayana:submitToRemote controller="security" name="secretQandASubmit"
					 				   id="secretQandASubmit"					 				 
					 				    action="validateSecretQandA"
					 				    value="Ok" update="[failure:'messagesDiv']"
					 				    before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
					 				    update="dynamicAuthContent"
					 				    onSuccess="onAuthSuccess(data,textStatus)"
										onFailure="onAuthFailure(XMLHttpRequest.responseText,'${params?.displayAsPopUp}')"
					 				    />
					 				    
				<g:if test="${securityHolder?.securitySettings && securityHolder?.securitySettings?.size() == 1}">
					<g:hiddenField name="securityHolderSize" value="true"/>
				</g:if>
				<g:else>
					<g:hiddenField name="securityHolderSize" value="false"/>
				</g:else>	 				    
				<g:hiddenField name="displayAsPopUp" value="${params?.displayAsPopUp}"/>
			</div>	