<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
<script src="${request.contextPath}/static/framework/zTree/js/jquery.ztree.core.min.js"></script>
<script src="${request.contextPath}/static/framework/zTree/js/jquery.ztree.excheck.min.js"></script>
<script>
	var setting = {
		check: {
			enable: true,
			chkboxType: { "Y" : "ps", "N" : "ps" }
		},
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onCheck: onCheck
		}
	};

	var zNodes = ${deptTree};

	var flagclick = false;

	$(function(){
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);

		//提示信息
		$("input[name='objname']").blur(function(){
			regIsMatch($(this),'姓名',/[\u4e00-\u9fa5_a-zA-Z_]/,'姓名只能由中文和英文组成');
		});
		$("input[name='shoujh']").blur(function(){
			regIsMatch($(this),'手机号',/^1\d{10}$/,'请填写正确的手机号');
		});
		$("input[name='zhanghm']").blur(function(){
			regIsMatch($(this),'登录账号','','');
		});
		$("input[name='mngdepids']").blur(function(){
			regIsMatch($(this),'隶属部门','','');
		});
		$("input[name='roleids']").blur(function(){
			regIsMatch($(this),'职责','','');
		});
		$("input[name='psw']").focus(function(){//密码
			$(this).parents('td').next().html('*<div class="pwd_strength" id="pwd_strength"><div class=""></div></div>');
		}).blur(function(){
			if ($(this).val() == ''){
				$(this).parents('td').next().html('*<img src="${request.contextPath}/static/image/Artboard 5.png"/><span>'+name+'不能为空</span>');
			} else {
				$(this).parents('td').next().html("*");
			}
		});
		$("input[name='rePsw']").focus(function(){//确认密码
			$(this).parents('td').next().html('*');
		}).blur(function(){
			if ($(this).val() != $("input[name='psw']").val()){
				$(this).parents('td').next().html('*<img src="${request.contextPath}/static/image/Artboard 5.png"/><span>两次输入的密码不一致</span>');
			} else {
				$(this).parents('td').next().html("*");
			}
		});
		$("input[name='youx']").blur(function(){//邮箱
			if ($(this).val() != ''){
				if ( $(this).val() .match(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/)){
					$(this).parents('td').next().html('');
				} else {
					$(this).parents('td').next().html('<img src="${request.contextPath}/static/image/Artboard 5.png"/><span>邮箱格式不正确</span>');
				}
			}
		});

		$('#pwd_strength').parents('tr').css('position','relative').css('top','-20px');//css

		$('.re-main p span').click(function() {
			$(this).addClass('checked').siblings().removeClass('checked');
			var value = $(this).attr('value');
			$(this).parent().children('input').attr('value', value);
		});

		$('#menuBtn').click(function(){
			if (flagclick == false){
				showMenu();
				console.log('true')
			} else {
				hideMenu();
				console.log('false')
			}
		})

		//多选 职责
		$(".re-toggle").click(function(e) {
			$(this).next().toggle();
			stopEvent(e);
		});

		$(".re-checkbox li").click(function() {
			if ($(this).attr("flag") == "true") {
				$(this).removeClass("checked");
				$(this).attr("flag", "false");
			} else {
				$(this).addClass("checked");
				$(this).attr("flag", "true");
			}

			var namesArr = new Array();
			var idsArr = new Array();
			for (i = 0; i < $(".re-checkbox li").length; i++) {
				if ($(".re-checkbox li").eq(i).attr("class") == "checked") {
					var nameValue = $(".re-checkbox li").eq(i).children("span:last-child").text();
					var idValue = $(".re-checkbox li").eq(i).children("span:last-child").attr("value");
					namesArr.push(nameValue);
					idsArr.push(idValue);
				}
			}
			$("#nameStr").val(namesArr);
			$("#roles").val(idsArr);
		});
	});

	//zTree
	function beforeClick(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}

	function onCheck(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getCheckedNodes(true);
		var namesArr = new Array();
		var idsArr = new Array();
		for (var i = 0; i < nodes.length; i++) {
			namesArr.push(nodes[i].name);
			idsArr.push(nodes[i].id);
		}
		$("#txt1").val(namesArr);
		$("#depts").val(idsArr);
	}

	function showMenu() {
		var cityObj = $("#txt1");
		var cityOffset = $("#txt1").offset();
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
		flagclick = true;
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
		flagclick = false;
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "txt1" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}

	function regIsMatch(ele,name,reg,msg){//表单是否为空,是否匹配正则
		if(ele.val() != ''){
			if (ele.val().match(reg)){
				ele.parents('td').next().html("*");
				return true;
			} else {
				ele.parents('td').next().html('*<img src="${request.contextPath}/static/image/Artboard 5.png"><span>'+msg+'</span>');
				return false;
			}
		} else {
			ele.parents('td').next().html('*<img src="${request.contextPath}/static/image/Artboard 5.png"><span>'+name+'不能为空</span>');
			return false;
		}
	}

	function regCanForm() { //注册按钮点击时的判断
		var name = regIsMatch($("input[name='objname']"),'姓名',/[\u4e00-\u9fa5_a-zA-Z_]/,'姓名只能由中文和英文组成'),
			phoneNum = regIsMatch($("input[name='shoujh']"), '手机号',/^1\d{10}$/,'请填写正确的手机号'),
			userAccount = regIsMatch($("input[name='zhanghm']"),'登录账号','',''),
			pwd = regIsMatch($("input[name='psw']"),'密码','',''),
			rePwd = regIsMatch($("input[name='rePsw']"),'确认密码','',''),
			department = regIsMatch($("input[name='mngdepids']"),'隶属部门','',''),
			response = regIsMatch($("input[name='roleids']"),'职责','','');
		return (name && phoneNum && userAccount && pwd && department && response);
	}

	//判断输入密码的类型  
	function CharMode(iN){  
		if (iN>=48 && iN <=57) //数字  
		return 1;  
		if (iN>=65 && iN <=90) //大写  
		return 2;  
		if (iN>=97 && iN <=122) //小写  
		return 4;  
		else  
		return 8;   
	}  
	//bitTotal函数  
	//计算密码模式  
	function bitTotal(num){  
		modes=0;  
		for (i=0;i<4;i++){  
		if (num & 1) modes++;  
		num>>>=1;  
		}  
		return modes;  
	}
	//返回强度级别  
	function checkStrong(sPW){  
		if (sPW.length<=4)  
		return 0; //密码太短  
		Modes=0;  
		for (i=0;i<sPW.length;i++){  //密码模式  
			Modes|=CharMode(sPW.charCodeAt(i));  
		}  
		return bitTotal(Modes);  
	}  

	//显示颜色  
	function pwStrength(pwd){  
		if (pwd==null||pwd==''){  
			$('#pwd_strength div').removeAttr('class');
		}  
		else{  
			S_level=checkStrong(pwd);
			switch(S_level) {  
				case 0:  
					$('#pwd_strength div').removeAttr('class');
				case 1:  
					$('#pwd_strength div').prop('class','strength_L');
					break;  
				case 2: 
					$('#pwd_strength div').prop('class','strength_M'); 
					break;  
				default:$('#pwd_strength div').prop('class','strength_S'); 
			}  
		} 
		return;  
	}

	function stopEvent(event){ //阻止冒泡事件
		var e=arguments.callee.caller.arguments[0]||event;
		if (e && e.stopPropagation) {
			e.stopPropagation();
		} else if (window.event) {
			window.event.cancelBubble = true;
		}
	}
</script>