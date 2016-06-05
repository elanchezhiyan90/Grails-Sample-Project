<form name="giftForm">
 <div class="fields">    
  <tr>
    <td><input type="checkbox" name="msgFacebook" id="msgFacebook" value="Facebook" class="facebook" />&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../themes/default_theme/img/gifts/facebook_icon.gif" width="15" height="15" style="margin-top:-5px;"  /></td>
    <td><input type="checkbox" name="msgEmail" id="msgEmail" value="Email" />&nbsp;<img src="../../themes/default_theme/img/gifts/mail_icon.png" width="15" height="15"  style="margin-top:-5px;" /></td>	
  </tr>
</div>  
<div class="fields">
		<p>
 			<label for="description">${message(code:'dateline.addreminder.description.label') }</label>
			<textarea rows="1" cols="30" title="Enter Remarks" id="description" name="description" required="required" ></textarea>
		</p>						
</div> 
    <div class="buttons">
	<input type="submit" name="submit" value="Send Message" id="submit">&nbsp;&nbsp;<input type="submit" name="cancel" value="Cancel" class="btn_next"></label>
    </div>
</form>


