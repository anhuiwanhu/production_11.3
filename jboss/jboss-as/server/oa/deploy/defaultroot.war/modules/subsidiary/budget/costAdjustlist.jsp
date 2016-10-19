<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
 List nianOptions= (List) request.getAttribute("nianOptions");
  com.whir.org.manager.bd.ManagerBD bd = new com.whir.org.manager.bd.ManagerBD();
 boolean modiManage = bd.hasRight(session.getAttribute("userId")+"","budget*cost*03");//预算管理--修改权限
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>预算费用调整</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
    <s:form name="queryForm" id="queryForm" action="${ctx}/budgetCostAdjust!list2.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
        <tr>
            <td class="whir_td_searchtitle2">预算部门：</td>
            <td class="whir_td_searchinput" nowrap >
                 <s:textfield id="sectionname" name="sectionname" size="16" cssClass="inputText" cssStyle="width:90%;"/><a href="javascript:void(0);" class="selectIco" onClick="openEndowBM();"></a>
                    <s:hidden name="sectionid" id="sectionid"/>
            </td>
             <td class="whir_td_searchtitle2">年度：</td>
            <td class="whir_td_searchinput">
                <select name="adjustyear" id="adjustyear" style="width:50%" class="selectlist" >
                  <%
                    if(nianOptions != null && nianOptions.size() >0){
                        for(int i = 0; i < nianOptions.size(); i++){
                            Object[] obj = (Object[])nianOptions.get(i);
                   %>
                        <option value="<%=obj[1]%>"><%=obj[0]%></option>
                   <%
                        }
                    }
                  %>
            </select>
            </td>
            <td class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>'/>
                <!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    

	<!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr>
            <td align="right">
               &nbsp;
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'sectionnamestring',width:'37%',renderer:show">预算部门</td> 
			<td whir-options="field:'costyear', width:'15%'">年度</td> 
            <td whir-options="field:'totalmoney', width:'20%'">预算总额(元)</td> 
            <td whir-options="field:'currentmoney', width:'20%'">当前额度(元)</td> 
			<td whir-options="field:'',width:'8%',renderer:myOperate">操作</td> 
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
		initListFormToAjax({formId:'queryForm'});		
	});
	 function show(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/budgetCostAdjust!adjustList.action?sectionid='+po.sectionid+ '&adjustyear='+po.costyear+'&verifyCode='+po.verifyCode+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'viewBudgetCostAdjust\'});">'+po.sectionnamestring+'</a>';
        return html;
	}
	//自定义操作栏内容
	function myOperate(po,i){
        var html ='';
		 <%--if(modiManage){%>
			 if(po.ishaveRight == 'yes'){
				html = '<img title="调整" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/budgetCostAdjust!add.action?adjustyear='+po.costyear+'&sectionid='+po.sectionid+'&verifyCode='+po.verifyCode+'\',width:600,height:350,winName:\'addBudgetCostAdjust\'});">';
				
			 }
        <%}--%>
        html = '<img title="调整" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/budgetCostAdjust!add.action?adjustyear='+po.costyear+'&sectionid='+po.sectionid+'&verifyCode='+po.verifyCode+'\',width:600,height:350,winName:\'addBudgetCostAdjust\'});">';
		return html;
	}
	function openEndowBM(){
        var myids=$("#sectionid").val();
        var mynames=$("#sectionname").val();
        var url="${ctx}/budgetSection!sectionChooseList.action?forward=sectionChoose&type=radio&opt=1&ids="+myids+"&id=sectionid&name=sectionname";
        openWin({url:url,width:600,height:400,winName:'selSection'});
        //popup({id:'sectionid',content: 'url:'+url,title:'预算部门',width: '600px',height: '400px',lock: true,resize: false}); 	
    }
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	
</script>

</html>

