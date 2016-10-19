<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>  
<%@ page isELIgnored ="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>项目汇报</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<style type="text/css">
	body,div,tr {
	}
	.divBackgroundColor {
		background: #f7f7f7;
	}
	td {
		padding-left:10px;
	}
	table {
		border-color: #e7e7e7;
		border-style: solid;
	}
	.reportToolbarTable {
	    border-width: 1px;
	    padding: 3px 5px 3px 0px;
	}
	.reportListTable {
	    border-left-width: 1px;
	    border-right-width: 1px;
	    border-bottom-width: 1px;
	}
	</style>
</head>
<script>
function iframeResizeHeight(frame_name,body_name,offset) {
	parent.document.getElementById(frame_name).height=document.getElementById(body_name).scrollHeight+offset;
}

function Resize(){
 	var frame_name="reportIframe";
 	var body_name="main";
 	if(parent.document.getElementById(frame_name)){
  		return iframeResizeHeight(frame_name,body_name,0);
 	}
}
</script>
<body onload="Resize();">
<div id="main" class="divBackgroundColor">
	<s:form name="queryForm" id="queryForm" action="project!projectReportList.action" method="post" theme="simple">
		<s:hidden id="id" name="id" value="%{#parameters.id[0]}"/>
		<s:hidden id="projectName" name="projectName" value="%{#parameters.projectName[0]}"/>
	    <!-- MIDDLE  BUTTONS START --> 
	   	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="reportToolbarTable">  
	        <tr>  
	        	<td align="left">
	        		项目汇报<span class="MustFillColor">(<s:property value="#request.projectReportList.size"/>)</span>
	                <input type="button" class="btnButton4font" onclick="addReport('<s:property value="%{#parameters.id[0]}"/>','<s:property value="%{#parameters.projectName[0]}"/>')" value="新　建" />
	        	</td> 
	        </tr>  
	    </table>  
	    <!-- MIDDLE  BUTTONS END --> 
	    
	    <!-- LIST TITLE PART START -->
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="reportListTable">  
	        <s:iterator value="#request.projectReportList" status="status">
	        	<tr bgcolor="#CCCCCC">
	        		<td height="23">
	        			<s:property value="empName"/>&nbsp;&nbsp;&nbsp;&nbsp;<s:date name="reportTime" format="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;
	        		</td>
	        	</tr>
	        	<tr bgcolor="#FFFFFF">
					<td height="20" colspan="4">
						内容：<s:property value="reportInfo"/>
					</td>
				</tr>
	        </s:iterator>
	        <s:if test="%{#request.reportAccessoryList.size != 0}">
	        <tr>
				<td height="20" colspan="4" style="border-right:0px">
					<s:set name="realFileName" value=""/>
					<s:set name="saveFileName" value=""/>
					<s:iterator value="#request.reportAccessoryList" status="status">
					<s:set name="realFileName"><s:property value="#realFileName"/><s:property value="#request.reportAccessoryList[#status.index][0]"/>|</s:set>
					<s:set name="saveFileName"><s:property value="#saveFileName"/><s:property value="#request.reportAccessoryList[#status.index][1]"/>|</s:set>
					</s:iterator>
					
					<s:hidden name="realFileName" id="realFileName" value="%{#realFileName}"/>  
					<s:hidden name="saveFileName" id="saveFileName" value="%{#saveFileName}"/>  
					<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
					   <jsp:param name="accessType"       value="include" />
					   <jsp:param name="dir"      value="project" />  
					   <jsp:param name="uniqueId"    value="uniqueIdxx" />  
					   <jsp:param name="realFileNameInputId"    value="realFileName" />
					   <jsp:param name="saveFileNameInputId"    value="saveFileName" />
					   <jsp:param name="canModify"       value="no" />
					</jsp:include>
				</td>
			</tr>
			</s:if>
	    </table>  
	    <!-- LIST TITLE PART END -->  
	</s:form>
	</div>
</body>

<script type="text/javascript">
	//初始化列表页form表单,"queryForm"是表单id，可修改。   
    $(document).ready(function(){ 
		//Resize();   
    });  
    function addReport(id, name) {
		var reportUrl = "<%=rootPath%>/project!addProjectReport.action?id=" + id + "&projectName=" + name;
		openWin({url:reportUrl,width:560,height:240,isResizable:'no',winName:'addProjectReport'});
	}
</script>

</html>



