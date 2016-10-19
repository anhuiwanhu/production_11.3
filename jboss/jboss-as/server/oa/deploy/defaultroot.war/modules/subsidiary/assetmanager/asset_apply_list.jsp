<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>  
<%@ page isELIgnored ="false" %>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>资产采购</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<script src="<%=rootPath%>/scripts/main/whir.userInfo.card.js" language="javascript"></script>  
	<style type="text/css">  
	    .trigger1:hover{color:red}  
	</style>  
</head>
  <% EncryptUtil util = new EncryptUtil();
    String dlcode = util.getSysEncoderKeyVlaue("FileName","assetApply_import_template.xls","dir");
    Map<String, String> applyClassMap = (Map<String, String>)request.getAttribute("applyClassMap");
    Set<Map.Entry<String, String>> applyClasses = applyClassMap.entrySet();
  %>
<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="assetApply!assetApplyListData.action" method="post" theme="simple">
	    <%@ include file="/public/include/form_list.jsp"%> 
	    <!-- SEARCH PART START -->  
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
	    	<tr>  
		        <td class="whir_td_searchtitle">资产名称：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield id="searchAssetName" name="searchAssetName" size="16" cssClass="inputText" maxlength="10" />  
		        </td>  
		        <td class="whir_td_searchtitle">规格型号：</td>  
		        <td class="whir_td_searchinput">  
		            <s:textfield id="searchKiteMark" name="searchKiteMark" size="16" cssClass="inputText" maxlength="10" />  
		        </td>
		        <td class="whir_td_searchtitle">申请人：</td>  
		        <td class="whir_td_searchinput">  
				  <s:textfield id="searchPurchaseApplyUserName" name="searchPurchaseApplyUserName" size="16" cssClass="inputText" maxlength="10" />
		        </td>  
		    </tr>
	    	<tr>  
		        <td class="whir_td_searchtitle">采购类别：</td>  
		        <td class="whir_td_searchinput">  
		        	<%--
		            <s:select name="searchApplyClassId" id="searchApplyClassId" list="#request.applyClassMap" cssClass="easyui-combobox" data-options="width:202,panelHeight:'auto'" headerKey="" headerValue="全部"/>
		             --%>
		            <select id="searchApplyClassId" name="searchApplyClassId" class="easyui-combobox" data-options="width:200" >
						<option value="">--全部--</option>
						<%
						for(Map.Entry<String, String> entry : applyClasses) {
						%>
						            <option value="<%= entry.getKey()%>" ><%= entry.getValue()%></option> 
						<%
						   } 
						%> 
				   </select>  
		        </td>  
		        <td class="whir_td_searchtitle">采购状态：</td>  
		        <td class="whir_td_searchinput">  
		            <s:select name="searchApplyStatus" id="searchApplyStatus" list="%{#{'0':'已采购','4':'已入库'}}" cssClass="selectlist" headerKey="" headerValue="全部"/>  
		        </td>
		        <td class="whir_td_searchtitle">导入信息：</td>  
		        <td class="whir_td_searchinput">  
				  	<s:select name="searchIsImport" id="searchIsImport" list="%{#{'1':'是','0':'否'}}" cssClass="selectlist" headerKey="" headerValue="全部"/>
		        </td>  
		    </tr>
		    <tr>  
		        <td class="whir_td_searchtitle">采购时间：</td>  
		        <td class="whir_td_searchinput" colspan="3">  
		            <s:textfield name="searchApplyDateFrom" id="searchApplyDateFrom" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchApplyDateTo\\',{d:0});}'})" />
		            至
		            <s:textfield name="searchApplyDateTo" id="searchApplyDateTo" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchApplyDateFrom\\',{d:0});}'})"/>
		        </td>
		        <td class="SearchBar_toolbar" colspan="2">  
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
	            	<s:if test="%{#request.hasModiRight == 1}">
					<%if(isForbiddenPad && !isSurface){%>
	            		<a style="cursor:pointer" onclick="downloadTemplate()">下载模板</a>
					<%}%>
	            	</s:if>
	            	<s:if test="%{#request.hasModiRight == 1}">
	            		<input type="button" class="btnButton4font" onclick="openWin({url:'<%=rootPath%>/assetApply!selectWorkFlow.action',width:600,height:220,winName:'selectWorkFlow'});" value="采购申请" />
	            	</s:if>
	            	<s:if test="%{#request.hasModiRight == 1}">
					<%if(isForbiddenPad && !isSurface){%>
	            		<input type="button" class="btnButton4font" onclick="importData()" value="批量导入" />
					 <%}%>
	            		<input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/assetApply!assetApplyDel.action','applyId','applyId',this);" value="<s:text name="comm.delselect"/>" />
	            		<input type="button" class="btnButton4font" onclick="export2Excel();" value="导　出" />
	            	</s:if>
	            </td>  
	        </tr>  
	    </table>  
	    <!-- MIDDLE  BUTTONS END --> 
	    
	    <!-- LIST TITLE PART START -->       
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
	        <!-- thead必须存在且id必须为headerContainer -->  
	        <thead id="headerContainer">  
	        <tr class="listTableHead"> 
	        	<td whir-options="field:'applyId',width:'3%',checkbox:true,renderer:showCheckbox" >
	            	<input type="checkbox" name="items" id="items" onclick="setCheckBoxState('applyId',this.checked);" />
	            </td>  
	            <td whir-options="field:'purchaseCode',width:'10%'">采购单编号</td>    
	            <td whir-options="field:'assetName',width:'20%',renderer:show">资产名称</td>    
	            <td whir-options="field:'applyClassName',width:'10%'">采购类别</td>    
	            <td whir-options="field:'kiteMark',width:'10%'">规格型号</td>    
	            <td whir-options="field:'purchaseApplyUserName',width:'10%',renderer:showPurchaseApplyUser">申请人</td>    
	            <td whir-options="field:'purchaseOrgName',width:'20%'">申请部门</td> 
	            <td whir-options="field:'applyStatus',width:'10%',renderer:showApplyStatus">采购状态</td> 
	            <td whir-options="field:'',width:'8%',renderer:myOperate">操作</td>    
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
        initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:showUserCardInfo});          
    }); 
     
    //自定义查看栏内容
    function showCheckbox(po, i) {
    	var hasModiRight = "${hasModiRight}";
    	var applyStatus = po.applyStatus;
    	var hasRight = po.hasRight;
    	
    	var html = "";
    	if(applyStatus != "0" || (hasModiRight != "1" || hasRight != "1")){
    		html = "disabled=true";
    	}
    	return html;
    }
    
	function show(po,i){
		var assetName =  po.assetName;
		/*
		var html = '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetApplyFlow.action?p_wf_recordId=' + po.applyId + '&p_wf_openType=modifyView' + '&editType=view' + '\',isFull:true,winName:\'assetApplyFlow\'});">' + assetName + '</a>';
		*/
		var html = '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetApplyFlow.action?p_wf_recordId=' + po.applyId + '&p_wf_openType=modifyView&p_wf_moduleId=110' + '&editType=view' + '\',isFull:true,winName:\'assetApplyFlow\'});">' + assetName + '</a>';
		var isImport = po.isImport;
		var applyStatus = po.applyStatus;
		if(isImport == '1') {
			html = '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetApplyView.action?applyId=' + po.applyId + '&verifyCode=' + po.verifyCode + '&p_wf_moduleId=110\',isFull:true,winName:\'assetApplyView\'});">' + assetName + '</a>';
		} else if(applyStatus == '4') {
			html = '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetApplyStore.action?applyId=' + po.applyId + '&verifyCode=' + po.verifyCode + '&p_wf_moduleId=110\',isFull:true,winName:\'assetApplyStore\'});">' + assetName + '</a>';
		}
		return html;
	}
	
	function showApplyStatus(po, i){
		var applyStatus = po.applyStatus;
		var html = "";
		if(applyStatus == "0") {
			html = "已采购";
		} else if(applyStatus == "4") {
			html = "已入库";
		} else {
			html = "&nbsp;";
		}
		return html;
	}
	//自定义操作栏内容   
    function myOperate(po,i){
    	var hasRight = po.hasRight;
    	var applyStatus = po.applyStatus;
    	var hasModiRight = '${hasModiRight}';
    	var isImport = po.isImport;
    	var html = "";
    	if(hasRight == "1" && applyStatus == "0") {
    		if(isImport == '1') {
    			html += '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetApplyModi.action?applyId=' + po.applyId + '&verifyCode=' + po.verifyCode + '\',isFull:true,winName:\'assetApplyModi\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="修改" ></a>';
    		} else {
    			html += '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetApplyFlow.action?p_wf_recordId=' + po.applyId + '&p_wf_openType=modifyView' + '&editType=modify' + '\',isFull:true,winName:\'assetApplyFlow\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="修改" ></a>';
    		}
    		if(hasModiRight == "1") {
    			if(isImport == "1") {
    				html += '<a href="javascript:void(0)" onclick="ajaxDelete(\'<%=rootPath%>/assetApply!assetApplyDel.action?applyId=' + po.applyId + '\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="删除" ></a>';
    			}
    			html += '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetStoreAdd.action?applyId=' + po.applyId + '&isImport=' + isImport + '&verifyCode=' + po.verifyCode + '\',width:820,height:670,winName:\'assetStoreAdd\'});"><img border="0" src="<%=rootPath%>/images/officeset.gif" title="入库" ></a>';
    		}
    	} else {
    		html += '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/assetApply!assetStoreView.action?applyId=' + po.applyId + '&verifyCode=' + po.verifyCode + '\',isFull:true,winName:\'assetStoreView\'});"><img border="0" src="<%=rootPath%>/images/konwledge_view.gif" title="查看" ></a>';
    	}
        return html;   
    }  
    
    function modify(applyId,type,isImport,applyStatus) {
    	var modiUrl = '<%=rootPath%>/assetApplyFlow.action?p_wf_recordId=' + applyId + '&p_wf_openType=modifyView';
    	var winName = "assetApplyFlow";
    	if(isImport == '1') {
    		modiUrl = '<%=rootPath%>/assetApply!assetApplyModi.action?applyId=' + applyId;
    		winName = "assetApplyModi";
    	}
		openWin({url:modiUrl,isFull:true,winName:'assetApplyModi'});
    }
    
    function downloadTemplate() {
    	location.href="<%=rootPath%>/public/download/download.jsp?verifyCode=<%=dlcode%>&FileName=assetApply_import_template.xls&name=资产采购模板.xls&path=assetManager";
    }
    
    function importData() {
    	excelImport({importer:"<%=rootPath%>/assetApply!assetApplyImportSave.action"});
    }
    
	function showPurchaseApplyUser(po,i){  
	    var html = "";  
	    var target = "false";  
	    if('${sessionScope.userId}'==po.purchaseApplyUserId){  
	        target = "true";  
	    }  
	    var data = whirRootPath + "/public/desktop/getUserCardInfo.jsp?id="+po.purchaseApplyUserId+"&hasMsg="+target;  
	    html +="<a class=\"trigger1\" rel=\""+data+"\" href=\"javascript:view("+po.purchaseApplyUserId+");\" >"+po.purchaseApplyUserName+"</a>";  
	  
	    return html;  
	}  
	
	function export2Excel(){
		var url = whirRootPath + "/assetApply!exportExcel.action";
	    commonExportExcel({formId:'queryForm',action:url});
	}
</script>

</html>



