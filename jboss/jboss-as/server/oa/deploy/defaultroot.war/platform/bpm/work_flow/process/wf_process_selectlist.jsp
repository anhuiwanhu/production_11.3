<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<s:form name="queryForm" id="queryForm" action="${ctx}/wfprocess!list.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <s:hidden  name="moduleId" id="moduleId"/>

	<s:hidden  name="selectId" id="selectId"/>
	<s:hidden  name="selectName" id="selectName"/>
	<s:hidden  name="paraId" id="paraId"/>
	<s:hidden  name="paraName" id="paraName"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar"  >  
        <tr>
            <td class="whir_td_searchtitle2" ><bean:message bundle="workflow" key="workflow.Category"/>：</td>
            <td class="whir_td_searchinput" >
			 <s:textfield id="searchPackageName" name="searchPackageName" size="16" cssClass="inputText" />
            </td>
			<td class="whir_td_searchtitle2" ><bean:message bundle="workflow" key="workflow.workflowname"/>：</td>
            <td class="whir_td_searchinput" >
			 <s:textfield id="searchProcessName" name="searchProcessName" size="16" cssClass="inputText" />
            </td>
            <td   class="SearchBar_toolbar" >
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
   
   <!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr>
			 <td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
                <input type="button" class="btnButton4font" onclick="ok();" value='确  定' />
                <input type="button" class="btnButton4font" onclick="clearSelect();" value='清  空' />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
		    <td whir-options="field:'wfWorkFlowProcessId',width:'2%',checkbox:true,renderer:showCheck" >&nbsp;</td>
			<td whir-options="field:'packageName',width:'15%'"><bean:message bundle="workflow" key="workflow.setupcategory"/></td> 
			<td whir-options="field:'workFlowProcessName',width:'20%',allowSort:true"><bean:message bundle="workflow" key="workflow.workflowname"/></td> 
			<td whir-options="field:'userScope',width:'15%'"><bean:message bundle="workflow" key="workflow.setupusers"/></td> 
			<td whir-options="field:'processType',width:'15%',renderer:showtype"><bean:message bundle="workflow" key="workflow.setuptype"/></td> 
			<td whir-options="field:'createUserName',width:'15%'"><bean:message bundle="workflow" key="workflow.setupcreator"/></td> 
			<td whir-options="field:'processSort',width:'10%'"><bean:message bundle="information" key="info.sort" /></td> 
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
</body>
 <script type="text/javascript">
 
    var api =null;
	var W=null;
	api=frameElement.api, W = api.opener; 
	api.max();
 
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:"queryForm"});		
	});

	 /**
	  展现批量选择复选框
	*/
	function  showCheck(po,i){
		 var html =' wfWorkFlowProcessId="'+po.wfWorkFlowProcessId+'"  workFlowProcessName="'+po.workFlowProcessName+'" ';
 
		 var selectId=$("#selectId").val();
		 if(selectId.indexOf(","+po.wfWorkFlowProcessId+",")>=0){
			 html+=' checked=true ';
		 }
         html+=' onclick="checkProcess(this);" ';
		 return html;
	}
    

	/**
	 选中或者取消 check
	*/
	function checkProcess(obj){
        var jobj=$(obj);
		if(jobj.attr("checked")=="checked"){
            var selectId_val=$("#selectId").val();
			var selectName_val=$("#selectName").val();
            selectId_val=selectId_val+","+jobj.attr("wfWorkFlowProcessId")+",";
            selectName_val=selectName_val+","+jobj.attr("workFlowProcessName")+",";
			$("#selectId").val(selectId_val);
			$("#selectName").val(selectName_val);
		}else{
		    var selectId_val=$("#selectId").val();
			var selectName_val=$("#selectName").val();
            selectId_val=selectId_val.replace(","+jobj.attr("wfWorkFlowProcessId")+",","");
			selectName_val=selectName_val.replace(","+jobj.attr("workFlowProcessName")+",","");
			$("#selectId").val(selectId_val);
			$("#selectName").val(selectName_val);
		}
	}
    
	/**
	 往父页面 设置选择 的id 与name
	*/
	function ok(){
         //$("#feedUserId",parent.document.body).val(selPressUserId);
        var selectId_val=$("#selectId").val();
	    var selectName_val=$("#selectName").val(); 
		if(selectId_val!=null&&selectId_val!=""){
			//把 ,前后分割  换为;分割
			selectName_val=selectName_val.substring(1,selectName_val.length-1);
            var selectName_valArr=selectName_val.split(",,");
			var selectName_val_="";
			for(var i=0;i<selectName_valArr.length;i++){
				selectName_val_+=selectName_valArr[i]+";";
			}
            selectName_val=selectName_val_.substring(0,selectName_val_.length-1);

			//把 ,前后分割  换为;分割
			selectId_val=selectId_val.substring(1,selectId_val.length-1);
            var selectId_valArr=selectId_val.split(",,");
			var selectId_val_="";
			for(var i=0;i<selectId_valArr.length;i++){
				selectId_val_+=selectId_valArr[i]+";";
			}
            selectId_val=selectId_val_.substring(0,selectId_val_.length-1);
		}else{
		}

		$("#"+$("#paraId").val(),parent.document.body).val(selectId_val);
		$("#"+$("#paraName").val(),parent.document.body).val(selectName_val);

		api.close();
	}
    
	/**
	 清空选择
	*/
	function clearSelect(){
		$("#"+$("#paraId").val(),parent.document.body).val("");
		$("#"+$("#paraName").val(),parent.document.body).val("");
		api.close();
	}

	//自定义查看栏内容
	function show(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/wfprocess!viewButton.action?buttonId='+po.buttonId+'&moduleId='+$("#moduleId").val()+'\',width:620,height:310,winName:\'showUser\'});">'+po.packageName+'</a>';
		return html;
	}
 
	function showtype(po,i){
		var html ;
		if(po.processType==1){
			html = '<bean:message bundle="workflow" key="workflow.newworkflowfix"/>';
		}else{
			html = '<bean:message bundle="workflow" key="workflow.newworkflowrandom"/>';
		}
		return html;
	}

	function add(){
	   var url='<%=rootPath%>/wfprocess!addProcess.action?moduleId='+$("#moduleId").val();
	   openWin({url:url,width:890,height:750,isFull:true,winName:'addProcess'});
	}
   </script>
</html>

