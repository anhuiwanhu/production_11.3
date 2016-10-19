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
<%
String userId = session.getAttribute("userId").toString();
ManagerBD managerBD = new ManagerBD();
boolean hasModify = managerBD.hasRight(session.getAttribute("userId").toString(), "HR*07*10");
%>
<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/partyinfo!partymember_turnout_list_data.action" method="post" >

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar" id="searchTable">  
        <tr>
            <td class="whir_td_searchtitle">原支部：</td>
            <td class="whir_td_searchinput">
                <s:select name="partyId" id="partyId" list="#request.partyMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--" cssClass="selectlist" />
            </td>
            <td class="whir_td_searchtitle">姓名：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="empName" id="empName"  cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">性别：</td>
            <td class="whir_td_searchinput">
                <s:radio name="empSex" list="%{#{'0':'男','1':'女','-1':'空'}}" ></s:radio>
            </td>
        </tr>
		<tr>
			<td class="whir_td_searchtitle">生日：</td>
            <td class="whir_td_searchinput" nowrap>
                 <s:textfield name="empBirth" id="empBirth" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'empBirth2\\',{d:0});}'})" /> 至 
				 <s:textfield name="empBirth2" id="empBirth2" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'empBirth\\',{d:0});}'})" />
            </td>
            <td class="whir_td_searchtitle">去向：</td>
            <td class="whir_td_searchinput">
            	<s:textfield  name="destination" id="destination"  cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">年龄：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="age" id="age"  cssClass="inputText" cssStyle="width:40px;" whir-options="vtype:['p_integer']"/> 至 <s:textfield  whir-options="vtype:['p_integer']"  name="age2" id="age2" cssStyle="width:40px;" cssClass="inputText" />
            </td>
        </tr>
		<tr>
            <td class="whir_td_searchtitle">入党时间：</td>
            <td class="whir_td_searchinput">
                 <s:textfield name="joinDate" id="joinDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'joinDate2\\',{d:0});}'})" /> 至 
				 <s:textfield name="joinDate2" id="joinDate2" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'joinDate\\',{d:0});}'})" />
            </td>
            <td class="whir_td_searchtitle">转出时间：</td>
            <td class="whir_td_searchinput" colspan="2" nowrap>
                 <s:textfield name="inDate" id="inDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'inDate2\\',{d:0});}'})" /> 至 
				 <s:textfield name="inDate2" id="inDate2" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'inDate\\',{d:0});}'})" />
            </td>
            <td  class="SearchBar_toolbar">
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
				<%
					if (hasModify) {
				%>
					<input type="button" class="btnButton4font" onClick="excelExport();" value='<s:text name="comm.export" />' />
				<%}%>
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'empId',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('empId',this.checked);" ></td>
			<td whir-options="field:'partyName',width:'10%'">原支部</td> 
			<td whir-options="field:'empName',width:'10%',renderer:show">姓名</td> 
			<td whir-options="field:'empSex', width:'5%',renderer:sex">性别</td> 
			<td whir-options="field:'empBirth', width:'15%',renderer:common_DateFormat">出生日期</td> 
			<td whir-options="field:'empBirth',width:'5%',renderer:getAge">年龄</td> 
			<td whir-options="field:'joinDate',width:'10%',renderer:common_DateFormat">入党时间</td> 
			<td whir-options="field:'outDate',width:'10%',renderer:common_DateFormat">转出时间</td> 
			<td whir-options="field:'destination',width:'15%'">去向</td> 
			<td whir-options="field:'memos',width:'5%'">备注</td> 
			<%
				if (hasModify) {
			%>
			<td whir-options="field:'',width:'8%',renderer:myOperate">操作</td> 
			<%}%>
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

	<s:form name="exportForm" id="exportForm" action="partyinfo!export_partymember_turnout.action" method="post">
		<table id="exportTable" style="display:none"> </table>
	</s:form>
</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:"queryForm"});	
	});
	
	//自定义操作栏内容
	function myOperate(po,i){
		 var html = "&nbsp;";
		<%if(hasModify){%>
    		 	html =   '<img border="0"  style="cursor:pointer" src="<%=rootPath%>/images/modi.gif"   title="修改" onclick="openWin({url:\'<%=rootPath%>/partyinfo!partymember_turnout_modify.action?empId='+po.empId+'&verifyCode='+po.verifyCode+'\',width:820,height:450,winName:\'partymember_modify\'});" />';
				html +=  '<img border="0"  style="cursor:pointer" src="<%=rootPath%>/images/quash.gif"  title="恢复" onclick="back(\''+po.empId+'\');" />';
    	<%}%>
		return html;
	}

	//自定义查看栏内容
	function show(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/partyinfo!partymember_turnout_show.action?hasRight=true&empId='+po.empId+'&verifyCode='+po.verifyCode+'\',width:820,height:450,winName:\'partymember_show\'});">'+po.empName+'</a>';
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
		
	function getAge(po,i){
		var   thisYear = getSmpFormatNowDate(false).substring(0,4);
		var brith = po.empBirth;
		var age = "";
		if(brith!=null && brith!=undefined && brith.length>=4){
			age = (thisYear-brith.substring(0,4));
		}
		return age;
	}
	
	function getEducation(po,i){
		var arr = {1:'博士',2:'硕士',3:'双学历',4:'大学本科',5:'大学专科',6:'中专',7:'中技',8:'高职',9:'高中',10:'初中及以下'};
		return arr[po.education];
	}
	
	function excelExport(){
		commonExportExcel({formId:'queryForm', action:'partyinfo!export_partymember_turnout.action' });
	}
    
	function back(empId){
		ajaxOperate({urlWithData:"partyinfo!partymember_turnout_back.action?empId="+empId,tip:"恢复",formId:"queryForm"});
	}
    
   </script>

</html>

