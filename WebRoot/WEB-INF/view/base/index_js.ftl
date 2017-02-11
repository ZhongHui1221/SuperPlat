<script src="${request.contextPath}/static/js/jquery-1.9.0.min.js"></script>
<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/ligerui.all.js"></script>
<script src="${request.contextPath}/static/js/jquery-ui-1.10.4.min.js"></script>
<script src="${request.contextPath}/static/js/jquery.mousewheel.js"></script>
<script src="${request.contextPath}/static/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script>

	/* 首页框架配置js */
	var tab = null;
	var accordion = null;
	var tree = null;
	var tabItems = [];

	$(function() {

		// 布局
		$("#layout1").ligerLayout({
			leftWidth: 240,
			height: '100%',
			heightDiff: -1,
			space: 0,
			//allowLeftResize: false,
			onHeightChanged: f_heightChanged,
			onLeftToggle: function() {
				tab && tab.trigger('sysWidthChange');
			},
			onRightToggle: function() {
				tab && tab.trigger('sysWidthChange');
			}
		});
		var height = $(".l-layout-center").height();

		// 页签
		tab = $("#framecenter").ligerTab({
			height: height,
			showSwitchInTab: true,
			showSwitch: true,
			contextmenu: false,
			onAfterAddTabItem: function(tabdata) {
				tabItems.push(tabdata);
				//saveTabStatus();
				// 将新增页签的 tree_id 属性变更为所选树节点的 id
				var tree_id = $("#tree1").find(".l-selected").parent().attr("id");
				$(".l-tab-links").find(".l-selected").attr("tree_id", tree_id);
			},
			onAfterRemoveTabItem: function(tabid) {
				for (var i = 0; i < tabItems.length; i++) {
					var o = tabItems[i];
					if (o.tabid == tabid) {
						tabItems.splice(i, 1);
						//saveTabStatus();
						break;
					}
				}
			},
			onReload: function(tabdata) {
				var tabid = tabdata.tabid;
				addFrameSkinLink(tabid);
			}
		});

		// 面板
		$("#accordion1").ligerAccordion({
			height: height - 1, speed: null
		});

		$(".l-link").hover(function() {
			$(this).addClass("l-link-over");
		}, function() {
			$(this).removeClass("l-link-over");
		});

		// 树形菜单
		$("#tree1").ligerTree({
			url: "${request.contextPath}/supHome/orgTree",
			// data: indexdata,
			checkbox: false,
			slide: true,
			nodeWidth: 220,
			parentIcon: null,
			childIcon: null,
			render: function(a) {
				if (!a.isnew) return a.text;
				return '<a href="' + a.url + '" target="_blank">' + a.text + '</a>';
			},
			onSelect: function(node) {
				$.post(
					"${request.contextPath}/supHome/switchOrg",
					{"orgidStr": node.data.id},
					function(data) {
						if (data == "SUCCESS") {
							// 获取当前选中页签的 tabid
							var tabid = $("li[class='l-selected']").attr("tabid");
							// 获取当前显示的 iframe
							var $iframe = $("iframe[id='" + tabid + "']");
							// 获取 iframe 的 src 地址
							var $src = $iframe.prop("src");
							// 能够标识平台首页的 URL 内容
							var homeMainPath = "${request.contextPath}/supHome/main";
							// 页面加载动画
							$iframe.prev(".l-tab-loading").show();
							// 如果当前选中的页签为平台首页
							if ($src.indexOf(homeMainPath) > 0) {
								$iframe.prop("src", homeMainPath);
							} else {
								// 表单提交方式刷新（$iframe 的同级表单，其 id 必须与 tabid 一致）
								var $form = $("form[id='" + tabid + "']");
								if ($form.length > 0) {
									$form.submit();
									/*
									// 页签内容加载完成后隐藏遮罩动画
									$iframe.load(function() {
										$iframe.prev(".l-tab-loading").hide();
									});
									*/
								} else {
									// 表单提交方式刷新（$iframe 的下级表单，其 id 必须与 tabid 一致）
									$form = $iframe.contents().find("form[id='" + tabid + "']");
									if ($form.length > 0) {
										$form.submit();
									} else {
										// iframe 自刷新
										$iframe.prop("src", $src);
									}
								}
							}
						}
					}
				);
				// 将当前页签的 tree_id 属性变更为所选树节点的 id
				$(".l-tab-links").find(".l-selected").attr("tree_id", node.data.id);
			},
			onSuccess: function() {
				// 刷新页面仍保留菜单的选中样式
				var currentOrgid = "${currentUser.currentOrgId}";
				var $currentOrg = $("#" + currentOrgid);
				$currentOrg.children(".l-body").addClass("l-selected");
				//点击浏览器刷新按钮时home页签赋值页签tree_id信息
				var node_defaultid = $("#tree1").find(".l-selected").parent().attr("id");
				$(".l-tab-links li").first().attr("tree_id",node_defaultid);
			}
		});

		tab = liger.get("framecenter");
		accordion = liger.get("accordion1");
		tree = liger.get("tree1");
		$("#pageloading").hide();

		css_init();
		//pages_init();

	});

	function f_heightChanged(options){
		if (tab)
			tab.addHeight(options.diff);
		if (accordion && options.middleHeight - 24 > 0)
			accordion.setHeight(options.middleHeight - 24);
	}

	function f_addTab(tabid, text, url){
		tab.addTabItem({
			tabid: tabid,
			text: text,
			url: url,
			callback: function ()
			{
				addFrameSkinLink(tabid);
			}
		});
	}

	function addShowCodeBtn(tabid){
		var viewSourceBtn = $('<a class="viewsourcelink" href="javascript:void(0)">查看源码</a>');
		var jiframe = $("#" + tabid);
		viewSourceBtn.insertBefore(jiframe);
		viewSourceBtn.click(function ()
		{
			showCodeView(jiframe.attr("src"));
		}).hover(function ()
		{
			viewSourceBtn.addClass("viewsourcelink-over");
		}, function ()
		{
			viewSourceBtn.removeClass("viewsourcelink-over");
		});
	}

	function addFrameSkinLink(tabid){
		var prevHref = getLinkPrevHref(tabid) || "";
		var skin = getQueryString("skin");
		if (!skin) return;
		skin = skin.toLowerCase();
		attachLinkToFrame(tabid, prevHref + skin_links[skin]);
	}

	var skin_links = {
		"aqua": "lib/ligerUI/skins/Aqua/css/ligerui-all.css",
		"gray": "lib/ligerUI/skins/Gray/css/all.css",
		"silvery": "lib/ligerUI/skins/Silvery/css/style.css",
		"gray2014": "lib/ligerUI/skins/gray2014/css/all.css"
	};

	/*
	function pages_init() {
		var tabJson = $.cookie("liger-home-tab");
		if (tabJson) {
			var tabitems = JSON2.parse(tabJson);
			for (var i = 0; tabitems && tabitems[i]; i++) {
				f_addTab(tabitems[i].tabid, tabitems[i].text, tabitems[i].url);
			}
		}
	}
	*/

	/*
	function saveTabStatus() {
		$.cookie("liger-home-tab", JSON2.stringify(tabItems));
	}
	*/

	function css_init()
	{
	    var css = $("#mylink").get(0), skin = getQueryString("skin");
	    $("#skinSelect").val(skin);
	    $("#skinSelect").change(function ()
	    {
	        if (this.value)
	        {
	            location.href = "index.htm?skin=" + this.value;
	        } else
	        {
	            location.href = "index.htm";
	        }
	    });
	    if (!css || !skin) return;
	    skin = skin.toLowerCase();
	    $('body').addClass("body-" + skin);
	    $(css).attr("href", skin_links[skin]);
	}

	function getQueryString(name){
	    var now_url = document.location.search.slice(1), q_array = now_url.split('&');
	    for (var i = 0; i < q_array.length; i++)
	    {
	        var v_array = q_array[i].split('=');
	        if (v_array[0] == name)
	        {
	            return v_array[1];
	        }
	    }
	    return false;
	}

	function attachLinkToFrame(iframeId, filename){
	    if(!window.frames[iframeId]) return;
	    var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
	    var fileref = window.frames[iframeId].document.createElement("link");
	    if (!fileref) return;
	    fileref.setAttribute("rel", "stylesheet");
	    fileref.setAttribute("type", "text/css");
	    fileref.setAttribute("href", filename);
	    head.appendChild(fileref);
	}

	function getLinkPrevHref(iframeId){
	    if (!window.frames[iframeId]) return;
	    var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
	    var links = $("link:first", head);
	    for (var i = 0; links[i]; i++)
	    {
	        var href = $(links[i]).attr("href");
	        if (href && href.toLowerCase().indexOf("ligerui") > 0)
	        {
	            return href.substring(0, href.toLowerCase().indexOf("lib") );
	        }
	    }
	}

	/* 首页功能js */
	$(function(){

		// 判断浏览器版本是否为IE8，修复IE8首页无loading
		if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
			$("#home").before('<div class="l-tab-loading" style="display: none;"></div>');
		}

		// 对主流浏览器(IE10及以上)做禁用浏览器后退按钮操作
		if(window.history && window.history.pushState){
			history.pushState(null, null, document.URL);
				window.addEventListener('popstate', function () {
					history.pushState(null, null, document.URL);
			});
		}

		// 不为 iframe 指定初始的 src（可解决重复发送请求的问题），待父页面的 DOM 结构渲染完成时再加载内页
		$("#home").prop("src", "${request.contextPath}/supHome/main");

		// 自定义滚动条
		$("#tree_left").mCustomScrollbar({
			scrollButtons: {
				enable: false,
				scrollType: "continuous",
				scrollSpeed: 20,
				scrollAmount: 40
			},
			horizontalScroll: false,
			scrollInertia: 600,
			autoHideScrollbar: true
		});

		//导航栏二级菜单显示隐藏
		$(".topmenu-home-g,.topmenu-home-c,.topmenu-home-j").mouseenter(function(){
			$(this).children(".topmenu-list").show();
		}).mouseleave(function(){
			$(this).children(".topmenu-list").hide();
		})
		$(".topmenu_list_card").click(function(){
			$(this).parents(".topmenu-list").hide();
		});
		//二级菜单选项卡切换
		$(".topmenu_list_header .topmenu_list_zcpt").click(function(){
			$(this).addClass("active").siblings(".topmenu_list_zcpt").removeClass("active");
			$(".topmenu_list_wapper .topmenu_list_card").eq($(this).index()).addClass("active").siblings(".topmenu_list_card").removeClass("active");
		})

		//重新登录切换
		$(".system_mag").click(function(){
			$(".system_mag b").hide();
			$(".system_mag_item").slideToggle(100);
		});
		//重新登录提示框显示隐藏
		$(".system_mag").mouseenter(function(){
			if($(".system_mag_item").css("display") == "none"){
				$(this).find("b").show();
			}
		}).mouseleave(function(){
			$(this).find("b").hide();
		})

		//角色切换
		$(".user_info_position_select").click(function(){
			var $show = $(".user_info_switch").attr("show");
			if($show == "hide"){
				$(".user_info_position").addClass("active");
				$(".sanjx").addClass("active");
				$(".user_info_switch").attr("show","show");
			}else{
				$(".sanjx").removeClass("active");
				$(".user_info_switch").attr("show","hide");
			}
		});

		//树形菜单鼠标悬浮显示文字
		$("#tree1").on("mouseenter","span",function(){
			var span = $(this);
			var pos = span.offset();
			if(pos.left + span.width() > $("#tree_left").width()){
				span.attr("title",span.html());
			}
		});

		//树形菜单搜索
		$(".search_tree i").click(function(){
			var search_text = $(".search_tree input").val();
			if(search_text && search_text != "请输入名称进行查找"){
				//遍历树列表
				var $tree_list = $("#tree_left span");
				var controller = true;
				var match_controll = true;
				$tree_list.each(function(i){
					var $match_html = $(this).html();
					if($match_html.search(search_text) != -1){
						controller = false;
						if($(this).attr("searched") == null){
							match_controll = false;
							$(this).attr("searched",true).parent(".l-body").addClass("l-over");
							//滚动条滚动
							var height = $(this).offset().top - $(window).height() + 20;
							if(height > 0){
								var es_top = $("#tree_left").scrollTop();
								//$("#tree_left").scrollTop(height + es_top + 30);
								 $("#tree_left").mCustomScrollbar("scrollTo",$(this))
							}
							return false;
						}else{//已经选到
							$(this).parent(".l-body").removeClass("l-over");
						}
					}
				})
				if(match_controll){
					$tree_list.removeAttr("searched");
					$("#tree_left").mCustomScrollbar("scrollTo","top");
				}
				if(controller){
					$("#search_tip").html("查不到该信息！").fadeIn(200).delay(1000).fadeOut(400);
				}
			}else{
				$("#search_tip").html("请输入搜索内容！").fadeIn(200).delay(1000).fadeOut(400);
			}
		});

		//树形菜单搜索框提示
		$(".search_tree input").focus(function(){
			if($(this).val() == "请输入名称进行查找"){
				$(this).val("");
			}
		}).blur(function(){
			if(!$(this).val()){
				$(this).val("请输入名称进行查找");
			}
		})

		//tree高度动态调整
		var height = $("#layout1").height();
		$("#tree_left").height(height - 61);
		window.onresize = function(){
			var height = $("#layout1").height();
			$("#accordion1").height(height);
			$("#tree_left").height(height - 61);
		}

		/* 页签相关 - BEGIN */
		// 显示隐藏
		$(".l-tab-links").on("mouseenter","li",function(){
			if($(this).hasClass("l-selected")){
				$(this).children(".l-tab-links-item-reload").show();
			}
		}).on("mouseleave","li",function(){
			$(this).children(".l-tab-links-item-reload").hide();
		})

		// 点击刷新
		$(".l-tab-links").on("click", ".l-tab-links-item-reload", function() {
			// 获取当前选中页签的 tabid
			var tabid = tab.getSelectedTabItemID();
			// 获取当前显示的 iframe
			var $iframe = $("iframe[id='" + tabid + "']");
			// 页面加载动画
			$iframe.prev(".l-tab-loading").show();
			// 表单提交方式刷新（$iframe 的同级表单，其 id 必须与 tabid 一致）
			var $form = $("form[id='" + tabid + "']");
			if ($form.length > 0) {
				$form.submit();
			} else {
				// 表单提交方式刷新（$iframe 的下级表单，其 id 必须与 tabid 一致）
				$form = $iframe.contents().find("form[id='" + tabid + "']");
				if ($form.length > 0) {
					$form.submit();
				} else {
					// 调用 LigerUI API 实现刷新
					tab.reload(tabid);
				}
			}
		});

		// 关闭全部
		$("body").on("click", ".close_all", function() {
			tab.removeAll();
			$(".l-tab-windowsswitch").remove();
		});

		// 关闭其他标签
		$("body").on("click", ".close_others", function() {
			var tabid = tab.getSelectedTabItemID();
			tab.removeOther(tabid);
			$(".l-tab-windowsswitch").remove();
		});

		// 切换刷新
		$(".l-tab-links").on("click", "li", function() {
			if ($(this).hasClass("l-tab-itemswitch")) {
				return;
			} else {
				// 获取当前选中页签的 tree_id
				var tree_id = $(this).attr("tree_id");
				// 获取当前选中单位的 id
				var node_id = $("#tree1").find(".l-selected").parent().attr("id");
				// 当两者的内容不一致时，执行刷新操作
				if (tree_id == node_id) {
					return;
				} else {
					// 获取当前选中页签的 tabid
					var tabid = tab.getSelectedTabItemID();
					// 获取当前显示的 iframe
					var $iframe = $("iframe[id='" + tabid + "']");
					// 页面加载动画
					$iframe.prev(".l-tab-loading").show();
					// 表单提交方式刷新（$iframe 的同级表单，其 id 必须与 tabid 一致）
					var $form = $("form[id='" + tabid + "']");
					if ($form.length > 0) {
						$form.submit();
					} else {
						// 表单提交方式刷新（$iframe 的下级表单，其 id 必须与 tabid 一致）
						$form = $iframe.contents().find("form[id='" + tabid + "']");
						if ($form.length > 0) {
							$form.submit();
						} else {
							// 调用 LigerUI API 实现刷新
							tab.reload(tabid);
						}
					}
					$(this).attr("tree_id",node_id);
				}
			}
		});
		//点击首页home键切换到首页页签，并根据左侧单位树判断是否刷新
		$(".topmenu-home-h").click(function(){
			tab.selectTabItem("home");
			var tree_id = $(".l-tab-links li").first().attr("tree_id");
			var node_id = $("#tree1").find(".l-selected").parent().attr("id");
			if (tree_id == node_id) {
					return;
			} else {
				var tabid = "home";
				var $iframe = $("iframe[id='" + tabid + "']");
				$iframe.prev(".l-tab-loading").show();
				// 表单提交方式刷新（$iframe 的同级表单，其 id 必须与 tabid 一致）
				var $form = $("form[id='" + tabid + "']");
				if ($form.length > 0) {
					$form.submit();
				} else {
					// 表单提交方式刷新（$iframe 的下级表单，其 id 必须与 tabid 一致）
					$form = $iframe.contents().find("form[id='" + tabid + "']");
					if ($form.length > 0) {
						$form.submit();
					} else {
						// 调用 LigerUI API 实现刷新
						tab.reload(tabid);
					}
				}
				$(".l-tab-links li").first().attr("tree_id",node_id);
			}
		})
		/* 页签相关 - END */

		//全屏功能
		$(".header_qpxs").click(function(){
			if($(this).attr("allscreen") == "not"){
				$(this).attr("allscreen","yes").css({"background-position":"0px -234px"}).children("b").html("退出全屏");
				requestFullScreen(document.documentElement);
			}else if($(this).attr("allscreen") == "yes"){
				$(this).attr("allscreen","not").css({"background-position":"0px -195px"}).children("b").html("全屏显示");
				exitFull();
			}
		})
		//关于我们点击显示隐藏
		$(".about").click(function(){
			if($(".zl_about").css("display") == "none"){
				$(".zl_about").show().animate({"top":"27%","opacity":"1"});
				$(".page_cover").fadeIn(100);
			}
		})
		$(".zl_about_close,.page_cover,.zl_bottom_close").click(function(){
			if($(".zl_about").css("display") == "block"){
				$(".zl_about").animate({"top":"10%","opacity":"0"},200,function(){
					$(this).hide();
				})
			}else if($(".card_module").css("display") == "block"){
				$(".card_module").animate({"margin-top":"-400px","opacity":"0"},200,function(){
					$(".card_module_content").removeClass("card_module_content_bg");
					$(this).removeClass("card_module_bg").hide();
					$("#card_module").attr("src","");
				})
			}
			$(".page_cover").fadeOut(300);
		})

	})

	//全屏和退出全屏
	function requestFullScreen(element) {
		// 判断各种浏览器，找到正确的方法
		var requestMethod = element.requestFullScreen || //W3C
		element.webkitRequestFullScreen ||  //Chrome等
		element.mozRequestFullScreen || //FireFox
		element.msRequestFullScreen; //IE11
		if (requestMethod) {
			requestMethod.call(element);
		}
		else if (typeof window.ActiveXObject !== "undefined") {//for Internet Explorer
			var wscript = new ActiveXObject("WScript.Shell");
			if (wscript !== null) {
		wscript.SendKeys("{F11}");
			}
		}
	}
	function exitFull() {
		// 判断各种浏览器，找到正确的方法
		var exitMethod = document.exitFullscreen || //W3C
		document.mozCancelFullScreen ||  //Chrome等
		document.webkitExitFullscreen || //FireFox
		document.webkitExitFullscreen; //IE11
		if (exitMethod) {
			exitMethod.call(document);
		}
		else if (typeof window.ActiveXObject !== "undefined") {//for Internet Explorer
			var wscript = new ActiveXObject("WScript.Shell");
			if (wscript !== null) {
			wscript.SendKeys("{F11}");
			}
		}
	}

	//卡片弹出
	function alertCard(params){
		var default_height = "-295px";
		var w_height = $(window).height();
		//检测屏幕高度，大屏弹出框变大
		if(w_height > 850){
			$(".card_module").addClass("card_module_bg");
			$(".card_module_content").addClass("card_module_content_bg");
			default_height = "-355px";
		}
		$(".card_module").show().animate({"margin-top": default_height,"opacity":"1"},100);
		$(".page_cover").fadeIn(100);
	}


	// POST 方式新增页签
	function addTabByPost(condition) {
		var error = "缺失必要的属性：";
		if (condition.targetTabId == undefined) {
			error += "targetTabId、";
		}
		if (condition.targetTabTitle == undefined) {
			error += "targetTabTitle、";
		}
		if (condition.targetTabUrl == undefined) {
			error += "targetTabUrl、";
		}
		if (error != "缺失必要的属性：") {
			alert(error.substring(0, error.length - 1));
			return;
		}

		window.parent.f_addTab(condition.targetTabId, condition.targetTabTitle);
		// 获取当前选中页签的 tabid
		var tabid = $("li[class='l-selected']").attr("tabid");
		// 获取当前显示的 iframe
		var $div = $("div[tabid='" + tabid + "']");
		// 每次创建元素前清空iframe容器内的内容
		$div.empty();
		var htmlStr = '<div class="l-tab-loading" style="display: block"></div>';
		htmlStr += '<iframe id="' + tabid + '" name="' + tabid + '" src="' + condition.targetTabUrl + '" frameborder="0"></iframe>';
		htmlStr += '<form id="' + tabid + '" action="' + condition.targetTabUrl + '" target="' + tabid + '" method="post">';
		// 遍历 condition 的各项属性，并循环追加隐藏域
		for (var field in condition) {
			if ((field != "targetTabId") && (field != "targetTabTitle") && (field != "targetTabUrl")) {
				htmlStr += '<input name="' + field + '" type="hidden" value="' + condition[field] + '" />';
			}
		}
		htmlStr += '</form>';
		$div.append(htmlStr);
		$("form[id='" + tabid + "']").submit();
	}

</script>