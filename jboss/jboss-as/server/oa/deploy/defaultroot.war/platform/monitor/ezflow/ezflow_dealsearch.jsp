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
<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/ezform.js"></script>
<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>
<style>
.bInputtext{width:30%;}
.bInputtext_hover{width:30%;}
.bInputtext:hover{width:30%;}
</style>
</head>
<%
String key = request.getParameter("key");
String whir_formKey = request.getParameter("whir_formKey");
String attachmentField = "";

String fileServer = (com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr())==null || com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr()).length()<1 || "null".equals(com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr())))?rootPath:com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
%>
<body class="MainFrameBox">  
<!--这里的表单id queryForm 允许修改 -->  
<s:form name="queryForm" id="queryForm" action="/EzFLOWDealSearch!deallist.action" method="post">
<input type="hidden" name="key" value="<%=key%>"/>
<input type="hidden" name="whir_formKey" value="<%=whir_formKey%>"/>
<input type="hidden" id="isEdit" name="isEdit" value="<s:property value="canModify"/>"/>
<!-- SEARCH PART START -->  
<%@ include file="/public/include/form_list.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
    <s:property value="searchPart" escape="false"/>
    <tr>
        <td class='whir_td_searchtitle'><s:text name="workflow.createtime"/>：</td>
        <td class='whir_td_searchinput'><input type=text class='Wdate whir_datebox' name=createStartDate id=createStartDate onclick='WdatePicker({el:"createStartDate", dateFmt:"yyyy-MM-dd"});' value="">&nbsp;<s:text name="file.to"/>&nbsp;<input type=text class='Wdate whir_datebox' name=createEndDate id=createEndDate onclick='WdatePicker({el:"createEndDate", dateFmt:"yyyy-MM-dd"});' value=""><!--input type="checkbox" name="createDate" value="1"--></td>

        <td class='whir_td_searchtitle'><s:text name="comm.finishedDate"/>：</td>
        <td class='whir_td_searchinput'><input type=text class='Wdate whir_datebox' name=doneStartDate id=doneStartDate onclick='WdatePicker({el:"doneStartDate", dateFmt:"yyyy-MM-dd"});' value="">&nbsp;<s:text name="file.to"/>&nbsp;<input type=text class='Wdate whir_datebox' name=doneEndDate id=doneEndDate onclick='WdatePicker({el:"doneEndDate", dateFmt:"yyyy-MM-dd"});' value=""><!--input type="checkbox" name="isDoneDate" value="1"--></td>

        <td class='whir_td_searchtitle'><s:text name="file.dostatus"/>：</td>
        <td class='whir_td_searchinput'>
            <select name="workStatus" class="selectlist"><!-- style="width:154px;"-->
				<option value="">--<s:text name="workflow.Pleaseselect"/>--</option>
				<option value="1"><s:text name="workflow.Transacting"/></option>
				<option value="100"><s:text name="workflow.Transacted"/></option>
				<option value="-2"><s:text name="workflow.Cancel"/></option>
				<option value="-1"><s:text name="workflow.Return"/></option>
			</select>
        </td>
        
    </tr>
    <tr>
        <td class='SearchBar_toolbar' colspan=6>
            <input type="button" class="btnButton4font" onClick="refreshTheListForm('queryForm');" value="<s:text name="comm.searchnow"/>"/>
            <input type="button" class="btnButton4font" onClick="resetTheForm(this);" value="<s:text name="comm.clear"/>"/>
        </td>
    </tr>
</table>
<!-- SEARCH PART END -->

<!-- MIDDLE  BUTTONS START -->  
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
    <tr>
        <td align="left">
            <span id="processSpanName"></span>
        </td>
        <td align="right">
            <s:if test="canModify == 1">
            <input type="button" class="btnButton4font" onClick="javascript:deleteBatch();" value="<s:text name="comm.delselect"/>">
            </s:if>
            <input type="button" class="btnButton4font" onClick="javascript:exportOut(1);" value="<s:text name="comm.selectedExport"/>">
            <input type="button" class="btnButton4font" onClick="javascript:exportOut(0);" value="<s:text name="comm.export"/>">
        </td>  
    </tr>
</table>  
<!-- MIDDLE  BUTTONS END -->  

<!-- LIST TITLE PART START -->      
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
    <!-- thead必须存在且id必须为headerContainer -->
    <thead id="headerContainer">  
    <tr class="listTableHead">
        <td whir-options="field:'p_wf_processInstanceId',width:'2%', checkbox:true, renderer:renderRecordId"><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('p_wf_processInstanceId',this.checked);" ></td>
    <%
        String[][] listFields = (String[][])request.getAttribute("listFields");
        if(listFields != null && listFields.length > 0){
            for(int i=0; i<listFields.length; i++){
    %>
        <td whir-options="field:'<%=listFields[i][2]%>',width:'<%=listFields[i][3]%>%', allowSort:true<%if("115".equals(listFields[i][4])){attachmentField += listFields[i][2] + ";" ;%>, renderer:renderAttachment<%}%>"><%=listFields[i][1]%></td>
    <%}}%>
        <td whir-options="field:'whir_dealing_activity',width:'10%',renderer:renderStep"><s:text name="file.dostatus"/></td>
        <td whir-options="field:'',width:'8%',renderer:renderOperate"><s:text name="workflow.categoryoperation"/></td>
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
<iframe id="downf" name="downf" style="display:none;"></iframe>
</body>
<script type="text/javascript">
//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){         
    initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:loadSumInfo});         
});

function loadSumInfo(json){
    var colspan = $('.listTableHead td').length;
    var _recordCount = parseInt($('#recordCount').val(), 10);
    if(_recordCount > 0){
        var _sumInfo = json.sumInfo;
        if(_sumInfo != ''){
            $('#itemContainer').append('<tr class="listTableLine1"><td class="listTableLineLastTD" colspan='+colspan+' align=right>'+_sumInfo+'</td></tr>');
        }
    }
}

function renderRecordId(po, i){
    return '';//' p_wf_processInstanceId="' + po.p_wf_processInstanceId + '" ';
}

function renderAttachment(po, i, field){
    var attachmentField = '<%=attachmentField%>';
    var atArr = attachmentField.split(';');
    var html = '';

    for(var i=0; i<atArr.length; i++){
        var f = atArr[i];
        if(f != '' && f == field){
            var pof = eval('po.'+f);
            if(pof != null && pof != '' && pof != 'NULL' && pof != 'null'){
                var fArr = pof.indexOf(';')!=-1?pof.split(';'):pof.split('|');
                var realName = fArr[0].split(',');
                var showName = fArr[1].split(',');
                for(var j=0; j<realName.length; j++){
                    if(realName[j] != ''){
                        if(html != '') html += ',';
                        html += '<a style="cursor:pointer;" href="<%=rootPath%>/platform/monitor/download.jsp?FileName=' + realName[j] + '&name=' + encodeURIComponent(showName[j]) + '&path=customform" target="downf">' + showName[j] + '</a>';
                    }
                }
            }
        }
    }

    return html;
}

function renderStep(po, i){
    var html = '';

    html += '<a href="javascript:void(0);" style="cursor:pointer;" onclick="openWin({url:\''+whirRootPath +'/ezflowopen!updateProcess.action?p_wf_openType=modifyView&p_wf_processInstanceId='+po.p_wf_processInstanceId+'&verifyCode='+po.verifyCode+'\', isPost:true, width:800, height:600, isFull:true});">' + po.whir_dealing_activity + '</a>';

    return html;
}

function renderOperate(po, i){
    var processSpanName = $('#processSpanName').html();
    if(processSpanName == ''){
        $('#processSpanName').html(po.NAME_);
    }

    var isEdit = $('#isEdit').val();

    var workstatus = po.whir_status;

    var html = '';

    if(isEdit == '1'){
        html += '<img src="<%=rootPath%>/images/del.gif" title="<s:text name="workflow.includedelete"/>" onclick="ajaxDelete(\'<%=rootPath%>/EzFLOWDealSearch!deleteWorkLog.action?status=-3&p_wf_processInstanceId='+po.p_wf_processInstanceId+'\',this);"/>';
    }

    if(workstatus == '100'){
        html += '<img src="<%=rootPath%>/images/lc.gif" title="<s:text name="workflow.Analyze"/>" onclick="operate(\'analysis\',\''+po.p_wf_processInstanceId+'\',\''+po.WORKRECORD_ID+'\');"/>';
    }

    if(isEdit == '1'){
        if(workstatus != '100' && workstatus != '-2' && workstatus != '-1' && workstatus != '-3'){
            html += '<img src="<%=rootPath%>/images/cxtj.gif" title="<s:text name="comm.qzjs"/>" onclick="qzjs(\''+po.p_wf_processInstanceId+'\')"/>';
        }
    }

    return html;
}

function refreshTheListForm(obj) {
    refreshListForm(obj);
}

function resetTheForm(obj){
    resetForm(obj);
}

function deleteBatch() {
    var ids = getCheckBoxData('p_wf_processInstanceId', 'p_wf_processInstanceId');
    if(ids == ''){
        whir_alert(comm.delremind1, null);
        return ;
    }
    ajaxOperate({urlWithData:whirRootPath + "/EzFLOWDealSearch!deleteWorkLog.action?status=-3&p_wf_processInstanceId="+ids,tip:"<%=Resource.getValue(whir_locale,"common","comm.sdel1")%>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}

function exportOut(flag){
    /*var $form = $('#exportForm');
    if ($form.length > 0) {
        $form.remove();//去除前一次导出时的form
    }*/

    var ids = '';
    if(flag == '1'){
        ids = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'p_wf_processInstanceId', attr_name:'p_wf_processInstanceId'});
        if(ids == ''){
            whir_alert('<s:text name="comm.selectedExportConfirm"/>', null);
            return;
        }
    }

    var params = '?selectIds='+ids+'&exportData=1&exportTitle='+$('#processSpanName').html();

    commonExportExcel({formId:'queryForm', action:'<%=rootPath%>/EzFLOWDealSearch!deallist.action'+params});
}

function operate(type, processId, recordId){
    if(type == "analysis"){
        openWin({url:whirRootPath + '/wfanalysisprocess!view.action?isezflow=1&processId='+processId+'&recordId='+recordId, isPost:true, width:800, height:600, isFull:true});
    }
}

//强制结束
function qzjs(p_wf_processInstanceId){
    ajaxOperate({urlWithData:"<%=rootPath%>/EzFLOWDealSearch!deleteWorkLog.action?status=100&p_wf_processInstanceId="+p_wf_processInstanceId,tip:"<s:text name="comm.qzjs1"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}
</script>
</html>