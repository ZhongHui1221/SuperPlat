/* 图表页面配置封装 */

// 颜色设置
var color = [ "#5BBFE9", "#AAABF5", "#6ED2D2", "#f8968c", "#4BC07F", "#D6B4FB","#ABE7E6", "#FCC86B", "#FCB883", "#FBA365", "#F8968C", "#96E5FF", "#6DDC8D","#FEB6D1", "#4ED6EF", "#A6E59F", "#FCDE5A", "#53D1B2", "#98ABFF","#B7E0CC", "#C7E59F" ];

// 饼图
function pie_option(data, obj, option, targetTabId, targetTabTitle, targetTabUrl) {
	option = {
		tooltip: {
			trigger: 'item',
			formatter: "{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'vertical',
			right: '2%',
			top: "3%",
			itemWidth: 20,
			itemGap: 5,
			padding: [2, 2],
			data: data.legend
		},
		series: [{
			color: color,
			type: 'pie',
			radius: '68%',
			center: ['40%', '50%'],
			data: data.data,
			itemStyle: {
				normal: {
					borderWidth: 0.5,
					borderColor: "#fff",
					label: {
						show: true,
						formatter: "{d}%"
					},
					labelLine: {
						show: true
					}
				},
				emphasis: {
					shadowBlur: 10,
					shadowOffsetX: 0,
					shadowColor: 'rgba(0, 0, 0, 0.5)'
				}
			}
		}]
	};
	// 生成图表
	obj.setOption(option);
	// 图表点击
	// params: node 点击到的图表对象
	obj.on('click',
	function(node) {
		addTabByForm(targetTabId, targetTabTitle, targetTabUrl + "/" + node.data.id, "get");
	});
}

// 禁止点击的饼图（针对“减少情况”）
function pie_option_noclick(data, obj, option) {
	option = {
		tooltip: {
			trigger: 'item',
			formatter: "{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'vertical',
			right: '2%',
			top: "3%",
			itemWidth: 20,
			itemGap: 5,
			padding: [2, 2],
			data: data.legend
		},
		series: [{
			color: color,
			type: 'pie',
			radius: '68%',
			center: ['30%', '50%'],
			data: data.data,
			hoverAnimation: false,
			itemStyle: {
				normal: {
					label: {
						show: true,
						formatter: "{d}%"
					},
					labelLine: {
						show: true
					}
				},
				emphasis: {
					shadowBlur: 0,
					shadowOffsetX: 0,
					shadowColor: 'rgba(0, 0, 0, 0.5)'
				}
			}
		}],
		graphic: {
			elements: {
				cursor: 'default'
			}
		}
	};
	// 生成图表
	obj.setOption(option);
}

// 柱状图
function bar_option(data, obj, option, targetTabId, targetTabTitle, targetTabUrl) {
	// 图表配置
	option = {
		color: color,
		tooltip: {
			formatter: '{b}<br/>{a}: {c}'
		},
		grid: {
			left: '2%',
			right: '2%',
			bottom: '36',
			height: '80%',
			containLabel: true
		},
		xAxis: [{
			type: 'category',
			data: data.legend,
			axisTick: {
				alignWithLabel: true
			},
			axisLabel: {
				//rotate: 30,
				interval: 0
			}
		}],
		yAxis: [{
			type: 'value'
		}],
		series: [{
			name: '值',
			type: 'bar',
			barWidth: '35',
			itemStyle: {
				normal: {},
				emphasis: {
					barBorderWidth: 1,
					shadowBlur: 10,
					shadowOffsetX: 0,
					shadowOffsetY: 0,
					shadowColor: 'rgba(0,0,0,0.5)'
				}
			},
			data: data.data
		}]
	};
	obj.setOption(option);
	// 图表点击
	// params: node 点击到的图表对象
	obj.on('click',
	function(node) {
		addTabByForm(targetTabId, targetTabTitle, targetTabUrl + "/" + node.data.id, "get");
	});
}

// 堆叠柱状图
function ddbar_option(data, obj, option, ifstack, targetTabId, targetTabTitle, targetTabUrl) {
	// 定义单元柱图样式
	var itemStyle = {
		normal: {},
		emphasis: {
			barBorderWidth: 1,
			shadowBlur: 10,
			shadowOffsetX: 0,
			shadowOffsetY: 0,
			shadowColor: 'rgba(0,0,0,0.5)'
		}
	};
	// 定义数据配置项
	var series = [];
	for (var i = 0; i < data.data.length; i++) {
		series.push({
			name: data.data[i].name,
			type: 'bar',
			stack: ifstack,
			itemStyle: itemStyle,
			barWidth: '35',
			data: data.data[i].value
		})
	}
	// 图表配置
	option = {
		tooltip: {},
		color: ["#449BE3", "#F5A623"],
		legend: {
			data: data.legend
		},
		grid: {
			left: '2%',
			right: '2%',
			bottom: '36',
			height: '75%',
			containLabel: true
		},
		yAxis: {
			type: 'value'
		},
		xAxis: {
			type: 'category',
			axisLabel: {
				interval: 0
			},
			data: data.used
		},
		series: series
	};
	// 生成图表
	obj.setOption(option);
	obj.on('click',
	function(node) {
		addTabByForm(targetTabId, targetTabTitle, targetTabUrl + "/" + node.data.id, "get");
	});
}

// 折线图
/* 参数说明
		data:     图表数据
		obj:      echarts图表对象
		option:   图表对象配置名称
		name:     鼠标悬浮到相应节点时提示文字
		ifclick:  是否支持点击事件
*/
function line_option(data, obj, option, name, ifclick) {
	// 折线图配置
	option = {
		tooltip: {
			trigger: 'axis',
			axisPointer: {
				lineStyle: {
					color: "#999"
				}
			}
		},
		grid: {
			left: '2%',
			right: '3%',
			height: '75%',
			bottom: '36',
			containLabel: true
		},
		xAxis: {
			type: 'category',
			boundaryGap: false,
			data: data.legend
		},
		yAxis: {
			type: 'value'
		},
		series: [{
			itemStyle: {
				normal: {
					label: {
						show: true,
						formatter:function(a,b,c){
							var result = [ ], counter = 0;
							var num_array = String(a.data).split('.');
							var num = num_array[0];
							var newstr = '';
							for (var i = num.length - 1; i >= 0; i--) {
								counter++;
								result.unshift(num[i]);
								if (!(counter % 3) && i != 0) { result.unshift(','); }
								}
								if(num_array.length>1){
									newstr = result.join('');
									newstr += '.'+num_array[1];
									return newstr;
								}else{
									return result.join('');
							}
						}
					},
					color: '#4A9BFF'
				}
			},
			name: name,
			type: 'line',
			stack: '总量',
			data: data.data
		}]
	};
	// 生成图表
	obj.setOption(option);
	obj.on('click',
 	function(node) {
		if (ifclick) {
			alert(node.data);
		} else {
			return false;
		}
	});
}

// 表单提交方式新增页签
function addTabByForm(targetTabId, targetTabTitle, targetTabUrl, method) {
	var error = "缺失必要的属性：";
	if (targetTabId == undefined) {
		error += "targetTabId、";
	}
	if (targetTabTitle == undefined) {
		error += "targetTabTitle、";
	}
	if (targetTabUrl == undefined) {
		error += "targetTabUrl、";
	}
	if (method == undefined) {
		error += "method、";
	}
	if (error != "缺失必要的属性：") {
		alert(error.substring(0, error.length - 1));
		return;
	}

	window.parent.f_addTab(targetTabId, targetTabTitle);
	// 获取当前选中页签的 tabid
	var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
	// 获取当前显示的 iframe
	var $div = $(window.parent.document).find("div[tabid='" + tabid + "']");
	// 事先将 iframe 清空
	$div.empty();
	var htmlStr = '<div class="l-tab-loading" style="display: block"></div>';
	htmlStr += '<iframe id="' + tabid + '" name="' + tabid + '" src="' + targetTabUrl + '" frameborder="0"></iframe>';
	htmlStr += '<form id="' + tabid + '" action="' + targetTabUrl + '" target="' + tabid + '" method="' + method + '"></form>';
	$div.append(htmlStr);
	$(window.parent.document).find("form[id='" + tabid + "']").submit();
}