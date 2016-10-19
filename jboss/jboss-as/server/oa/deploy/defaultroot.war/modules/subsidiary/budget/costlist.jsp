<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>

<%
   com.whir.org.manager.bd.ManagerBD bd = new com.whir.org.manager.bd.ManagerBD();
boolean addManage = bd.hasRight(session.getAttribute("userId")+"","budget*cost*02");//预算管理--新增权限
boolean modiManage = bd.hasRight(session.getAttribute("userId")+"","budget*cost*03");//预算管理--修改权限
 List nianOptions= (List) request.getAttribute("nianOptions");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>预算费用</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
    <s:form name="queryForm" id="queryForm" action="${ctx}/budgetCost!list2.action" method="post" theme="simple">

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
                <select name="costyear" id="costyear" style="width:50%" class="selectlist" >
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
            <td align="right">
                <%if(addManage){%>
                <input type="button" class="btnButton4font" onclick="openWin({url:'<%=rootPath%>/budgetCost!add.action?addType=add',width:screen.availWidth-20,height:(screen.availHeight-20),winName:'addBudgetCost'});" value='<s:text name="comm.add"/>' />
                <%}%>
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'sectionnamestring',width:'52%',renderer:show">预算部门</td> 
			<td whir-options="field:'costyear', width:'15%'">年度</td> 
            <td whir-options="field:'sumcostamount', width:'25%'">预算总额(元)</td> 
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
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/budgetCost!viewMonth.action?viewType=view&sectionid='+po.sectionid+ '&costyear='+po.costyear+'&verifyCode='+po.verifyCode+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'viewSyxx\'});">'+po.sectionnamestring+'</a>';
		
        return html;
	}
	//自定义操作栏内容
	function myOperate(po,i){
        var html ='';
        //alert("modiManage:<%=modiManage%>");
        //alert("po.ishaveRight:"+po.ishaveRight);
        <%--if(modiManage){%>
            if(po.ishaveRight == 'yes'){
                html =   '<img title="修改" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/budgetCost!edit.action?bcwfId='+po.wfid+'&addType=update&costyear='+po.costyear+'&sectionid='+po.sectionid+'&verifyCode='+po.verifyCode+'\',width:'+(screen.width-20)+',height:'+(screen.height-20)+',winName:\'modifyCost\'});"><img title="删除" style="cursor:hand" border="0" src="<%=rootPath%>/images/del.gif" onClick="remove2(\''+po.sectionid+'\',\''+po.costyear+'\',\''+po.verifyCode+'\');">';
            }
        <%}--%>
         <%if(addManage){%>           
            if(po.ishaveRight == 'yes'){
                html =   '<img title="修改" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/budgetCost!edit.action?bcwfId='+po.wfid+'&addType=update&costyear='+po.costyear+'&sectionid='+po.sectionid+'&verifyCode='+po.verifyCode+'\',width:'+(screen.width-20)+',height:'+(screen.height-20)+',winName:\'modifyCost\'});"><img title="删除" style="cursor:hand" border="0" src="<%=rootPath%>/images/del.gif" onClick="remove2(\''+po.sectionid+'\',\''+po.costyear+'\',\''+po.verifyCode+'\');">';
            } 
        <%}else if(modiManage){%>  
            if(po.ishaveRight == 'yes'){
                html =   '<img title="修改" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/budgetCost!edit.action?bcwfId='+po.wfid+'&addType=update&costyear='+po.costyear+'&sectionid='+po.sectionid+'&verifyCode='+po.verifyCode+'\',width:'+(screen.width-20)+',height:'+(screen.height-20)+',winName:\'modifyCost\'});"><img title="删除" style="cursor:hand" border="0" src="<%=rootPath%>/images/del.gif" onClick="remove2(\''+po.sectionid+'\',\''+po.costyear+'\',\''+po.verifyCode+'\');">';
             }      
        <%}%>
		return html;
	}
    function remove2(sectionid,costyear,verifyCode){
		  if(sectionid !=''){
            $.dialog.confirm("确认删除记录吗？", function(){remove1(sectionid,costyear,verifyCode)});
          }
    }
    function remove1(sectionid,costyear,verifyCode){
				var ok = true;
				$.ajax({
				url: '<%=rootPath%>/modules/subsidiary/budget/getServices.jsp?tag=costQuote&costyear=' + costyear + '&sectionid=' + sectionid + '&' + Math.round(Math.random()*1000),
				type: 'GET',
				data: null,
				timeout: 1000,
				async: false,      //true异，false,ajax同步
				error: function(){
					//alert('Error loading XML document');
				},
				success: function(data){
					data = data.replace(/(^\s*)|(\s*$)/g,"");
					if(data !='' && data=='1'){
						ok = false;
					}
				}
				});
				if(!ok){
                    $.dialog.confirm("此预算部门" + costyear + "年,已发生费用，确认删除吗?", function(){
                        var urlWithData='${ctx}/budgetCost!delete.action?sectionid='+sectionid+'&costyear='+costyear+'&verifyCode='+verifyCode;
                        var paramers={urlWithData:urlWithData,tip:'',isconfirm:false,formId:'queryForm',callbackfunction:null};
                        ajaxOperate(paramers);
                    });
					
				}else{
					  var urlWithData='${ctx}/budgetCost!delete.action?sectionid='+sectionid+'&costyear='+costyear+'&verifyCode='+verifyCode;
                        var paramers={urlWithData:urlWithData,tip:'',isconfirm:false,formId:'queryForm',callbackfunction:null};
                        ajaxOperate(paramers);
				}
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

