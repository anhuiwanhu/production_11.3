<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	
</head>
<%
  String type =request.getParameter("type")==null?"":request.getParameter("type");
  com.whir.org.manager.bd.ManagerBD  managerBD = new com.whir.org.manager.bd.ManagerBD ();
  //当前人的userId 
  String userId=session.getAttribute("userId").toString();
  boolean hasright=managerBD.hasRight(userId, "yibo*01*01");
%>
<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="YiBoChannel!list.action" method="post" theme="simple">
	<%@ include file="/public/include/form_list.jsp"%>
	<s:hidden id="channelType" name="channelType" />
	<s:hidden id="userDefine" name="userDefine" />
	<s:hidden id="userChannelName" name="userChannelName" />
	<input type="hidden" name="type" id="type" value="<%=type%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
        <tr>
            <td class="whir_td_searchtitle2"><s:text name="info.columnname"/>：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="searchChannelName" name="searchChannelName" cssClass="inputText" />
            </td>
			<td class="SearchBar_toolbar">
                <input type="button" class="btnButton4font" onclick="refreshListForm('queryForm');"  value="<s:text name='comm.searchnow'/>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" onclick="resetForm(this);" value="<s:text name='comm.clear'/>" />
            </td>
        </tr>
    </table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			<td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <%if(hasright){%>
			<td align="right">
                <input type="button" class="btnButton4font" onclick="add();" value="<s:text name='comm.add'/>"/>
            </td>
			<%}%>
        </tr>
    </table>
	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td nowrap whir-options="field:'yiboChannelName',renderer:yiboTitle">易播栏目名称</td> 
			<td whir-options="field:'channelName',width:'35%'">对应信息栏目</td> 
			<td whir-options="field:'yiboCreatedEmpName', width:'10%'">创建人</td> 
			<td whir-options="field:'yiboCreatedTime', width:'10%',renderer:common_DateFormat">创建日期</td> 
			 <%if(hasright){%>
			<td whir-options="field:'',width:'8%',renderer:myOperate"><s:text name="comm.opr"/></td> 
			 <%}%>
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
</s:form>
<script language="javascript">
$(document).ready(function(){
	initListFormToAjax({formId:"queryForm"});
});

document.onkeydown=function(e){ 
	var theEvent = window.event || e; 
	var code = theEvent.keyCode || theEvent.which; 
	if (code == 13) { 
		refreshListForm('queryForm');
	} 
} 

function needAudit(po,i){
	var html ;
	if(po.channelNeedCheckup==1){
		html = "是";
	}else{
		html = "否";
	}
	return html;
}

function add(){
	var url = 'YiBoChannel!add.action?channelType='+$("#channelType").val()+'&userDefine='+$("#userDefine").val();
	openWin({url:url,isFull:true,winName:'addChannel'});
}

function myOperate(po,i){
	var html = "&nbsp;";
	if(po.canVindicate=='1'){
		html = '<a href="javascript:void(0)" onclick="openWin({url:\'YiBoChannel!load.action?yiboChannelId='+po.yiboChannelId+'&channelType='+$("#channelType").val()+'&userDefine='+$("#userDefine").val()+'\',isFull:true,winName:\'modifyTemplate\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="info.allmodify"/>" ></a><a href="javascript:void(0)" onclick="deleteYiBoChannel(\'YiBoChannel!delete.action?yiboChannelId='+po.yiboChannelId+'&channelId='+po.channelId+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="info.alldelete"/>" ></a>';
	}
	return html;
}

function deleteYiBoChannel(url,obj){
	whir_confirm('确认要删除该易播栏目吗？',function(){
		ajaxOperate({urlWithData:url,tip:'<s:text name="info.alldelete"/>',isconfirm:false,formId:'queryForm'});
	});
}

//渲染标题
function yiboTitle(po,i){
	var html = "", channelName="";
	channelName = "<a onclick='location_href(\"InfoList!allList.action?channelId="+po.channelId+"&channelName="+po.channelName+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$('#channelType').val()+"&userChannelName="+$('#userChannelName').val()+"&userDefine="+$('#userDefine').val()+"\");' style='cursor:pointer'>"+po.yiboChannelName+"</a>";
	html = channelName;
	return html;
}
</script>
</body>