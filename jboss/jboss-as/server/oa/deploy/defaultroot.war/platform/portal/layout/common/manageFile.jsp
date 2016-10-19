<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%
request.setCharacterEncoding("UTF-8");
String portletSettingId = request.getParameter("portletSettingId");
String path = request.getParameter("path");
PortalLayoutBD bd = new PortalLayoutBD();
List list = bd.getPortalPortletFileList(portletSettingId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>文件管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/public/include/meta_base.jsp"%>
<link href="<%=rootPath%>/<%=whir_skin%>/style.css" rel="stylesheet" type="text/css"/>
</head>

<body class="MainFrameBox" leftmargin="0" topmargin="0">
<form name="dataForm" id="dataForm" action="PortletData!updateFileUrl.action" method="post" theme="simple">
	<%@ include file="/public/include/form_detail.jsp"%>
		<input type="hidden" name="fileId" id="fileId"/>
		<input type="hidden" name="url" id="url"/>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">
	<tr align="center" class="listTableHead">
		<td width="35%" nowrap="nowrap">文件名称</td>
		<td width="57%" nowrap="nowrap">链接地址</td>
		<td width="8%" nowrap>操作</td>
    </tr>
    <%
        if(list!=null&&list.size()>0){
            for(int i=0; i<list.size(); i++){
                PortalPortletFilePO fpo = (PortalPortletFilePO)list.get(i);
    %>
    <tr class="listTableLine1">
		<td nowrap="nowrap"><%=fpo.getRealname()%></td>
		<td nowrap="nowrap">
			<input type="text" id="<%=fpo.getId()%>" name="addr" value="<%=fpo.getUrl()!=null?fpo.getUrl():""%>" class="inputText" style="width:100%;"/>
		</td>
		<td class="listTableLineLastTD" nowrap><img src="<%=rootPath%>/images/cxtj.gif" title="保存" onclick="saveUrl('<%=fpo.getId()%>');" style="cursor:pointer"><img src="<%=rootPath%>/images/del.gif" title="删除" onclick="del('<%=fpo.getId()%>');" style="cursor:pointer"></td>
    </tr>
    <%}}%>
</table>
</form>
<div style="padding:5px 0 0 5px;">
	<input type="button" class="btnButton4font" style="cursor:pointer" onclick="javascript:window.close();" value="退&nbsp;&nbsp;&nbsp;&nbsp;出"/>
</div>
</body>
</html>
<script language="JavaScript">
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'',"tip":'保存'});
function saveUrl(id){
	$("#fileId").val(id);
	$("#url").val($("#"+id).val());
	ok(1,$("#"+id));
}

function del(id){
    whir_confirm('确定要删除该文件？',function(){
        $.ajax({
            type: 'POST',
            url: '<%=rootPath%>/platform/portal/layout/common/deleteFile.jsp',
            cache: false,
            data: 'id='+id,
            dataType: 'json',
            success: function(json) {
                //alert("处理成功");
                //location.reload();
				location_href('<%=rootPath%>/platform/portal/layout/common/manageFile.jsp?portletSettingId=<%=portletSettingId%>');
            }
        });
    });
}
</script>