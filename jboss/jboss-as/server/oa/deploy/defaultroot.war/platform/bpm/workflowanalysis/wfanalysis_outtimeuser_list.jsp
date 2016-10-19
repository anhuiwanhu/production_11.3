<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>标准列表页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
    <script language="JavaScript" src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/src/name/xio/util/Map.js" type="text/javascript"></script>	
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	 var outTimeUserMap=new Map();
	 <% 
	    Map outTimeUserMap=new HashMap();
		if(request.getAttribute("outTimeUserMap")!=null){
			outTimeUserMap=(Map)request.getAttribute("outTimeUserMap");
		}
	    if (outTimeUserMap != null) {
             Iterator it = outTimeUserMap.entrySet().iterator();
             while (it.hasNext()) {
                 Map.Entry entry = (Map.Entry) it.next();
                 String key = "" + entry.getKey();
                 Object value = entry.getValue();
	 %>
                outTimeUserMap.put("<%=key%>","<%=value%>");
	 <%
             }
        }
	 
	 %>
		
	//-->
	</SCRIPT>
</head>
<!-- <body class="MainFrameBox"> -->
<body class="MainFrameBox" style="overflow-x:hidden;" >
	<s:form name="queryForm" id="queryForm" action="${ctx}/wfanalysisouttimeuser!list.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <s:hidden  name="moduleId"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar"  >  
        <tr>
            <td class="whir_td_searchtitle"><s:text name="workflowAnalysis.Personnel"/> <!-- 人员 -->：</td>
            <td class="whir_td_searchinput" style="width:500px" colspan="2" nowrap>
			   <s:textfield id="searchUserNames" name="searchUserNames" size="16" cssClass="inputText"    readonly="true"  /><a href="#" class="selectIco" onclick="openSelect({allowId:'searchUserIds', allowName:'searchUserNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
                <s:hidden  name="searchUserIds" id="searchUserIds" />
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="whir_td_searchtitle" ><!-- <s:text name="file.subtime"/> -->创建时间：</td>
			<td class="whir_td_searchinput"  colspan="2" nowrap>
				<s:textfield name="searchBeginDate" id="searchBeginDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchEndDate\\',{d:0});}'})" /> <s:text name="file.to"/> 
				<s:textfield name="searchEndDate" id="searchEndDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchBeginDate\\',{d:0});}'})" />
				<!-- <s:checkbox  name="searchDate"  id="searchDate" ></s:checkbox> -->
			</td> 
            <td  class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
   
   <!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
               <!--  <input type="button" class="btnButton4font" onclick="openWin({url:'<%=rootPath%>/wfchannel!add.action',width:700,height:360,winName:'addUser'});" value="新增" /> -->
                <!--input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/wfsetup!deleteButton.action?deleteId=','buttonId','value',this);" value="批量删除" /-->
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'_m_outtimenum',width:'8%',allowSort:true,renderer:showRank "><s:text name="workflowAnalysis.OverallRanking"/><!--总排名--></td>
			<td whir-options="field:'m_empname',width:'15%'"><s:text name="workflowAnalysis.Personnel"/><!-- 具体流程 --></td>
			<td whir-options="field:'m_orgnamestring',width:'35%',allowSort:true"><s:text name="workflowAnalysis.Department"/><!-- 跳转前活动 --></td>
			<td whir-options="field:'m_pronum',width:'10%'"><s:text name="workflow.AllNumOfactivities"/><!-- <s:text name="workflowAnalysis.TotalWorkflow"/> --><!-- 跳转前办理人 --></td>
			<td whir-options="field:'m_outtimenum',width:'10%'"><s:text name="workflowAnalysis.ExpiredNumber"/><!-- 跳转后活动 --></td>
			<td whir-options="field:'m_percent',width:'10%'"><s:text name="workflowAnalysis.ExpiredRate"/>(100%)<!-- 跳转后办理人 --></td> 
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

	function showRank(po,i){
	    var html=outTimeUserMap.get(po.emp_id);
	    return html;
	}
 
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
   </script>
</html>

