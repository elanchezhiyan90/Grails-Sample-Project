<%--<div class="col-550">--%>
<%--	<br> <br>--%>
	<div class="middle_img_keypad">
  <div class="keyboard">
  <h3><a class="drag_vk" ><img align="left" src="/ib-retail-web/themes/pmcb_theme/img/common/drag.png" width="24" height="24" alt="drag"></a><a href="#" class="close_vk"></a></h3>

<table border="0" cellpadding="10" cellspacing="0" align="center">
	<tr>   
    <td align="center">
                <table cellspacing="0" cellpadding="0" border="0" id="randomnumbers">
				<script>
				var numArray;
				numArray=new Array(0,1,2,3,4,5,6,7,8,9);
				var tempnumArray=new Array();
				var numcount=numArray.length;
				var numChar="";
				for (i=0;i<numcount;i++){
					var now = new Date();
					var secs = now.getSeconds();
					rnd = Math.random(secs);
					rnd = Math.round(rnd * (numArray.length));
					if (rnd == numArray.length){rnd = 0}
					tempnumArray[i]=numArray[rnd];
					numChar+=tempnumArray[i]+", "
					removenumChar(rnd);
				}

				numArray=tempnumArray;

				function removenumChar(id){
					var temp=new Array();
					for (j=0;j<numArray.length;j++){
						if(id!=j){
							temp[temp.length]=numArray[j];
						}
					}
					numArray=temp;
				}
				
				document.getElementById("randomnumbers").innerHTML ='<tr><td><input type="button" class="keysc" onclick="writePwd('+numArray[0]+')" value="'+numArray[0]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[1]+')" value="'+numArray[1]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[2]+')" value="'+numArray[2]+'"/></td></tr><tr><td><input type="button" class="keysc" onclick="writePwd('+numArray[3]+')" value="'+numArray[3]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[4]+')" value="'+numArray[4]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[5]+')" value="'+numArray[5]+'"/></td></tr><tr><td><input type="button" class="keysc" onclick="writePwd('+numArray[6]+')" value="'+numArray[6]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[7]+')" value="'+numArray[7]+'"/></td><td><input type="button" class="keysc" onclick="writePwd('+numArray[8]+')" value="'+numArray[8]+'"/></td></tr><tr><td><td><input type="button" class="keysc" onclick="writePwd('+numArray[9]+')" value="'+numArray[9]+'" /></td><td></td></tr>';

				</script>
		</table>
		<table width="100%">
	        <tr>
	        	<td><a href="#" onclick="javascript: backSpacer();" class="btnc">&larr; Backsp</a></td><td><a href="#" class="btnc done" >	&#8629; Done</a></td>
	        </tr>
        </table>
	</td>
    </tr>
		
</table>
<%--</div>--%>



</div>
</div>
