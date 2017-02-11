<#-- noFilter：未指定 noFilter 或当其为 false 时，显示更多筛选条件 -->
<#-- exportUrl：只有指定了 exportUrl 时，才显示导出按钮 -->
<#-- printFunction：只有指定了 printFunction 时，才显示打印按钮 -->
<#-- noViewMode：未指定 noViewMode 或当其为 false 时，显示视图切换按钮 -->

<div class="toolbar_box">
	<div class="toolbar_left fl">
		<div class="toolbar_choseall fl">
			<label class="fl"><input id="chkAll" type="checkbox" /></label>
			<div class="fl">全选</div>
		</div>
		<div class="toobar_chosethis fl">
			<label class="fl"><input id="chkThisPage" type="checkbox" /></label>
			<div class="fl">选择当前页</div>
		</div>
		<div class="toobar_search fl">
			<form class="query_form" action="${queryUrl}" method="post">
				<input name="keyvalueStr" type="text" value="${keyvalueStr}" />
				<#-- 当前页数 -->
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
				<#-- 来源模块（用于标识是从何处穿透至卡片列表） -->
				<input name="fromModel" type="hidden" value="${fromModel}" />
				<input name="dateStr" type="hidden" value="${dateStr}" />
				<input name="zicflidStr" type="hidden" value="${zicflidStr}" />
				<input name="yongtidStr" type="hidden" value="${yongtidStr}" />
				<input name="shiyzkidStr" type="hidden" value="${shiyzkidStr}" />
				<input name="sortpartStr" type="hidden" value="${sortpartStr}" />
				<input name="timeStr" type="hidden" value="${timeStr}" />
				<input name="mothStr" type="hidden" value="${mothStr}" />
				<input name="weixfsidStr" type="hidden" value="${weixfsidStr}" />
				<input name="zicdlrwidStr" type="hidden" value="${zicdlrwidStr}" />
				<input name="beginDateStr" type="hidden" value="${beginDateStr}" />
				<input name="endDateStr" type="hidden" value="${endDateStr}" />
				<input name="qudfsidStr" type="hidden" value="${qudfsidStr}" />
				<#-- 分布情况模块的特别参数 -->
				<input name="fbqkType" type="hidden" value="${fbqkType}" />
				<input name="fbqkOrgid" type="hidden" value="${fbqkOrgid}" />
				<input name="fbqkDeptid" type="hidden" value="${fbqkDeptid}" />
				<#-- 盘点监控模块的特别参数 -->
				<input name="qcjzr" type="hidden" value="${qcjzr}" /> <#-- 清查基准日 -->
				<input name="pdjkType" type="hidden" value="${pdjkType}" />
				<input name="pdjkRwid" type="hidden" value="${pdjkRwid}" />
				<input name="pdjkOrgid" type="hidden" value="${pdjkOrgid}" />
				<input name="pdjkDeptid" type="hidden" value="${pdjkDeptid}" />
				<input name="colType" type="hidden" value="${colType}" />
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
	<div class="toolbar_right fr">
		<#-- 只有指定了 exportUrl 时，才显示导出按钮 -->
		<#if exportUrl??>
			<div class="toolbar_dc fl">
				导出<span></span>
				<div class="tips_dc_wushuju">请选择要导出的数据！</div>
			</div>
		</#if>

		<#-- 只有指定了 printFunction 时，才显示打印按钮 -->
		<#if printFunction??>
			<div class="toolbar_dy fl" onclick="${printFunction}">
				打印 / 预览<span></span>
				<div class="tips_dy_wushuju">您未勾选数据，请选择需要打印的数据！</div>
			</div>
		</#if>

		<#-- 总是显示翻页工具栏 -->
		<div class="toolbar_fy fl">
			<ul>
				<li class="toobar_jt toobar_jtll" pageNo="1" <#if page.hasPrev>able="true"</#if>>
					<a <#if page.hasPrev>href="javascript: void(0)" class="toobar_jtll_a"</#if>></a>
				</li>
				<li class="toobar_jt toobar_jtl" pageNo="${page.prev}" <#if page.hasPrev>able="true"</#if>>
					<a <#if page.hasPrev>href="javascript: void(0)" class="toobar_jtl_a"</#if>></a>
				</li>
				<li class="toobar_pagenum"><input id="page_switch" type="text" value="${page.pageNo}" /></li>
				<li style="width: 10px">/</li>
				<li>${page.totalPageNo}</li>
				<li class="toobar_jt toobar_jtr" pageNo="${page.next}" <#if page.hasNext>able="true"</#if>>
					<a <#if page.hasNext>href="javascript: void(0)" class="toobar_jtr_a"</#if>></a>
				</li>
				<li class="toobar_jt toobar_jtrr" pageNo="${page.totalPageNo}" <#if page.hasNext>able="true"</#if>>
					<a <#if page.hasNext>href="javascript: void(0)" class="toobar_jtrr_a"</#if>></a>
				</li>
			</ul>
		</div>

		<#-- 未指定 noViewMode 或当其为 false 时，显示视图切换按钮 -->
		<#if !noViewMode>
			<div class="toolbar_card fl">
				<a id="toCard"
					<#if VIEW_MODE == "LIST_MODE">href="javascript: void(0)"</#if>
				><span></span></a>
			</div>
			<div class="toolbar_list fl">
				<a id="toList"
					<#if VIEW_MODE == "CARD_MODE">href="javascript: void(0)"</#if>
				><span></span></a>
			</div>
		</#if>
	</div>
</div>