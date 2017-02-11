<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<#-- 即使在地址栏重复回车，也不访问缓存 -->
		<#-- 考虑到集中式部署的场景特殊性，必须确保登录页经过后端控制器，所以一定要避开缓存 -->
		<meta http-equiv="expires" content="0">
		<title>资产监管平台</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/main.css" />
		<link rel="shortcut icon" href="${request.contextPath}/static/image/favicon.ico" />
		<style>
			body{background-image: url(${request.contextPath}/static/image/bg.jpg);background-position: center;background-size: cover; position: relative;}
		</style>
	</head>

	<body>
		<div class="login_wapper">
			<div class="login_header">
				<h2>资产监管平台</h2>
			</div>
			<div class="login_item">
				<div class="login_tips_wapper">
					<div class="login_tips"></div>
				</div>
			 	<form class="login_form">
					<table class="login_table">
						<tr>
							<td class="login_username">
								<input name="zhanghm" type="text" autocomplete="off" maxlength="26" />
								<span></span>
							</td>
						</tr>
						<tr>
							<td class="login_pwd">
								<input name="psw" type="password" autocomplete="off" maxlength="24" />
								<span></span>
							</td>
						</tr>
						<tr>
							<td class="login_yzm">
								<input class="yanzhengma" name="inputKey" type="text" maxlength="4" />
								<span><img id="captchaImg" src="${request.contextPath}/captcha.jpg" style="width: 120px; height: 40px; margin-left: 200px" /></span>
							</td>
						</tr>
						<tr>
							<td><button class="login_button" id="submitBtn">用户登录</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<div class="login_footer">
			<div class="login_footer_info">
				<div class="login_footer_l fl">上海市徐汇区钦州路100号</div>
				<div class="login_footer_c">
					<span>上海哲凌科技有限公司</span><br />
					<span>${version}</span>
				</div>
				<div class="login_footer_r fr">电话：021-61138827</div>
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script>

			$(function() {
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
												var width = data.length * 14 +20;
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

				// 输入框获取和失去焦点样式
				$("input").focus(function(){
					$(this).css("border-color", "#2f88f3");
				}).blur(function(){
					$(this).css("border-color", "#ccc");
				});
			});

		</script>
	</body>
</html>