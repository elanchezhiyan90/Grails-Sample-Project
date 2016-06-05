<g:each in="${questionBaskets}"
						var="questionBasket">
						<div class="fields">
							<p>
							<g:hiddenField name="ibUserSecretQuestionId" id="ibUserSecretQuestionId" value="${questionBaskets.question?.id?.iterator()?.next()}"/>
						<label for="ibUserSecretAnswer"><b>${questionBaskets.question?.description?.iterator()?.next()}</b></label>   
								<br><input type="text"
									name=ibUserSecretAnswer id="ibUserSecretAnswer"
									placeholder="${message(code:'userregistration.templates.secretinfocontent.secretanswer.placeholder.text') }"
									autocomplete="off" autofocus required="required"   
									data-errormessage="Please enter secret answer" />

							</p>

						</div>
					</g:each>