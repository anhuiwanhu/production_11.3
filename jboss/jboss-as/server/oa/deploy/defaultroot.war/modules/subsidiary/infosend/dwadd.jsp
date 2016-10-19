<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
    String localAddr = request.getServerName() + ":" + request.getServerPort()+ com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
	com.whir.ezoffice.infosend.actionsupport.RemoteAddr r = new com.whir.ezoffice.infosend.actionsupport.RemoteAddr();
	String remoteAddr = null;
	if(application.getAttribute("remoteAddr") == null) {
	  remoteAddr = r.getRemoteAddr();
	  application.setAttribute("remoteAddr", remoteAddr);
	} else {
	  remoteAddr = application.getAttribute("remoteAddr").toString();
	}
	String localDwbz=r.getConfigXML("XXBS", "dwbz");
	String remoteDwbz=r.getConfigXML("XXBS", "remotedwbz");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test='#request.action == "add"'>新单位</s:if><s:else>修改单位</s:else> 
</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="Pupwin">
	<div class="BodyMargin_10" >  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="${ctx}/dw!save.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
        <s:hidden name="dwPO.dwid" />
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>  
                <td for="单位名称" style="width:130px;" class="td_lefttitle">  
                    单位名称<span class="MustFillColor">*</span>：  
                </td>  
                <td>  
                    <s:textfield name="dwPO.mc" id="mc" cssClass="inputText"  cssStyle="width:80%;"whir-options="vtype:['notempty',{'maxLength':20},'spechar3']"  maxlength="20"/>  
                </td>  
            </tr>  
            <tr>  
                <td for="上级单位" class="td_lefttitle">  
                    上级单位：  
                </td>  
                <td>  
                   <select name="dwPO.sjdw" id="sjdw"  class="easyui-combobox" style="width:150px"  data-options="panelHeight:200,forceSelection:true,onSelect: function(record){chsjdw(record);}">
                        <option value="" dwjb="0">主单位</option>
                        <s:iterator var="po" value="#request.dwList" status="dw" >
                         <s:if test='#request.action == "add"'>
                        <option value="<s:property value='#po.dwid'/>" dwjb="<s:property value='#po.dwjb'/>"><s:property value="#po.mc" escape="false"/></option>
                         </s:if>
                        <s:else>
                            <s:if test='dwPO.sjdw == #po.dwid'>
                                <option value="<s:property value='#po.dwid'/>" dwjb="<s:property value='#po.dwjb'/>" selected><s:property value="#po.mc" escape="false"/></option>
                            </s:if>
                            <s:else>
                               <option value="<s:property value='#po.dwid'/>" dwjb="<s:property value='#po.dwjb'/>"><s:property value="#po.mc" escape="false"/></option> 
                            </s:else>
                        </s:else>
                        </s:iterator>  
                   </select>
                </td>  
            </tr>
            <tr>  
                <td for="排序" class="td_lefttitle" >  
                    排序：  
                </td>  
                <td>  
            
					 <select name="dwPO.pxdw" id="pxdw"  class="easyui-combobox" style="width:150px"  data-options="panelHeight:200,forceSelection:true,valueField:'id',textField:'text'">
                        <s:iterator var="po" value="#request.pxList" status="px" >
                         <s:if test='#request.action == "add"'>
                        <option value="<s:property value='#po.dwid'/>"><s:property value="#po.mc" escape="false"/></option>
                         </s:if>
                        <s:else>
                            <s:if test='dwPO.pxdw == #po.dwid'>
                                <option value="<s:property value='#po.dwid'/>"  selected><s:property value="#po.mc" escape="false"/></option>
                            </s:if>
                            <s:else>
                               <option value="<s:property value='#po.dwid'/>"><s:property value="#po.mc" escape="false"/></option> 
                            </s:else>
                        </s:else>
                        </s:iterator>  
                   </select>
                    <s:if test='#request.action == "add"'>
                    <s:radio name="dwPO.pxqh" list="%{#{'0':'前','1':'后'}}" value="1" theme="simple"></s:radio>
                     </s:if>
                    <s:else>
                    <s:radio name="dwPO.pxqh" list="%{#{'0':'前','1':'后'}}"  theme="simple"></s:radio>
                    </s:else>
                </td>  
            </tr>

            <tr>  
                <td for="积分排行" class="td_lefttitle" >  
                    是否参与积分排行：  
                </td>  
                <td>
                    <s:if test='#request.action == "add"'>
                   <s:radio name="dwPO.jfph" list="%{#{'0':'是','1':'否'}}" value="0" theme="simple"></s:radio>
                     </s:if>
                    <s:else>
                    <s:radio name="dwPO.jfph" list="%{#{'0':'是','1':'否'}}" theme="simple"></s:radio>
                    </s:else>
                </td>  
            </tr>

            <tr>  
                <td for="报送人" class="td_lefttitle">  
                    报送人<span class="MustFillColor">*</span>：  
                </td>  
                <td>  
                  <s:textarea name="dwPO.yhmc" id="yhmc" cols="112" rows="3" whir-options="vtype:['notempty']"  cssClass="inputTextarea" cssStyle="width:80%;"readonly="true"/><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'yhid', allowName:'yhmc', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
              
                    <s:hidden name="dwPO.yhid" id="yhid"/>
                    <s:hidden name="dwPO.createdEmp" />
                    <s:hidden name="dwPO.createdOrg" />
                    <s:hidden name="dwPO.dwjb" id="dwjb"/>
                    <s:hidden name="dwPO.server" />
					<s:hidden name="dwPO.dwbz" id="dwbz"/>
                </td>  
            </tr>
            <tr class="Table_nobttomline">  
                <td > </td> 
                <td nowrap>  
                    <input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.saveclose"/>' />  
                    <s:if test='#request.action=="add"'>
                    <input type="button" class="btnButton4font" onClick="ok(1,this);" value='<s:text name="comm.savecontinue"/>' />  
                    </s:if>
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                </td>  
            </tr>  
        </table>  
	</s:form>
		</div>
	</div>
</body>
<iframe name="iframe1" style="display:none"></iframe>
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});


	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
/**
 * 新增或修改页面点击保存退出或保存继续按钮触发的事件.
 * @param n   0:保存退出；1:保存继续.
 * @param obj 保存按钮的dom对象.
 */
function ok(n,obj){ 
   // alert("1");
   var dwbz=$("#dwbz").val();
   if(dwbz == null || dwbz =='' || dwbz == 'null'){
	   whir_alert("单位标志不能为空，请检查配置文件！",null,null);
       return false;
   }else{
	  
		var formId = $(obj).parents("form").attr("id");
		var validation = validateForm(formId);
		$(obj).parents("form").find("#saveType").val(n);
		if(validation){
			 <%if(!localDwbz.equals(remoteDwbz)) {%>
			  dataForm.action = "http://<%=remoteAddr%>/modules/subsidiary/infosend/dwsave.jsp";
			  dataForm.target = "iframe1";
			  dataForm.submit();
			<%}%>
			dataForm.action = "${ctx}/dw!save.action";
			$('#'+formId).submit();
		}
   }
}
$(document).ready(function(){
    var url='${ctx}/dw!changeSjdw.action?action=<s:property value="#request.action"/>&dwid=&sjdwId=';
    <s:if test='#request.action!="add"'>
	 url='${ctx}/dw!changeSjdw.action?action=<s:property value="#request.action"/>&dwid=<s:property value="#request.editId"/>&sjdwId=<s:property value="#request.sjdwId"/>';
     </s:if> 
     //$('#pxdw').combobox('reload', url);
});

function chsjdw(sjdwObj) {
     var dwjb=Number($('#sjdw option[value='+sjdwObj.value+']').attr('dwjb'))+1;
      $("#dataForm").find("#dwjb").val(dwjb);

        var url='<%=rootPath%>/dw!changeSjdw.action';
        var data_str='action=<s:property value="#request.action"/>&sjdwId='+sjdwObj.value+'&dwid=<s:property value="#request.editId"/>';
        url+="?"+data_str;
        $('#pxdw').combobox('clear');

        $('#pxdw').combobox('reload', url);


       //  $('#classSortCode').combobox('clear');
        //$('#classSortCode').combobox('reload', url); 
}
	
</script>

</html>

