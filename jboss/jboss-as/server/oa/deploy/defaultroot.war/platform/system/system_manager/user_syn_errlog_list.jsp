<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
<title>同步用户日志</title>  
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
<%@ include file="/public/include/meta_base.jsp"%>  
<%@ include file="/public/include/meta_list.jsp"%>  
<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>  

<body class="MainFrameBox"> 
	<div class="Public_tag">  
		<ul>  
			<li id="user_syn_log" onclick="userlist();" class="tag_aon" ><span class="tag_center">用户同步日志</span><span class="tag_right"></span></li>
			<li id="org_syn_log" onclick="orglist();"  ><span class="tag_center">组织同步日志</span><span class="tag_right"></span></li>
		</ul>  
	</div> 
<!--这里的表单id queryForm 允许修改 -->  
<s:form name="queryForm" id="queryForm" action="/MoveOAmanager!logList.action" method="post">
<input type="hidden" name="user_org_flag"  id="user_org_flag"  value="0" />
<!-- SEARCH PART START -->  
<%@ include file="/public/include/form_list.jsp"%>  

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
    <tr>  
       <td class="whir_td_searchtitle" nowrap style="width:5%;">时间：</td>
			<td class="whir_td_searchinput" colspan="2" style="width:60%;">
				<s:textfield name="startDate" id="startDate" style="width:170px;" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,maxDate:'#F{$dp.$D(\\'endDate\\')}'})"/>&nbsp;<s:text name="info.to"/>&nbsp;<s:textfield name="endDate" id="endDate" style="width:170px;" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,minDate:'#F{$dp.$D(\\'startDate\\')}'})" />
			</td>
        <td class="SearchBar_toolbar">  
            <!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->  
            <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<s:text name="comm.searchnow"/>" />  
            <!--resetForm(obj)为公共方法-->  
            <input type="button" class="btnButton4font" value="<s:text name="comm.clear"/>" onclick="resetForm(this);" />
        </td>  
    </tr>  
</table>  
<!-- SEARCH PART END -->
  
<!-- MIDDLE  BUTTONS START -->  
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
    <tr> 
        <td align="right">
            <input type="button" class="btnButton4font" onclick="excelExport()" value="导  出" />
            
        </td>  
    </tr>
</table>  
<!-- MIDDLE  BUTTONS END -->  

<!-- LIST TITLE PART START -->      
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
    <!-- thead必须存在且id必须为headerContainer -->
    <thead id="headerContainer">  
    <tr class="listTableHead">  
        <td whir-options="field:'id',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>  
        <td whir-options="field:'create_date',width:'20%'">时间</td>
        <td whir-options="field:'orgname',width:'10%'">组织</td> 
        <td whir-options="field:'username',width:'10%'">姓名</td>   
        <td whir-options="field:'phonenum', width:'20%'">手机号</td>   
        <td whir-options="field:'event',width:'20%'">事件</td>   
        <td whir-options="field:'result', width:'20%'">结果</td> 
        
    </tr>
    </thead>  
    <!-- tbody必须存在且id必须为itemContainer -->  
    <tbody id="itemContainer">
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
    initListFormToAjax({formId:"queryForm"});         
});
  //用户同步日志页签
function userlist(){
	$("#user_syn_log").addClass("tag_aon");
	$("#org_syn_log").removeClass();
	
	location_href("<%=rootPath%>/MoveOAmanager!getUserLogList.action");
}
//组织同步日志页签
function orglist(){
	$("#org_syn_log").addClass("tag_aon");
	$("#user_syn_log").removeClass();
	
	location_href("<%=rootPath%>/MoveOAmanager!getOrgLogList.action");
}
// 导出
function excelExport(){
    commonExportExcel({formId:"queryForm", action:whirRootPath + '/MoveOAmanager!logList.action?exportFlag=1'});
}

</script>
</html>