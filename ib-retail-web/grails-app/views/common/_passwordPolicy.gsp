<%--<g:set var="pwdpolicy" value="${ppc}"></g:set>--%>

<%--<ul>--%>
<%--  <li> First letter of new password  should be :${ppc?.firstCharacterValue?.firstCharacterValue} </li>--%>
<%--  <li> Password Disallowed Characters : ${ppc?.disallowedCharacters} </li>--%>
<%--  <li> Force Change password :${ppc?.forceChangePasscodeDays} </li>--%>
<%--  <li> No of wrong enters allowed: ${ppc?.lockAferNWrongPasscode} </li>--%>
<%--  <li> Login and Transaction password same :${ppc?.loginAndTxnSamePasscode}</li>--%>
<%--  <li> Password Lowercase Mandatory : ${ppc?.lowercaseMandatory}</li>--%>
<%--  <li> Password Maximum Length :${ppc?.maximumLength} </li>--%>
<%--  <li> Password Minimum Length: ${ppc?.minimumLength} </li>--%>
<%--  <li> Password Numerals Mandatory:${ppc?.numeralsMandatory}</li>--%>
<%--  <li> Password History Count : ${ppc?.passcodeHistoryCount}</li>--%>
<%--  <li> Password ReminderDays  :${ppc?.passcodeReminderDays} </li>--%>
<%--  <li> Password Change Frequency :${ppc?.passwordChangeFrequency} </li>--%>
<%--  <li> Repeating Value Allowed in :${ppc?.repeatingValueAllowedInPwd}</li>--%>
<%--  <li> Special Character Mandatory :${ppc?.specialCharactersMandatory}</li>--%>
<%--  <li> Password Uppercase Mandatory:${ppc?.uppercaseMandatory}</li>--%>
<%-- --%>
<%--</ul>--%>
<ul>
<li>1. First letter of new password  should be small (lower case)</li>
<li>2. New password should contain one small letter(lower case), one CAPITAL letter (Upper case), one numeric character (1,2,3 etc.) and one Special Character (!,@,#,$,%,^,&,*)</li>
<li>3. Minimum length of the password is 6 and maximum is 12</li>
<li>4. Last two password s should not be repeated</li>
<li>5. Login and transaction password should not be same</li>
</ul>
