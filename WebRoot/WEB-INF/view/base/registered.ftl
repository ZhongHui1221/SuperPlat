<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <title>注册成功</title>
	    <style>
	        .main {
				width: 385px;
				margin: 0 auto;
				padding-top: 15%;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
				box-sizing: border-box;
			}
			.main h1 {
				text-align: right;
				font-size: 20px;
				color: #277fd0;
				letter-spacing: 4px;
				position: relative;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
				box-sizing: border-box;
			}
			.main h1 img {
				position: absolute;
				top: -8px;
				left: -8px;
			}
			.main a {
				width: 250px;
				height: 42px;
				display: inline-block;
				margin-top: 36px;
				border-radius: 4px;
				color: #fff;
				font: 18px/40px 'microsoft yahei';
				font-weight: bold;
				letter-spacing: 3px;
				text-align: center;
				text-decoration: none;
				border: none;
				outline: none;
				background: #277fdd;
			}
	    </style>
	</head>

	<body>
		<div class="main">
			<h1><img src="${request.contextPath}/static/image/success42.png">注册成功，请等待管理员审核！</h1>
			<center><a class="re-btn" href="${request.contextPath}/${code}">返回登录页面</a></center>
		</div>
	</body>
</html>