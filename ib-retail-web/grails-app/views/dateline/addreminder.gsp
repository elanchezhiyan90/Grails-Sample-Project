<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
<title>Add Reminder</title>
</head>
<body>
<div class="remi_panel">
<!--------------Benefeciary Starts here--------------------->
 <form>
<div id="less" style="display:visible;">
  <table width="100%" border="0" class="remi_grid" id="blockLess" cellspacing="10">
    <tbody>
      <tr>
        <td width="10%"><textarea rows="1" cols="30" title="Enter Remarks" id="desc1" required="required" ></textarea></td>
        <td width="5%"><input type="date" name="startDate" id="startDate" /></td>
        <td width="5%"><input type="button" name="More" value="More" id="More" class="btn_next" /></td>
        <td width="5%"><input type="button" name="Add" value="Add" id="Add" class="btn_next" /> </td>
     </tr>
    </tbody>
  </table>
</div>

<div id="more" style="display:none;">
  <table width="100%" border="0" class="remi_grid" id="blockMore" cellspacing="10">
    <tbody>
      <tr>
        <td width="5%"><input type="text" value="" title="Enter Beneficiary Name" name="bene_name" id="bene_name" class="name" /></td>
        <td width="15%"> <input type="number" step="any" name="amount" id="amount" class="s_amt" min="1" required="required" /> </td>
      </tr>
    </tbody>
  </table>
</div>      
     
  </form>
</div>
<br />
<div id="titleReminder">
  <h2><br />Previous Reminders<br /><br /></span></h2>
</div>
<section>                
        <form>
       		 <!-- Sticky header starts here ----------->
                <div class="start-stick_top"></div>
                   <div class="grid_stickyhead_top">
                  <table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
                    <thead>
                      <tr>
                        <th width="15%">Date</th>
                        <th width="20%">Remarks</th>
                        <th width="25%">Bene. Name</th>
                        <th width="15%">Amount</th>
                        <th width="10%">Done</th>
                        <th width="15%">Remove</th>
                      </tr>
                    </thead>
                 </table>
       	  </div>
                    <!-- Sticky header ends here ----------->  
          <!-- Add Transaction Type -->
 <table width="100%" border="0" class="grid" id="">

    <tbody>
      <tr >
        <td width="15%"></td>
        <td width="20%"></td>
        <td width="25%"></td>
        <td width="15%"></td>
        <td width="10%"></td>
        <td width="15%"></td>
      </tr>
      <tr >
        <td width="15%">17-11-2012</td>
        <td width="20%">Pay Tracy</td>
        <td width="25%">Tracy Scott</td>
        <td width="15%">299.00</td>
        <td width="10%"><input type="checkbox"  class="tabledata" id="chk1"></td>
        <td width="15%"><a  href="#" class="remove" id="">-</a></td>
      </tr>
      <tr>
        <td>17-11-2012</td>
        <td>John's Birthday</td>
        <td>John Greig</td>
        <td></td>
        <td><input type="checkbox"  class="tabledata" id="chk2"></td>
        <td><a  href="#" class="remove" id="">-</a></td>
      </tr>
      <tr>
        <td>15-11-2012</td>
        <td><span id="updateBeneDesc">Pay Airtel Broadband</span></td>
        <td><span id="updateBeneName">Airtel Broadband</span></td>
        <td>350.00</td>
        <td><input type="checkbox" class="tabledata" id="chk3"></td>
        <td><a  href="#" class="remove" id="">-</a></td>
      </tr>
     </tbody>
  </table>
   <br />

    </form>	
<br />
<div class="buttons">
<input type="button" id="saveUser" value="Save" name="saveUser" onClick="$.fn.ceebox.closebox();" >
<input type="button" id="saveUser" value="Close" name="saveUser" onClick="$.fn.ceebox.closebox();"  class="btn_next">
</div>

</section>

<script>

$(document).ready(function(){

		$('input[title!=""]').hint();
		
		$('textarea').hint();		
		
		$("form").updatePolyfill();//update polyfill on after ajax load.	
		
		$(".grid tr .remove").click(function(event){
			event.preventDefault();
			var remSegment=$(this).parents("tr");
			remSegment.fadeOut(500, function(){remSegment.remove();});
			});

		 $('#go').click(function () {
				
			$("#more").show();
			$("#blockLess").hide();	
			return false;
         });			
			

</script>			    		
</body>

