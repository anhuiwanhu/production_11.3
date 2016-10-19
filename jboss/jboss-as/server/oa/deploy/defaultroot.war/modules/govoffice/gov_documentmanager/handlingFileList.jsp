<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%@ page import="com.whir.govezoffice.documentmanager.bd.SendFileBD"%>
<%@ page import="com.whir.govezoffice.documentmanager.bd.SenddocumentBD"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>经办文件查阅</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
 //取 基础信息
String [] secretLevel=null;
String [] keepSecretLevel=null;
String [] transactLevel=null;
String [] contentLevel=null;
String [] openPropertyArr=null;
String [] fileTypeArr=null;

Object [] baseObj=(Object[]) new SenddocumentBD().getSenddocumentBaseInfo();
if(baseObj!=null&&baseObj.length>0){
  if(baseObj[4]!=null&&!baseObj[4].toString().equals("")){
	secretLevel=baseObj[4].toString().split(";");//秘密级别：
	keepSecretLevel=baseObj[3].toString().split(";");//保密期限：
	transactLevel=baseObj[5].toString().split(";"); // 办理紧急：
    contentLevel=baseObj[1].toString().split(";");//内容紧急：
	if(baseObj.length>10&&baseObj[11]!=null&&!baseObj[11].toString().equals("")){
	  openPropertyArr=baseObj[11].toString().split(";");
	}
	
	fileTypeArr=baseObj[2].toString().split(";");// 文件种类
  }
}
 
 %>
<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="GovDocSend!handlingFileListData.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
<!--<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
       
         <tr>
            <td>公文标题：</td>
            <td colspan="6">
            	  <s:textfield id="docTitle" name="docTitle" size="16" cssClass="inputText"  style="width:200px;"/>
	        </td>
            <td colspan="2" align="right">
				  	
            </td>
        </tr>
		 <tr>
            <td>发送日期：</td>
            <td colspan="6">
            	 
				<input type="text" class="Wdate whir_datebox" name="startDate" id="d122" onfocus="WdatePicker({el:'d122'})"/>
				-
                <input type="text" class="Wdate whir_datebox" name="endDate" id="d124" onfocus="WdatePicker({el:'d124'})"/>

				<input type="checkbox" value="1" name="queryItem"  style="cursor:hand">
				  
	        </td>
            <td colspan="2" align="right">
				< !-- refreshListForm 是公共方法，queryForm 为上面的表单id-- >
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="立即查找" />
				< !--resetForm(obj)为公共方法-- >
                <input type="button" class="btnButton4font" value="清除" onclick="resetForm(this);" />
            </td>
        </tr>
    </table>-->
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine" style="display:none">
	    <tr>
	        <td align="right">
			  <!-- <input type="button" class="btnButton4font" onclick="openWin({url:'<%=rootPath%>/GovCustom!addForm.action?govFormType=${param.govFormType}',width:850,height:500,winName:'addUser'});" value="新　增" />
	           <input name="" type="button" value="" class="btnButton4font" style="display:none"/>-->
			    <input  name="govFormType" type="hidden" value="${param.govFormType}" />

	        </td>
	    </tr>
	</table>	

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <tr>
            <td class="whir_td_searchtitle" nowrap>标题：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryTitle" name="queryTitle" size="16" cssClass="inputText"  />
            </td>
            <td class="whir_td_searchtitle" nowrap>办理状态：</td>
            <td class="whir_td_searchinput">
                <select id="transactStatus" class="easyui-combobox" name="queryStatus" style="width:200px;" data-options="panelHeight:'auto'">  
					<option value="none" >请选择</option>
					<option value="0" <%if("0".equals(request.getParameter("queryStatus"))){%>selected<%}%>>办理中</option>
					<option value="1" <%if("1".equals(request.getParameter("queryStatus"))){%>selected<%}%>>办理完毕</option>
					<option value="2" <%if("2".equals(request.getParameter("queryStatus"))){%>selected<%}%>>退回</option></select>
				</select>
            </td>
            <td class="whir_td_searchtitle" nowrap>主题词：</td>
            <td class="whir_td_searchinput">
                <input type="text" id="topicWord" name="documentSendFileTopicWord" size="14" value="" class="inputText"  />
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle" nowrap>文号：</td>
            <td class="whir_td_searchinput">
                <input type="text" Class="inputText" name="queryNumber" id="queryNumber" size="16" value=""   />
            </td>
            <td class="whir_td_searchtitle" nowrap>拟稿单位：</td>
            <td class="whir_td_searchinput">
                <input type="text" Class="inputText" id="createdOrg" name="queryOrg" size="16" value=""  />
            </td>
			<td class="whir_td_searchtitle" nowrap>公开属性：</td>
            <td class="whir_td_searchinput">
                <select id="queryOpenProperty" name="queryOpenProperty" class="easyui-combobox" data-options="panelHeight:'auto'"   name="dept" style="width:200px;">
					<option value="none" >请选择</option>

					<%if(openPropertyArr!=null&&openPropertyArr.length>0){
										    for(int i=0;i<openPropertyArr.length;i++){
											 String openPropertyValue=openPropertyArr[i];
											 %>
											  
									    <option value="<%=openPropertyValue%>"<%=openPropertyValue.equals(request.getParameter("queryOpenProperty"))?" selected":""%>><%=openPropertyValue%></option>
					 <%} }%>
				</select>
            </td>
        </tr>
        
         <tr>
            <td nowrap>发文日期：</td>
            <td class="whir_td_searchinput" nowrap>
            	
    <input name="queryBeginDate"  id="empBirth"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'empBirth2\',{d:0});}'})" /> 至   
    <input name="queryEndDate" id="empBirth2"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'empBirth\',{d:1});}'})" />  
        		<!--<input type="checkbox" name="queryItem" id="goodDay0" value="1"/>-->


	        </td>
            <td colspan="4" class="SearchBar_toolbar">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="立即查找" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="清　除" onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine" style="display:none" >
	    <tr>
	        <td align="right">
	           <input name="" type="button" value="" class="btnButton4font" style="display:none"/>
	        </td>
	    </tr>
	</table>
	
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('userId',this.checked);" ></td>
			<td whir-options="field:'byteNum',width:'20%'">文号</td> 
			<td whir-options="field:'title',width:'30%',renderer:show">标题</td> 
			<td whir-options="field:'writeOrg', width:'30%'">拟稿单位</td> 
			<td whir-options="field:'createdTime', width:'10%',renderer:common_DateFormat">发文日期</td> 
			<td whir-options="field:'transactStatus',width:'8%',renderer:getStatus">办理状态</td> 

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
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});		
	});
	
	
	//自定义查看栏内容
	function show(po,i){


	//function moder(editId,editType,canEdit,editLink,tableId) {
   // var hhref = "GovSendFileAction.do?action=listLoad&editId=" + editId+"&editType="+editType+"&canEdit="+canEdit+"&viewOnly=1&myFile=1&tableId="+tableId;
//javascript:moder('498','0','0','','24')"> 
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendProcess!editfile.action?from=blcyview&p_wf_openType=modifyView&fromlist=handlingFileList&editType=0&canEdit=0&viewOnly=1&myFile=1&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\',width:620,height:290,isResizable: true,isFull: true,winName:\'showUser\'});">'+po.title+'</a>';
		return html;
	}

	
	
	function formatDate(po,i){
		return getFormatDateByLong(po.createdTime,"yyyy-MM-dd");
	}
	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sex(po,i){
		var html ;
		if(po.sex==0){
			html = "男";
		}else{
			html = "女";
		}
		return html;
	}

	function getStatus(po,i){
		if(po.transactStatus == "0"){
			return "办理中";
		}
		if(po.transactStatus == "1"){
			return "办理完毕";
		}
		if(po.transactStatus == "2"){
			return "退回";
		}
	}

  

	
   </script>

</html>


