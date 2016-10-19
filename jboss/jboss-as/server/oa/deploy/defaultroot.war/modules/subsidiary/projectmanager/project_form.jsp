
<%
	java.util.Map projectProgressMap = new java.util.LinkedHashMap();
	for(int i = 0; i <= 20; i++) {
		projectProgressMap.put(i*5 + "", i*5 + "%");
	}
	request.setAttribute("projectProgressMap", projectProgressMap);
%>
<s:set var="projectStatusMap" value="#{'0':'未开始','1':'进行中'}"></s:set>
<s:if test="%{#readType == 1}">
	<s:if test="%{projectPO.status == 0}">
		<s:set var="projectStatusMap" value="#{'0':'未开始','1':'进行中','3':'已推迟','4':'已取消'}"></s:set>
	</s:if>
	<s:else>
		<s:set var="projectStatusMap" value="#{'1':'进行中','2':'已完成','3':'已推迟','4':'已取消'}"></s:set>
	</s:else>
</s:if>
<s:if test="%{#readType == 2}">
	<s:set var="projectStatusMap" value="#{'0':'未开始','1':'进行中','2':'已完成','3':'已推迟','4':'已取消'}"></s:set>
</s:if>

<s:set name="isReadOnly" value="'false'"/>
<s:if test="%{#readType == 2}"> 
	<s:set name="isReadOnly" value="'true'"/> 
</s:if>
<s:hidden name="projectPO.id" id="id"/>
<s:if test="%{#readType == 3}"> 
	<s:hidden name="modId" id="modId" value="%{#request.modId}"/>
</s:if>
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
	<tr>  
        <td for="项目名称" class="td_lefttitle" nowrap>项目名称<span class="MustFillColor">*</span>：</td>  
        <td colspan="3" nowrap>  
            <s:textfield name="projectPO.name" id="name" whir-options="vtype:['notempty',{'maxLength':100},'spechar3']" cssClass="inputText" cssStyle="width:94%;" readonly="%{#isReadOnly}"/>  
        </td>  
    </tr>
	<tr>    
		<td for="项目类型" class="td_lefttitle" width="12%" nowrap>项目类型<span class="MustFillColor">*</span>：</td>    
	    <td width="38%">    
	        <s:select name="projectPO.projectType.id" id="typeId" list="#request.projectTypeMap" cssClass="easyui-combobox" data-options="width:202,panelHeight:'auto'" headerKey="" headerValue="请选择" whir-options="vtype:['notempty']" disabled="%{#isReadOnly}"/>
	    </td>
	    <td for="项目状态" class="td_lefttitle"  width="12%" nowrap>项目状态<span class="MustFillColor">*</span>：</td>    
	    <td width="38%">    
	        <s:select name="projectPO.status" id="status" list="%{#projectStatusMap}" cssClass="easyui-combobox" data-options="width:202,panelHeight:'auto'" headerKey="" headerValue="请选择" whir-options="vtype:['notempty']" disabled="%{#isReadOnly}"/>  
	    </td>     
	</tr>
	<tr>    
		<td for="项目编码" class="td_lefttitle" nowrap>项目编码<span class="MustFillColor">*</span>：</td>    
	    <td>    
	        <s:textfield name="projectPO.code" id="code" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" cssClass="inputText" cssStyle="width:90%;" readonly="%{#isReadOnly}"/>  
	    </td>
	    <td for="项目经理" class="td_lefttitle" nowrap>项目经理<span class="MustFillColor">*</span>：</td>    
	    <td nowrap>    
			<s:hidden name="projectPO.managerId" id="managerId"/>
	        <s:textfield name="projectPO.managerName" id="managerName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':1000}]" cssStyle="width:87%;" readonly="true"/><s:if test="%{#readType != 2}"><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'managerId', allowName:'managerName', select:'user', single:'yes', show:'usergroup', range:'*0*'});"></a></s:if>  
	    </td>     
	</tr>
	<tr>  
        <td for="项目成员" class="td_lefttitle" nowrap>  
            项目成员<span class="MustFillColor">*</span>：   
        </td>  
        <td colspan="3">  
			<s:hidden id="memberIds" name="projectPO.memberIds"/>
	        <s:textarea name="projectPO.memberNames" id="memberNames" rows="3" cssClass="inputTextarea" whir-options="vtype:['notempty',{'maxLength':1000}]" cssStyle="width:94%;" readonly="true"/><s:if test="%{#readType != 2}"><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'memberIds', allowName:'memberNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a></s:if>
		</td>  
	</tr>
	<tr>
	    <td for="汇报提交至" class="td_lefttitle" nowrap>汇报提交至：</td>    
	    <td colspan="3">    
			<s:hidden name="projectPO.reportToUserIds" id="reportToUserIds"/>
	        <s:textfield name="projectPO.reportTo" id="reportTo" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:94%;" readonly="true"/><s:if test="%{#readType != 2}"><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'reportToUserIds', allowName:'reportTo', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a></s:if>  
	    </td>    
	</tr>
	<tr>    
		<td for="开始日期" class="td_lefttitle" nowrap>开始日期<span class="MustFillColor">*</span>：</td>    
	    <td>    
	        <s:textfield name="projectPO.startDate" id="startDate" cssClass="Wdate whir_datebox" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'endDate\\',{d:0});}'})" whir-options="vtype:['notempty']" >
            	<s:param name="value"><s:date name="projectPO.startDate" format="yyyy-MM-dd" /></s:param> 
            </s:textfield>  
	    </td>
	    <td for="结束日期" class="td_lefttitle" nowrap>结束日期<span class="MustFillColor">*</span>：</td>    
	    <td>    
	        <s:textfield name="projectPO.endDate" id="endDate" cssClass="Wdate whir_datebox" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'startDate\\',{d:0});}'})" whir-options="vtype:['notempty']">
            	<s:param name="value"><s:date name="projectPO.endDate" format="yyyy-MM-dd" /></s:param>
            </s:textfield>  
	    </td>     
	</tr>
	<tr>  
        <td for="附件" class="td_lefttitle">  
            附件：   
        </td>  
        <td colspan="3">  
	        <s:hidden name="realFileName" id="realFileName" value="%{#request.realFileName}"/>  
			<s:hidden name="saveFileName" id="saveFileName" value="%{#request.saveFileName}"/>  
			<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
			   <jsp:param name="accessType"       value="include" />
			   <jsp:param name="dir"      value="project" />  
			   <jsp:param name="uniqueId"    value="uniqueId111" />  
			   <jsp:param name="realFileNameInputId"    value="realFileName" />
			   <jsp:param name="saveFileNameInputId"    value="saveFileName" />
			   <jsp:param name="canModify"       value="yes" />
			</jsp:include>  
		</td>  
	</tr>
	<%
	com.opensymphony.xwork2.ognl.OgnlValueStack stack = (com.opensymphony.xwork2.ognl.OgnlValueStack) request.getAttribute("struts.valueStack");
	com.whir.ezoffice.projectmanager.po.ProjectPO po = (com.whir.ezoffice.projectmanager.po.ProjectPO) stack.findValue("projectPO");
	String extInfoId_para = (po == null || po.getId() == null) ? "-1" : po.getId().toString();
	%>
	<jsp:include page="/platform/custom/extension/extension_include.jsp" flush="true">
		<jsp:param name="extTableId" value="oa_project"/>
		<jsp:param name="extInfoId" value="<%=extInfoId_para%>"/>
		<jsp:param name="extCssStyle" value="width:90%"/>
		<jsp:param name="extTextareaRows" value="3"/>
		<jsp:param name="isAdd" value="false"/>
		<jsp:param name="canModify" value="true"/>
		<jsp:param name="showCols" value="2"/>
	</jsp:include>
	<s:if test="%{#readType == 1}">
	<tr>  
        <td for="进度" class="td_lefttitle" nowrap>  
            进度：   
        </td>  
        <td>  
			<s:select name="projectPO.projectfinishrate" id="projectfinishrate" list="#request.projectProgressMap" cssClass="selectlist" cssStyle="width:90%;margin:0px;" disabled="%{#isReadOnly}"/>
		</td>
		<td class="td_lefttitle">&nbsp;</td><td>&nbsp;</td>  
	</tr>
	</s:if>
	
	<tr>
		<td colspan="4" style="padding-left:10px;padding-right:6px">
			<!-- 相关性 -->
			<input name="moduleType" type="hidden" value="project">
			<input name="infoId" type="hidden" value="<s:property value='projectPO.id'/>">
			<div id='relationObjectDIV'></div>
			<IFRAME name='relationIFrame' id='relationIFrame' src='' frameborder=0 marginwidth='0' marginheight='0' scrolling='auto' width='95%' height='150'></IFRAME>
		</td>
	</tr>
	<s:if test="%{#readType == 1 || #readType == 2}">
	<tr>
		<td colspan="4" style="padding-left:10px;padding-right:6px">
			<!-- 项目汇报 -->
			<iframe id="reportIframe" name="reportIframe" width="95%" frameborder="0" src="project!projectReportList.action?id=<s:property value="%{projectPO.id}"/>&projectName=<s:property value="%{projectPO.name}"/>" scrolling="no">
			</iframe>    
		</td>
	</tr>
	</s:if>
	<s:if test="%{#readType != 0 && #readType != 3}">
	<tr>  
        <td for="修改理由" class="td_lefttitle" nowrap>  
            修改理由：   
        </td>  
        <td colspan="3" nowrap>  
	        <s:textarea name="projectPO.updateReason" id="updateReason" rows="3" cssClass="inputTextarea" whir-options="vtype:[{'maxLength':1000}]" cssStyle="width:94%;" readonly="%{#isReadOnly}"/> 
		</td>  
	</tr>
	</s:if>
	
	<tr class="Table_nobttomline">  
     	<td class="td_lefttitle"></td> 
        <td colspan="3" nowrap>
        <s:if test="%{#readType != 0 && #readType != 3}">  
	        <s:if test="%{#readType != 2}">  
	            <input type="button" class="btnButton4font" onClick="if(checkUpdateReason()) {ok(0,this);}" value="<s:text name="comm.saveclose"/>" />
			</s:if>
	        <s:if test="%{#readType == 1}">  
	            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
			</s:if>
	            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
        </s:if>  
        </td>
    </tr> 
</table>

