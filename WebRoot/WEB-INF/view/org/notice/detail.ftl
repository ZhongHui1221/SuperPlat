<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>公告信息</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/main_org.css" />
	</head>

	<body>
		<div class="container_gg">
			<div class="notice_m_header">
				<div class="notice_yiyue"><a href="javascript:void(0)">已阅</a></div>
				<div class="notice_m_ys">${notice["TITLE"]}</div>
				<div class="notive_m_fb">
					<div class="notice_m_fbz">发布者：${notice["FABZ"]}</div>
					<div class="notice_m_fbsj">发布时间：${notice["FABRQ"]}</div>
				</div>
			</div>
		</div>
		<div class="notice_m_cont">
			<div class="container_gg">
				<div class="notice_m_info">
					<pre>
						${notice["MSG"]}
					</pre>
				</div>
				<div class="notice_m_fj">
					<ul>
						<#list attsCursor as obj>
							<li><a href="${prefixPath}/FileFolder/${obj['TITLE']}.${obj['EXTENSION']}" download>附件 ${obj["FILEINDEX"]}：${obj["TITLE"]}.${obj["EXTENSION"]}</a></li>
						</#list>
					</ul>
				</div>
			</div>
		</div>
	</body>
</html>