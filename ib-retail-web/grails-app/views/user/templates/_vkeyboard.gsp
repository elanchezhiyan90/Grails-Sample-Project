<div class="middle_img_keypad">
	<div class="keyboard">
		<h3>
			<a class="drag_vk"><img align="left"
				src="/ib-retail-web/themes/pmcb_theme/img/common/drag.png"
				width="24" height="24" alt="drag"></a><a href="#" class="close_vk"></a>
		</h3>

		<table border="0" cellpadding="10" cellspacing="0" align="center">
			<tr>
				<td align="center">
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" colspan="10">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="center"><table border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td><input type="button" class="keysc"
														onclick="writePwd('!')" value="!" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('@')" value="@" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('#')" value="#" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('$')" value="$" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('%')" value="%" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('^')" value="^" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('(')" value="(" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd(')')" value=")" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('*')" value="*" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('-')" value="-" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('_')" value="_" /></td>
													<td><input type="button" class="keysc"
														onclick="writePwd('&')" value="&" /></td>
												</tr>
											</table></td>
									</tr>
									<tr>
										<td>
											<div id="smallLayout" style="display: inline">
												<table border="0" cellspacing="0" cellpadding="0"
													id="smallaplpha">
												</table>
											</div>
											<div id="capsLayout" style="display: none">
												<table border="0" cellspacing="0" cellpadding="0"
													id="capsalpha">
												</table>
											</div>
										</td>
									</tr>
								</table>

							</td>
						</tr>
					</table>
				</td>
				<td align="center">
					<table cellspacing="0" cellpadding="0" border="0"
						id="randomnumbers">

					</table>
				</td>
			</tr>
		</table>
	</div>
</div>
<g:javascript>
/* Small alphabets */
var alphaArray;
alphaArray=new Array("q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m");
var tempalphaArray=new Array();
var alphacount=alphaArray.length;
var alphaChar="";
for (i=0;i < alphacount;i++)
{
	var now = new Date();
	var secs = now.getSeconds();
	rnd = Math.random(secs);
	rnd = Math.round(rnd * (alphaArray.length));
	if (rnd == alphaArray.length){rnd = 0}
	tempalphaArray[i]=alphaArray[rnd];
	alphaChar+=tempalphaArray[i]+", "
	removealphaChar(rnd);
}
alphaArray=tempalphaArray;
function removealphaChar(id)
{
	var temp1=new Array();	
	for (k=0;k < alphaArray.length;k++)
	{
		if(id!=k)
		{
			temp1[temp1.length]=alphaArray[k];			
		}
	}	
	alphaArray=temp1;	
}
$("#smallaplpha").append('<tr><td align="center"><table border="0" cellspacing="0" cellpadding="0"><tr><td><a href="#" class="capsc" onclick="toggle();">	&#11014; Caps</a></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[0])" value="'+alphaArray[0]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[1])" value="'+alphaArray[1]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[2])" value="'+alphaArray[2]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[3])" value="'+alphaArray[3]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[4])" value="'+alphaArray[4]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[5])" value="'+alphaArray[5]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[6])" value="'+alphaArray[6]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[7])" value="'+alphaArray[7]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[8])" value="'+alphaArray[8]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[9])" value="'+alphaArray[9]+'" /></td></tr></table></td></tr><tr><td align="center"><table border="0" cellspacing="0" cellpadding="0"><tr><td><a href="#" class="shiftc" onclick="toggleshift();">	&#8679; Shift</a></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[10])" value="'+alphaArray[10]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[11])" value="'+alphaArray[11]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[12])" value="'+alphaArray[12]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[13])" value="'+alphaArray[13]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[14])" value="'+alphaArray[14]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[15])" value="'+alphaArray[15]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[16])" value="'+alphaArray[16]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[17])" value="'+alphaArray[17]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[18])" value="'+alphaArray[18]+'" /></td><td><a href="#" class="btnc done" >	&#8629; Done</a></td></tr></table></td></tr><tr><td align="center"><table border="0" cellspacing="0" cellpadding="0"><tr><td><a href="#" onclick="javascript:clearAll();" class="btnc">Clear &#8998; </a></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[19])" value="'+alphaArray[19]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[20])" value="'+alphaArray[20]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[21])" value="'+alphaArray[21]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[22])" value="'+alphaArray[22]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[23])" value="'+alphaArray[23]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[24])" value="'+alphaArray[24]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(alphaArray[25])" value="'+alphaArray[25]+'" /></td><td><a href="#" onclick="javascript: backSpacer();" class="btnc">&larr; Backsp</a></td></tr></table></td></tr>');


						                  
/* Caps Alphabets */
var calphaArray;
calphaArray=new Array("Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M");
var ctempalphaArray=new Array();
var calphacount=calphaArray.length;
var calphaChar="";
for (i=0;i < calphacount;i++)
{
	var now = new Date();
	var secs = now.getSeconds();
	crnd = Math.random(secs);
	crnd = Math.round(crnd * (calphaArray.length));
	if (crnd == calphaArray.length){crnd = 0}
	ctempalphaArray[i]=calphaArray[crnd];
	calphaChar+=ctempalphaArray[i]+", "
	cremovealphaChar(crnd);
}
calphaArray=ctempalphaArray;
function cremovealphaChar(id)
{
	var ctemp1=new Array();
	for (C=0;C < calphaArray.length;C++)
	{
		if(id!=C)
		{
			ctemp1[ctemp1.length]=calphaArray[C];			
		}
	}	
	calphaArray=ctemp1;	
}
$("#capsalpha").append('<tr><td align="center"><table border="0" cellspacing="0" cellpadding="0"><tr><td><a href="#" class="capsc" onclick="toggle();">	&#11014; Caps</a></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[0])" value="'+calphaArray[0]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[1])" value="'+calphaArray[1]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[2])" value="'+calphaArray[2]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[3])" value="'+calphaArray[3]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[4])" value="'+calphaArray[4]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[5])" value="'+calphaArray[5]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[6])" value="'+calphaArray[6]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[7])" value="'+calphaArray[7]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[8])" value="'+calphaArray[8]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[9])" value="'+calphaArray[9]+'" /></td></tr></table></td></tr><tr><td align="center"><table border="0" cellspacing="0" cellpadding="0"><tr><td><a href="#" class="shiftc" onclick="toggleshift();">	&#8679; Shift</a></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[10])" value="'+calphaArray[10]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[11])" value="'+calphaArray[11]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[12])" value="'+calphaArray[12]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[13])" value="'+calphaArray[13]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[14])" value="'+calphaArray[14]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[15])" value="'+calphaArray[15]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[16])" value="'+calphaArray[16]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[17])" value="'+calphaArray[17]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[18])" value="'+calphaArray[18]+'" /></td><td><a href="#" class="btnc done">	&#8629; Done</a></td></tr></table></td></tr><tr><td align="center"><table border="0" cellspacing="0" cellpadding="0"><tr><td><a href="#" onclick="javascript:clearAll();" class="btnc">Clear &#8998; </a></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[19])" value="'+calphaArray[19]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[20])" value="'+calphaArray[20]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[21])" value="'+calphaArray[21]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[22])" value="'+calphaArray[22]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[23])" value="'+calphaArray[23]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[24])" value="'+calphaArray[24]+'" /></td><td><input type="button" class="keysc" onclick="writePwd(calphaArray[25])" value="'+calphaArray[25]+'" /></td><td><a href="#" onclick="javascript: backSpacer();" class="btnc">&larr; Backsp</a></td></tr></table></td></tr>');

/* Numbers */
					                      
var numArray;
numArray=new Array(0,1,2,3,4,5,6,7,8,9);
var tempnumArray=new Array();
var numcount=numArray.length;
var numChar="";
for (i=0;i < numcount;i++){
	var now = new Date();
	var secs = now.getSeconds();
	rnd = Math.random(secs);
	rnd = Math.round(rnd * (numArray.length));
	if (rnd == numArray.length){rnd = 0;}
	tempnumArray[i]=numArray[rnd];
	numChar+=tempnumArray[i]+", "
	removenumChar(rnd);
}
numArray=tempnumArray;
function removenumChar(id){
	var temp=new Array();
	for (j=0;j < numArray.length;j++){
		if(id!=j){
			temp[temp.length]=numArray[j];
		}
	}
	numArray=temp;
}
$("#randomnumbers").append('<tr><td><input type="button" class="keysc" onclick="writePwd('+numArray[0]+')" value="'+numArray[0]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[1]+')" value="'+numArray[1]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[2]+')" value="'+numArray[2]+'"/></td></tr><tr><td><input type="button" class="keysc" onclick="writePwd('+numArray[3]+')" value="'+numArray[3]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[4]+')" value="'+numArray[4]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[5]+')" value="'+numArray[5]+'"/></td></tr><tr><td><input type="button" class="keysc" onclick="writePwd('+numArray[6]+')" value="'+numArray[6]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[7]+')" value="'+numArray[7]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[8]+')" value="'+numArray[8]+'"/></td></tr><tr><td><td><input type="button" class="keysc" onclick="writePwd('+numArray[9]+')" value="'+numArray[9]+'" /></td><td></td></tr>');
	
</g:javascript>
<script>
			
	var count=1;
	function toggle(){
		if(count==0){
			document.getElementById('smallLayout').style.display="inline";
			document.getElementById('capsLayout').style.display="none";
		
			count=1;
		}else{
			document.getElementById('capsLayout').style.display="inline";
			document.getElementById('smallLayout').style.display="none";
				 $(".capsc").toggleClass("highlight");
			count=0;
		}
	}
	
	var countshift=1;
	function toggleshift(){
		if(countshift==1){
			shiftopt="true";
			document.getElementById('capsLayout').style.display="inline";
			document.getElementById('smallLayout').style.display="none";
			$(".shiftc").toggleClass("highlight");
			countshift=1;
		}
	}
</script>