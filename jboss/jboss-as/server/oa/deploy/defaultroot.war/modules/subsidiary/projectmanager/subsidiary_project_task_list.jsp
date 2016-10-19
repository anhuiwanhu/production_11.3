<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>项目任务列表</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/modules/subsidiary/projectmanager/project_task_list.js" type="text/javascript"></script>
</head>

<body class="MainFrameBox">
    <s:form name="queryForm" id="queryForm" action="projectTask!projectTaskListData.action" method="post" theme="simple">
        <s:hidden name="projectId" id="projectId" value="%{projectId}"/>
        <s:hidden name="status" id="status" value="%{#parameters.status[0]}"/>
        <s:hidden name="fromAction" id="fromAction" value="%{#parameters.fromAction[0]}"/>
        <s:hidden name="tagFlag" id="tagFlag" value="%{tagFlag}" />
		<s:if test="%{#parameters.fromAction[0] == 'projectRelationList'}">
			<input type="hidden" id="infoId" value='<s:property value="%{#parameters.infoId[0]}"/>' />
			<input type="hidden" id="moduleType" value='<s:property value="%{#parameters.moduleType[0]}"/>' />
			<input type="hidden" id="relationModule" value='<s:property value="%{#parameters.relationModule[0]}"/>' />
		</s:if>
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
                    <s:textfield name="searchEndTimeFrom" id="searchEndTimeFrom" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchEndTimeTo\\',{d:0});}'})" />
                    至
                    <s:textfield name="searchEndTimeTo" id="searchEndTimeTo" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchEndTimeFrom\\',{d:0});}'})"/>
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
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">     
            <tr>  
                <td align="left">
                    <div class="Public_tag">
                        <ul>
                            <li onclick="tagSwitch(this, 0);"><span class="tag_center">按任务</span><span class="tag_right"></span>
                            </li>
                            <li onclick="tagSwitch(this, 1);"><span class="tag_center">按人员</span><span class="tag_right"></span>
                            </li>
                            <li onclick="tagSwitch(this, 2);"><span class="tag_center">进行中</span><span class="tag_right"></span>
                            </li>
                            <li onclick="tagSwitch(this, 3);"><span class="tag_center">已超期</span><span class="tag_right"></span>
                            </li>
                            <li onclick="tagSwitch(this, 4);"><span class="tag_center">已完成</span><span class="tag_right"></span>
                            </li>
                        </ul>
                        <s:property value="#request.projectName"/>
                    </div>
                </td>  
                <td align="right" class="inlineBottomLine_toolbar">
                    <s:if test="%{#parameters.fromAction[0] != 'projectRelationList' && #parameters.isView == null}">
                        <s:if test="%{#request.isManager == 'true' || #request.isMember == 'true' || #request.isCreator == 'true'}">
                            <input type="button" class="btnButton4font" onclick="add();" value='<s:text name="comm.add"/>' />
                            <input type="button" class="btnButton4font" onclick="batchAdd();" value='<s:text name="comm.batchadd"/>' />
                        </s:if>
                        <s:if test='%{#request.isManager == "true"}'>
                            <input type="button" class="btnButton4font" onclick="batchDel(this);" value="<s:text name="comm.delselect"/>" />
                        </s:if>
                    </s:if>
                    
                    <s:if test="%{#parameters.fromAction[0] == 'projectMyList'}">
                        <input type="button" class="btnButton4font" onclick="location_href('<%=rootPath%>/project!projectMyList.action')" value="返　回" />
                    </s:if>
                    <s:elseif test="%{#parameters.fromAction[0] == 'projectList'}">
                        <input type="button" class="btnButton4font" onclick="location_href('<%=rootPath%>/project!projectList.action')" value="返　回" />
                    </s:elseif>
                    <s:elseif test="%{#parameters.fromAction[0] == 'projectRelationList'}">
                        <input type="button" class="btnButton4font" onclick="location_href('<%=rootPath%>/project!projectRelationList.action?infoId=<s:property value="%{#parameters.infoId[0]}"/>&type=<s:property value="%{#parameters.type[0]}"/>&moduleType=<s:property value="%{#parameters.moduleType[0]}"/>&relationModule=<s:property value="%{#parameters.relationModule[0]}"/>')" value="返　回" />
                    </s:elseif>
                </td>   
            </tr>  
        </table>  
        <!-- MIDDLE  BUTTONS END --> 
        
        <!-- LIST TITLE PART START -->       
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
            <!-- thead必须存在且id必须为headerContainer -->  
            <thead id="headerContainer">  
                <tr class="listTableHead"> 
                    <td whir-options="field:'taskId',width:'3%',checkbox:true,renderer:showCheckbox" >
                        <input type="checkbox" name="items" id="items" onclick="setCheckBoxState('taskId',this.checked);" />
                    </td>
                    <s:if test="tagFlag == 1">
                        <td whir-options="field:'taskPrincipalNames',width:'8%',renderer:showPrincipal">负责人</td>
                    </s:if>
                    <td whir-options="field:'islandmark',width:'4%',renderer:showMark">里程碑</td>
                    <td whir-options="field:'taskTitle',width:'22%',renderer:showName">任务名称</td>
                    <td whir-options="field:'processName',width:'8%',renderer:showFlow" >工作流程</td>
                    <td whir-options="field:'tasktimelimit',width:'6%'">工期(天)</td>
                    <td whir-options="field:'taskBeginTime',width:'8%',renderer:common_DateFormat,allowSort:true">开始日期</td>
                    <td whir-options="field:'taskEndTime',width:'8%',renderer:common_DateFormat,allowSort:true">结束日期</td>
                    <td whir-options="field:'flowNum',width:'5%'">相关流程</td>
                    <td whir-options="field:'infoNum',width:'5%'">相关信息</td>
                    <td whir-options="field:'taskReportNum',width:'5%'">任务汇报</td>
                    <s:if test="tagFlag != 1">
                        <td whir-options="field:'taskPrincipalNames',width:'8%',renderer:showPrincipal">负责人</td>
                    </s:if>
                    <td colspan="2" whir-options="field:'',width:'12%',renderer:showProcessChart" >进度</td>
                    <td whir-options="field:'',width:'6%',renderer:myOperate">操作</td>
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
// 初始化列表页form表单,"queryForm"是表单id，可修改。   
$(document).ready(function(){
    var tagFlag = $('#tagFlag').val();
    $('.Public_tag > ul > li').eq(tagFlag).addClass('tag_aon');
    if(tagFlag == '1'){
        initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:mergeCells_principal});
    } else {
        initListFormToAjax({formId:"queryForm"});
    }
});

// 渲染: 复选框
function showCheckbox(po, i) {
    var userId = "${sessionScope.userId}";
    var isManager = '<s:property value="%{#request.isManager}" />';
    var html = "";
    if(!((isManager == "true" || po.taskPrincipal == userId) && (po.taskFinishRate != 100 && po.taskStatus != 2))){
        html = "disabled=true";
    }
    return html;
}

// 渲染: 里程碑
function showMark(po, i) {
    var html = "&nbsp;"
    if(po.islandmark == "1") {
        html = '<img border="0" src="<%=rootPath%>/images/top1.gif">';
    }
    return html;
}

// 渲染: 任务名称
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
    html += '<a href="javascript:void(0)" onclick="view(' + po.taskId + ');">' + taskTitle + '</a>';
    return html;
}

// 渲染: 工作流程
function showFlow(po, i){
    var html = '<a href="javascript:void(0);" onclick="startProcess(' + po.flowId + ');">'+po.flowName+'</a>';
    return html;
}  

// 渲染: 负责人
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
            html += '<a href="javascript:void(0);" onclick="openWin({url:\'<%=rootPath%>/employee!user_view.action?empId=' + taskPrincipalsArr[j] + '\',width:800,height:600,winName:\'user_view\'});">' + taskPrincipalNamesArr[j] + ',</a>';
        }
    }
    return html;
}

// 渲染: 进度
function showProcessChart(po, i) {
    var html = "&nbsp;";
    var taskFinishRate = po.taskFinishRate;
    if(taskFinishRate == null || taskFinishRate == "null" || taskFinishRate == "") {
        taskFinishRate = "0";
    }
    html = '<div style="background-color:#FF8C00;margin:0;padding:0;width:' + taskFinishRate + '%">&nbsp;</div>' + '</td><td width="5%" >' + taskFinishRate + '%';
    return html;
}

// 渲染: 操作栏
function myOperate(po,i){
    var userId = "${sessionScope.userId}";
    var isView = "${param.isView}";
    var isManager = '<s:property value="%{#request.isManager}" />';
    var html = "&nbsp;";
    if((isView != "true" && ((isManager == "true" || po.taskPrincipal == userId) && (po.taskFinishRate != 100 && po.taskStatus != 2))) || (po.taskPrincipals).indexOf("$" + userId + "$") > -1) {
        html = '<a href="javascript:void(0);" onclick="modi(' + po.taskId + ');"><img border="0" src="<%=rootPath%>/images/modi.gif" title="修改" ></a>';
    }
    return html;   
}
</script>
</html>