$(function(){

	// toolbar功能列表鼠标样式
	$(".toolbar_item").mousedown(function(){
		$(this).addClass("active");
	}).mouseup(function(){
		$(this).removeClass("active");
	});
	$(".yewu_rclyw").click(function(event){
		event.stopPropagation();
		$(".bjlyw_list").hide();
		$(".yewu_bjlyw").removeClass("active");
		if($(".rclyw_list").css("display") == "none"){
			$(this).addClass("active");
			$(".rclyw_list").show();
		}else{
			$(this).removeClass("active");
			$(".rclyw_list").hide();
		}
	});
	$(".yewu_bjlyw").click(function(event){
		event.stopPropagation();
		$(".rclyw_list").hide();
		$(".yewu_rclyw").removeClass("active");
		if($(".bjlyw_list").css("display") == "none"){
			$(this).addClass("active");
			$(".bjlyw_list").show();
		}else{
			$(this).removeClass("active");
			$(".bjlyw_list").hide();
		}
	});
	$(document).click(function(){
		$(".yewu_rclyw, .yewu_bjlyw").removeClass("active");
		$(".rclyw_list, .bjlyw_list").hide();
	});

	function alertTips(info, that){
	}
})

// 卡片列表模式页面动态给列表赋值最大高度
function setMaxheight(hdeff) {
	$(".list_wapper").height($(".container_card").height() - 150 - hdeff);
	$(".list_wapper .list_wapper_content").height($(".list_wapper").height() - 42);
	if ($(".list_wapper_content").height() > $(".list_wapper_content table").height()) {
		$(".list_wapper_header").css("padding-right", "0");
	} else {
		$(".list_wapper_header").css("padding-right", "17px");
	}
}