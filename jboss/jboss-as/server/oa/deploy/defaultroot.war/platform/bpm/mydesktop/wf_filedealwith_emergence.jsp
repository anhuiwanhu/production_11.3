<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.whir.i18n.Resource"%> 
<%@ include file="/public/include/init.jsp"%>
<%
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
 
<table width="100%" height="85%" border="0" cellpadding="1" cellspacing="1" class="listTable">
	<tr>
		<td height="98%" valign="top">
			<table width="99%" border="0" align="center" cellpadding="0" cellspacing="1">
			 
				<%
	 
				String emer0 = request.getAttribute("emer0")==null?"0":""+request.getAttribute("emer0");
				String emer1 = request.getAttribute("emer1")==null?"0":""+request.getAttribute("emer1");
				String emer2 = request.getAttribute("emer2")==null?"0":""+request.getAttribute("emer2");
				String emer3 = request.getAttribute("emer3")==null?"0":""+request.getAttribute("emer3");
				String emer4 = request.getAttribute("emer4")==null?"0":""+request.getAttribute("emer4");
				%>
				<tr>
					<td width="33%">
					<table width="100%" border="0" cellspacing="1" cellpadding="0">
					<tr>
						<td height="20">&nbsp;<font size=3>·</font><a href="#" onclick="emergenceList('4')"><bean:message bundle="filetransact" key="file.sort1"/>(<label style="color:red"><%=emer4%></label>)</a></td>
					</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="33%" valign="top">
					<table width="100%" border="0" cellspacing="1" cellpadding="0">
					<tr>
						<td height="20">&nbsp;<font size=3>·</font><a href="#" onclick="emergenceList('3')"><bean:message bundle="filetransact" key="file.sort2"/>(<label style="color:red"><%=emer3%></label>)</a></td>
					</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="33%" valign="top">
					<table width="100%" border="0" cellspacing="1" cellpadding="0">
					<tr>
						<td height="20">&nbsp;<font size=3>·</font><a href="#" onclick="emergenceList('2')"><bean:message bundle="filetransact" key="file.sort4"/>(<label style="color:red"><%=emer2%></label>)</a></td>
					</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="33%" valign="top">
					<table width="100%" border="0" cellspacing="1" cellpadding="0">
					<tr>
						<td height="20">&nbsp;<font size=3>·</font><a href="#" onclick="emergenceList('1')"><bean:message bundle="filetransact" key="file.sort3"/>(<label style="color:red"><%=emer1%></label>)</a></td>
					</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="33%" valign="top">
					<table width="100%" border="0" cellspacing="1" cellpadding="0">
					<tr>
						<td height="20">&nbsp;<font size=3>·</font><a href="#" onclick="emergenceList('0')"><bean:message bundle="filetransact" key="file.sort5"/>(<label style="color:red"><%=emer0%></label>)</a></td>
					</tr>
					</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
 
<script LANGUAGE="javascript">	
<!--
 //用户点击缓急中流程，跳转到只显示该缓急的列表画面
function emergenceList(emergence){
	$("#emergence").val(emergence); 
	$("#last_processName").val("");
	$("#processID").val("");
    refreshListForm('queryForm');
	changePanle("0");
}

//-->
</script>
 