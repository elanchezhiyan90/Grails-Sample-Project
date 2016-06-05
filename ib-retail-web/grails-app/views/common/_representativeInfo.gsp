					<g:hiddenField name="homeBranchId" value="${homeBranchName}"/>
					<div id="receiverdata">
						<div class="fields">
							<p>
	      							<label for="personname">${message(code:'taglib.representativeinfo.personname.label')}</label>	     							
	     							<g:textField value="" def_value="${customerName}" name="representativeFirstName" id="representativeFirstName" required="required" />                               
	  						</p>  						
						</div>
						<div class="fields">
							<p>
	      							<label for="collectionBranchId">${message(code:'taglib.representativeinfo.branchname.label')}
</label>
	     							<vayana:select name="collectionBranchId" id="collectionBranchId" optvalue="description" type="BRANCH" findBy="ALL" domain="ib" required="required" ></vayana:select>	     							                         
	  						</p>  						
						</div>
						<div class="fields">
							<p>
	      							<label for="representativeIdentityCode">${message(code:'taglib.representativeinfo.idtype.label')}</label>
	     							<vayana:iblookupSelect name="representativeIdentityCode" id="representativeIdentityCode" optionKey="code" type="IDENTIFICATION_TYPE" domain = "base" required="required"/>
	     					</p>  						
						</div>							
						<div class="fields">
							<p>
	      							<label for="representativeIdentityDetails">${message(code:'taglib.representativeinfo.idnumber.label')}
</label>
	     							<g:textField  value="" name="representativeIdentityDetails" id="representativeIdentityDetails" required="required" />                               
	  						</p>  						
						</div>						
											
						<div class="fields">
							<p>
	      							<label for="collectionDate">${message(code:'taglib.representativeinfo.collectiondatetime.label')}</label>
	      							<vayana:vayanaDate name="collectionDate" id="collectionDate" value=""/>
	  						</p>  						
						</div>					
					</div>

