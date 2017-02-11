<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>个人资料</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/zTree/css/zTreeStyle.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/base.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/register_org.css" />
	</head>

	<body>
		<div class="header">
			个人资料
			<p><a href="${request.contextPath}/${edition}Home/index/${currentUser.currentOrgId}/${currentUser.currentRoleId}">返回</a></p>
		</div>
		<div class="main">
			<form>
				<table class='re-main'>
					<tr>
						<td>真实姓名</td>
						<td><input id="name" name="objname" type="text" value="${personal['OBJNAME']}" /></td>
						<td>*</td>
					</tr>
					<tr>
						<td>手机号</td>
						<td><input id="phone" name="shoujh" type="text" value="${personal['SHOUJH']}" /></td>
						<td>*</td>
					</tr>
					<tr>
						<td>登录账号</td>
						<td><input id="username" name="zhanghm" type="text" value="${personal['ZHANGHM']}" /></td>
						<td>*</td>
					</tr>
					<tr>
						<td>新密码</td>
						<td><input id="psw" name="psw" type="password" onKeyUp="pwStrength(this.value)" onBlur="pwStrength(this.value)" /></td>
						<td>*</td>
					</tr>
					<tr>
						<td>确认密码</td>
						<td><input name="rePsw" type="password" /></td>
						<td>*</td>
					</tr>
					<tr class="po-adjust">
						<td>隶属部门</td><!-- 树形菜单 -->
						<td>
							<div class="re-inp">
								<input id="txt1" name="mngdepids" type="text" readonly onclick="showMenu()" value="${personal['MNGDEPIDS']}" />
								<input id="depts" type="hidden" value="${personal['MNGDEPIDS']}" />
								<a id="menuBtn" class="re-toggle" href="#" return false;"></a>
							</div>
						</td>
						<td>*</td>
					</tr>
					<tr class="po-adjust">
						<td>职责</td><!-- 多选 -->
						<td>
							<div class="re-inp">
								<input id="nameStr" name="roleids" type="text" readonly />
								<input id="roles" type="hidden" value="${personal['ROLEIDS']}" />
								<span class="re-toggle"></span>
								<div class="re-checkbox">
									<ul>
										<#list roleList as obj>
											<li flag = "false"><span></span><span value="${obj.rwid}">${obj.objname}</span></li>
										</#list>
									</ul>
								</div>
							</div>
						</td>
						<td>*</td>
					</tr>
					<tr>
						<td>职级</td><!-- 单选 -->
						<td>
							<select id="zhijid" name="zhijid">
								<option value="0">请选择</option>
								<#list zjList as obj>
									<option value="${obj.rwid}"
										<#if obj.rwid == personal["ZHIJID"]>selected</#if>
									>${obj.objname}</option>
								</#list>
							</select>
						</td>
						<td>*</td>
					</tr>
					<tr>
						<td>是否在编</td>
						<td>
							<p>
								<span <#if personal["SHIFZB"] == "1">class="checked"</#if> value="1"></span>是
								<span <#if personal["SHIFZB"] == "0">class="checked"</#if> value="0" style="margin-left: 25px"></span>否
								<input id="sfzb" type="hidden" value="${personal['SHIFZB']}" />
							</p>
						</td>
					</tr>
					<tr>
						<td>性别</td>
						<td>
							<p>
								<span <#if personal["XINGB"] == "0">class="checked"</#if> value="0"></span>男
								<span <#if personal["XINGB"] == "1">class="checked"</#if> value="1" style="margin-left: 25px"></span>女
								<input id="gender" type="hidden" value="${personal['XINGB']}" />
							</p>
						</td>
					</tr>
					<tr>
						<td>邮箱</td>
						<td><input id="email" name="youx" type="text" value="${personal['YOUX']}" /></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<button class="re-btn" type="button">保　存</button>
						</td>
						<td></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="menuContent" class="menuContent" style="display:none; position: absolute;background :#fff;margin-left:-2px;margin-top:1px;border:1px solid #e3e3e3;border-radius:3px;">
			<ul id="treeDemo" class="ztree" style="margin-top:0; width:290px; height: 200px;overflow:scroll;"></ul>
		</div>

		<#-- 导入用户注册 JS 模版 -->
		<#include "/base/register_org_js.ftl" />
		<script>

			$(function() {
				$.fn.zTree.init($("#treeDemo"), setting, zNodesDael);

				var roleids = "${personal['ROLEIDS']}";
				var namesArr = new Array();
				$(".re-checkbox li").each(function() {
					var nameValue = $(this).children("span:last-child").text();
					var idValue = $(this).children("span:last-child").attr("value");
					if (roleids.indexOf(idValue) > -1) {
						$(this).addClass("checked");
						$(this).attr("flag", "true");
						namesArr.push(nameValue);
					}
				});
				$("#nameStr").val(namesArr);

				$(".re-btn").click(function() {
					if (regCanForm()) {
						// 参数收集
						var name = $("#name").val();
						var phone = $("#phone").val();
						var username = $("#username").val();
						var psw = $("#psw").val();
						var depts = $("#depts").val();
						var roles = $("#roles").val();
						var rank = $("#zhijid").val();
						var sfzb = $("#sfzb").val();
						var gender = $("#gender").val();
						var email = $("#email").val();
						$.post(
							"${request.contextPath}/CoreUser/modify",
							{"_method": "PUT", "objname": name, "shoujh": phone, "zhanghm": username, "psw": psw,
								"mngdepids": depts, "roleids": roles, "zhijid": rank, "shifzb": sfzb, "xingb": gender, "youx": email},
							function(data) {
								if (data == "SUCCESS") {
									location.href = "${request.contextPath}/${edition}Home/index/${currentUser.currentOrgId}/${currentUser.currentRoleId}";
								} else {
									alert(data);
								}
							}
						);
					}
				});
			});

			var zNodes = ${deptTree};
			var zNodesDael = zNodesDataDeal();
			

			function strToArray(string){
				array = string.split(",");
				return array;
			}
			
			function zNodesDataDeal(){
				var array = strToArray("${personal['MNGDEPIDS']}");
				for (var m = 0;m < array.length ; m++){
					for (var i = 0;i<zNodes.length;i++){
						if (zNodes[i].id == array[m]){
							zNodes[i].checked = true;	
						} else {
							if (zNodes[i].children != undefined){
								if (zNodes[i].children[0].id == array[m]){
									zNodes[i].children[0].checked = true;
								}
							}
						}
					}
				}
				return zNodes;	
			}
		</script>
	</body>
</html>