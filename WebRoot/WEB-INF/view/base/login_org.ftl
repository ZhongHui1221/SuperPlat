<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<#-- 即使在地址栏重复回车，也不访问缓存 -->
		<#-- 考虑到集中式部署的场景特殊性，必须确保登录页经过后端控制器，所以一定要避开缓存 -->
		<meta http-equiv="expires" content="0">
		<title>资产管理系统</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/login_org.css" />
	</head>

	<body class="clearfix">
		<div class="header">
			<div class="container">
				<h1>资产管理信息系统</h1>
				<p>Asset Management Information System</p>
			</div>
		</div>
		<div class="content" id='content'>
			<div class="container">
				<div class="logo_bg"></div>
				<div class="login_form">
					<h2>用户登录</h2>
					<form>
						<div class="user_input">
							<div class="user_img"></div>
							<input name="zhanghm" type="text" placeholder="用户名" maxlength="26" />
						</div>
						<div class="pass_input">
							<div class="pass_img"></div>
							<input name="psw" type="text" placeholder="密　码" maxlength="24" />
						</div>
						<div class="yz_input">
							<div class="yz_img"></div>
							<input class="yzkuang" name="inputKey" type="text" placeholder="验证码" maxlength="4" />
							<div class="image"><img id="captchaImg" src="${request.contextPath}/captcha.jpg" style="width: 90px; height: 40px" /></div>
						</div>
						<div class="mt20">
							<button class="login_btn" id="submitBtn">用户登录</button>
						</div>
					</form>
					<div class="login_tips"></div>
					<a class="regist" href="${request.contextPath}/${code}/register">新用户注册</a>
				</div>
			</div>
		</div>
		<div class="footer">
			<p>版本号:&nbsp;&nbsp;&nbsp;1.0.10.12</p>
			<p>上海哲凌科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;上海市徐汇区钦州路100号&nbsp;&nbsp;&nbsp;&nbsp;电话:&nbsp;&nbsp;021-6113827</p>
			<p>建议您使用IE9+、FireFox、Google Chrome、分辨率1280*800及以上操作本系统，获得更好的用户体验</p>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_org_js.ftl" />
		<script>

			function contentHeight() {
				var $w_height = $(window).height();
				$('#content').height($w_height-210);
			}

			$(window).resize(function() {
				contentHeight();
			});

			$(function() {

				contentHeight();

				// 判断登录页是否是在最外层窗体，若不是则重定向为最外层
				if (top.location != self.location) {
					top.location = "${request.contextPath}/${code}";
				}

				$("#submitBtn").click(function() {
					var b1 = validate(0, "zhanghm", /^.{1,}$/, "请输入用户名");
					if (b1) {
						var b2 = validate(0, "psw", /^.{1,}$/, "请输入密码");
						if (b2) {
							var b3 = validate(0, "inputKey", /^.{1,}$/, "请输入验证码");
							if (b3) {
								var zhanghm = $("input[name='zhanghm']").val();
								var psw = $("input[name='psw']").val();
								var inputKey = $("input[name='inputKey']").val();
								$.post(
									"${request.contextPath}/CoreUser/login",
									{"orgid": "${orgid}", "zhanghm": zhanghm, "psw": psw, "inputKey": inputKey},
									function(data) {
										if (data.length == 69) {
											$(".login_tips").html("");
											location.href = "${request.contextPath}/" + data.split(",")[0] + "Home/index/" + data.split(",")[1] + "/" + data.split(",")[2];
										} else {
											if($(".login_tips").css("display") == "none"){
												var width = data.length * 14 + 20;
												$(".login_tips").html(data).css("margin-left", - width / 2).fadeIn(200).delay(1500).fadeOut(400);
											}
											// 通过生成随机数，避开浏览器读取缓存的行为
											var url = "${request.contextPath}/captcha.jpg?t=" + Math.floor(Math.random() * 100);
											$("#captchaImg").prop("src", url);
										}
									}
								);
							}
						}
					}
					return false;
				});

				$("#captchaImg").click(function() {
					// 通过生成随机数，避开浏览器读取缓存的行为
					var url = "${request.contextPath}/captcha.jpg?t=" + Math.floor(Math.random() * 100);
					$(this).prop("src", url);
				});

			});

		</script>
	</body>
</html>