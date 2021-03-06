<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>申领资产分类-明细资产分类</title>
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
			<li class="gggl_lb"><a href="${request.contextPath}/findZicfl">常用资产分类</a><span></span></li>
			<li class="gggl_xx select"><a href="${request.contextPath}/findXxZicfl">明细资产分类</a><span></span></li>
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
	<div class="syr_mxzcfl">
		<div class="syr_mx one">
			<ul class="mx_one_ul mx_one_fir">
			</ul>
		</div>
		<div class="syr_mx two">
			<ul class="mx_one_sec active">
			</ul>
		</div>
		<div class="syr_mx three">
			<ul class="mx_one_sec active">
			</ul>
		</div>
		<div class="syr_mx four">
			<ul class="mx_one_sec active">
			</ul>
		</div>
	</div>
	<div class="gggl_bottom gggl_bottom_ab">
		<div class="left">您当前选择的是: <span></span></div>
		<input class="iframe_btn gggl_btn_qd" type="button" name="" value="确定" />
	</div>
	<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
	<script>
		//分类数据
		var mxData = ${xxZicfls};
		console.log(mxData[0]);
		
		<#-- 
		var mxData = [
			{name:"一级分类1",children:[
				{name:"二级分类11",children:[
					{name:"三级分类1",children:[
						{name:"四级分类1",children:[
							{name:"末级分类1"},
							{name:"末级分类2"}
						]}
					]},
					{name:"三级分类2",children:[
						{name:"四级分类21",children:[
							{name:"末级分类22"},
							{name:"末级分类23"}
						]}
					]},
					{name:"三级分类4"}
				]},
				{name:"二级分类12",children:[
					{name:"三级分类5",children:[
						{name:"四级分类4",children:[
							{name:"末级分类9"},
							{name:"末级分类fssv"}
						]}
					]},
					{name:"三级分类6"},
					{name:"三级分类7"}
				]}
			]},
			{name:"一级分类2",children:[
				{name:"二级分类22",children:[
					{name:"三级分类1"},
					{name:"三级分类2"},
					{name:"三级分类3"},
					{name:"三级分类4"}
				]},
				{name:"二级分类24",children:[
					{name:"三级分类1"},
					{name:"三级分类2"},
					{name:"三级分类3"},
					{name:"三级分类4"}
				]},
				{name:"二级分类23",children:[
					{name:"三级分类23"},
					{name:"三级分类23"},
					{name:"三级分类21"},
					{name:"三级分类24"}
				]}
			]},
			{name:"一级分类3",children:[
				{name:"二级分类31",children:[
					{name:"三级分类31"},
					{name:"三级分类32"},
					{name:"三级分类3"},
					{name:"三级分类4"}
				]}
			]}
		]
		-->

		function dataLoad(){
			var fl_cls1 = mxData.length;
			for (var i = 0;i< fl_cls1; i++){//一级分类
				var fl_cls2 = mxData[i].children.length;
				$('.one .mx_one_fir').append('<li classid='+mxData[i].id+' nochild='+!mxData[i].children+'><p><span class="w_icon"></span><span class="fl_class1"></span><i></i></p><ul class="mx_one_sec"></ul></li>');
				$('.one p').eq(i).children('.fl_class1').html(mxData[i].name);
				$('.syr_cyzcfl_right>ul').eq(i).children('li').children('.left').html(mxData[i].name+"<i></i>");
				for(var j = 0;j < fl_cls2; j++){//二级分类
					var fl_cls3 = mxData[i].children[j].children.length;
					$('.one .mx_one_fir>li').eq(i).children('.mx_one_sec').append('<li classid='+mxData[i].children[j].id+' nochild='+!mxData[i].children[j].children+'></li>');
					$('.one .mx_one_fir>li').eq(i).children('.mx_one_sec').children('li').eq(j).html(mxData[i].children[j].name+"<i></i>");
				}
			}
		}

		function dataFill(data,container){
			
			$(container+' .mx_one_sec').html('');
			if(data){
				console.log('container:'+container);
				console.log('data:'+data);
				for (var i = 0;i<data.length;i++){
					$(container+' .mx_one_sec').append('<li zcflid='+data[i].id+' nochild='+!data[i].children+'>'+data[i].name+'<i></i></li>');
				}
			}
		}

		$(function(){
			$(dataLoad);
			$('.gggl_header li').click(function(){
				$(this).addClass('select').siblings().removeClass('select');
				$('.container>div').eq($(this).index()).addClass('active').siblings().removeClass('active');
			});

			$(document).delegate('.mx_one_ul li','click',function(){
				$(this).children('.mx_one_sec').slideToggle();
			});
			$(document).delegate(".mx_one_sec li",'click',function(event) {
			    event.stopPropagation();
			});

			$('.gggl_btn_qd').click(function(){
				if ($('li.active:last').attr('nochild') == true){
					alert('请选择资产节点一直到末级节点');
				} else {
					window.parent.closePublicModal();
					var index = window.parent.layer.open({
						type:2,
						title:'申领资产详情',
						content:'./page/shenling/sl_zcxq.html',
						area:['800px','560px']
					})
					window.parent.alertEditModal("申领资产详情","./page/shenling/sl_zcxq.html");
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
									console.log("SUCCESS")
									searchResultList(json.datas);
								}
							}else{
								console.log( json.info);
							}
						}
					);
			});
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

			//一级
			$(document).delegate('.one li li','click',function(){
				var $oneIndex = $(this).parents('li').index();
				var $thisIndex = $(this).index();
				var $childCount = mxData[$oneIndex].children[$thisIndex].children;
				$('.three ul,.four ul').html('');
				$('.one li li').removeClass('active');
				$(this).addClass('active');
				dataFill($childCount,'.two');
				$('.gggl_bottom_ab span').html($(this).html());
			});
			
			// 二级
			$(document).delegate('.two li','click',function(){
				var $oneIndex = $('.one li li.active').parents('li').index();
				var $twoIndex = $('.one li li.active').index();
				var $thisIndex = $(this).index();
				var $childCount = mxData[$oneIndex].children[$twoIndex].children[$thisIndex].children;
				$('.four ul').html('');
				$('.two li').removeClass('active');
				$(this).addClass('active');
				dataFill($childCount,'.three');
				$('.gggl_bottom_ab span').html($('.one ul ul li.active').html()+"->"+$(this).html());
			});
			// 三级
			$(document).delegate('.three li','click',function(){
				var $oneIndex = $('.one li li.active').parents('li').index();
				var $twoIndex = $('.one li li.active').index();
				var $threeIndex = $('.two li.active').index();
				var $thisIndex = $(this).index();
				var $childCount = mxData[$oneIndex].children[$twoIndex].children[$threeIndex].children[$thisIndex].children;
				$('.three li').removeClass('active');
				$(this).addClass('active');
				dataFill($childCount,'.four');
				$('.gggl_bottom_ab span').html($('.one ul ul li.active').html()+"->"+$('.two li.active').html()+"->"+$(this).html());
			});
			// 四级
			$(document).delegate('.four ul li','click',function(){
				$('.four ul li').removeClass('active');
				$(this).addClass('active');
				$('.gggl_bottom_ab span').html($('.one ul ul li.active').html()+"->"+$('.two li.active').html()+"->"+$('.three li.active').html()+"->"+$(this).html());
			});
			// 通用
			$(document).delegate('.mx_one_sec li','click',function(){
				var zcflid = $(this).attr("zcflid");
				$('.gggl_bottom_ab span').attr("zcflid",zcflid);
				$(this).addClass('active');
			});
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