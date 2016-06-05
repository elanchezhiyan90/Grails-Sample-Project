<div class="pager" style="display: none">
	<g:form controller="${controller}" action="${action}">
		<table>
			<tr>
				<g:if test="${paramsModel != null && paramsModel != ''}">
				<td>
					<input  type="number" step="any"
					class="pagenum" min="1" value="" max="1" />
					
						<button class="gobtn" type="button"  onclick="${remoteFunction(action:action, update:update, before:'if (pageCheck(event)) {return false;}', params:'\'gotoPage=\'+getPageNumber(event)+'+paramsModel, onSuccess:'pagerSuccess();')}">${message(code:'taglib.pager.go.button.text')}</button>
				</td>
				<td>
					<span class="of"><span class="crntpg">1</span> of <span
					class="nofpg"></span></span></td>
				<td>
					<div>
						<button class="previous" type="button" onclick="${remoteFunction(action:action, update:update, params:'\'gotoPage=\'+getCurrentPage("prev")+'+paramsModel, onSuccess:'pagerSuccess();')}">${message(code:'taglib.pager.previouspage.button.text')}</button>
						<button class="next" type="button" onclick="${remoteFunction(action:action, update:update, params:'\'gotoPage=\'+getCurrentPage("next")+'+paramsModel, onSuccess:'pagerSuccess();')}">${message(code:'taglib.pager.nextpage.button.text')}</button>
					</div>
				</td>
				</g:if>
				<g:else>
					<td>
						<input  type="number" step="any"
						class="pagenum" min="1" value="" max="1" />
						
							<button class="gobtn" type="button"  onclick="${remoteFunction(action:action, update:update, before:'if (pageCheck(event)) {return false;}', params:'\'gotoPage=\'+getPageNumber(event)', onSuccess:'pagerSuccess();')}">${message(code:'taglib.pager.go.button.text')}</button>
					</td>
					<td>
						<span class="of"><span class="crntpg">1</span> of <span
						class="nofpg"></span></span></td>
					<td>
						<div>
							<button class="previous" type="button" onclick="${remoteFunction(action:action, update:update, params:'\'gotoPage=\'+getCurrentPage("prev")', onSuccess:'pagerSuccess();')}">${message(code:'taglib.pager.previouspage.button.text')}</button>
							<button class="next" type="button" onclick="${remoteFunction(action:action, update:update, params:'\'gotoPage=\'+getCurrentPage("next")', onSuccess:'pagerSuccess();')}">${message(code:'taglib.pager.nextpage.button.text')}</button>
						</div>
					</td>
				</g:else>
			</tr>
		</table>
	</g:form>
</div>