<%--<g:if test="${BillerDetailsModel?.billerService}">
<g:set var="img" value="${BillerDetailsModel?.billerService?.getBiller()?.getDocument()?.getDocumentDetails().iterator().next().getId()}"/>
<g:set var="imgdoc" value="${BillerDetailsModel?.billerService?.getBiller()?.getImageDocument()?.getDocumentDetails().iterator().next().getId()}"/>
<span id="billerlogo"><vayana:img documentDetailId="${img}" height="36" width="36" /></span>
</g:if>
--%>
<g:each var="billermetadata" in="${BillerDetailsModel?.billerService?.billerMetaData}">
<g:set var="isNullable" value="${billermetadata?.nullable.toString()}" />
<g:set var="dataType" value="${billermetadata?.dataType.toString()}" />
<div class="fields">
	<p>
		<label for="${billermetadata?.dataLabel?.code}" >${billermetadata?.dataLabel?.description}</label>
		
		<g:if test="${dataType.equals("L")}">
			<g:if test="${isNullable.equals("N")}">
						
			<%--<vayana:iblookupSelect name="${billermetadata?.dataLabel}" type="${billermetadata?.tenantLookupType.code}" id="${billermetadata?.dataLabel}" domain="ib"></vayana:iblookupSelect>
			
			--%>
			
			
			<g:select id="${billermetadata?.dataLabel?.code}" 
			                             name='${billermetadata?.dataLabel?.code}' 
			                             from='${billermetadata?.tenantLookupType}'
			                             optionKey="id" 
								         optionValue="description"
								         noSelection ="${['null':'Select the Option']}"
								         required="required"							         	
								         />	
			</g:if>
			<g:if test="${isNullable.equals("Y")}">
			<g:select id="${billermetadata?.dataLabel?.code}.toLowerCase()" 
			                             name='${billermetadata?.dataLabel?.code}' 
			                             from='${billermetadata?.tenantLookupType}'
			                             optionKey="id" 
								         optionValue="description"
								         noSelection ="${['null':'Select the Option']}"				         	
								         />	
			</g:if>								  
		</g:if>		
		<g:if test="${dataType.equals("V")}">
			<g:if test="${isNullable.equals("N")}">
			<input type="text" value="" name="${billermetadata?.dataLabel?.code}" id="${billermetadata?.dataLabel?.code}"  required="required" />
			</g:if>
			<g:if test="${isNullable.equals("Y")}">
			<input type="text" value="" name="${billermetadata?.dataLabel?.code}" id="${billermetadata?.dataLabel?.code}" />
			</g:if>
		</g:if>
		
		<g:if test="${dataType.equals("N")}">
			<g:if test="${isNullable.equals("N")}">
			<input type="text" value="" name="${billermetadata?.dataLabel?.code}" id="${billermetadata?.dataLabel?.code}"  required="required" />
			</g:if>
			<g:if test="${isNullable.equals("Y")}">
			<input type="text" value="" name="${billermetadata?.dataLabel?.code}" id="${billermetadata?.dataLabel?.code}" />
			</g:if>
		</g:if>
		
		<g:if test="${dataType.equals("D")}">
			<g:if test="${isNullable.equals("N")}">
			<input type="date" name="${billermetadata?.dataLabel?.code}" id="${billermetadata?.dataLabel?.code}" data-errormessage="${message(code:'biller.templates.addbiller.metadatafields.date.error.message') }" />
			</g:if>
			<g:if test="${isNullable.equals("Y")}">
			<input type="date" name="${billermetadata?.dataLabel?.code}" id="${billermetadata?.dataLabel?.code}" data-errormessage="${message(code:'biller.templates.addbiller.metadatafields.date.error.message') }"  required="required"/>
			</g:if>
		</g:if>                               
	</p>
</div>
</g:each>
