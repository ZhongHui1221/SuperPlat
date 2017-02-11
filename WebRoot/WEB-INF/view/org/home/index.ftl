<!DOCTYPE html>
<html>
	<head>
		<title>资产管理系统</title>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="renderer" content="webkit">
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/main_org.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/jquery.mCustomScrollbar.css" />
		<link rel="stylesheet" id="mylink" />
		<link rel="shortcut icon" href="${request.contextPath}/static/image/favicon.ico" />
	</head>

	<body style="padding:0px;background:#EAEEF5">
		<div class="container">
			<div id="pageloading"></div>
			<div id="topmenu" class="l-topmenu">
				<div class="l-topmenu-logo">资产管理系统</div>
				<div class="l-topmenu-welcome">
					<ul>
						<li class="header_index">
							<a href="javascript:void(0)">首页</a>
						</li>
						<li class="header_zcfg">
							<a href="javascript: f_addTab('zcfg_main', '政策法规', '${prefixPath}/Policy/policy.html')">政策法规</a>
						</li>
						<li class="header_gggl">
							<a href="javascript:void(0)">公告管理</a>
						</li>
						<li class="header_help">
							<a href="javascript:void(0)">帮助</a>
						</li>
						<li class="header_xzzx">
							<a href="javascript:void(0)">下载中心</a>
						</li>
						<li class="header_lxkf">
							<a href="javascript: void(0)">联系客服</a>
						</li>
						<li class="system_mag">
							<a href="javascript: void(0)">系统管理</a>
							<ul class="system_mag_item">
								<li class="system_mag_icon"></li>
								<li class="department_user_mag">
									<a href="javascript: void(0)">部门用户管理</a>
								</li>
								<li class="user_review">
									<a href="javascript: void(0)">用户审核</a>
								</li>
								<li class="caizheng_log">
									<a href="javascript: void(0)">财政交互日志</a>
								</li>
								<li class="location_mag">
									<a href="javascript: void(0)">存放地点管理</a>
								</li>
								<li class="system_mag_item_first">
									<a href="${request.contextPath}/CoreUser/logout">重新登录</a>
								</li>
								<li class="about">
									<a href="javascript: void(0)">关于</a>
								</li>
							</ul>
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
					<div title="功能列表" class="l-scroll">
						<div class="user_wapper">
							<div class="default_user" onclick="location.href='${request.contextPath}/CoreUser/personal'">${currentUser.name}</div>
							<div class="user_work_wapper">
								<div class="user_work">
									<span>${currentUser.currentRoleName}</span>
									<ul class="user_work_switch">
										<#list currentUser.roleCursor as obj>
											<#if (obj["OBJCODE"] != "008") && (obj["OBJCODE"] != "009")>
												<li>
													<a href="${request.contextPath}/orgHome/index/${currentUser.currentOrgId}/${obj['RWID']}">${obj["OBJNAME"]}</a></li>
											</#if>
										</#list>
									</ul>
								</div>
								<i class="icon_sjx"></i>
							</div>
						</div>
						<div class="message_info">
							<div class="message_todo">
								<span></span>
							</div>
							<div class="message_notice">
								<span></span>
							</div>
							<div class="message_list">
								<div class="message_list_header">待办事项
									<span id="dbsxCount"></span>
									<div class="message_action">
										<i class="msg_action_refresh" title="刷新" onclick="findDbsx()"></i>
										<i class="msg_action_close" title="关闭"></i>
									</div>
								</div>
								<div class="message_content">
									<div class="msg_loading">
										<i></i>
										<div style="text-align: center">加载中...</div>
									</div>
									<ul id="dbsxCursor"></ul>
								</div>
								<div class="jt_sjx"></div>
							</div>
							<div class="notice_list">
								<div class="notice_list_header">公告栏
									<span id="noticesCount"></span>
									<div class="notice_action">
										<i class="noc_action_refresh" title="刷新" onclick="findNotices()"></i>
										<i class="noc_action_close" title="关闭"></i>
									</div>
								</div>
								<div class="message_content">
									<div class="msg_loading">
										<i></i>
										<div style="text-align: center">加载中...</div>
									</div>
									<ul id="noticesCursor"></ul>
								</div>
								<div class="jt_sjx"></div>
							</div>
						</div>
						<div class="gn_model" id="gn_model">
							<#-- 单位资产管理员 -->
							<#if currentUser.currentRoleCode == "004">
								<ul>
									<li class="gn_item select" gn_id="home">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_main select">
												<a href="javascript:void(0)">首页</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="pzgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_pzgl">
												<a href="javascript: f_addTab('pzgl', '配置管理', '${request.contextPath}/orgSlpz/main/peizgl/${currentUser.currentRoleCode}')">配置管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="kpgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_kpgl">
												<a href="javascript:void(0)">卡片管理</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('kpgl_ysgl', '验收管理', '../test.html')">验收管理</a></li>
											<li><a href="javascript: f_addTab('kpgl_dzgl', '登帐管理', '../test.html')">登帐管理</a></li>
											<li><a href="javascript: void(0)" onclick="toCorrect()">信息变更</a></li>
											<li><a href="javascript: f_addTab('kpgl_zjgl', '折旧管理', '../test.html')">折旧管理</a></li>
										</ul>
									</li>
									<li class="gn_item" gn_id="zczy">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zczy">
												<a href="javascript:void(0)">资产转移</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('zczy_zcfp', '资产分配', '../test.html')">资产分配</a></li>
											<li><a href="javascript: f_addTab('zczy_zcsh', '资产收回', '../test.html')">资产收回</a></li>
											<li><a href="javascript: f_addTab('zczy_zczy', '资产转移', '../test.html')">资产转移</a></li>
											<li><a href="javascript: f_addTab('zczy_yjgwc', '移交公物仓', '../test.html')">移交公物仓</a></li>
										</ul>
									</li>
									<li class="gn_item" gn_id="zcpd">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zcpd">
												<a href="javascript: f_addTab('zcpd', '资产盘点', '../test.html')">资产盘点</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="wxgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_wxgl">
												<a href="javascript: void(0)" onclick="toRepair()">维修管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zccz">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zccz">
												<a href="javascript: f_addTab('zccz', '资产处置', '../test.html')">资产处置</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zczl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zczl">
												<a href="javascript: f_addTab('zczl', '资产租赁', '../test.html')">资产租赁</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="dwtz">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_dwtz">
												<a href="javascript: f_addTab('dwtz', '对外投资', '../test.html')">对外投资</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="sygl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_sygl">
												<a href="javascript: f_addTab('sygl', '收益管理', '../test.html')">收益管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="jcfx">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_jcfx">
												<a href="javascript:void(0)">决策分析</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('jcfx_jcfx', '决策分析', '../test.html')">决策分析</a></li>
											<li><a href="javascript: f_addTab('jcfx_hzcx', '汇总查询', '../test.html')">汇总查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_lscx', '历史查询', '../test.html')">历史查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_fscx', '附属查询', '../test.html')">附属查询</a></li>
										</ul>
									</li>
								</ul>
							</#if>

							<#-- 使用人 -->
							<#if currentUser.currentRoleCode == "001">
								<ul>
									<li class="gn_item select" gn_id="home">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_main select">
												<a href="javascript:void(0)">首页</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="wysl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_wysl">
												<a href="javascript: f_addTab('wysl', '我要申领', '${request.contextPath}/orgSlpz/main/wysl/${currentUser.currentRoleCode}')">我要申领</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="wypd">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_wypd">
												<a href="javascript: f_addTab('wypd', '我要盘点', '../test.html')">我要盘点</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="wybx">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_wybx">
												<a href="javascript: f_addTab('wybx', '我要报修', '../test.html')">我要报修</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zygh">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zygh">
												<a href="javascript:void(0)">转移归还</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('zygh_gh', '归还', '../test.html')">归还</a></li>
											<li><a href="javascript: f_addTab('zygh_zy', '转移', '../test.html')">转移</a></li>
										</ul>
									</li>
									<li class="gn_item" gn_id="wycz">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_wycz">
												<a href="javascript: f_addTab('wycz', '我要处置', '../test.html')">我要处置</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="yszc">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_yszc">
												<a href="javascript: f_addTab('yszc', '验收资产', '../test.html')">验收资产</a>
												<span></span>
											</div>
										</div>
									</li>
								</ul>
							</#if>

							<#-- 部门资产管理员、部门领导 -->
							<#if (currentUser.currentRoleCode == "002") || (currentUser.currentRoleCode == "003")>
								<ul>
									<li class="gn_item select" gn_id="home">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_main select">
												<a href="javascript:void(0)">首页</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="pzgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_pzgl">
												<a href="javascript: f_addTab('pzgl', '配置管理', '${request.contextPath}/orgSlpz/main/peizgl/${currentUser.currentRoleCode}')">配置管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="yszc">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_yszc">
												<a href="javascript: f_addTab('yszc', '验收资产', '../test.html')">验收资产</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zczy">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zczy">
												<a href="javascript:void(0)">资产转移</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('zczy_zcfp', '资产分配', '../test.html')">资产分配</a></li>
											<li><a href="javascript: f_addTab('zczy_zcsh', '资产收回', '../test.html')">资产收回</a></li>
											<li><a href="javascript: f_addTab('zczy_zczy', '资产转移', '../test.html')">资产转移</a></li>
											<li><a href="javascript: f_addTab('zczy_yjgwc', '移交公物仓', '../test.html')">移交公物仓</a></li>
										</ul>
									</li>
									<li class="gn_item" gn_id="zcpd">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zcpd">
												<a href="javascript: f_addTab('zcpd', '资产盘点', '../test.html')">资产盘点</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="wxgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_wxgl">
												<a href="javascript: f_addTab('wxgl', '维修管理', '../test.html')">维修管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zccz">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zccz">
												<a href="javascript: f_addTab('zccz', '资产处置', '../test.html')">资产处置</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="jcfx">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_jcfx">
												<a href="javascript:void(0)">决策分析</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('jcfx_jcfx', '决策分析', '../test.html')">决策分析</a></li>
											<li><a href="javascript: f_addTab('jcfx_hzcx', '汇总查询', '../test.html')">汇总查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_lscx', '历史查询', '../test.html')">历史查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_fscx', '附属查询', '../test.html')">附属查询</a></li>
										</ul>
									</li>
								</ul>
							</#if>

							<#-- 单位领导 -->
							<#if currentUser.currentRoleCode == "005">
								<ul>
									<li class="gn_item select" gn_id="home">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_main select">
												<a href="javascript:void(0)">首页</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="pzgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_pzgl">
												<a href="javascript: f_addTab('pzgl', '配置管理', '${request.contextPath}/orgSlpz/main/peizgl/${currentUser.currentRoleCode}')">配置管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="kpgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_kpgl">
												<a href="javascript:void(0)">卡片管理</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('kpgl_ysgl', '验收管理', '../test.html')">验收管理</a></li>
											<li><a href="javascript: f_addTab('kpgl_dzgl', '登帐管理', '../test.html')">登帐管理</a></li>
										</ul>
									</li>
									<li class="gn_item" gn_id="zczy">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zczy">
												<a href="javascript:void(0)">资产转移</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('zczy_zcfp', '资产分配', '../test.html')">资产分配</a></li>
											<li><a href="javascript: f_addTab('zczy_zcsh', '资产收回', '../test.html')">资产收回</a></li>
										</ul>
									</li>
									<li class="gn_item" gn_id="zcpd">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zcpd">
												<a href="javascript: f_addTab('zcpd', '资产盘点', '../test.html')">资产盘点</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="wxgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_wxgl">
												<a href="javascript: f_addTab('wxgl', '维修管理', '../test.html')">维修管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zccz">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zccz">
												<a href="javascript: f_addTab('zccz', '资产处置', '../test.html')">资产处置</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="jcfx">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_jcfx">
												<a href="javascript:void(0)">决策分析</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('jcfx_jcfx', '决策分析', '../test.html')">决策分析</a></li>
											<li><a href="javascript: f_addTab('jcfx_hzcx', '汇总查询', '../test.html')">汇总查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_lscx', '历史查询', '../test.html')">历史查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_fscx', '附属查询', '../test.html')">附属查询</a></li>
										</ul>
									</li>
								</ul>
							</#if>

							<#-- 财务制单人员 -->
							<#if currentUser.currentRoleCode == "006">
								<ul>
									<li class="gn_item select" gn_id="home">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_main select">
												<a href="javascript:void(0)">首页</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="xzzc">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_xzzc">
												<a href="javascript: f_addTab('xzzc', '新增资产', '../test.html')">新增资产</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="hxzc">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_hxzc">
												<a href="javascript: f_addTab('hxzc', '核销资产', '../test.html')">核销资产</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zcxl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zcxl">
												<a href="javascript: f_addTab('zcxl', '资产修理', '../test.html')">资产修理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="sygl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_sygl">
												<a href="javascript: f_addTab('sygl', '收益管理', '../test.html')">收益管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="xxgz">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_xxgz">
												<a href="javascript: f_addTab('xxgz', '信息更正', '../test.html')">信息更正</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="zjgl">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_zjgl">
												<a href="javascript: f_addTab('zjgl', '折旧管理', '../test.html')">折旧管理</a>
												<span></span>
											</div>
										</div>
									</li>
									<li class="gn_item" gn_id="cxfx">
										<div class="gn_item_wapper">
											<div class="gn_item_inner gn_cxfx">
												<a href="javascript:void(0)">查询分析</a>
												<span></span>
											</div>
										</div>
										<ul class="gn_item_list">
											<li><a href="javascript: f_addTab('jcfx_jcfx', '决策分析', '../test.html')">决策分析</a></li>
											<li><a href="javascript: f_addTab('jcfx_hzcx', '汇总查询', '../test.html')">汇总查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_lscx', '历史查询', '../test.html')">历史查询</a></li>
											<li><a href="javascript: f_addTab('jcfx_fscx', '附属查询', '../test.html')">附属查询</a></li>
										</ul>
									</li>
								</ul>
							</#if>
						</div>
					</div>
				</div>
				<div position="center" id="framecenter">
					<div tabid="home" title="首页" style="height:300px">
						<iframe frameborder="0" name="home" id="home"></iframe>
					</div>
				</div>
			</div>
			<div style="display: none"></div>
		</div>
		<div class="card_module" id="card_iframe_modal">
			<div class="zl_about_header">
				<div class="about_header_info">卡片详细信息查看</div>
				<div class="zl_about_icon"></div>
				<div class="zl_about_close"></div>
			</div>
			<div class="card_module_content">
				<iframe frameborder="0" width="100%" height="100%" name="card_module" id="card_module"></iframe>
			</div>
		</div>
		<div class="notice_module">
			<div class="zl_about_header">
				<div class="about_header_info">公告管理</div>
				<div class="zl_about_icon"></div>
				<div class="zl_about_close"></div>
			</div>
			<div class="notice_module_content">
				<iframe frameborder="0" width="100%" height="100%" name="notice_module" id="notice_module" src=""></iframe>
			</div>
		</div>
		<div class="public_modal">
			<div class="zl_about_header">
				<div class="about_header_info"></div>
				<div class="zl_about_icon"></div>
				<div class="zl_about_close"></div>
			</div>
			<div class="public_modal_content">
				<iframe frameborder="0" width="100%" height="100%" name="public_module" id="public_module"></iframe>
			</div>
		</div>
		<div class="edit_modal edit_shenl">
            <div class="edit_modal_header">
                <div class="edit_modal_info"></div>
                <div class="edit_modal_icon"></div>
                <div class="edit_modal_close"></div>
            </div>
            <div class="edit_modal_content edit_content_shenl">
                <iframe frameborder="0" width="100%" height="100%" name="edit_modal" id="edit_modal" src=""></iframe>
            </div>
        </div>
		<div class="w_msy_wrap">
            <div class="w_msg">
                <div class="w_msg_header">提示</div>
                <div class="w_msg_content"></div>
                <div class="w_msg_footer">
                    <span class="w_btn w_btn_sure">确定</span>
                    <span class="w_btn w_btn_cancel">取消</span>
                </div>
            </div>
        </div>
		<#-- 导入“关于我们”模版 -->
		<#include "/base/about_us.ftl" />
		<div class="page_cover"></div>
		<div class="page_cover_tips"></div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_org_js.ftl" />
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
					leftWidth: 170,
					height: '100%',
					heightDiff: -1,
					space: 0,
					allowLeftResize: false,
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
					height: height - 1,
					speed: null
				});

				$(".l-link").hover(function() {
					$(this).addClass("l-link-over");
				},
				function() {
					$(this).removeClass("l-link-over");
				});

				tab = liger.get("framecenter");
				accordion = liger.get("accordion1");
				tree = liger.get("tree1");
				$("#pageloading").hide();

				css_init();
				//pages_init();
			});

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

			function f_heightChanged(options) {
				if (tab) tab.addHeight(options.diff);
				if (accordion && options.middleHeight - 24 > 0) accordion.setHeight(options.middleHeight - 24);
			}

			function f_addTab(tabid, text, url) {
				tab.addTabItem({
					tabid: tabid,
					text: text,
					url: url,
					callback: function() {
						addFrameSkinLink(tabid);
					}
				});
			}

			function addFrameSkinLink(tabid) {
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

			function css_init() {
				var css = $("#mylink").get(0),
				skin = getQueryString("skin");
				$("#skinSelect").val(skin);
				$("#skinSelect").change(function() {
					if (this.value) {
						location.href = "index.htm?skin=" + this.value;
					} else {
						location.href = "index.htm";
					}
				});
				if (!css || !skin) return;
				skin = skin.toLowerCase();
				$('body').addClass("body-" + skin);
				$(css).attr("href", skin_links[skin]);
			}

			function getQueryString(name) {
				var now_url = document.location.search.slice(1),
				q_array = now_url.split('&');
				for (var i = 0; i < q_array.length; i++) {
					var v_array = q_array[i].split('=');
					if (v_array[0] == name) {
						return v_array[1];
					}
				}
				return false;
			}

			function attachLinkToFrame(iframeId, filename) {
				if (!window.frames[iframeId]) return;
				var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
				var fileref = window.frames[iframeId].document.createElement("link");
				if (!fileref) return;
				fileref.setAttribute("rel", "stylesheet");
				fileref.setAttribute("type", "text/css");
				fileref.setAttribute("href", filename);
				head.appendChild(fileref);
			}

			function getLinkPrevHref(iframeId) {
				if (!window.frames[iframeId]) return;
				var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
				var links = $("link:first", head);
				for (var i = 0; links[i]; i++) {
					var href = $(links[i]).attr("href");
					if (href && href.toLowerCase().indexOf("ligerui") > 0) {
						return href.substring(0, href.toLowerCase().indexOf("lib"));
					}
				}
			}

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

			/* 页签相关 - BEGIN */
			// 加载主页
			function homeMain() {
				// 获取当前选中页签的 tabid
				var tabid = "home";
				// 获取当前显示的 iframe
				var $div = $(window.parent.document).find("div[tabid='" + tabid + "']");
				// 执行拼接前清空 iframe
				$div.empty();
				var htmlStr = '<div class="l-tab-loading" style="display: block"></div>';
				htmlStr += '<iframe id="' + tabid + '" name="' + tabid + '" src="${request.contextPath}/orgHome/main" frameborder="0"></iframe>';
				htmlStr += '<form id="' + tabid + '" action="${request.contextPath}/orgHome/main" target="' + tabid + '" method="post"></form>';
				$div.append(htmlStr);
				$(window.parent.document).find("form[id='" + tabid + "']").submit();
			}

			// POST 方式新增“信息变更”页签
			function toCorrect(obj) {
				var condition = {
					targetTabId: "card_correct",
					targetTabTitle: "信息变更",
					targetTabUrl: "${request.contextPath}/Correct/toUnSubmit",
					method: "post",
					fromModel: ""
				};
				addTabByForm(condition);
			}

			// POST 方式新增“维修管理”页签
			function toRepair(obj) {
				var condition = {
					targetTabId: "repair",
					targetTabTitle: "维修管理",
					targetTabUrl: "${request.contextPath}/Repair/toUnaudited",
					method: "post",
					fromModel: ""
				};
				addTabByForm(condition);
			}
			/* 页签相关 - END */

			/* 公告栏相关 - BEGIN */
			// 公告列表
			function findNotices() {
				$(".msg_loading").show();
				$("#noticesCursor").empty();
				$.post(
					"${request.contextPath}/orgHome/findNotices",
					function(data) {
						var arr = eval(data);
						$("#noticesCount").text("（" + arr.length + "）");
						if (arr.length != 0) {
							$(".message_notice span").removeClass("nodata");
							var htmlStr = '';
							for (var i = 0; i < arr.length; i++) {
								// 去除末项的底部边框
								if (i + 1 == arr.length) {
									htmlStr += '<li style="border-bottom: none"><span>' + (i + 1) + '.&nbsp;</span><div class="message_item" rwid="' + arr[i].RWID + '"><a href="javascript: void(0)">' + arr[i].TITLE + '</a></div></li>';
								} else {
									htmlStr += '<li><span>' + (i + 1) + '.&nbsp;</span><div class="message_item" rwid="' + arr[i].RWID + '"><a href="javascript: void(0)">' + arr[i].TITLE + '</a></div></li>';
								}
							}
							$("#noticesCursor").append(htmlStr);
						}else{
							$(".message_notice span").addClass("nodata");
						}
						$(".msg_loading").fadeOut(100);
					}
				);
			}
			/* 公告栏相关 - END */

			/* 待办事项相关 - BEGIN */
			// 待办事项列表
			function findDbsx() {
				$(".msg_loading").show();
				$("#dbsxCursor").empty();
				$.post(
					"${request.contextPath}/orgHome/findDbsx",
					function(data) {
						var arr = eval(data);
						$("#dbsxCount").text("（" + arr.length + "）");
						if (arr.length != 0) {
							$(".message_todo span").removeClass("nodata");
							var htmlStr = '';
							for (var i = 0; i < arr.length; i++) {
								// 去除末项的底部边框
								if (i + 1 == arr.length) {
									htmlStr += '<li style="border-bottom: none"><span>' + (i + 1) + '.&nbsp;</span><div class="message_item"><a href="javascript: void(0)">' + arr[i].C1 + '</a></div></li>';
								} else {
									htmlStr += '<li><span>' + (i + 1) + '.&nbsp;</span><div class="message_item"><a href="javascript: void(0)">' + arr[i].C1 + '</a></div></li>';
								}
							}
							$("#dbsxCursor").append(htmlStr);
						}else{
							$(".message_todo span").addClass("nodata");
						}
						$(".msg_loading").fadeOut(100);
					}
				);
			}
			/* 待办事项相关 - END */

			$(function() {

				// 判断浏览器版本是否为IE8，修复IE8首页无loading
				if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i) == "8.") {
					$("#home").before('<div class="l-tab-loading" style="display: none;"></div>');
				}

				// 加载待办事项
				findDbsx();

				// 加载公告栏
				findNotices();

				// 加载主页
				homeMain();

				// 对主流浏览器(IE10及以上)做禁用浏览器后退按钮操作
				if (window.history && window.history.pushState) {
					history.pushState(null, null, document.URL);
					window.addEventListener('popstate',
					function() {
						history.pushState(null, null, document.URL);
					});
				}

				// 待办事项，公告栏，左侧菜单栏自定义滚动条
				$(".message_content, #gn_model").mCustomScrollbar({
					scrollButtons: {
						enable: false,
						scrollType: "continuous",
						scrollSpeed: 20,
						scrollAmount: 40
					},
					horizontalScroll: false,
					scrollInertia: 200,
					autoHideScrollbar: true
				});

				// 左侧面板动态调整高度
				var left_height = $(".l-layout-left").height();
				$("#accordion1, .l-accordion-content").height(left_height);
				$(".gn_model").height(left_height - 104);
				window.onresize = function() {
					var left_height = $(".l-layout-left").height();
					$("#accordion1, .l-accordion-content").height($(".l-layout-left").height());
					$(".gn_model").height(left_height - 104);
				}

				/* 系统管理相关 - BEGIN */
				$(".system_mag").click(function(event) {
					event.stopPropagation();
					$(".system_mag_item").slideToggle(100);
				});
				$(".caizheng_log").click(function(event) {
					event.stopPropagation();
					$(".system_mag_item").hide();
					layer.open({
						type : 2,
						skin : "content_class",
						title : "财政交互日志",
						area : ["800px", "560px"],
						anim : 0,
						shadeClose : true,
						fixed : false,
						content : "./jiaohurizhi/caizhengjiaohurz_wwc.htm"
					});
				});
				$(".location_mag").click(function(event) {
					event.stopPropagation();
					$(".system_mag_item").hide();
					layer.open({
						type : 2,
						skin : "content_class",
						title : "存放地点管理",
						area : ["800px", "560px"],
						anim : 0,
						shadeClose : true,
						fixed : false,
						content : "${request.contextPath}/Storage/main"
					});
				});
				$("body").click(function() {
					$(".system_mag_item").slideUp(100);
				})
				/* 系统管理相关 - END */

				/* 待办事项、公告栏相关 - BEGIN */
				// 待办事项、公告栏打开效果
				$(".message_todo span").click(function() {
					$(".notice_list").hide();
					$(".message_list").fadeToggle(100);
				});
				$(".msg_action_close").click(function() {
					$(".message_list").fadeOut(100);
				});
				$(".message_notice").click(function() {
					$(".message_list").hide();
					$(".notice_list").fadeToggle(100);
				});
				$(".noc_action_close").click(function() {
					$(".notice_list").fadeOut(100);
				});
				// 点击公告栏条目弹出公告栏模态框
				$(".notice_list").on("click", ".message_item", function() {
					var rwid = $(this).attr("rwid");
					//$("#notice_module").prop("src", "${request.contextPath}/orgHome/noticeDetail/" + rwid);
					//$(".notice_module .about_header_info").html("公告信息");
					//$(".notice_module, .page_cover").show();
					layer.open({
						type : 2,
						skin : "content_class",
						title : "公告信息",
						area : ["800px", "560px"],
						anim : 4,
						shadeClose : true,
						fixed : false,
						content : "${request.contextPath}/orgHome/noticeDetail/" + rwid
					});
				});
				// 点击右上角公告管理弹出公共管理弹出框
				$(".header_gggl").click(function(){
					$("#notice_module").prop("src", "${request.contextPath}/Notice/toAdd");
					$(".notice_module .about_header_info").html("公告管理");
					$(".notice_module, .page_cover").show();
				});
				/* 待办事项、公告栏相关 - END */

				/* 页签相关事件 - BEGIN */
				// 刷新按钮显示隐藏
				$(".l-tab-links").on("mouseenter", "li",
				function() {
					if ($(this).hasClass("l-selected")) {
						$(this).children(".l-tab-links-item-reload").show();
					}
				}).on("mouseleave", "li",
				function() {
					$(this).children(".l-tab-links-item-reload").hide();
				});
				// 关闭全部
				$("body").on("click", ".close_all",
				function() {
					tab.removeAll();
					$(".l-tab-windowsswitch").remove();
				});
				// 关闭其他标签
				$("body").on("click", ".close_others",
				function() {
					var tabid = tab.getSelectedTabItemID();
					tab.removeOther(tabid);
					$(".l-tab-windowsswitch").remove();
				});
				/* 页签相关事件 - END */

				// 左边菜单栏弹出下拉框及点击弹出页签
				$(".gn_model .gn_item").click(function() {
					$(".gn_model .gn_item, .gn_model .gn_item_inner").removeClass("select");
					$(this).addClass("select").find(".gn_item_inner").addClass("select");
					//var tabId = $(this).attr("gn_id");
					//var tabUrl = $(this).attr("gn_url");
					//var tabName = $(this).find("a").html();
					//window.f_addTab(tabId, tabName, tabUrl);
				});
				$(".gn_item_wapper").click(function() {
					var $slide = $(this).next();
					if ($slide.css("display") == "block") {
						$slide.slideUp(100);
					}else{
						$(".gn_item_list").slideUp(100);
						$slide.slideDown(100);
					}
				});

				// 角色切换
				$(".icon_sjx").click(function() {
					$(".user_work").toggleClass("open");
				});

				// 关于我们点击显示隐藏
				$(".about").click(function(event) {
					event.stopPropagation();
					$(".system_mag_item").hide();
					if ($(".zl_about").css("display") == "none") {
						$(".zl_about").show().animate({
							"top": "27%",
							"opacity": "1"
						});
						$(".page_cover").fadeIn(100);
					}
				});

				$(".zl_about_close, .page_cover, .zl_bottom_close").click(function() {
					if ($(".zl_about").css("display") == "block") {
						$(".zl_about").animate({
							"top": "10%",
							"opacity": "0"
						},
						200,
						function() {
							$(this).hide();
						})
					} else if ($(".card_module").css("display") == "block") {
						$(".card_module").animate({
							"margin-top": "-400px",
							"opacity": "0"
						},
						200,
						function() {
							$(".card_module_content").removeClass("card_module_content_bg");
							$(this).removeClass("card_module_bg").hide();
							$("#card_module").attr("src", "");
						})
					} else if($(".notice_module").css("display") == "block") {
						$(".notice_module").fadeOut(200);
					} else if($(".public_modal").css("display") == "block") {
						$(".public_modal").fadeOut(200);
					}
					$(".page_cover").fadeOut(300);
				});

				// 全屏功能
				$(".header_qpxs").click(function() {
					if ($(this).attr("allscreen") == "not") {
						$(this).attr("allscreen", "yes").css({
							"background-position": "0px -234px"
						}).children("b").html("退出全屏");
						requestFullScreen(document.documentElement);
					} else if ($(this).attr("allscreen") == "yes") {
						$(this).attr("allscreen", "not").css({
							"background-position": "0px -195px"
						}).children("b").html("全屏显示");
						exitFull();
					}
				});

				// 卡片关闭
				$('.zl_about_close').click(function(){
                    $('.public_modal').hide();
                })
                $('.edit_modal_close').click(function(){
                    $('.edit_modal').hide();
                })
				$('.w_btn_b').click(function(){
                    $('.w_msy_wrap').hide();
                })
			});

			//卡片弹出-资产申领分类
            function alertPublicModal(title,params){
                $('.public_modal .about_header_info').html(title);
                $('#public_module').prop('src',params);
                $('.public_modal').show();
            }

			//卡片关闭-资产申领分类
            function closePublicModal(){
                $('.public_modal').hide();
            }

            //卡片弹出-资产申领详情
            function alertEditModal(title,params){
                $('.about_header_info').html(title);
                $('#edit_modal').prop('src',params);
                $('.edit_modal').show();
            }
            //卡片关闭-资产申领详情
            function closeEditModal(){
                $('.edit_modal').hide();
            }
            function alertWMeg(msg,isConfirm,fn){
                if (isConfirm){
                    $('.w_msg_footer').addClass('confirm').removeClass('alert');
                } else {
                    $('.w_msg_footer').removeClass('confirm').addClass('alert');
                }
                $('.w_msg_content').html(msg);
                $('.w_msy_wrap').show();
                $('.w_btn_cancel').click(function(){
                    $('.w_msy_wrap').hide();
                })
                $('.w_btn_sure').click(function(){
                    fn;
                    $('.w_msy_wrap').hide();
                })
            }
            function closeWMsg(){
                $('.w_msy_wrap').hide();
            }

            // 关闭父页面弹框
            function closeCard() {
            	$(".zl_about_close").trigger("click");
            }

            /* 由父页面提供 子iframe调用的方法 - BEGIN */
            // 子页面调用关闭同级iframe弹框
            function closeModal(modalClass) {
            	$(".page_cover").hide();
            	$(modalClass).hide();
            }

            // 由存放地点管理页面调用设置卡片详情存放地点字段
            function setCardStorage(cfdd, rwid) {
            	var cunfangdd = document.getElementById("card_module").contentWindow.document.getElementById("cunfangdd")
            	cunfangdd.value = cfdd;
            	$(cunfangdd).attr("rwid", rwid);
            	$(".public_modal").hide();
            }
            /* 由父页面提供 子iframe调用的方法 - END */
		</script>
	</body>
</html>