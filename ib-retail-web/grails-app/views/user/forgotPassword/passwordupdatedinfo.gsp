
<head>
<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">Logo</a></h1></div>
</header>
	<div class="content">
		<!-- applicatin content section starts here-->
		<div class="content-wrap">
			<section class="app-section">
				<div>
					<p><b>
	  	  				Dear Customer <br/><br/>		
          					Congratulations! Your password has been changed Successfully for Punjab and Maharashtra Co-Operative Bank Internet Retail Banking Application. We promise you a best in class, refreshing net banking experience<br/><br/>
          					<g:link controller="tenant">${message(code:'user.templates.content.clickhere.text') }</g:link> to login into the application for a new improved Experience using <br/>
		  					<br/>
		  					Looking forward to serve you.
		  					<br/>
		  					Regards,
		  					<br/>
		  					Net Banking Team
		  					<br/><br/>
		  				<br/><br/>
		  				
			    </b></p>
			    </div>
			   </section>
		</div>
	</div>
	 <g:render template="/user/templates/footer"/>
</body>
