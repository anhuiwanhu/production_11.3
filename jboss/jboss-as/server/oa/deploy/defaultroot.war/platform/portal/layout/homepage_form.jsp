<s:hidden name="po.layoutId" id="layoutId"/>
<s:hidden name="layoutId" id="layoutId"/>
<s:hidden name="type" id="type"/>
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
	<tr>  
		<td for="首页名称" width="10%" class="td_lefttitle" nowrap>  
			首页名称<span class="MustFillColor">*</span>：  
		</td>  
		<td>  
			<s:textfield name="po.name" id="name" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':66}],'promptText':'请输入首页名称'" cssStyle="width:94%;" />  
		</td>  
	</tr>  

	<tr>  
		<td for="首页菜单名" width="10%" class="td_lefttitle" nowrap>  
			首页菜单名<span class="MustFillColor">*</span>：  
		</td>  
		<td>  
			<s:textfield name="po.portalMenuName" id="portalMenuName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':66}],'promptText':'请输入首页菜单名'" cssStyle="width:94%;" />  
		</td>  
	</tr>

	<tr id="tempTr">
		<td for="布局模板" width="10%" class="td_lefttitle" nowrap>
			布局模板<span class="MustFillColor">*</span>：
		</td>
		<td nowrap>
			<s:textfield id="templateName" name="templateName" maxlength="66" whir-options="vtype:['notempty'],'promptText':'请选择布局模板'" style="width:94%" cssClass="inputText" readonly="true"/><a href="javascript:void(0);" onClick="layoutSettingPanel();" class="selectIco"></a>
			<s:hidden id="templateId" name="po.templateId"/>
		</td>
	</tr>
	<s:if test="type!='personal'">
	<tr>
		<td for="适用范围" width="10%" class="td_lefttitle" nowrap>
			适用范围<span class="MustFillColor">*</span>：
		</td>
		<td nowrap>
			<s:textarea id="scopeName" name="po.scopeName" rows="3" style="width:94%" cssClass="inputTextarea" whir-options="vtype:['notempty']" readonly="true"/><a href="javascript:void(0);" onClick='openSelect({allowId:"scopeIds",allowName:"scopeName",select:"userorggroup",single:"no",show:"userorggroup",range:"<s:property value="%{#request.rightRange}"/>"});' class="selectIco textareaIco"></a>
			<s:hidden id="scopeUserIds" name="po.scopeUserIds"/>
			<s:hidden id="scopeOrgIds" name="po.scopeOrgIds"/>
			<s:hidden id="scopeGroupIds" name="po.scopeGroupIds"/>
			<s:hidden id="scopeIds" name="scopeIds"/>
		</td>
	</tr>
    </s:if>

	<tr style="display:<s:if test="type=='personal'">none</s:if>">  
		<td for="所属模块" width="10%" class="td_lefttitle" nowrap>  
			所属模块<span class="MustFillColor">*</span>： 
		</td>  
		<td>  
		<s:if test="type=='homepage'">
			<select id="ownerModule" name="po.ownerModule" class="easyui-combobox" whir-options="vtype:['notempty']" data-options="panelHeight:'150',onSelect:function(record){showCate(record.value);}" style="width:490px">
				<option value=""></option>
				<option value="homepage">首页</option>
			</select>
		</s:if>
		<s:elseif test="type=='personal'">
			<select id="ownerModule" name="po.ownerModule" class="easyui-combobox" whir-options="vtype:['notempty']" data-options="panelHeight:'150',onSelect:function(record){showCate(record.value);}" style="width:490px">
				<option value="personal" selected>个人首页</option>
			</select>
		</s:elseif>
		<s:else>
			<select id="ownerModule" name="po.ownerModule" class="easyui-combobox" data-options="panelHeight:'150'" whir-options="vtype:['notempty']" style="width:490px">
				<%
                List otherClassList = (List)request.getAttribute("otherClassList");
                if(otherClassList!=null&&otherClassList.size()>0){
                    for(int i0=0; i0<otherClassList.size(); i0++){
                        Object[] obj = (Object[])otherClassList.get(i0);
                %>
                <option value="<%=obj[2]%>"><%=obj[1]%></option>
                <%}}%>
			</select>
		</s:else>
		</td>  
	</tr>

	<tr style="display:<s:if test="type!='personal'">none</s:if>">  
		<td for="个人首页模版" width="10%" class="td_lefttitle" nowrap>  
			个人首页模版： 
		</td>  
		<td>  
            <input id="homepageLayoutId" name="po.homepageLayoutId" class="easyui-combobox" data-options="panelHeight:'150',valueField:'id',textField:'name',onSelect:function(record){hideTemp();}" style="width:490px">
		</td>  
	</tr>

	<tr id="category" style="display:none;">  
		<td for="分类" width="10%" class="td_lefttitle" nowrap>  
			分类： 
		</td>  
		<td>  
			<input id="typeId" name="typeId" class="easyui-combobox" data-options="panelHeight:'150',valueField:'id',textField:'name'" style="width:490px">
		</td>  
	</tr>

	<tr>
		<td for="描述" width="10%" class="td_lefttitle" nowrap>
			描述：
		</td>
		<td>
			<s:textarea id="description" name="po.description" rows="3" maxlength="300" style="width:94%" cssClass="inputTextarea" />
		</td>
	</tr>

	<tr>  
		<td for="排序" width="10%" class="td_lefttitle" nowrap>  
			排序<span class="MustFillColor">*</span>： 
		</td>  
		<td>  
			<s:textfield name="po.sortNo" id="sortNo" cssClass="inputText" whir-options="vtype:['notempty','p_integer_e',{'maxLength':5}]"  cssStyle="width:94%;"/>
		</td> 
	</tr>

    <!-- 2015-09-07 add by whx -->
    <%--s:if test="type=='personal'">
    <tr>  
		<td class="td_lefttitle">  
			默认项：
		</td>  
		<td>  
			<s:checkboxlist name="po.loginUsed" list="#{'1':'默认显示'}"></s:checkboxlist>
		</td> 
	</tr>
    </s:if--%>

	<tr class="Table_nobttomline">  
		<td>&nbsp;</td>
		<td nowrap>  
			<input type="button" class="btnButton4font" onClick="add(0,this);" value="保存退出" />  
			<s:if test="layoutId==null">
			<input type="button" class="btnButton4font" onClick="add(1,this);" value="保存继续" />  
			</s:if>
			<input type="reset" class="btnButton4font" onclick="resetDataForm(this);" value="重&nbsp;&nbsp;&nbsp;&nbsp;置" />  
			<input type="button" class="btnButton4font" onClick="closeWindow(null);" value="退&nbsp;&nbsp;&nbsp;&nbsp;出" />  
		</td>  
	</tr>  
</table>  
<div id="setting" style="display:none">
<div id="layoutSetting" class="easyui-window" title="布局" iconCls="icon-edit" maximizable="false" minimizable="false" collapsible="false" style="width:550px;height:330px;padding:5px;background: #fafafa;" modal="true" closed="true">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr height='60'>
            <%
                List templateList = (List)request.getAttribute("templateList");
                if(templateList!=null&&templateList.size()>0){
                    for(int i=0; i<templateList.size(); i++){
                        PortalTemplatePO tpo = (PortalTemplatePO)templateList.get(i);
                        String _img = tpo.getImage_();
                        if(i>0&&i%3==0)out.print("</tr><tr height='60'>");
            %>
                <td width="33.3%" valign=top>				
				<input type="radio" name="newTemplateId" value="<%=tpo.getTemplateId()%>" templateName="<%=tpo.getName()%>" <%=templateName.equals(tpo.getName().toString())?"checked":""%>>
                <img src="<%=rootPath%>/platform/portal/images/layout/<%=_img!=null&&!"".equals(_img)&&!"null".equals(_img)?_img:"custom.gif"%>">
                <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=tpo.getName()%><br>&nbsp;
                </td>
            <%}}%>                
                </tr>
            </table>
        </div>
        <div region="south" border="false" style="text-align:right;height:40px;line-height:40px;padding-top:3px;overflow:hidden;">
            <a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="save()">保存</a>
            <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="cancel()">取消</a>
        </div>
    </div>
</div>
</div>