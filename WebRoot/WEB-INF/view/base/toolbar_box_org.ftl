<#-- noFilter：未指定 noFilter 或当其为 false 时，显示更多筛选条件 -->
<#-- barCode：只有指定了 barCode 时，才显示条码打印 -->
<#-- exportUrl：只有指定了 exportUrl 时，才显示导出按钮 -->
<#-- printFunction：只有指定了 printFunction 时，才显示打印按钮 -->
<#-- noViewMode：未指定 noViewMode 或当其为 false 时，显示视图切换按钮 -->

<div class="toolbar_box">
	<div class="toolbar_left fl">
		<div class="toobar_chosethis fl">
			<label class="fl"><input id="chkThisPage" type="checkbox" /></label>
			<div class="fl">选择当前页</div>
		</div>
		<div class="toobar_search fl">
			<form class="query_form" action="${queryUrl}" method="post">
				<input name="keyvalueStr" type="text" value="${keyvalueStr}" />
				<#-- 当前页数 -->
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
				<input name="sortpartStr" type="hidden" value="${sortpartStr}" />
				<#-- 额外参数 -->
				<input name="extra" type="hidden" value="${extra}" />
				<#-- 视图模式 -->
				<input id="viewMode" name="viewMode" type="hidden" value="${VIEW_MODE}" />
				<#-- 选中数据的 ID 集合 -->
				<input id="checkedIdStr" name="checkedIdStr" type="hidden" />
				<button class="toobar_search_btn" type="submit"><span></span></button>
			</form>
			<div class="searchcard_tip">请输入要查找的内容</div>
		</div>

		<#-- 未指定 noFilter 或当其为 false 时，显示更多筛选条件 -->
		<#if !noFilter>
			<div class="toobar_moresearch fl">更多筛选条件</div>
		</#if>
	</div>

	<#-- 总是显示翻页工具栏 -->
	<div class="toolbar_right fr">
		<div class="toolbar_fy fl">
			<ul>
				<li class="toobar_jt toobar_jtll" pageNo="1" <#if page.hasPrev>able="true"</#if>>
					<a <#if page.hasPrev>class="toobar_jtll_a" href="javascript: void(0)"</#if>></a>
				</li>
				<li class="toobar_jt toobar_jtl" pageNo="${page.prev}" <#if page.hasPrev>able="true"</#if>>
					<a <#if page.hasPrev>class="toobar_jtl_a" href="javascript: void(0)"</#if>></a>
				</li>
				<li class="toobar_pagenum"><input id="page_switch" type="text" value="${page.pageNo}" /></li>
				<li style="width: 10px">/</li>
				<li>${page.totalPageNo}</li>
				<li class="toobar_jt toobar_jtr" pageNo="${page.next}" <#if page.hasNext>able="true"</#if>>
					<a <#if page.hasNext>class="toobar_jtr_a" href="javascript: void(0)"</#if>></a>
				</li>
				<li class="toobar_jt toobar_jtrr" pageNo="${page.totalPageNo}" <#if page.hasNext>able="true"</#if>>
					<a <#if page.hasNext>class="toobar_jtrr_a" href="javascript: void(0)"</#if>></a>
				</li>
			</ul>
		</div>
	</div>
</div>

<div class="toolbar_box" style="margin-bottom: 4px">
	<div class="toolbar_left fl">
		<ul class="yewu_action">
			<#-- 使用人（001） -->
			<#if currentUser.currentRoleCode == "001">
				<li class="yewu_sqbx toolbar_item"><a href="javascript: void(0)" onclick="applyForRepair()">申请报修</a><span></span></li>
				<li class="toobar_line"></li>
				<li class="yewu_sqcz toolbar_item"><a href="javascript: void(0)" onclick="applyForDeal()">申请处置</a><span></span></li>
				<li class="toobar_line"></li>
				<li class="yewu_sqzy toolbar_item"><a href="javascript: void(0)" onclick="applyForTransfer()">申请转移</a><span></span></li>
				<li class="toobar_line"></li>
				<li class="yewu_sqgh toolbar_item"><a href="javascript: void(0)" onclick="applyForReturn()">申请归还</a><span></span></li>
			</#if>

			<#-- 部门资产管理员（002） -->
			<#if currentUser.currentRoleCode == "002">
				<li class="yewu_rclyw toolbar_item"><a href="javascript: void(0)">日常类业务</a><span></span><i></i></li>
				<li class="rclyw_list">
					<ul>
						<li class="tool_sqbxiu"><a href="javascript: void(0)" onclick="applyForRepair()">申请报修</a></li>
						<li class="tool_sqczhi"><a href="javascript: void(0)" onclick="applyForDeal()">申请处置</a></li>
						<li class="tool_sqzyi"><a href="javascript: void(0)" onclick="applyForTransfer()">申请转移</a></li>
						<li class="tool_sqghuan"><a href="javascript: void(0)" onclick="applyForReturn()">申请归还</a></li>
						<li class="tool_xgzfddian"><a href="javascript: void(0)">修改存放地点</a></li>
					</ul>
				</li>
				<li class="toobar_line"></li>
				<li class="yewu_bjlyw toolbar_item"><a href="javascript: void(0)">标记类业务</a><span></span><i></i></li>
				<li class="bjlyw_list">
					<ul>
						<li class="tool_bwgyzc"><a href="javascript: void(0)" onclick="markAsPublic('1')">标记为公用资产</a></li>
						<li class="tool_qxgyzcbj"><a href="javascript: void(0)" onclick="markAsPublic('0')">取消公用资产标记</a></li>
					</ul>
				</li>
			</#if>

			<#-- 部门领导（003） -->
			<#if currentUser.currentRoleCode == "003">
				<li class="yewu_sqbx toolbar_item"><a href="javascript: void(0)">申请报修</a><span></span></li>
				<li class="toobar_line"></li>
				<li class="yewu_sqcz toolbar_item"><a href="javascript: void(0)">申请处置</a><span></span></li>
				<li class="toobar_line"></li>
				<li class="yewu_sqgh toolbar_item"><a href="javascript: void(0)" onclick="applyForReturn()">申请归还</a><span></span></li>
			</#if>

			<#-- 单位资产管理员（004） -->
			<#if currentUser.currentRoleCode == "004">
				<li class="yewu_rclyw toolbar_item"><a href="javascript: void(0)">日常类业务</a><span></span><i></i></li>
				<li class="rclyw_list">
					<ul>
						<li class="tool_sqbxiu"><a href="javascript: void(0)" onclick="applyForRepair()">申请报修</a></li>
						<li class="tool_sqczhi"><a href="javascript: void(0)" onclick="applyForDeal()">申请处置</a></li>
						<li class="tool_sqzyi"><a href="javascript: void(0)" onclick="applyForTransfer()">申请转移</a></li>
						<li class="tool_sqgheng"><a href="javascript: void(0)" onclick="applyForCorrect()">申请更正</a></li>
						<li class="tool_sqczu"><a href="javascript: void(0)" onclick="applyForLease()">申请出租</a></li>
						<li class="tool_sqcshou"><a href="javascript: void(0)">申请出借</a></li>
						<li class="tool_sqdytzi"><a href="javascript: void(0)" onclick="applyForInvest()">申请对外投资</a></li>
						<li class="tool_zwzkpian"><a href="javascript: void(0)">转为主卡片</a></li>
						<li class="tool_zwfkpian"><a href="javascript: void(0)">转为附卡片</a></li>
						<li class="tool_xgzfddian"><a href="javascript: void(0)">修改存放地点</a></li>
						<li class="tool_xgglbmen"><a href="javascript: void(0)">修改管理部门</a></li>
					</ul>
				</li>
				<li class="toobar_line"></li>
				<li class="yewu_bjlyw toolbar_item"><a href="javascript: void(0)">标记类业务</a><span></span><i></i></li>
				<li class="bjlyw_list">
					<ul>
						<li class="tool_bwgyzc"><a href="javascript: void(0)" onclick="markAsPublic('1')">标记为公用资产</a></li>
						<li class="tool_qxgyzcbj"><a href="javascript: void(0)" onclick="markAsPublic('0')">取消公用资产标记</a></li>
						<li class="tool_bjwdbfzc"><a href="javascript: void(0)">标记为待报废资产</a></li>
						<li class="tool_qxdbfzcbj"><a href="javascript: void(0)">取消待报废资产标记</a></li>
						<li class="tool_bji"><a href="javascript: void(0)">标记</a></li>
						<li class="tool_qxbji"><a href="javascript: void(0)">取消标记</a></li>
					</ul>
				</li>
			</#if>
		</ul>
	</div>

	<div class="toolbar_right fr">
		<ul class="gongneng_list fl">
			<#-- 只有指定了 barCode 时，才显示导出按钮 -->
			<#if barCode??>
				<li class="toolbar_tmdy toolbar_item">条码打印<span></span></li>
				<li class="toobar_line"></li>
			</#if>

			<#-- 只有指定了 exportUrl 时，才显示导出按钮 -->
			<#if exportUrl??>
				<li class="toolbar_dc toolbar_item">导出<span></span></li>
				<li class="toobar_line"></li>
			</#if>

			<#-- 只有指定了 printFunction 时，才显示打印按钮 -->
			<#if printFunction??>
				<li class="toolbar_dy toolbar_item">打印 / 预览<span></span></li>
				<li class="toobar_line"></li>
			</#if>

			<li class="toolbar_zdydc toolbar_item" style="display: none">自定义导出<span></span></li>
			<li class="toobar_line" style="display: none"></li>
			<li class="toolbar_zdylx toolbar_item" style="display: none">自定义列选<span></span></li>
		</ul>

		<#-- 未指定 noViewMode 或当其为 false 时，显示视图切换按钮 -->
		<#if !noViewMode>
			<div class="switch_model fl">
				<div class="model_card" title="卡片模式">
					<a id="toCard" href="javascript: void(0)"><span></span></a>
				</div>
				<div class="model_img" title="图片列表模式">
					<a id="toImgList" href="javascript: void(0)"><span></span></a>
				</div>
				<div class="model_list" title="列表模式">
					<a id="toList" href="javascript: void(0)"><span></span></a>
				</div>
			</div>
		</#if>
	</div>
</div>