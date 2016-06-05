     <form  method="post">
    	<div class="fields">
			<p>
			<label for="date">${message(code:'dateline.templates.alarm.alerton.label')}</label>
			<input type="date" name="a_date" id="a_date" required="required" min="${new Date().format('yyyy-MM-dd')}"/>
 			</p>
		</div>
    	<div class="fields">
			<p>
			<label for="time">${message(code:'dateline.templates.alarm.alertat.label')}</label>
			<input type="text" name="time" id="time" class="timepicker"  required="required"/>
 			</p>
		</div>
        <div class="fields">
			<p>
      		<label for="from_account">${message(code:'dateline.templates.alarm.youraccount.label')}</label>
     		<select  name="from_account" id="from_account" required>
                <option>${message(code:'dateline.templates.alarm.sms.message')}</option>
                <option>${message(code:'dateline.templates.alarm.email.message')}</option>
                </select>
  			</p>
        </div>
        <div class="buttons" >
			<input type="button" name="" value="${message(code:'dateline.templates.alarm.button.setalarm.text')}" id="setalarm" />
			<input type="button" name="" value="${message(code:'dateline.templates.alarm.button.cancel.text')}" id="cancel" class="btn_next cee_close" />
		</div>
        </form>
<script>

$(document).ready(function () {
		
	$('.timepicker').timepicker({ampm: true});
	if(!Modernizr.touch){
		$( "select" ).combobox();
		$("form").updatePolyfill();//update polyfill on after ajax load.
	}
		
});
</script>
