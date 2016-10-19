<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%
	String saveFileName = request.getParameter("saveFileName"); 
	String moduleName = request.getParameter("moduleName"); 
	String url = "/defaultroot/upload/" + moduleName + "/" + saveFileName.substring(0, 6) + "/" + saveFileName;
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>图片预览</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
</head>
<body>
<section class="wh-section">
	<article class="wh-article wh-article-pic">
		<img src="<%=url %>" onerror="javascript:alert('图片不存在!');" />
	</article>
</section> 
</body>
</html>
