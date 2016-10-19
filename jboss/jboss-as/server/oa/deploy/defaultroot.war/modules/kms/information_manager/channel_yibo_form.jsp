<s:hidden id="yiboChannelId" name="yiboChannel.yiboChannelId" />
<s:hidden id="channelType" name="channelType" />
<s:hidden id="userDefine" name="userDefine" />
<s:hidden id="domainId" name="yiboChannel.domainId" />
<s:hidden id="yiboCreatedEmp" name="yiboChannel.yiboCreatedEmp" />
<s:hidden id="yiboCreatedEmpName" name="yiboChannel.yiboCreatedEmpName" />
<s:hidden id="yiboCreatedOrgId" name="yiboChannel.yiboCreatedOrgId" />
<s:hidden id="yiboCreatedTime" name="yiboChannel.yiboCreatedTime" />
<s:if test="yiboChannel.yiboChannelId != null">
<s:hidden id="channel" name="channel" value="%{#request.channel}"/>
</s:if>
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
	<tr>  
		<td for="<s:text name='info.columnname'/>" width="10%" class="td_lefttitle" nowrap>  
			<s:text name="info.columnname"/><span class="MustFillColor">*</span>：  
		</td>
		<td colspan="3">
			<s:textfield name="yiboChannel.yiboChannelName" id="yiboChannelName" cssClass="inputText" whir-options="vtype:['notempty','spechar3',{'maxLength':25}],'promptText':'%{getText('info.entercolumname')}'" cssStyle="width:94%;" />  
		</td>
	</tr>
	<tr>
		<td for="对应信息栏目" width="10%" class="td_lefttitle" nowrap>  
			对应信息栏目<span class="MustFillColor">*</span>：  
		</td>  
		<td colspan="3">  
		    <select id="channelId" name="channelId" class="" style="width:763px;" whir-options="vtype:['notempty']"
			data-options="forceSelection:true,panelHeight:'150'">
				
		    </select>
		</td>
	</tr>
	<tr>
		<td for="播放条数" width="10%" class="td_lefttitle" nowrap>  
			播放条数：  
		</td>  
		<td colspan="3">  
		    <select id="yiboPlayNum" name="yiboChannel.yiboPlayNum" class="easyui-combobox" whir-options="vtype:['notempty']"
			data-options="forceSelection:true,panelHeight:'150',width:'45'" >
				<option value="5"> 5 </option>
				<option value="15"> 15 </option>
				<option value="30" selected="selected"> 30 </option>
                <option value="50"> 50 </option>
            </select>
		</td>
	</tr>
	<tr>
		<td for="<s:text name='info.sort'/>" width="10%" class="td_lefttitle" nowrap>
			<s:text name="info.sort"/>：
		</td>
		<td colspan="3">
		<s:if test="yiboChannelId==null">
			<select id="channelOrderId" name="channelOrderId" class="" style="width:565px;" whir-options="vtype:['notempty']"
			data-options="forceSelection:true,panelHeight:'150'" >
				<option value="-1">===<s:text name='info.Pleaseselectthesort'/>===</option>
				<%
				List list2 = (List)request.getAttribute("allYiBoChannelList");
				for(int i=0;i<list2.size();i++){
					Object[] obj2 = (Object[])list2.get(i);
				%>
				<option value='<%=obj2[0]%>'><%=obj2[1].toString()%></option>
				<%}%>
		    </select>&nbsp;
			<s:radio name="yiboChannel.positonUpDown" list="%{#{'0':getText('info.columnbefore'),'1':getText('info.columnafter')}}" theme="simple" value="1"></s:radio>
		</s:if>
		<s:else>
			<select id="channelOrderId" name="channelOrderId" class="" style="width:565px;" whir-options="vtype:['notempty']"
			data-options="forceSelection:true,panelHeight:'150'" >
				<option value="-1">===<s:text name='info.Pleaseselectthesort'/>===</option>
				<%
				List list2 = (List)request.getAttribute("allYiBoChannelList");
				for(int i=0;i<list2.size();i++){
					Object[] obj2 = (Object[])list2.get(i);
				%>
				<option value='<%=obj2[0]%>'><%=obj2[1].toString()%></option>
				<%}%>
		    </select>&nbsp;
			<s:radio name="yiboChannel.positonUpDown" list="%{#{'0':getText('info.columnbefore'),'1':getText('info.columnafter')}}" theme="simple"></s:radio>
		</s:else>
		</td> 
	</tr>
	
	<tr class="Table_nobttomline">
		<td>&nbsp;</td>
		<td nowrap colspan="3">
			<input type="button" class="btnButton4font" onclick="save(0,this);" value="<s:text name='comm.saveclose'/>" />
			<s:if test="yiboChannelId==null">
			<input type="button" class="btnButton4font" onclick="save(1,this);" value="<s:text name='comm.savecontinue'/>" />
			</s:if>
			<input type="button" class="btnButton4font" onclick="resetDataForm(this);" value="<s:text name='comm.reset'/>" />
			<input type="button" class="btnButton4font" onclick="closeWindow(null);" value="<s:text name='comm.exit'/>" />
		</td>
	</tr>
</table>
<%@ include file="/public/include/include_extjs.jsp"%>