<!DOCTYPE html>
<html>
	<head>
		<title>资产监管平台</title>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/main.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/jquery.mCustomScrollbar.css" />
		<link rel="stylesheet" id="mylink" />
		<link rel="shortcut icon" href="${request.contextPath}/static/image/favicon.ico" />
		<!--[if IE]>
			<style>
				.header_qpxs{display:none;}
			</style>
		<![endif]-->
	</head>

	<body style="padding:0px;background:#EAEEF5">
		<div class="container">
			<div id="pageloading"></div>
			<div id="topmenu" class="l-topmenu">
				<div class="l-topmenu-logo">资产监管平台</div>
				<div class="l-topmenu-home">
					<ul>
						<li class="topmenu-home-h">
							<a href="javascript: void(0)">首页</a></li>
						<li class="topmenu-home-g">
							<div class="topmenu-list">
								<div class="tiaozheng"></div>
								<div class="topmenu_list_header">
									<p class="topmenu_list_zcpt active" style="margin-left: 10px">工作平台</p></div>
								<div class="topmenu_list_card active">
									<a href="javascript: f_addTab('pzbzsh', '配置标准审核', '${request.contextPath}/peizhibiaozhunshenhe.htm')">配置标准审核
										<span class="pzbzsh"></span></a>
									<a href="javascript: f_addTab('pzjhsh', '配置计划审核', '${request.contextPath}/view/home/peizhijihuashenhe.htm')">配置计划审核
										<span class="pzjhsh"></span></a>
								</div>
							</div>
						</li>
						<li class="topmenu-home-c">
							<span class="topmenu-home-text">查询平台</span>
							<div class="topmenu-list">
								<div class="tiaozheng"></div>
								<div class="topmenu_list_header">
									<p class="topmenu_list_zcpt zcpt_gdzc active" style="margin-left: 10px">固定资产</p>
									<p class="topmenu_list_zcpt zcpt_czqk">处置情况</p>
									<p class="topmenu_list_zcpt zcpt_zjqk" style="display: none">租借情况</p>
									<p class="topmenu_list_zcpt zcpt_tzqk" style="display: none">投资情况</p>
									<p class="topmenu_list_zcpt zcpt_syqk" style="display: none">收益情况</p></div>
								<div class="topmenu_list_wapper">
									<div class="topmenu_list_card list_zcpt_gdzc active">
										<a href="javascript: f_addTab('ztqk_main', '总体情况', '${request.contextPath}/Query/Ztqk/main')">总体情况
											<span class="ztqk_main"></span></a>
										<a href="javascript: f_addTab('gcqk_main', '构成情况', '${request.contextPath}/Query/Gcqk/main')">构成情况
											<span class="gcqk_main"></span></a>
										<a href="javascript: f_addTab('zjqk_main', '增加情况', '${request.contextPath}/Query/Zjqk/main')">增加情况
											<span class="zjqk_main"></span></a>
										<a href="javascript: f_addTab('jsqk_main', '减少情况', '${request.contextPath}/Query/Jsqk/main')">减少情况
											<span class="jsqk_main"></span></a>
										<a href="javascript: f_addTab('cyzc_main', '常用资产', '${request.contextPath}/Query/Cyzc/main')">常用资产
											<span class="cyzc_main"></span></a>
										<a href="javascript: f_addTab('syzk_main', '使用情况', '${request.contextPath}/Query/Syzk/main')">使用情况
											<span class="syzk_main"></span></a>
										<a href="javascript: f_addTab('fbqk_main', '分布情况', '${request.contextPath}/Query/Fbqk/main/0/0')">分布情况
											<span class="fbqk_main"></span></a>
										<a href="javascript: f_addTab('ytfl_main', '用途分类', '${request.contextPath}/Query/Ytfl/main')">用途分类
											<span class="ytqk_main"></span></a>
										<a href="javascript: f_addTab('wxqk_main', '维修情况', '${request.contextPath}/Query/Wxqk/main')">维修情况
											<span class="wxqk_main"></span></a>
										<a href="javascript: f_addTab('dbfqk_main', '待报废资产', '${request.contextPath}/Query/Dbfqk/main')">待报废资产
											<span class="dbfqk_main"></span></a>
										<a href="javascript: f_addTab('rzqk_main', '入账情况', '${request.contextPath}/Query/Rzqk/main')">入账情况
											<span class="rzqk_main"></span></a>
										<a href="javascript: f_addTab('fwxx_main', '房屋信息', '${request.contextPath}/Query/Fwxx/main')">房屋信息
											<span class="fwxx_main"></span></a>
									</div>
									<div class="topmenu_list_card list_zcpt_czqk">
										<a href="javascript: f_addTab('czqk_main', '处置情况', '${request.contextPath}/Query/Czqk/main')">处置情况
											<span class="czqk_main"></span></a>
										<a href="javascript: void(0)" onclick="toCzdsp()">处置待审批
											<span class="czdsp_main"></span></a>
										<a href="javascript: void(0)" onclick="toCzzxz()">处置执行中
											<span class="czzxz_main"></span></a>
										<a href="javascript: void(0)" onclick="toCzwc()">处置完成
											<span class="czwc_main"></span></a>
									</div>
									<div class="topmenu_list_card list_zcpt_zjqk" style="display: none">
										<a href="javascript: f_addTab('zujieqk_main', '租借情况', '${request.contextPath}/Query/Zujieqk/main')">租借情况
											<span class="zujieqk_main"></span></a>
										<a href="javascript: f_addTab('zujiedsp_main', '租借待审批', '${request.contextPath}/Query/Zujieqk/zujiedsp')">租借待审批
											<span class="zujiedsp_main"></span></a>
										<a href="javascript: f_addTab('zujiez_main', '租(借)中', '${request.contextPath}/Query/Zujieqk/zujiez')">租(借)中
											<span class="zujiez_main"></span></a>
										<a href="javascript: f_addTab('zujiesh_main', '租(借)收回', '${request.contextPath}/Query/Zujieqk/zujiesh')">租(借)收回
											<span class="zujiesh_main"></span></a>
									</div>
									<div class="topmenu_list_card list_zcpt_tzqk" style="display: none">
										<a href="javascript: f_addTab('touziqk_main', '投资情况', '')">投资情况
											<span class="touziqk_main"></span></a>
										<a href="javascript: f_addTab('touzidsp_main', '投资待审批', '')">投资待审批
											<span class="touzidsp_main"></span></a>
										<a href="javascript: f_addTab('touziz_main', '投资中', '')">投资中
											<span class="touziz_main"></span></a>
										<a href="javascript: f_addTab('touzish_main', '投资收回', '')">投资收回
											<span class="touzish_main"></span></a>
									</div>
									<div class="topmenu_list_card list_zcpt_syqk" style="display: none">
										<a href="javascript: f_addTab('shouyiqk_main', '收益情况', '')">收益情况
											<span class="shouyiqk_main"></span></a>
										<a href="javascript: f_addTab('shouyifb_main', '收益分布', '')">收益分布
											<span class="shouyifb_main"></span></a>
									</div>
								</div>
							</div>
						</li>
						<li class="topmenu-home-j">
							<span class="topmenu-home-text">监控平台</span>
							<div class="topmenu-list">
								<div class="tiaozheng"></div>
								<div class="topmenu_list_header">
									<p class="topmenu_list_zcpt active" style="margin-left: 10px">监控平台</p></div>
								<div class="topmenu_list_card active">
									<a href="javascript: f_addTab('pdjk_main', '盘点监控', '${request.contextPath}/Monitor/Pdjk/main/0/*/0')">盘点监控
										<span class="pdjk_main"></span></a>
								</div>
							</div>
						</li>
						<li class="topmenu-home-w"></li>
					</ul>
				</div>
				<div class="l-topmenu-welcome">
					<!-- <label> 皮肤切换：</label>
					<select id="skinSelect">
					<option value="aqua">默认</option>
					<option value="silvery">Silvery</option>
					<option value="gray">Gray</option>
					<option value="gray2014">Gray2014</option></select>
					<a href="index.aspx" class="l-link2">服务器版本</a>
					<span class="space">|</span>
					<a href="http://www.ligerui.com/pay.html" class="l-link2" target="_blank">捐赠</a>
					<span class="space">|</span>
					<a href="http://www.ligerui.com/server.html" class="l-link2" target="_blank">服务支持</a>  -->
					<ul>
						<li>
							<div class="user_info_name">${currentUser.name}</div></li>
						<li>
							<div class="user_info_position">
								<p class="user_info_position_select">
									<span>${currentUser.currentRoleName}</span>
									<i class="sanjx" style="display: none"></i>
								</p>
								<ul class="user_info_switch" show="hide">
									<#list currentUser.roleCursor as obj>
										<#if (obj["OBJCODE"] == "008") || (obj["OBJCODE"] == "009")>
											<li>
												<a href="${request.contextPath}/supHome/index/${currentUser.currentOrgId}/${obj['RWID']}">${obj["OBJNAME"]}</a></li>
										</#if>
									</#list>
								</ul>
							</div>
						</li>
						<li class="header_zcfg" style="margin-left: 20px">
							<a href="javascript: f_addTab('zcfg_main', '政策法规', '${prefixPath}/Policy/policy.html')"></a>
							<b>政策法规</b>
						</li>
						<li class="header_xzzx" style="display: none">
							<a href="javascript: f_addTab('listpage', '列表页面', 'demos/case/listpage.htm')"></a>
							<b>下载中心</b>
						</li>
						<li class="header_lxkf" style="display: none">
							<a href="javascript: void(0)"></a>
							<b>联系客服</b>
						</li>
						<li class="system_mag">
							<a href="javascript: void(0)"></a>
							<ul class="system_mag_item">
								<li class="system_mag_item_first">
									<a href="${request.contextPath}/CoreUser/logout">重新登录</a></li>
								<li class="about">
									<a href="javascript: void(0)">关于</a></li>
							</ul>
							<b>系统管理</b>
						</li>
						<li class="header_qpxs" allscreen="not">
							<a href="javascript: void(0)"></a>
							<b>全屏显示</b>
						</li>
					</ul>
				</div>
			</div>
			<div id="layout1" style="width:99.8%; margin:0px; ">
				<div position="left" id="accordion1">
					<span class="search_tree">
						<div id="search_tip"></div>
						<input type="text" value="请输入名称进行查找">
						<i>
						</i>
					</span>
					<div title="功能列表" class="l-scroll" id="tree_left">
						<ul id="tree1" style="margin-top:3px;"></ul>
					</div>
					<!-- <div title="应用场景">
					<div style=" height:7px;"></div>
					<a class="l-link" href="http://www.ligerui.com/go.aspx?id=case" target="_blank">演示系统</a>
					<a class="l-link" href="javascript: f_addTab('listpage', '列表页面', 'demos/case/listpage.htm')">列表页面</a>
					<a class="l-link" href="demos/dialog/win7.htm" target="_blank">模拟Window桌面</a>
					<a class="l-link" href="javascript: f_addTab('week', '工作日志', 'demos/case/week.htm')">工作日志</a></div>
					<div title="实验室">
					<div style=" height:7px;"></div>
					<a class="l-link" href="lab/generate/index.htm" target="_blank">表格表单设计器</a>
					<a class="l-link" href="lab/formdesign/index.htm" target="_blank">可视化表单设计</a></div>
					-->
				</div>
				<div position="center" id="framecenter">
					<div tabid="home" title="首页" style="height:300px">
						<iframe frameborder="0" name="home" id="home"></iframe>
					</div>
				</div>
			</div>
			<div style="display:none"></div>
		</div>
		<div class="card_module">
			<div class="zl_about_header">
				<div class="about_header_info">卡片详细信息查看</div>
				<div class="zl_about_icon"></div>
				<div class="zl_about_close"></div>
			</div>
			<div class="card_module_content">
				<iframe frameborder="0" width="100%" height="100%" name="card_module" id="card_module"></iframe>
			</div>
		</div>
		<#-- 导入“关于我们”模版 -->
		<#include "/base/about_us.ftl" />
		<div class="page_cover"></div>
		<div class="page_cover_tips"></div>

		<#-- 导入首页 JS 模板 -->
		<#include "/base/index_js.ftl" />
		<script>

			// POST 方式新增“处置待审批”页签
			function toCzdsp() {
				var condition = {
					targetTabId: "czdsp_main",
					targetTabTitle: "处置待审批",
					targetTabUrl: "${request.contextPath}/Query/Czqk/czdsp"
				};
				addTabByPost(condition);
			}

			// POST 方式新增“处置执行中”页签
			function toCzzxz() {
				var condition = {
					targetTabId: "czzxz_main",
					targetTabTitle: "处置执行中",
					targetTabUrl: "${request.contextPath}/Query/Czqk/symx",
					extra: "0"
				};
				addTabByPost(condition);
			}

			// POST 方式新增“处置完成”页签
			function toCzwc() {
				var condition = {
					targetTabId: "czwc_main",
					targetTabTitle: "处置完成",
					targetTabUrl: "${request.contextPath}/Query/Czqk/symx",
					extra: "1"
				};
				addTabByPost(condition);
			}

		</script>
	</body>
</html>