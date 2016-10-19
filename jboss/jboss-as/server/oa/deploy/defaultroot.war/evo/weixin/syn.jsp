
<%@page import="com.whir.evo.weixin.bd.WeiXinBD"%><%
if(session.getAttribute("corpid") == null){
	response.sendRedirect("config.jsp");
}else{
	new WeiXinBD().synAllOrgnization();
	%><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><h1>同步完成</h1><a href="config.jsp">返回</a>
<%}%>