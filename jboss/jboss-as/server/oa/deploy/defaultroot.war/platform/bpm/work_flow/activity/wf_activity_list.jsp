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
	<s:form name="queryForm" id="queryForm" action="/wfactivity!list.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <s:hidden  name="moduleId"  id="moduleId"/>
	<s:hidden  name="processId" id="processId"/>
	<s:hidden  name="tableId"   id="tableId"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar"  style="display:none"  >  
        
    </table>
	<!-- SEARCH PART END -->
   
   <!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
                <input type="button" class="btnButton4font" onclick="add();" value='<bean:message bundle="common" key="comm.add"/>' />
                <input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/wfactivity!deleteActivity.action','wfActivityId','wfActivityId',this);" value='<bean:message bundle="common" key="comm.delselect"/>' />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'wfActivityId',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('wfActivityId',this.checked);" ></td>
		    <td whir-options="field:'index',width:'2%'"><bean:message bundle="workflow" key="workflow.xuhao"/></td>  
			<td whir-options="field:'activityName',width:'20%'"><bean:message bundle="workflow" key="workflow.activityname"/></td> 
			<td whir-options="field:'activityType',width:'12%' ,renderer:showtype "><bean:message bundle="workflow" key="workflow.activitytype"/></td> 
			<td whir-options="field:'fromnames',width:'8%'"><!-- 前驱  --><bean:message bundle="workflow" key="workflow.activitysetupprecursor"/></td>
		    <td whir-options="field:'tonames',width:'8%'"><bean:message bundle="workflow" key="workflow.activitysetupsuccessor"/></td>
			<td whir-options="field:'activityDescription',width:'24%'"><bean:message bundle="workflow" key="workflow.activitydescription"/></td>
	        <td whir-options="field:'',width:'11%' ,renderer:showSet"><bean:message bundle="workflow" key="workflow.activitysetup"/></td>
		    <td whir-options="field:'',width:'8%',renderer:myOperate"><bean:message bundle="workflow" key="workflow.categoryoperation"/></td>
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
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:"queryForm"});			
	});
	
	//自定义操作栏内容
	function myOperate(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/wfactivity!updateActivity.action?moduleId='+$("#moduleId").val()+'&processId='+$("#processId").val()+'&tableId='+$("#tableId").val()+'&wfActivityId='+po.wfActivityId+'\',width:950,height:650,winName:\'modifyPackage\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="comm.supdate"/>" ></a><a href="javascript:void(0)" onclick="ajaxDelete(\'<%=rootPath%>/wfactivity!deleteActivity.action?wfActivityId='+po.wfActivityId+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="comm.sdel"/>" ></a>';
		return html;
	}
 
	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function showtype(po,i){
		var html ;
		if(po.activityClass==0){
			html = '<bean:message bundle="workflow" key="workflow.newactivityson"/>';
		}else if(po.activityClass==1){
			html = '<bean:message bundle="workflow" key="workflow.newactivitystandard"/>';
		}else if(po.activityClass==2){
			html = '<bean:message bundle="workflow" key="workflow.newactivityvirtual"/>';
		}else if(po.activityClass==3){
			html = '<bean:message bundle="workflow" key="workflow.newactivityautoback"/>';
		}else if(po.activityClass==4){
			html = '分叉';
		}else if(po.activityClass==5){
			html = '聚合';
		}else{
			html = '<bean:message bundle="workflow" key="workflow.newworkflowrandom"/>';
		}
		return html;
	}

	function showSet(po,i){
	     var html= '<a href=\'javascript:openActivityRelation("'+po.wfActivityId+'","'+po.activityType+'","'+po.activityName+'")\'><bean:message bundle="workflow" key="workflow.activitysetup"/></a>'
		 return html;
	}

    function  openActivityRelation(activityId,activityType,activityName){
	     //alert(activityId);

		  var url='<%=rootPath%>/wfactivity!relation.action?moduleId='+$("#moduleId").val()+'&processId='+$("#processId").val()+'&tableId='+$("#tableId").val()+'&wfActivityId='+activityId+'&activityType='+activityType+'&activityName='+activityName;
 
	      openWin({url:url,width:850,height:650,winName:'relation'});
	}

	function add(){
	      var url='<%=rootPath%>/wfactivity!addActivity.action?moduleId='+$("#moduleId").val()+'&processId='+$("#processId").val()+'&tableId='+$("#tableId").val();
	     openWin({url:url,width:950,height:650,winName:'addProcess'});
	}
   </script>
</html>

