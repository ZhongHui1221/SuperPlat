<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
		<title>房屋信息</title>
		<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css" />
		<style>
			body {
				font-family: "微软雅黑";
				font-size: 14px;
			}
			.marker_wapper {
				position: absolute;
				left: 50%;
			}
			.marker {
				padding: 4px 7px;
				border-radius: 5px;
				color: #fff;
				max-width: 300px;
				white-space: nowrap;
				transition: 0.2s;
			}
			.marker_icon {
				width: 0;
				height: 0;
				border: 10px solid transparent;
				margin: 0 auto;
				transition: 0.2s;
			}
			.marker_xz {
				background: #FF3034;
			}
			.marker_zy {
				background: #66B336;
			}
			.marker_zj {
				background: #FF3034;
			}
			.marker_bfzj {
				background: #F9AC2D;
			}
			.marker_icon_xz {
				border-top-color: #FF3034;
			}
			.marker_icon_zy {
				border-top-color: #66B336;
			}
			.marker_icon_zj {
				border-top-color: #FF3034;
			}
			.marker_icon_bfzj {
				border-top-color: #F9AC2D;
			}
			.marker_wapper:hover .marker_xz{
				background:#D42B2E;
			}
			.marker_wapper:hover .marker_zy{
				background:#57992D;
			}
			.marker_wapper:hover .marker_zj{
				background:#D42B2E;
			}
			.marker_wapper:hover .marker_bfzj{
				background:#FF9500;
			}
			.marker_wapper:hover .marker_icon_xz{
				border-top-color:#D42B2E;
			}
			.marker_wapper:hover .marker_icon_zy{
				border-top-color:#57992D;
			}
			.marker_wapper:hover .marker_icon_zj{
				border-top-color:#D42B2E;
			}
			.marker_wapper:hover .marker_icon_bfzj{
				border-top-color:#FF9500;
			}
		</style>
	</head>

	<body>
		<div id="container"></div>
		<div class="button-group">
			<input id="setFitView" class="button" type="button" value="地图自适应显示" />
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="http://webapi.amap.com/maps?v=1.3&key=您申请的key值"></script>
		<script>
			// 生成toolBar
			window.onload = function() {
				map.plugin(["AMap.ToolBar"], function() {
					map.addControl(new AMap.ToolBar());
				});
				if(location.href.indexOf('&guide=1')!==-1){
					map.setStatus({scrollWheel:false})
				}
			}

			// 创建地图对象
			var map = new AMap.Map("container");

			// 点标记集合
			var markers = ${fwxxData};

			// 对IE8不兼容forEach的兼容处理
			if (!Array.prototype.forEach) {
				Array.prototype.forEach = function(fun /*, thisp*/) {
					var len = this.length;
					if (typeof fun != "function")
					throw new TypeError();
					var thisp = arguments[1];
					for (var i = 0; i < len; i++) {
						if (i in this)
						fun.call(thisp, this[i], i, this);
					}
				};
			}

			markers.forEach(function(data) {

				// 根据房屋状态显示不同样式的 marker
				switch(data.fwztmc) {
					case "闲置":
						var marker = new AMap.Marker({
							map: map,

							content: '<div class="marker_wapper" rwid="' + data.rwid + '" objcode="' + data.objcode + '">' +
											'<div class="marker marker_xz" fwztmc="' + data.fwztmc + '" mianj="' + data.mianj + '" zicmc="' + data.zicmc + '" danwjc="' + data.danwjc + '">' + data.fwztmc + "：" + data.mianj + 'm²' + '</div><div class="marker_icon marker_icon_xz"></div></div>',
							position: [data.position[0], data.position[1]]
						});
						break;
					case "在用":
						var marker = new AMap.Marker({
							map: map,
							content: '<div class="marker_wapper" rwid="' + data.rwid + '" objcode="' + data.objcode + '">' +
											'<div class="marker marker_zy" fwztmc="' + data.fwztmc + '" mianj="' + data.mianj + '" zicmc="' + data.zicmc + '" danwjc="' + data.danwjc + '">'+ data.fwztmc + "：" + data.mianj + 'm²' + '</div><div class="marker_icon marker_icon_zy"></div></div>',
							position: [data.position[0], data.position[1]]
						});
						break;
					case "部分租借":
						var marker = new AMap.Marker({
							map: map,
							content: '<div class="marker_wapper" rwid="' + data.rwid + '" objcode="' + data.objcode + '">' +
											'<div class="marker marker_bfzj" fwztmc="' + data.fwztmc +'" mianj="' + data.mianj +'" zicmc="' + data.zicmc + '" danwjc="' + data.danwjc + '">' + data.fwztmc + "：" + data.mianj + 'm²' + '</div><div class="marker_icon marker_icon_bfzj"></div></div>',
							position: [data.position[0], data.position[1]]
						});
						break;
					case "租借":
						var marker = new AMap.Marker({
							map: map,
							content: '<div class="marker_wapper" rwid="' + data.rwid + '" objcode="' + data.objcode + '">' +
											'<div class="marker marker_zj" fwztmc="' + data.fwztmc +'" mianj="' + data.mianj +'" zicmc="' + data.zicmc + '" danwjc="' + data.danwjc + '">' + data.fwztmc + "：" + data.mianj + 'm²' + '</div><div class="marker_icon marker_icon_zj"></div></div>',
							position: [data.position[0], data.position[1]]
						});
						break;
					default:
						var marker = new AMap.Marker({
							map: map,
							content: '<div class="marker_wapper" rwid="' + data.rwid + '" objcode="' + data.objcode + '">' +
											'<div class="marker marker_xz" fwztmc="' + data.fwztmc +'" mianj="' + data.mianj +'" zicmc="' + data.zicmc + '" danwjc="' + data.danwjc + '">' + data.fwztmc + "：" + data.mianj + 'm²' + '</div><div class="marker_icon"></div></div>',
							position: [data.position[0], data.position[1]]
						});
				}

				// 鼠标滑过点标时的文字提示
				marker.setTitle(data.zicmc);
			});

			// 地图缩放事件监听
			AMap.event.addListener(map, "zoomend", function() {
				var map_zoom = map.getZoom();
				if (map_zoom <= 10) {
					$(".marker").each(function() {
						$(this).html($(this).attr("fwztmc"));
						var parent = $(this).parent(".marker_wapper");
						parent.css({"margin-left": - parent.width() / 2});
					});
				} else if (map_zoom > 10 && map_zoom <= 14) {
					$(".marker").each(function() {
						$(this).html($(this).attr("fwztmc") + "：" + $(this).attr("mianj") + " m²");
						var parent = $(this).parent(".marker_wapper");
						parent.css({"margin-left": - parent.width() / 2, "top": "0"});
					});
				} else if (map_zoom > 15) {
					$(".marker").each(function() {
						$(this).html($(this).attr("danwjc") + "<br />" + $(this).attr("fwztmc") + "：" + $(this).attr("mianj") + " m²");
						var parent = $(this).parent(".marker_wapper");
						parent.css({"margin-left": - parent.width() / 2, "top": "-20px"});
					});
				}
			});

			// 鼠标悬浮调整marker层级关系
			$("#container").on("mouseenter", ".marker", function(){
				$(this).parents(".amap-marker").css("z-index", "101");
			}).on("mouseleave", ".marker", function(){
				$(this).parents(".amap-marker").css("z-index", "100");
			});

			//marker添加点击弹出卡片事件
			$("#container").on("click", ".marker", function(){
				var rwid = $(this).parent(".marker_wapper").attr("rwid");
				var objcode = $(this).parent(".marker_wapper").attr("objcode");
				$cardModal.prop("src", "${request.contextPath}/Query/BsAstCard/card/" + rwid + "/" + objcode);
				window.parent.alertCard();
			})


			// 为 setFitView 按钮添加事件监听
			AMap.event.addDomListener(document.getElementById("setFitView"), "click", function() {
				var newCenter = map.setFitView();
			});

			// 地图自适应显示（该行代码应始终位于 script 块的末端）
			map.setFitView();
			// 判断浏览器版本是否为IE8，修复IE8Marker信息显示问题
			if(navigator.appName == "Microsoft Internet Explorer" && (navigator.appVersion.match(/8./i)=="8."
			 || navigator.appVersion.match(/9./i)=="9.")){
				map.setZoom(15);
			}

		</script>
	</body>
</html>