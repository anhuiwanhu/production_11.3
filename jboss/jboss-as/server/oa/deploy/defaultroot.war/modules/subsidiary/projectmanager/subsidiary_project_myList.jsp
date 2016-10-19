<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>  
<%@ page isELIgnored ="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
boolean hasMsg = com.whir.org.common.util.SysSetupReader.getInstance().hasMsg(session.getAttribute("domainId").toString());
%>

<head>
	<title>项目管理-我的项目-列表页面</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<script src="<%=rootPath%>/modules/subsidiary/projectmanager/project_mine_list.js" type="text/javascript"></script>
	
    <!-- 人员浮动卡片 [BEGIN] -->
	<script src="<%=rootPath%>/scripts/main/whir.userInfo.card.js" language="javascript"></script>
	<style type="text/css">  
	    .trigger1:hover{color:red}  
	</style> 
    <!-- 人员浮动卡片 [END] -->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="project!projectMyListData.action" method="post" theme="simple">
		<s:hidden name="curUserId" id="curUserId" value="%{#session.userId}"/>
		<s:hidden name="empId" id="empId" value="%{#parameters.empId[0]}"/>
		<s:hidden name="from" id="from" value="%{#parameters.from[0]}"/>
		<!-- SEARCH PART START -->  
	    <%@ include file="/public/include/form_list.jsp"%>  
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
	    	 <tr>  
		        <td class="whir_td_searchtitle">编号：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield id="searchCode" name="searchCode" size="16" cssClass="inputText" maxlength="10" />  
		        </td>  
		        <td class="whir_td_searchtitle">项目名称：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield id="searchName" name="searchName" size="16" cssClass="inputText" maxlength="10" />  
		        </td>  
		        <td class="whir_td_searchtitle">状态：</td>  
		        <td class="whir_td_searchinput">  
		            <s:select name="searchStatus" id="searchStatus" list="%{#{'0':'未开始','1':'进行中','2':'已完成','3':'已推迟','4':'已取消'}}" cssClass="selectlist" cssStyle="margin:0px;" headerKey="" headerValue="请选择"/>
		        </td>  
		    </tr>     
	        <tr>  
	            <td class="whir_td_searchtitle">项目类型：</td>  
	            <td class="whir_td_searchinput">  
	                <s:select name="searchTypeId" id="searchTypeId" list="#request.projectTypeMap" cssClass="selectlist" cssStyle="margin:0px;" headerKey="" headerValue="请选择"/>  
	            </td>
	            <td class="whir_td_searchtitle">项目经理：</td>  
	            <td class="whir_td_searchinput">  
	                <s:textfield id="searchManagerName" name="searchManagerName" size="16" cssClass="inputText" maxlength="10" />  
	            </td>  
	            <td colspan="2" class="SearchBar_toolbar">  
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
	            <td whir-options="field:'code',width:'10%'">编号</td>    
	            <td whir-options="field:'name',width:'20%',renderer:show">项目名称</td>   
	            <td whir-options="field:'taskNum',width:'12%',renderer:showTask">项目任务</td>
	            <td whir-options="field:'startDate',width:'8%',renderer:common_DateFormat,allowSort:true">开始日期</td> 
	            <td whir-options="field:'endDate',width:'8%',renderer:common_DateFormat,allowSort:true">结束日期</td>    
	            <td whir-options="field:'managerName',width:'8%',renderer:showManagerName">项目经理</td>    
	            <td whir-options="field:'status',width:'7%',renderer:showStatus,allowSort:true">状态</td>    
	            <td colspan="2" whir-options="field:'',width:'12%',renderer:showProcessChart" >进度</td>  
	            <td whir-options="field:'',width:'10%',renderer:myOperate">操作</td>    
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
	
	<s:form id="mailForm" name="mailForm" action="innerMail!openAddMail.action" method="post" target="sendMail">
		<s:hidden type="hidden" id="empId" name="empId"/>
		<s:hidden type="hidden" id="empName" name="empName"/>
		<s:hidden type="hidden" id="pageSubject" name="pageSubject"/>
		<s:hidden type="hidden" id="pageURL" name="pageURL"/>
	</s:form>
</body>

<script type="text/javascript">
	//初始化列表页form表单,"queryForm"是表单id，可修改。   
    $(document).ready(function(){ 
        initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:showListTrLength});
        
    });  
    
	   function showListTrLength(data1,data2){
		      showUserCardInfo();
//   	var  data = eval("("+data1+")").data;
				    var  data = data1.data;
					   if(data.length==0){
						     var no_record_tip = '<tr><td colspan="10" align="center" >'+comm.norecord+'</td></tr>';
				    //   $("#itemContainer").html(no_record_tip);
				       $("#itemContainer tr td").attr("colspan",10);
					   }
				}
    function show(po, i){
    	var html = po.name;
    	html = '<a href="javascript:void(0)" onclick="viewProject(' + po.projectId + ', \'' + po.verifyCode + '\');">' + html + '</a>';
    	return html;
    }
    
    function showTask(po, i) {
    	var html='项目任务(<font color="red">' + po.taskNum + '</font>)';
    	var createDate = po.createDate;
    	var updateDate = po.updateDate;
    	var currentDate = new Date();
    	var hasNew = false;
    	var dayCount = getDistinceDay(createDate, currentDate);
    	if(dayCount <= 3) {
    		hasNew = true;
    	}
    	
    	if(updateDate != null) {
    		dayCount = getDistinceDay(updateDate, currentDate);
    		if(dayCount <= 3) {
    			hasNew = true;
    		}
    	}
    	html = '<a href="javascript:void(0)" onclick="gotoTaskList(' + po.projectId + ', ' + po.status + ');">' + html + '</a>';
    	if(hasNew) {
    		html += '<img border="0" src="<%=rootPath%>/images/new.gif">';
    	}
    	return html;
    }
    
    function showStatus(po, i) {
    	var status = po.status;
    	var html = "";
    	switch(status) {
    		case "0":html = "未开始";break;
			case "1":html = "进行中";break;
			case "2":html = "已完成";break;
			case "3":html = "已推迟";break;
			case "4":html = "已取消";break;
			default:html = "";break;
    	}
    	return html;
    }
    
    function showProcessChart(po, i) {
    	var html = "&nbsp;";
    	var projectfinishrate = po.projectfinishrate;
    	if(projectfinishrate == null || projectfinishrate == "null" || projectfinishrate == "") {
    		projectfinishrate = "0";
    	}
    	html = '<div style="background-color:#FF8C00;margin:0;padding:0;width:' + projectfinishrate + '%">&nbsp;</div>' + '</td><td width="5%" >' + projectfinishrate + '%';
    	return html;
    }
    
    function getDistinceDay(startDate, endDate) {
    	var start = new Date(startDate.substring(0,startDate.indexOf(" ")).replace(/-/g,"/"));
    	var end = endDate;
    	var dayCount = (end.getTime() - start.getTime()) / 86400000;
    	return dayCount;
    }
    
    //自定义操作栏内容
    function myOperate(po,i){
		var isForbiddenPad='<%=isForbiddenPad%>';
    	var curUserId = '${sessionScope.userId}';
    	var managerId = po.managerId;
    	var createEmpId = po.createEmpId;
    	var status = po.status;
    	var html = "";
    	var from = '${param.from}';
    	var empId = '${param.empId}';
    	if(from != "hrm" || curUserId == empId) {
	    	if(curUserId == managerId || curUserId == createEmpId) {
	    		html += '<a href="javascript:void(0);" onclick="modiProject(' + po.projectId + ', \'' + po.verifyCode + '\', ' + managerId  + ');"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="comm.supdate"/>" ></a>';
	    	}
	    	if(status == "0" && curUserId == createEmpId) {
	    		html += '<a href="javascript:void(0);" onclick="delProject(' + po.projectId + ', ' + po.typeId + ', this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="comm.sdel"/>" ></a>';
	    	}
			if(isForbiddenPad == 'true'){
				html += '<a href="javascript:void(0);" onclick="viewGanttChart(' + po.projectId +', \'' + po.verifyCode + '\');"><img border="0" src="<%=rootPath%>/images/konwledge_workflow.gif" title="甘特图" ></a>';
			}
			html += '<a href="javascript:void(0);" onclick="sendInnerMail(' + po.projectId + ');"><img border="0" src="<%=rootPath%>/images/new_mail.gif" title="发邮件" ></a>';
			if(curUserId == managerId){
				// 项目经理
				html += '<a href="javascript:void(0);" onclick="gotoBudgetList(' + po.projectId + ', \'' + po.verifyCode + '\');"><img border="0" src="<%=rootPath%>/images/clfy.gif" title="项目任务预算" ></a>';
			}
			if('<s:property value="%{#request.managerRight}" />' == "true"){
				html += '<a href="javascript:void(0);" onclick="saveAsModel(' + po.projectId + ');"><img border="0" src="<%=rootPath%>/images/saveAs.png" title="另存为模板" ></a>';
			}
        }
        return html;   
    }  
    
    function showManagerName(po,i){  
	    var html = "";
	    var data = whirRootPath + "/public/desktop/getUserCardInfo.jsp?id=" + po.managerId + "&hasMsg=<%=hasMsg%>";  
	    html = '<a href="javascript:void(0);" class="trigger1" rel="' + data + '" onclick="viewUserInfo(' + po.managerId + ');" >' + po.managerName + '</a>';  
	    return html;  
	} 
</script>

</html>



