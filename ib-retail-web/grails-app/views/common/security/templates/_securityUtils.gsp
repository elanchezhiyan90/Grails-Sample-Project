<g:set var="keySize" value="${grailsApplication.config.security.aes.keySize}" />
<g:set var="iterations" value="${grailsApplication.config.security.aes.iterations}" />
<g:set var="salt" value="${grailsApplication.config.security.aes.salt}" />
<g:set var="iv" value="${grailsApplication.config.security.aes.iv}" />
<g:set var="passPhrase" value="${grailsApplication.config.security.aes.passPhrase}" />

<script>
function encrypt(plainText)
{
	var secKeySize  = '${keySize}';
	var secIterations  = ${iterations};
	var secSalt  = '${salt}';
	var secIV  = '${iv}';
	var secPassPhrase  = '${passPhrase}';
	var cipher = encryptData(plainText,secKeySize,secIterations,secSalt,secIV,secPassPhrase);
	return cipher;
}
	
</script>