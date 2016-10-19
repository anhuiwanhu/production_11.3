<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>  
<%@ page isELIgnored ="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>项目管理-我的任务-列表页面</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<script src="<%=rootPath%>/modules/subsidiary/projectmanager/project_task_list.js" type="text/javascript"></script>
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="projectTask!projectTaskMyListData.action" method="post" theme="simple">
		<!-- SEARCH PART START -->  
	    <%@ include file="/public/include/form_list.jsp"%>  
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
	    	 <tr>  
		        <td class="whir_td_searchtitle">任务名称：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield id="searchTaskName" name="searchTaskName" size="16" cssClass="inputText" cssStyle="width:75%" maxlength="10" />  
		        </td>  
		        <td class="whir_td_searchtitle">负责人：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield id="searchPrincipalNames" name="searchPrincipalNames" size="16" cssClass="inputText" cssStyle="width:75%" maxlength="10" />  
		        </td>
		    </tr>
		    <tr>  
		        <td class="whir_td_searchtitle">开始日期：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield name="searchBeginTimeFrom" id="searchBeginTimeFrom" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchBeginTimeTo\\',{d:0});}'})" />
		            至
		            <s:textfield name="searchBeginTimeTo" id="searchBeginTimeTo" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchBeginTimeFrom\\',{d:0});}'})"/>
		        </td>
		        <td class="whir_td_searchtitle">结束日期：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield name="searchEndTimeFrom" id="searchEndTimeFrom" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchBeginTimeTo\\',{d:0});}'})" />
		            至
		            <s:textfield name="searchEndTimeTo" id="searchEndTimeTo" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchEndTimeTo\\',{d:0});}'})"/>
		        </td>
		    </tr>     
		    <tr>  
		        <td class="SearchBar_toolbar" colspan="4">  
	                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<s:text name="comm.searchnow"/>" />  
	                <input type="button" class="btnButton4font"  onclick="resetForm(this);" value="<s:text name="comm.clear"/>"/>  
	            </td>  
		    </tr>     
	    </table>   
	    <!-- SEARCH PART END -->       
  
	    <!-- MIDDLE  BUTTONS START -->  
	   	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">     
	        <tr>  
	            <td align="right">
	            	&nbsp;
	            </td>   
	        </tr>  
	    </table>  
	    <!-- MIDDLE  BUTTONS END --> 
	    
	    <!-- LIST TITLE PART START -->       
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
	        <!-- thead必须存在且id必须为headerContainer -->  
	        <thead id="headerContainer">  
				<tr class="listTableHead"> 
					<td whir-options="field:'name',width:'18%',renderer:showProject,allowSort:true">项目名称</td>   
					<td whir-options="field:'taskTitle',width:'20%',renderer:showName">任务名称</td>   
					<td whir-options="field:'processName',width:'10%',renderer:showFlow">工作流程</td>
					<td whir-options="field:'tasktimelimit',width:'6%'">工期(天)</td> 
					<td whir-options="field:'taskBeginTime',width:'10%',renderer:common_DateFormat,allowSort:true">开始日期</td>    
					<td whir-options="field:'taskEndTime',width:'10%',renderer:common_DateFormat,allowSort:true">结束日期</td>    
					<td whir-options="field:'taskPrincipalNames',width:'10%',renderer:showPrincipal">负责人</td>    
					<td colspan="2" whir-options="field:'',width:'12%',renderer:showProcessChart" >进度</td>
					<td whir-options="field:'',width:'4%',renderer:myOperate">操作</td>    
				</tr>
	        </thead>  
	        <!-- tbody必须存在且id必须为itemContainer -->  
	        <tbody  id="itemContainer" >  
	           
	        </tbody>  
	    </table>  
	    <!-- LIST TITLE PART END -->  
	    <!-- PAGER START -->  
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">  
	        <tr>  
	            <td>  
	                <%@ include file="/public/page/pager.jsp"%>  
	            </td>  
	        </tr>  
	    </table>  
	    <!-- PAGER END -->  
	</s:form>
</body>

<script type="text/javascript">
//初始化列表页form表单,"queryForm"是表单id，可修改。   
$(document).ready(function(){ 
	initListFormToAjax({formId:"queryForm",onLoadSuccessAfter:showListTrLength});
});  

//标题栏有td标签中有colspan的，当检索出的数据为空时，需要增加td中colspan长度
function showListTrLength(data1,data2){
//   	var  data = eval("("+data1+")").data;
    var  data = data1.data;
	   if(data.length==0){
		     var no_record_tip = '<tr><td colspan="10" align="center" >'+comm.norecord+'</td></tr>';
    //   $("#itemContainer").html(no_record_tip);
       $("#itemContainer tr td").attr("colspan",10);
	   }
}

function showProject(po, i) {
	var html = po.name;
	html = '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/project!viewProject.action?projectId=' + po.projectId + '&verifyCode=' + po.verifyCode + '\',isFull:true,winName:\'viewProjectType\'});">' + html + '</a>';
	return html;
}

function showName(po, i){
	var html = "";
	var taskOrderCode = po.taskOrderCode;
	var space = "";
	for(var i = 0; i < taskOrderCode; i++) {
		space += "&nbsp;&nbsp;&nbsp;&nbsp;";
	}
	html += space;
	if(taskOrderCode == "0") {
		html += '<img border="0" src="images/plus1.gif" align="absbottom">';
	}
	
	var taskEndTime = po.taskEndTime;
	taskEndTime = taskEndTime.substring(0, taskEndTime.indexOf(" ")).replace(/-/g, "/");
	var taskFinishRate = po.taskFinishRate;
	var taskTitle = po.taskTitle;
	if(new Date(taskEndTime) < new Date() && taskFinishRate != '100') {
		taskTitle = '<font color="red">' + taskTitle + '</font>';
	}
	html += '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/projectTask!viewProjectTask.action?taskId=' + po.taskId + '&projectId=' + po.projectId + '\',isFull:true,isFull:true,winName:\'viewProjectTask\'});">' + taskTitle + '</a>';
	return html;
}

function showProcessChart(po, i) {
	var html = "&nbsp;";
	var taskFinishRate = po.taskFinishRate;
	if(taskFinishRate == null || taskFinishRate == "null" || taskFinishRate == "") {
		taskFinishRate = "0";
	}
	html = '<div style="background-color:#FF8C00;margin:0;padding:0;width:' + taskFinishRate + '%">&nbsp;</div>' + '</td><td width="5%" >' + taskFinishRate + '%';
	return html;
}

function showPrincipal(po, i) {
	var html = "&nbsp;";
	var taskPrincipals = po.taskPrincipals;
	var taskPrincipalNames = po.taskPrincipalNames;
	
	if(taskPrincipals != null && taskPrincipals.length > 0) {
		taskPrincipals = taskPrincipals.substring(1, taskPrincipals.length - 1);
		var taskPrincipalsArr = taskPrincipals.split("\\$\\$");
		var taskPrincipalNamesArr = taskPrincipalNames.substring(0, taskPrincipalNames.length - 1).split(",");
		html = "";
		for(var j = 0; j < taskPrincipalsArr.length; j++) {
			html += '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/employee!user_view.action?empId=' + taskPrincipalsArr[j] + '\',width:800,height:600,isFull:true,winName:\'user_view\'});">' + taskPrincipalNamesArr[j] + ',</a>';
		}
	}
	return html;
}

function showFlow(po,i){
	var html = '<a href="javascript:void(0);" onclick="startProcess('+po.flowId+');">'+po.flowName+'</a>'; 
	return html;   
}

//自定义操作栏内容   
function myOperate(po,i){
	var userId = "${sessionScope.userId}";
	var isView = "${param.isView}";
	var isManager = po.isManager;
	var html = "&nbsp;";
	if((isView != "true" && ((isManager == "true" || po.taskPrincipal == userId) && (po.taskFinishRate != 100 && po.taskStatus != 2))) || (po.taskPrincipals).indexOf("$" + userId + "$") > -1) {
		html = '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/projectTask!modiProjectTask.action?taskId=' + po.taskId + '&projectId=' + po.projectId + '\',isFull:true,isFull:true,winName:\'modiProject\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="修改" ></a>';
	}
	html += '<a href="javascript:void(0)" onclick="addSubTask('+po.projectId+','+po.taskId+');"><img border="0" src="<%=rootPath%>/images/taskchild.gif" title="添加子任务" ></a>';
	return html;   
}  
</script>

</html>



