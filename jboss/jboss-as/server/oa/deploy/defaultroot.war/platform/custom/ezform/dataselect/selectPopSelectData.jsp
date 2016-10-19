<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
<title>选择<s:property value="showFieldName"/></title>  
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
<%@ include file="/public/include/meta_base.jsp"%>  
<%@ include file="/public/include/meta_list.jsp"%>  
<!--这里可以追加导入模块内私有的js文件或css文件-->
<script language="javascript" src="<%=rootPath%>/platform/custom/custom_form/run/js/form.js"></script>
<!--script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/ezform.js"></script-->
<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>
<style>
.bInputtext{width:30%;}
.bInputtext_hover{width:30%;}
.bInputtext:hover{width:30%;}
</style>
</head>
<%
String selectType = request.getParameter("selectType");
String fieldId = request.getParameter("fieldId")!=null?request.getParameter("fieldId"):"";
String fieldValue = request.getParameter("fieldValue")!=null?request.getParameter("fieldValue"):"";
String fieldName = request.getParameter("fieldName")!=null?request.getParameter("fieldName"):"";
String popIndex = request.getParameter("popIndex")!=null?request.getParameter("popIndex"):"0";

String mainTableId = (String)request.getAttribute("mainTableId");
String showField = (String)request.getAttribute("showField");
String tableName = (String)request.getAttribute("tableName");
String field="";
%>
<body class="MainFrameBox">  
<!--这里的表单id queryForm 允许修改 -->  
<s:form name="queryForm" id="queryForm" action="/PopSelect!popSelectList.action" method="post">
<input type="hidden" name="selectType" value="<%=selectType%>"/>
<input type="hidden" name="fieldId" value="<%=fieldId%>"/>
<input type="hidden" name="fieldValue" value="<%=fieldValue%>"/>
<input type="hidden" name="fieldName" value="<%=fieldName%>"/>
<input type="hidden" name="popIndex" value="<%=popIndex%>"/>
<!-- SEARCH PART START -->  
<%@ include file="/public/include/form_list.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
<s:property value="searchPart" escape="false"/>
</table>
<!-- SEARCH PART END -->
  
<!-- MIDDLE  BUTTONS START -->  
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
    <tr> 
        <td align="right">
            <input type="button" class="btnButton4font" onClick="javascript:save('close');" value="确&nbsp;&nbsp;&nbsp;定">
            <input type="button" class="btnButton4font" onClick="javascript:window.close();" value="退&nbsp;&nbsp;&nbsp;出">
        </td>  
    </tr>
</table>  
<!-- MIDDLE  BUTTONS END -->  

<!-- LIST TITLE PART START -->      
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
    <!-- thead必须存在且id必须为headerContainer -->
    <thead id="headerContainer">  
    <tr class="listTableHead">
    <%
        if("1".equals(selectType)){
    %>
        <td whir-options="field:'<s:property value="sysTableName" escape="false"/>_id',width:'2%', checkbox:true, renderer:renderBox"><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('<s:property value="sysTableName" escape="false"/>_id',this.checked);" ></td>
    <%
        } else {
    %>
        <td whir-options="field:'<s:property value="sysTableName" escape="false"/>_id',width:'2%', radio:true, renderer:renderBox" >&nbsp;</td>
    <%
        }
    %>
    <%
        String[][] listFields = (String[][])request.getAttribute("listFields");
        if(listFields != null && listFields.length > 0){
            for(int i=0; i<listFields.length; i++){
            	if(!showField.equals(listFields[i][2])){
					field += listFields[i][2]+",";
				}
    %>
        <td whir-options="field:'<%=listFields[i][2]%>',width:'<%=listFields[i][3]%>%', allowSort:true"><%=listFields[i][1]%></td>
    <%}}%>
    </tr>  
    </thead>
    <!-- tbody必须存在且id必须为itemContainer -->  
    <tbody id="itemContainer">
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
    initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:initData});         
});

var attrName = '<s:property value="sysTableName" escape="false"/>_id';
attrnName = replaceDollar(attrName);//attrName.replace(/\$/igm, '\\$');

function initData(){
    //var openerVal = "," + opener.document.getElementsByName("<%=fieldName%>")[<%=popIndex%>].value + ",";
    var openerVal = "," + opener.document.getElementsByName("<%=fieldName%>")[<%=popIndex%>].getAttribute("data-val") + ",";
    $('input[name="'+attrnName+'"]').each(function(i){
        var val = "," + $(this).attr('hiddenval') + ",";
        if(openerVal != ',,' && openerVal.indexOf(val)!=-1){
            $(this).attr("checked",true);	
		    //$(this).parent().addClass("checked");
        }
    });
}

function renderBox(po, i){
    var val="";
	<%
		field = field.substring(0,field.length()-1);
		String[] fields = field.split(",");
		for(int i=0;i<fields.length;i++){
	%>
		val += po.<%=fields[i]%>+",";
	<%}%>

	val = val.substring(0,val.length-1);
    var html = '';

    html += ' showval="'+po.<%=showField%>+'" hiddenval="'+val+'" ';

    return html;
}

function refreshTheListForm(obj) {
    refreshListForm(obj);
}

function resetTheForm(obj){
    resetForm(obj);
}

//自动关联两个数据库中相同的字段值
function selAssociateFieldsRET(id){
<%
    if(mainTableId!=null && !"".equals(mainTableId)){
%>
    xmlHttp.open("GET", "<%=rootPath%>/platform/custom/ezform/asscoiatefield/getAsscoiateField_ajax.jsp?id="+id+"&mainTableId=<%=mainTableId%>&asscoiateTable=<%=tableName%>&field=<%=showField%>&popIndex=<%=popIndex%>&isPopWin=1", false);//单选弹出与下拉框统一
	xmlHttp.onreadystatechange = updateAsscoiateField;
	xmlHttp.send(null);
<%}%>
}

function updateAsscoiateField(){
	if (xmlHttp.readyState < 4) {
	}

	if (xmlHttp.readyState == 4) {
		if(xmlHttp.status==200) {
			var response = xmlHttp.responseText;
			eval(response);
		}
	}
}

function save(tag){
	if(tag=='close'){
		var checks = $("input[name='"+attrName+"']");//document.getElementsByName("batchDel");
        var radio_type = false;
        var radio_id='';
        var val3='';
		if (checks) {
			var pVal1="";
			//var pVal2="";
			var j=0;
			for(var i = 0 ; i < checks.length ; i++ ) {
				var chkObj = checks[i] ;
                var inputType = chkObj.type;
                if(radio_type==false){
                    if(inputType == 'radio'){
                        radio_type = true;
                    }
                }

				if(chkObj.checked){
					var val1 = checks[i].getAttribute('showval');//document.getElementsByName('<%=showField%>_h')[i].value;
					var val2 = checks[i].getAttribute('<s:property value="sysTableName" escape="false"/>_id');
					val3 = checks[i].getAttribute('hiddenval');
                    radio_id = val2;

					pVal1 += (j>0?",":"")+val1;
					//pVal2 += (j>0?",":"")+val2;
					j++;
				}
			}

			opener.document.getElementsByName("<%=fieldName%>")[<%=popIndex%>].value=pVal1;
			opener.document.getElementsByName("<%=fieldName%>")[<%=popIndex%>].setAttribute("data-val",val3);

<%if(fieldValue!=null&&fieldValue.startsWith("@")){%>
            //
            if(radio_type){
                if(radio_id!=''){
                    //自动关联两个数据库中相同的字段值
                    selAssociateFieldsRET(radio_id);
                }
            }
<%}%>
            //防止第一次赋值不成功，重新赋值
			opener.document.getElementsByName("<%=fieldName%>")[<%=popIndex%>].value=pVal1;
			opener.document.getElementsByName("<%=fieldName%>")[<%=popIndex%>].setAttribute("data-val",val3);
            try{
                opener.document.getElementsByName("<%=fieldName%>")[<%=popIndex%>].focus();
            }catch(e){}
            try{
                opener.wfchooseData();//工作流程设置用
            }catch(e){}
			window.close();
		}
	}
}
</script>
</html>