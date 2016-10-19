<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.org.manager.bd.ManagerBD" %>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>标准列表页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/employee!expirationofcontract_emp_list_data.action" method="post" >

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar" id="searchTable">  
        <tr>
            <td class="whir_td_searchtitle">姓名：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="empName" size="14" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">组织：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="orgName" size="16" cssClass="inputText" />
            </td>
			 <td class="whir_td_searchtitle"></td><td class="whir_td_searchinput"></td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle">合同到期日：</td>
            <td class="whir_td_searchinput" colspan="2">
                <s:textfield name="start_date" id="start_date" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'end_date\\',{d:0});}'})" /> 至 
				 <s:textfield name="end_date" id="end_date" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'start_date\\',{d:0});}'})" />
            </td>
             <td colspan="3" class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow" />' />
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear" />' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    

	<!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >			 
            <td align="right">
					<input type="button" class="btnButton4font" onClick="excelExport();" value='<s:text name="comm.export" />' />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'orgNameString',width:'30%'">组织</td> 
			<td whir-options="field:'empName',width:'10%',renderer:show">姓名</td> 
			<td whir-options="field:'empSex', width:'10%',renderer:sex">性别</td> 
			<td whir-options="field:'empBirth', width:'15%',renderer:common_DateFormat">出生日期</td> 
			<td whir-options="field:'empDuty',width:'15%'">职务</td> 
			<td whir-options="field:'empLeaderName',width:'10%'">直接上级</td>
			<td whir-options="field:'workPackEndDate', width:'15%',renderer:common_DateFormat">合同到期日</td> 
        </tr>
		</thead>
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

	<s:form name="exportForm" id="exportForm" action="employee!expirationofcontract_emp_list_export.action" method="post">
		<table id="exportTable" style="display:none"> </table>
	</s:form>
</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:"queryForm"});	
	});
	
	//自定义查看栏内容
	function show(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/employee!incumbent_view.action?hasRight=true&empId='+po.empId+'&verifyCode='+po.verifyCode+'\',isFull:true,winName:\'showUser\'});">'+po.empName+'</a>';
		return html;
	}

	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sex(po,i){
        var html ;
        if(po.empSex=='0'){
            html = "男";
        }else if(po.empSex=='1'){
            html = "女";
        }else{
            html = "&nbsp;";
        }
        return html;
    }
	
	function excelExport(){
		commonExportExcel({formId:'queryForm', action:'employee!expirationofcontract_emp_list_export.action' });
	}
    
   </script>

</html>

