<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>申领资产分类</title>
	<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	<style>
		.search_box li{
			white-space:nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}
	</style>
</head>
<body>
	<div class="gggl_header">
		<ul class="gggl_tabs fl">
			<li class="gggl_lb select"><a href="${request.contextPath}/findZicfl">常用资产分类</a><span></span></li>
			<li class="gggl_xx"><a href="${request.contextPath}/findXxZicfl">明细资产分类</a><span></span></li>
		</ul>
		<div class="search_list fr">
			<span class="search_list_note fl">类目搜索:</span>
			<form class="fl" action="">
				<div class="search_wrap">
					<input id="shenl_search" type="search">
					<span></span>
				</div>
				<div class="search_box">
					<ul class="search_result_list">
					</ul>
				</div>
			</form>
		</div>
	</div>
	<div class="syr_slzcfl">
		<div class="syr_cyzcfl active">
			<ul class='syr_cyzcfl_left fl'>
			</ul>
			<div class="syr_cyzcfl_right fl">
			</div>
		</div>
	</div>
	<div class="gggl_bottom gggl_bottom_ab">
		<div class="left">您当前选择的是: <span></span></div>
		<input class="iframe_btn gggl_btn_qd" type="button" name="" value="确定" />
	</div>
	<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
	<script>
		//分类数据
		var cyData = ${zicflTree};
		<#-- 
		var cyData = [
			{name:'房屋及附属设备',id:'fir1',children:[
				{name:"房屋二级分类1",id:'sec11',children:[
					{name:"房屋三级分类1",id:'thd111'},
					{name:"房屋三级分类2",id:'thd112'},
					{name:"房屋三级分类3",id:'thd113'},
					{name:"房屋三级分类2",id:'thd114'},
					{name:"房屋三级分类4",id:'thd115'}
				]},
				{name:"房屋二级分类2",id:'sec12',children:[
					{name:"房屋三级分类5",id:'thd121'},
					{name:"房屋三级分类6",id:'thd122'},
					{name:"房屋三级分类7",id:'thd123'}
				]},
				{name:"房屋二级分类3",id:'sec13',children:[
					{name:"房屋三级分类31",id:'thd131'},
					{name:"房屋三级分类32",id:'thd132'},
					{name:"房屋三级分类33",id:'thd133'}
				]}
			]},
			{name:'计算机设备及软件',id:'fir2',children:[
				{name:"计算机二级分类1",children:[
					{name:"计算机三级分类1"},
					{name:"计算机三级分类2"},
					{name:"计算机三级分类3"},
					{name:"计算机三级分类2"},
					{name:"计算机三级分类3"},
					{name:"计算机三级分类2"},
					{name:"计算机三级分类3"},
					{name:"计算机三级分类4"}
				]},
				{name:"计算机二级分类2",children:[
					{name:"计算机三级分类5"},
					{name:"计算机三级分类6"},
					{name:"计算机三级分类7"}
				]},
				{name:"计算机二级分类3",children:[
					{name:"计算机三级分类31"},
					{name:"计算机三级分类32"},
					{name:"计算机三级分类33"}
				]},
				{name:"计算机二级分类4",children:[
					{name:"计算机三级分类41"},
					{name:"计算机三级分类42"},
					{name:"计算机三级分类43"},
					{name:"计算机三级分类44"}
				]}
			]},
			{name:'办公设备',id:'fir3',children:[
				{name:"办公二级分类1",children:[
					{name:"办公三级分类1"},
					{name:"办公三级分类2"},
					{name:"办公三级分类3"},
					{name:"办公三级分类2"},
					{name:"办公三级分类3"},
					{name:"办公三级分类2"},
					{name:"办公三级分类3"},
					{name:"办公三级分类4"}
				]},
				{name:"办公二级分类2",children:[
					{name:"计算机三级分类5"},
					{name:"计算机三级分类6"},
					{name:"计算机三级分类7"}
				]},
				{name:"办公二级分类3",children:[
					{name:"办公三级分类31"},
					{name:"办公三级分类32"},
					{name:"办公三级分类33"}
				]},
				{name:"办公二级分类4",children:[
					{name:"办公三级分类41"},
					{name:"办公三级分类42"},
					{name:"办公三级分类43"},
					{name:"办公三级分类44"}
				]}
			]},
			{name:'数码电器',id:'fir4',children:[
				{name:"数码二级分类1",children:[
					{name:"数码三级分类1"}
				]},
				{name:"数码二级分类2",children:[
					{name:"计算机三级分类5"}
				]},
				{name:"数码二级分类3",children:[
					{name:"数码三级分类31"}
				]}
			]},
			{name:'交通运输设备'},
			{name:'图书档案'},
			{name:'动植物'},
			{name:'家具用具'},
			{name:'无形资产'}
		]
		-->

		function dataLoad(){
			for (var i = 0;i< cyData.length ; i++){
				$('.syr_cyzcfl_left').append('<li><i></i>'+cyData[i].OBJNAME+'</li>');//一级分类
			}
		}

		$(function(){
			$(dataLoad);
			$(document).delegate(".syr_cyzcfl_left li","click",function(){
				var $thisUl = cyData[$(this).index()].children;//二级分类
				$(this).addClass('active').siblings().removeClass('active');
				$('.syr_cyzcfl_right').html('');
				for (var i = 0;i< $thisUl.length ; i++){
					$('.syr_cyzcfl_right').append('<ul class="syr_cyzcfl_sec active"><li class="active"><div class="left fl"><i></i></div><div class="right fl"><ul></ul></div></li></ul>');
					$('.syr_cyzcfl_right>ul').eq(i).children('li').children('.left').html($thisUl[i].OBJNAME+"<i></i>");//二级
					for(var j = 0;j < $thisUl[i].children.length; j++){
						$('<li zcflid='+$thisUl[i].children[j].RWID+'>'+$thisUl[i].children[j].OBJNAME+'</li>').appendTo($('.syr_cyzcfl_right .syr_cyzcfl_sec').eq(i).children('li').children('.right').children('ul'));//三级
					}
				}
			})

			$(document).delegate('.syr_cyzcfl_sec .right li','click',function(){//末级目录
				$('.gggl_bottom_ab .left span').attr('zcflid_str',$(this).attr('zcflid'));
				$('.gggl_bottom_ab .left span').html($(this).html());
			})

			$('.gggl_btn_qd').click(function(){
				if ($('.gggl_bottom_ab .left span').html() == ''){
					alert('请选择资产节点一直到末级节点');
				} else {
					var strZcflid = $('.gggl_bottom_ab .left span').attr('zcflid_str');
					var strObjname  = $('.gggl_bottom_ab .left span').html();
					window.parent.layer.closeAll();
					var index = window.parent.layer.open({
						type:2,
						title:'申领资产详情',
						content:"${request.contextPath}/orgSlpz/getShenlzcXqpage/${currentUser.currentRoleCode}/" + strZcflid + "/" + strObjname,
						area:['536px','289px']
					})
					<#--window.parent.closePublicModal();
					window.parent.alertEditModal("申领资产详情","${request.contextPath}/orgSlpz/getShenlzcXqpage/${currentUser.currentRoleCode}/" + strZcflid + "/" + strObjname);-->
				}
			})
			$('.edit_modal_close').click(function(){
				$('.edit_shenl').hide();
			})

			$('#shenl_search').focus(function(event){
				event.stopPropagation();
				$('.search_box').show();
			}).keyup(function(){
				//获取搜索关键字
				var keyvalueStr = $('#shenl_search').val();
				console.log(keyvalueStr);
				//此处执行搜索
				$.post(
					"${request.contextPath}/findZicflQuick",
					{"_method" : "POST",
					"keyvalueStr" : keyvalueStr
					},
					function(data){
						var json = eval('(' + data + ')');
						if(json.stat == "SUCCESS"){
							if (json.datas != undefined){
								searchResultList(json.datas);
							}
						}else{
							console.log( json.info);
						}
					}
				);
			});

			$("input[name ='shenl_zcfl']").focus(function(){
				$('.edit_shenl').hide();
			})

			$('.search_wrap span').click(function(event){
				event.stopPropagation();
				if ($('.search_box').css('display') == 'none'){
					$('.search_box').show();
				} else {
					$('.search_box').hide();
				}
			})
			$(document).delegate('.search_box li','click',function(){
				$('.gggl_bottom_ab .left span').html($(this).html());
				$('.search_box').hide();
				$('#shenl_search').val($(this).html());
			})

			$('.zl_about_close').click(function(){
				$('.public_modal').hide();
			})
		});

		function searchResultList(data){
			$('.search_result_list').html('');
			for (i = 0;i<8;i++){
				$('.search_result_list').append('<li>'+data[i].OBJNAME+'</li>');
			}
		}
	</script>
</body>
</html>
