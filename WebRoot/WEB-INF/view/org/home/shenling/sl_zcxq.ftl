<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>申领资产分类</title>
	<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	<style>
		body{
			min-width:534px;
		}
	</style>
</head>
<body>
	<form id="syr_zcsl" class="syr_zcslxq" action="" method="" name="">
		<table>
			<colgroup>
				<col width="17%"></col>
				<col width="33%"></col>
				<col width="17%"></col>
				<col width="33%"></col>
			</colgroup>
			<tr>
				<td class="edit_shenl_t"><span>*</span>资产分类：</td>
				<td>
					<input type="text" zcflid="${checkedIdStr}" name="shenl_zcfl" value="${objnameStr}"/>
				</td>
				<td class="edit_shenl_t"><span>*</span>预计单价：</td>
				<td class="mustnumber"><input type="text" name="shenl_yjdj"/ value="0.00"></td>
			</tr>
			<tr>
				<td class="edit_shenl_t"><span>*</span>资产名称：</td>
				<td><input type="text" name="shenl_zcmc" value="${objnameStr}"/></td>
				<td class="edit_shenl_t"><span>*</span>申报数量：</td>
				<td class="mustnumber"><input type="text" name="shenl_sbsl" value="1"/></td>
			</tr>
			<tr>
				<td class="edit_shenl_t"><span>&nbsp;</span>规格要求：</td>
				<td><input type="text" name="shenl_guigxh"/></td>
				<td class="edit_shenl_t"><span>&nbsp;</span>预计总价：</td>
				<td class="mustnumber"><input type="text" name="shenl_yjzj" value="0.00"/></td>
			</tr>
			<tr>
				<td class="edit_shenl_t"><span>*</span>申领用途：</td>
				<td>
					<select name="shenl_slyt" id="">
						<option value=""></option>
						<#list yt as obj>
							<option value="${obj['rwid']}">${obj["objname"]}</option>
						</#list>
					</select>
				</td>
			</tr>
			<tr>
				<td class="edit_shenl_t mg_t30"><span>&nbsp;</span>备注信息：</td>
				<td colspan="3"><textarea name="shenl_slyy" id="" cols="30" rows="10"></textarea></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td colspan="2">
					<span class="w_iframe_btn w_cancel_btn fr w_btn_last">取消</span>
					<button class="w_iframe_btn w_sure_btn fr" type="button">确定</button>
				</td>
			</tr>
		</table>
	</form>
	<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
	<script>
		$(function(){
			//计算总价
			$('input[name="shenl_yjdj"],input[name="shenl_sbsl"]').keyup(function(){
				var unit = $('input[name="shenl_yjdj"]').val();
				var num = $('input[name="shenl_sbsl"]').val();
				$('input[name="shenl_yjzj"]').val(unit*num);
				console.log('单价'+unit+'数量'+num);
			});
			// input键盘事件，只能输入二位小数
			$('.mustnumber').on("keyup", "input", function(){
				var val = $(this).val();
				val = val.replace(/[^\d.]/g,"").replace(/^\./g,"").replace(/\.{2,}/g,".").replace(".","$#$").replace(/\./g,"").replace("$#$",".").replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');
				$(this).val(val);
			}).on("keypress", "input", function(){
				var keyCode = event.keyCode;
				if ((keyCode >= 48 && keyCode <= 57 || keyCode == 46)){
					event.returnValue = true;
				} else {
					event.returnValue = false;
				}
			});

			$('.w_sure_btn').click(function(){
				var shenl_zcfl = starIsEmpty($('input[name="shenl_zcfl"]'));
				var shenl_yjdj = starIsEmpty($('input[name="shenl_yjdj"]'));
				var shenl_zcmc = starIsEmpty($('input[name="shenl_zcmc"]'));
				var shenl_sbsl = starIsEmpty($('input[name="shenl_sbsl"]'));
				if (shenl_zcfl && shenl_yjdj && shenl_zcmc && shenl_sbsl){
					if ($('select[name="shenl_slyt"]').val() != ""){
						var zicflid = $("input[name='shenl_zcfl']").attr("zcflid");
						var zicmc = $("input[name='shenl_zcmc']").val();
						var guigxh = $("input[name='shenl_guigxh']").val();
						var yujdj = $("input[name='shenl_yjdj']").val();
						var yujjz = $("input[name='shenl_yjzj']").val();
						var shul = $("input[name='shenl_sbsl']").val();
						var shenlyy = $("textarea[name='shenl_slyy']").val();
						var shenlytid = $('select[name="shenl_slyt"]').val();
						$.post(
							"${request.contextPath}/orgSlpz/addSld/${currentUser.currentRoleCode}",
							{"_method" : "PUT",
							"zicflid" : zicflid,
							"zicmc" : zicmc,
							"guigxh" : guigxh,
							"yujdj" : yujdj,
							"yujjz" : yujjz,
							"shul" : shul,
							"shenlyy" : shenlyy,
							"shenlytid" : shenlytid
							},
							function(data){
								if(data == "SUCCESS"){
									//window.parent.closeEditModal();
									window.parent.layer.closeAll();
									$(window.parent.document.getElementById("wysl").contentWindow.document).find(".query_form").submit();
								}else{
									alert(data);
								}
							}
						);
						return;
					} else {
						//window.parent.alertWMeg("带*为必填项,请填写完整");
					}
				} else {
					//window.parent.alertWMeg("带*为必填项,请填写完整");
				}
			});

			$(".syr_cyzcfl_left li").hover(function(){//一级目录
				$(this).addClass('active').siblings().removeClass('active');
				$('.syr_cyzcfl_right>ul').eq($(this).index()).addClass('active').siblings().removeClass('active');
			});

			$('.syr_cyzcfl_sec .right li').click(function(){//末级目录
				$('.gggl_bottom_ab .left span').html($(this).html());
			});

			$('.gggl_btn_qd').click(function(){
				if ($('.gggl_bottom_ab .left span').html() == ''){
					alert('请选择资产节点一直到末级节点');
				} else {
					$('.edit_shenl').show();
				}
			});
			$('.edit_modal_close').click(function(){
				$('.edit_shenl').hide();
			});

			$('#shenl_search').focus(function(event){
				event.stopPropagation();
				$('.search_box').show();
			}).keyup(function(){
				//此处执行搜索
			});

			$("input[name ='shenl_zcfl']").focus(function(){
				window.parent.layer.closeAll();
				var index = layer.open({
					type:2,
					title:'申领资产分类',
					content:'${request.contextPath}/findZicfl',
					area:['800px','560px']
				})
				<#--window.parent.closeEditModal();
				window.parent.alertPublicModal("申领资产分类","${request.contextPath}/findZicfl");-->
			});

			$('.search_wrap span').click(function(event){
				event.stopPropagation();
				if ($('.search_box').css('display') == 'none'){
					$('.search_box').show();
				} else {
					$('.search_box').hide();
				}
			});
			$('.search_box li').click(function(){
				$('.gggl_bottom_ab .left span').html($(this).html());
				$('.search_box').hide();
				$('#shenl_search').val($(this).html());
			});

			$('.zl_about_close').click(function(){
				$('.public_modal').hide();
			});

			function starIsEmpty(ele){//带星号的不能为空
				if (ele.val()== ""){
					return false;
				} else {
					return true;
				}
			}
		})
	</script>
</body>
</html>