<head>
<meta name="layout" content="chart" />
<parameter name="themeName" value="${params.themeName}" />
<style>
.dateline ul li .d_msg {
	border: 1px solid transparent;
	float: left;
	margin-left: 10px;
	max-width: 50%;
	width: 50%;
}

.dateline ul li .d_msg .type {
	color: #333333;
	font-size: 1.2em;
	font-style: normal;
}

.folio_col {
	min-width: 400px;
	max-width: 480px;
	float: left;
	margin-right: 15px;
}

.dtl_swap_div ul li a span {
	background: url(../themes/pmcb_theme/img/common/p_chart.png) no-repeat;
}

#date_filter {
	color: #666;
	font-weight: bold;
	padding: 5px;
	display: block;
	text-align: right;
}
</style>
</head>
<body>
	<section class="body-scroll">
		<h2>
			${message(code:'portfolio.portfoliomaster.h2.text') }
		</h2>
		<div class="grid_filter">
			<div class="fields">
				<p>
					<label for="portfolio currency"> ${message(code:'portfolio.portfoliomaster.portfolioin.label') }
					</label>
					<vayana:tenantOpsCurrencySelect name="baseCurId" id="baseCurId"
						onchange="${remoteFunction(controller:'portfolio',
							action:'preferredCurrencyChange',
							update:'summary',
							params:'\'preferredCurrency=\'+preferredCurrency()+\'&baseCurrencyCode=\'+baseCurrencyCode()',
							before:'if(validate()){return false;}',
							onSuccess:'updaterepresentativediv(data,textStatus);')}" />
				</p>
			</div>
			<div class="dtl_swap_div">
				<ul>
					<li><a href="#" class="crnt" id="stream-view"
						title="${message(code:'portfolio.portfoliomaster.streamview.text') }"><span></span></a>
					</li>
					<li><a href="#" id="graph-view"
						title="${message(code:'portfolio.portfoliomaster.graphview.text') }"><span></span></a>
					</li>
				</ul>
			</div>
		</div>
		<!-- end of grid_filter -->
		<div class="summary" id="summary">
			<g:render template="templates/portfoliosummary"></g:render>
		</div>
	</section>
	<g:javascript>
$(document).ready(function () {
		
		$("#baseCurId option").each(function () {
        			if ($(this).text() == "${baseCurrencyModel?.code}") {
            		$(this).attr("selected", "selected").siblings('option').removeAttr('selected');
           			var sel=$($(this)).val('${baseCurrencyModel?.idVersion}').text();
					$($(this)).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
        		}
		});
		
		$(".dtl_swap_div ul li a").click(function(){
			$(this).addClass('crnt');
			$(this).parents("li").siblings().find('a').removeClass('crnt');	
		});
		
		$("a#stream-view").click(function(){
		
				$(".graph").hide();
				$(".stream").show();
				$(".stream").dynamicfieldupdate();
		});
		
		$("a#graph-view").click(function(){
		
				$(".stream").hide();
				$(".graph").show();
				graphDraw();
				$(".graph").dynamicfieldupdate();
				
		});
		
		
		
		$(".dateline li.has-dtl a").live("click",function(event){
		event.preventDefault();
		$(this).parent("li").children(".view-dtl").fadeToggle(500,function(){$('.body-scroll').jScrollPane();});
		$(this).closest("li").toggleClass('hlt');
		$('.body-scroll').jScrollPane();
		});


});
function validate()
{
	if($("#baseCurId option:selected").text()==$('#currentCurCode').val())
	{
		return true;
	}
	else
	{
		return false;
	}
}
function preferredCurrency()
{
	var text = $("#baseCurId option:selected").val();
	return text;
}

function baseCurrencyCode()
{
	return '${baseCurrencyModel?.code}';
}
function updaterepresentativediv(data,textStatus)
{
 		if(textStatus == 'success')
 		{
 			var dataq =  $(data).first().html();
 			$("#summary").dynamicfieldupdate();
		}
}
</g:javascript>


</body>
