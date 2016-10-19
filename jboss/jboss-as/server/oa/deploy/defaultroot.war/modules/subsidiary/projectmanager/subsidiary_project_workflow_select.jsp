<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>选择申请流程</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">  
        <div class="docBoxNoPanel">
            <s:form name="dataForm" id="dataForm" action="" method="post" theme="simple" >
                <%@ include file="/public/include/form_detail.jsp"%>
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <s:if test="%{#request.hasFlow == 0}">
                        <tr><td>您没有可选择的流程，请联系管理员！</td></tr>
                    </s:if>
                    <s:else>
                        <tr>    
                            <td for="申请流程" class="td_lefttitle" width="100" nowrap>请选择申请流程<span class="MustFillColor">*</span>：</td>    
                            <td>    
                                <s:select name="p_wf_pool_processId" id="p_wf_pool_processId" list="#request.selecWorkFlowMap" cssClass="easyui-combobox" data-options="width:202,panelHeight:'auto',forceSelection:true" headerKey="" headerValue="--请选择--" whir-options="vtype:['notempty']"/>
                            </td>    
                        </tr>
                        <tr class="Table_nobttomline">  
                             <td class="td_lefttitle"></td>
                            <td nowrap> 
                                <input type="button" class="btnButton4font" onClick="select_to_workflow()" value="确　定" />  
                            </td>  
                        </tr>  
                    </s:else>
                </table>  
                <!-- 表单页面 -->
            </s:form>
        </div>
    </div>
</body>

<script type="text/javascript">
$(document).ready(function(){ 
    var hasFlow = '<s:property value="#request.hasFlow"/>';
    if(hasFlow == '1') {
        var p_wf_pool_processId = '<s:property value="#request.p_wf_pool_processId"/>';
        var href = whirRootPath + "/project!addProject.action?p_wf_pool_processId=" + p_wf_pool_processId;
        openWin({url:href,isFull:'true',winName:'addProject'});
        closeWindow(null);
    }
});

// 选择
function select_to_workflow() {
    var validation = validateForm("dataForm");
    var p_wf_pool_processId = whirCombobox.getValue('p_wf_pool_processId') ;
    var href = whirRootPath + "/project!addProject.action?p_wf_pool_processId=" + p_wf_pool_processId; 
    if(validation) {
    <%if(isForbiddenPad){%>
        openWin({url:href,isFull:true});
        closeWindow(null);
    <%}else{%>
        location_href(href);
    <%}%>
    }
}
</script>

</html>

