<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt"%>
<%@ page import="com.whir.ezoffice.hrm.report.po.*"%>
<%@ page import="com.whir.org.manager.bd.ManagerBD" %>
<%

DbOpt dbOpt = new DbOpt();

List tableList = (List)request.getAttribute("tableList");
List solutionList = (List)request.getAttribute("solutionList");

List conList = null;
List showList = null;
List initList = null;
RptSolutionPO solutionPO = null;
String sortBy = "";
String[] sortFields = {"","",""};

if(request.getAttribute("solutionMap")!=null){
	Map solutionMap = (Map)request.getAttribute("solutionMap");
	if(solutionMap.get("conList")!=null){
		conList = (List)solutionMap.get("conList");
		showList = (List)solutionMap.get("showList");
    	initList = (List)solutionMap.get("initList");
		solutionPO = (RptSolutionPO)solutionMap.get("solutionPO");
		sortBy = solutionPO.getSortBy();
		if(sortBy!=null&&!"".equals(sortBy)){
			sortFields = sortBy.split(",");
		}
	}
}

String solutionId = request.getAttribute("id")!=null?request.getAttribute("id").toString():"";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>自定义报表</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<script src="<%=rootPath%>/modules/hrm/report/customize/initSelect.jsp"></script>
	<script language="JavaScript" type="text/JavaScript">
	<!--
	
	var dbType = "oracle";
	<%
	if(dbOpt.dbtype.indexOf("sqlserver")>=0){
	%>
		dbType = "sqlserver";
	<%}else if(dbOpt.dbtype.indexOf("mysql")>=0){%>
		dbType = "mysql";
	<%}%>
	
	//-->
	</script>
	<style type="text/css">
	.btnQuery input{margin:1px 5px 1px 5px;}
	</style>
</head>

<body  class="MainFrameBox" >

	<form action="<%=rootPath%>/hrmcustomizereport!customize_save.action" name="form1" id="form1" method="post" >
			   	<input type="hidden" name="selectSQL" id="selectSQL" />
			   	<input type="hidden" name="fromSQL" id="fromSQL"/>
			   	<input type="hidden" name="whereSQL" id="whereSQL"/>
			   	<input type="hidden" name="solutionId" id="solutionId" value="<%=solutionId%>" />
			   	<input type="hidden" name="solutionName" id="solutionName" value="" />
				<input type="hidden" name="tableNames" id="tableNames" />
				<input type="hidden" name="fieldIds" id="fieldIds" />
			   	<input type="hidden" name="valSource" id="valSource" />
				<input type="hidden" name="sortBy" id="sortBy"/>
					
				<!-- SEARCH	PART -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
					<tr>
						<td align="left" style="width:100px;padding-left:3px;">选择查询方案：</td>
						<td width="50%" align="left">
			                <select name="solution" id="solution" class="selectlist" style="width:350px;" onchange="selSolution(this);">
			                    <option value="">--请选择--</option>
			                    <%
			                    if(solutionList!=null&&solutionList.size()>0){
			                    	for(int i0=0; i0<solutionList.size(); i0++){
			                        	Object[] obj = (Object[])solutionList.get(i0);
			                    %>
			                    <option value="<%=obj[0]%>" <%=obj[0].toString().equals(solutionId)?"selected":""%>><%=obj[1]%></option>
			                    <%}}%>
			                </select>
						</td>
						<td align="right">
							<input type="button" class="btnButton4font" onclick="search();" 	  style="cursor:pointer" value='<s:text name="comm.searchnow" />' />
							<input type="button" class="btnButton4font" onclick="clearr();"		  style="cursor:pointer" value='<s:text name="comm.clear" />' />
			                <input type="button" class="btnButton4font" onclick="saveSolution();" style="cursor:pointer" value="保存方案" />
			                <input type="button" class="btnButton4font" onclick="delSolution();"  style="cursor:pointer" value="删除方案" />
			                <input type="button" style="display:none;"  onclick="$('#form1').submit();"  id="submitform1"  value="提交方案" />
						</td>
					</tr>
				</table>
	
                <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="listTable" id="tbl">
                    <tr class="listTableHead">
						<td width="8%" class="listTableHead">逻辑符</td>
                		<td width="8%" class="listTableHead">左括号</td>
                    	<td width="20%" class="listTableHead">表</td>
                    	<td width="20%" class="listTableHead">字段</td>
                		<td width="8%" class="listTableHead">比较符</td>
                		<td width="20%" class="listTableHead">值</td>
                    	<td width="8%" class="listTableHead">右括号</td>
                    	<td width="8%" class="listTableHead">操作</td>
                    </tr>

                    <%
                    	if(conList==null||conList.size()==0){
                    %>
                    <tr height="26" id="copyTR">
                        <td align="center">
                            <select name="conAndOr" id="conAndOr_0" class="selectlist" style="width:100%">
                                <option value="">--请选择--</option>
                            </select>
                		</td>
                		<td align="center">
                            <select name="conLeft" id="conLeft_0" class="selectlist" style="width:100%">
                                <option value="">--请选择--</option>
                                <option value="(">(</option>
                                <option value="((">((</option>
                                <option value="(((">(((</option>
                                <option value="((((">((((</option>
                                <option value="(((((">(((((</option>
                            </select>
                        </td>
                    	<td align="center">
                            <select name="conTableName" id="conTableName_0" class="selectlist" style="width:100%" onchange="initField(this);">
                    			<option value="">--请选择--</option>
                            	<%
                                if(tableList!=null&&tableList.size()>0){
                                    for(int i0=0; i0<tableList.size(); i0++){
                                        Object[] obj = (Object[])tableList.get(i0);
                                %>
                                <option value="<%=obj[1]%>" alias="<%=obj[2]%>"><%=obj[0]%></option>
                                <%}}%>
                			</select>
						</td>
						<td align="center">
                            <input type="hidden" name="conFieldId" id="conFieldId_0"  />
                            <span id="sp">
	                            <select name="conFieldName" id="conFieldName_0" onchange="selCompareOperators(this);"  class="selectlist" style="width:205px;" >
	                    			<option value="">--请选择--</option>
	                			</select>
                            </span>
						</td>
                		<td align="center">
                            <select name="conCompare" id="conCompare_0"  class="selectlist" style="width:80px;" onchange="changeInputType(this);">
								<option value="">--请选择--</option>
                			</select>
                		</td>
                		<td align="left">
                            <span id="sp_val">
                            	<input type="text" class="inputText" name="conHiddenValue" id="conHiddenValue_0" maxlength="20" value="" style="width:98%;height:23px;">
                            </span>
                        </td>
                		<td align="center" >
                            <select name="conRight" id="conRight_0" class="selectlist" style="width:100%">
                                <option value="">--请选择--</option>
                                <option value=")">)</option>
                                <option value="))">))</option>
                                <option value=")))">)))</option>
                                <option value="))))">))))</option>
                                <option value=")))))">)))))</option>
                            </select>
                        </td>
						<td align="center"><IMG style="cursor:pointer"  src="<%=rootPath%>/images/addarrow.gif" onclick="commonAddTr({tableId:'tbl',trIndex:1,operate:'clone',position:'end',isKeep:false,obj:null,callbackfunction:mycall});" align="absMiddle" /></td>
        			</tr>

                	<%}else{
                        for(int i=0; i<conList.size(); i++){
                            Object[] __obj = (Object[])conList.get(i);
                            RptConditionPO conPO = (RptConditionPO)__obj[0];
                            RptInitFieldPO fieldPO = (RptInitFieldPO)__obj[1];
                	%>
                    <tr height="26" <%if(i==0){%>id="copyTR"<%} %>>
                        <td align="center">
                            <select name="conAndOr" id="conAndOr_<%=i%>" class="selectlist" style="width:100%">
                                <option value="">--请选择--</option>
                                <%if(i>0){ %>
								<option value="and">并且</option>
                    			<option value="or">或</option>
                    			<%} %>
                            </select>
                		</td>
                		<td align="center">
                            <select name="conLeft" id="conLeft_<%=i%>" class="selectlist" style="width:100%">
                               <option value="">--请选择--</option>
                                <option value="(" <%="(".equals(conPO.getConLeft())?"selected":""%>>(</option>
                                <option value="((" <%="((".equals(conPO.getConLeft())?"selected":""%>>((</option>
                                <option value="(((" <%="(((".equals(conPO.getConLeft())?"selected":""%>>(((</option>
                                <option value="((((" <%="((((".equals(conPO.getConLeft())?"selected":""%>>((((</option>
                                <option value="(((((" <%="(((((".equals(conPO.getConLeft())?"selected":""%>>(((((</option>
                            </select>
                        </td>
                    	<td align="center">
                            <select name="conTableName" id="conTableName_<%=i%>" class="selectlist" style="width:100%" onchange="initField(this);">
                    			<option value="">--请选择--</option>
                            	<%
                                if(tableList!=null&&tableList.size()>0){
                                    for(int i0=0; i0<tableList.size(); i0++){
                                        Object[] obj = (Object[])tableList.get(i0);
                                %>
                                <option value="<%=obj[1]%>" alias="<%=obj[2]%>" <%=obj[1].toString().equals(fieldPO.getTblRealName())?"selected":""%>><%=obj[0]%></option>
                                <%}}%>
                			</select>
						</td>
						<td align="center">
                            <input type="hidden" name="conFieldId" id="conFieldId_<%=i%>" />
                            <span id="sp">
                            <select name="conFieldName" id="conFieldName_<%=i%>" onchange="selCompareOperators(this);"  class="selectlist"  style="width:205px;">
                    			<option value="">--请选择--</option>
                			</select>
                            </span>
						</td>
                		<td align="center">
                            <select name="conCompare" id="conCompare_<%=i%>" class="selectlist" style="width:80px;" onchange="changeInputType(this);">
							<option value="">--请选择--</option>
                			</select>
                		</td>
                		<td align="center">
                            <span id="sp_val">
                           		<input type="text" Class="inputText" name="conHiddenValue" id="conHiddenValue_<%=i%>" maxlength="20" value="" style="width:98%;height:23px;">
                            </span>
                        </td>
                		<td align="center">
                            <select name="conRight" id="conRight_<%=i%>" class="selectlist" style="width:100%">
                               <option value="">--请选择--</option>
                                <option value=")" <%=")".equals(conPO.getConRight())?"selected":""%>>)</option>
                                <option value="))" <%="))".equals(conPO.getConRight())?"selected":""%>>))</option>
                                <option value=")))" <%=")))".equals(conPO.getConRight())?"selected":""%>>)))</option>
                                <option value="))))" <%="))))".equals(conPO.getConRight())?"selected":""%>>))))</option>
                                <option value=")))))" <%=")))))".equals(conPO.getConRight())?"selected":""%>>)))))</option>
                            </select>
                        </td>
						<td align="center"><IMG style="cursor:pointer"  <%if(i==0){%>src="<%=rootPath%>/images/addarrow.gif" onclick="commonAddTr({tableId:'tbl',trIndex:1,operate:'clone',position:'end',isKeep:false,obj:null,callbackfunction:mycall});"  <%}else{ %> src="<%=rootPath%>/images/delarrow.gif"  onclick='commonRemoveTr({obj:this});'   <%} %> align="absMiddle"></td>
        			</tr>

                	<%
                		}
                	}
                	%>

                </table>
	</form>


<!-- SEARCH	PART -->
<br />
<div style="padding-left:10px;">报表显示字段：</div>
<br />
<!-- MIDDLE	BUTTONS	-->

<%
if(tableList!=null&&tableList.size()>0){
%>
<input type="hidden" name="frmNum" id="frmNum" value="<%=tableList.size()%>"/>
<%
com.whir.ezoffice.hrm.report.bd.CustomizeReportBD bd = new com.whir.ezoffice.hrm.report.bd.CustomizeReportBD();
for(int i0=0; i0<tableList.size(); i0++){
	Object[] obj = (Object[])tableList.get(i0);
%>
<div style="padding-left:10px;" ><font size="2pt">[<%=obj[0]%>]</font></div>

<form name="frm<%=i0%>"  id="frm<%=i0%>" >

<input type="hidden" name="tableName" id="tableName<%=i0%>" value="<%=obj[1]%>.<%=obj[0]%>" />
<input type="hidden" name="tableAliasName" id="tableAliasName<%=i0%>" value="<%=obj[2]%>" />

<table width="" border="0" align="" cellpadding="1" cellspacing="1" class="" width="100%" style="table-layout:fixed;">
	<tr >
		<td width="20%"  align="left">
			<select name="SrcSelect<%=i0%>" id="SrcSelect<%=i0%>" size="6" class="" style="height:160px;width:90%" multiple ondblclick="transferOptions('SrcSelect<%=i0%>','ObjSelect<%=i0%>')">
                <%
                if(initList==null||initList.size()==0){
                	List fieldList = bd.getRptField(obj[1].toString(),"hrm");
                	if(fieldList!=null&&fieldList.size()>0){
                		int size = fieldList.size();
    					for(int i=0; i<size; i++){
        					Object[] o = (Object[])fieldList.get(i);
                            if(obj[1].toString().equalsIgnoreCase("org_employee")&&o[1].toString().equalsIgnoreCase("empname"))continue;
                %>
                <option value="<%=o[5]%>.<%=o[1]%>.<%=o[0]%>" valSource="<%=o[6]!=null?o[6].toString():""%>"><%=o[0]%></option>
                <%}}}else{
                    for(int i=0; i<initList.size(); i++){
                    	RptInitFieldPO fieldPO = (RptInitFieldPO)initList.get(i);
                    	if(obj[1].toString().equals(fieldPO.getTblRealName())){
                            if(fieldPO.getTblRealName().equalsIgnoreCase("org_employee")&&fieldPO.getRealName().equalsIgnoreCase("empname"))continue;
                %>
                <option value="<%=fieldPO.getFieldId()%>.<%=fieldPO.getRealName()%>.<%=fieldPO.getShowName()%>" valSource="<%=fieldPO.getValSource()!=null?fieldPO.getValSource():""%>"><%=fieldPO.getShowName()%></option>
                <%}}}%>
        	</select>

    	</td>
    	<td width="10%" align="center">
    	<div align="center" valign="center" class="btnQuery">
        	<input class="btnButton4font" type="button" value=">>" onclick="transferOptionsAll('SrcSelect<%=i0%>','ObjSelect<%=i0%>');" ><br>
	        	<input class="btnButton4font" type="button" value=">"  onclick="transferOptions('SrcSelect<%=i0%>','ObjSelect<%=i0%>');" ><br>
	        	<input class="btnButton4font" type="button" value="↑"  onclick="upOrDownOptions('ObjSelect<%=i0%>','up');" ><br>
	        	<input class="btnButton4font" type="button" value="↓"  onclick="upOrDownOptions('ObjSelect<%=i0%>','down');" ><br>
	        	<input class="btnButton4font" type="button" value="<"  onclick="transferOptions('ObjSelect<%=i0%>','SrcSelect<%=i0%>');" ><br>
	        	<input class="btnButton4font" type="button" value="<<" onclick="transferOptionsAll('ObjSelect<%=i0%>','SrcSelect<%=i0%>');" >
	        	</div>
    	</td>
    	<td width="70%" align="left" style="padding-left:30px;">
        	<select  name="ObjSelect<%=i0%>" id="ObjSelect<%=i0%>" size=6 class="" style="height:160px;width:30%" multiple ondblclick="transferOptions('ObjSelect<%=i0%>','SrcSelect<%=i0%>');">
            	<%
                if(showList!=null&&showList.size()>0){
                	for(int i=0; i<showList.size(); i++){
                		Object[] __obj = (Object[])showList.get(i);
                    	RptInitFieldPO fieldPO = (RptInitFieldPO)__obj[1];
                    	if(obj[1].toString().equals(fieldPO.getTblRealName())){
                %>
                <option value="<%=fieldPO.getFieldId()%>.<%=fieldPO.getRealName()%>.<%=fieldPO.getShowName()%>" valSource="<%=fieldPO.getValSource()!=null?fieldPO.getValSource():""%>"><%=fieldPO.getShowName()%></option>
                <%}}}%>
        	</select>
    	</td>
	</tr>
</table>

</form>
<%
	if(i0==0){
%>
<br />
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="">
	<tr >
		<td width="6%" nowrap>排序：</td>
		<td width="6%" nowrap> <input type="radio"  name="sortType" value="0" checked onclick="selectSort('0');">默认 </td>
		<td width="88%" nowrap><input type="radio"  name="sortType" value="1" onclick="selectSort('1');">设置</td>
	</tr>
	<tr id="tr_sort0" style="display:none">
		<td >&nbsp;</td><td  >&nbsp;</td>
		<td  >	
				<span style="width:105"></span><input type="checkbox" name="sortField" value="1" <%=sortFields.length>0&&!"".equals(sortFields[0])?"checked":""%>>字段一&nbsp;
				<select name='fieldSort'>
				<option value=''>--请选择--</option>
				<%
					List fieldList = bd.getRptField("org_employee","hrm");
                	if(fieldList!=null&&fieldList.size()>0){
						int size = fieldList.size();
    					for(int i=0; i<size; i++){
        					Object[] o = (Object[])fieldList.get(i);
							String fieldName=(String)o[1];
							if(fieldName.equalsIgnoreCase("SIDELINEORGNAME")||//兼职部门
								fieldName.equalsIgnoreCase("partjob_duty")||//兼职职务
							    fieldName.equalsIgnoreCase("EMPLEADERNAME")||//上级领导
								fieldName.equalsIgnoreCase("EMPBUSINESSPHONE")||//商务电话
								fieldName.equalsIgnoreCase("EMPBUSINESSFAX")||//传真
								fieldName.equalsIgnoreCase("SERIAL")||//分机号
								fieldName.equalsIgnoreCase("EMPMOBILEPHONE")||//移动电话
								fieldName.equalsIgnoreCase("EMPPHONE")||//住宅电话
								fieldName.equalsIgnoreCase("EMPEMAIL")||//电子邮箱
								fieldName.equalsIgnoreCase("EMPDESCRIBE")||//个人简介
								fieldName.equalsIgnoreCase("EMPNATIVEPLACE")||//籍贯
								fieldName.equalsIgnoreCase("SECTION")||//工段
								fieldName.equalsIgnoreCase("EMPRESUMENUM")||//用工性质
								fieldName.equalsIgnoreCase("DIGNITY")||//身份
								fieldName.equalsIgnoreCase("PARTYDATE")||//入党团时间
								fieldName.equalsIgnoreCase("hk_xz")||//户口性质
								fieldName.equalsIgnoreCase("HUJIADDRESS")||//户口所在地
								fieldName.equalsIgnoreCase("EMPIDCARD")||//身份证号
								fieldName.equalsIgnoreCase("sfz_qfjg")||//身份证签发机关
								fieldName.equalsIgnoreCase("passport_no")||//因私护照号码
								fieldName.equalsIgnoreCase("sfz_address")||//身份证住址
								fieldName.equalsIgnoreCase("sfz_postcode")||//身份证住址邮编
								fieldName.equalsIgnoreCase("EMPADDRESS")||//家庭住址
								fieldName.equalsIgnoreCase("family_postcode")||//家庭住址邮编
								fieldName.equalsIgnoreCase("now_living_address")||//现居住地址
								fieldName.equalsIgnoreCase("now_living_postcode")||//现居住地址邮编
								fieldName.equalsIgnoreCase("zzz_no")||//暂住证号码
								fieldName.equalsIgnoreCase("zzz_date")||//暂住证有效期
								fieldName.equalsIgnoreCase("insurance_card_no")||//保险卡号
								fieldName.equalsIgnoreCase("pay_card_no")||//工资卡号
								fieldName.equalsIgnoreCase("EMPINTEREST"))//个人特长和爱好
								continue;
                                if("EMPDUTY".equals(fieldName))fieldName="EMPDUTYLEVEL";
				%>
				<option value='<%=fieldName%>' <%=sortFields.length>0&&sortFields[0].indexOf(fieldName)!=-1?"selected":""%>><%=o[0]%></option>
				<%}}%>
			</select>
			<input type="checkbox" name="sortDesc" value='desc' <%=sortFields.length>0&&sortFields[0].indexOf(" desc")!=-1?"checked":""%>>降序
		</td>
	</tr>
	<tr id="tr_sort1" style="display:none">
			<td></td><td></td>
			<td>
				<span style="width:105"></span><input type="checkbox" name="sortField" value="2" <%=sortFields.length>1&&!"".equals(sortFields[1])?"checked":""%>>字段二&nbsp;
				<select name='fieldSort'>
				<option value=''>--请选择--</option>
				<%
                	if(fieldList!=null&&fieldList.size()>0){
						int size = fieldList.size();
    					for(int i=0; i<size; i++){
        					Object[] o = (Object[])fieldList.get(i);
							String fieldName=(String)o[1];
							if(fieldName.equalsIgnoreCase("SIDELINEORGNAME")||//兼职部门
								fieldName.equalsIgnoreCase("partjob_duty")||//兼职职务
							    fieldName.equalsIgnoreCase("EMPLEADERNAME")||//上级领导
								fieldName.equalsIgnoreCase("EMPBUSINESSPHONE")||//商务电话
								fieldName.equalsIgnoreCase("EMPBUSINESSFAX")||//传真
								fieldName.equalsIgnoreCase("SERIAL")||//分机号
								fieldName.equalsIgnoreCase("EMPMOBILEPHONE")||//移动电话
								fieldName.equalsIgnoreCase("EMPPHONE")||//住宅电话
								fieldName.equalsIgnoreCase("EMPEMAIL")||//电子邮箱
								fieldName.equalsIgnoreCase("EMPDESCRIBE")||//个人简介
								fieldName.equalsIgnoreCase("EMPNATIVEPLACE")||//籍贯
								fieldName.equalsIgnoreCase("SECTION")||//工段
								fieldName.equalsIgnoreCase("EMPRESUMENUM")||//用工性质
								fieldName.equalsIgnoreCase("DIGNITY")||//身份
								fieldName.equalsIgnoreCase("PARTYDATE")||//入党团时间
								fieldName.equalsIgnoreCase("hk_xz")||//户口性质
								fieldName.equalsIgnoreCase("HUJIADDRESS")||//户口所在地
								fieldName.equalsIgnoreCase("EMPIDCARD")||//身份证号
								fieldName.equalsIgnoreCase("sfz_qfjg")||//身份证签发机关
								fieldName.equalsIgnoreCase("passport_no")||//因私护照号码
								fieldName.equalsIgnoreCase("sfz_address")||//身份证住址
								fieldName.equalsIgnoreCase("sfz_postcode")||//身份证住址邮编
								fieldName.equalsIgnoreCase("EMPADDRESS")||//家庭住址
								fieldName.equalsIgnoreCase("family_postcode")||//家庭住址邮编
								fieldName.equalsIgnoreCase("now_living_address")||//现居住地址
								fieldName.equalsIgnoreCase("now_living_postcode")||//现居住地址邮编
								fieldName.equalsIgnoreCase("zzz_no")||//暂住证号码
								fieldName.equalsIgnoreCase("zzz_date")||//暂住证有效期
								fieldName.equalsIgnoreCase("insurance_card_no")||//保险卡号
								fieldName.equalsIgnoreCase("pay_card_no")||//工资卡号
								fieldName.equalsIgnoreCase("EMPINTEREST"))//个人特长和爱好
								continue;
                                if("EMPDUTY".equals(fieldName))fieldName="EMPDUTYLEVEL";
				%>
				<option value='<%=fieldName%>' <%=sortFields.length>1&&sortFields[1].indexOf(fieldName)!=-1?"selected":""%>><%=o[0]%></option>
				<%}}%>
			</select>
			<input type="checkbox" name="sortDesc" value='desc' <%=sortFields.length>1&&sortFields[1].indexOf(" desc")!=-1?"checked":""%>>降序
		</td>
	</tr>
	<tr id="tr_sort2" style="display:none">
				<td></td><td></td>
				<td>
				<span style="width:105"></span><input type="checkbox" name="sortField" value="3" <%=sortFields.length>2&&!"".equals(sortFields[2])?"checked":""%>>字段三&nbsp;
				<select name='fieldSort'>
				<option value=''>--请选择--</option>
				<%
                	if(fieldList!=null&&fieldList.size()>0){
						int size = fieldList.size();
    					for(int i=0; i<size; i++){
        					Object[] o = (Object[])fieldList.get(i);
							String fieldName=(String)o[1];
							if(fieldName.equalsIgnoreCase("SIDELINEORGNAME")||//兼职部门
								fieldName.equalsIgnoreCase("partjob_duty")||//兼职职务
							    fieldName.equalsIgnoreCase("EMPLEADERNAME")||//上级领导
								fieldName.equalsIgnoreCase("EMPBUSINESSPHONE")||//商务电话
								fieldName.equalsIgnoreCase("EMPBUSINESSFAX")||//传真
								fieldName.equalsIgnoreCase("SERIAL")||//分机号
								fieldName.equalsIgnoreCase("EMPMOBILEPHONE")||//移动电话
								fieldName.equalsIgnoreCase("EMPPHONE")||//住宅电话
								fieldName.equalsIgnoreCase("EMPEMAIL")||//电子邮箱
								fieldName.equalsIgnoreCase("EMPDESCRIBE")||//个人简介
								fieldName.equalsIgnoreCase("EMPNATIVEPLACE")||//籍贯
								fieldName.equalsIgnoreCase("SECTION")||//工段
								fieldName.equalsIgnoreCase("EMPRESUMENUM")||//用工性质
								fieldName.equalsIgnoreCase("DIGNITY")||//身份
								fieldName.equalsIgnoreCase("PARTYDATE")||//入党团时间
								fieldName.equalsIgnoreCase("hk_xz")||//户口性质
								fieldName.equalsIgnoreCase("HUJIADDRESS")||//户口所在地
								fieldName.equalsIgnoreCase("EMPIDCARD")||//身份证号
								fieldName.equalsIgnoreCase("sfz_qfjg")||//身份证签发机关
								fieldName.equalsIgnoreCase("passport_no")||//因私护照号码
								fieldName.equalsIgnoreCase("sfz_address")||//身份证住址
								fieldName.equalsIgnoreCase("sfz_postcode")||//身份证住址邮编
								fieldName.equalsIgnoreCase("EMPADDRESS")||//家庭住址
								fieldName.equalsIgnoreCase("family_postcode")||//家庭住址邮编
								fieldName.equalsIgnoreCase("now_living_address")||//现居住地址
								fieldName.equalsIgnoreCase("now_living_postcode")||//现居住地址邮编
								fieldName.equalsIgnoreCase("zzz_no")||//暂住证号码
								fieldName.equalsIgnoreCase("zzz_date")||//暂住证有效期
								fieldName.equalsIgnoreCase("insurance_card_no")||//保险卡号
								fieldName.equalsIgnoreCase("pay_card_no")||//工资卡号
								fieldName.equalsIgnoreCase("EMPINTEREST"))//个人特长和爱好
								continue;
                                if("EMPDUTY".equals(fieldName))fieldName="EMPDUTYLEVEL";
				%>
				<option value='<%=fieldName%>' <%=sortFields.length>2&&sortFields[2].indexOf(fieldName)!=-1?"selected":""%>><%=o[0]%></option>
				<%}}%>
			</select>
			<input type="checkbox" name="sortDesc" value='desc' <%=sortFields.length>2&&sortFields[2].indexOf(" desc")!=-1?"checked":""%>>降序
		</td>
	</tr>
</table>
<br />
<%}}}%>
<!-- MIDDLE	BUTTONS	-->


</body>
</html>


<script language="javascript">
<!--

function mycall(newTr){
	newTr.find("td:first").find("select").append('<option value="and">并且</option><option value="or">或</option>');
	newTr.find("td:last").html('<img style="cursor:pointer"   src="<%=rootPath%>/images/delarrow.gif"  onclick="commonRemoveTr({obj:this});"  align="absMiddle">');
	newTr.find("td").eq(3).find("select").html("<option value='' fieldType='' inputType='' methodName='' fieldId=''>--请选择--</option>");
	newTr.find("td").eq(4).find("select").html('<option value="">--请选择--</option>');
	var index = newTr.index();
	newTr.find("td").eq(5).html("<input type='text' class='inputText' name='conHiddenValue' id='conHiddenValue_"+index+"' maxlength='20' value='' style='width:100%'>");
}

function init(){
	$("#solutionName").val($("#solution").val()==''?'':$("#solution").find("option:selected").text());
	<%
	//初始化查询条件
	if(conList!=null && conList.size()>0){
		for(int i=0; i<conList.size(); i++){
			Object[] __obj = (Object[])conList.get(i);
        	RptConditionPO conPO = (RptConditionPO)__obj[0];
        	RptInitFieldPO fieldPO = (RptInitFieldPO)__obj[1];
	%>
			document.getElementsByName("conAndOr")[<%=i%>].value = "<%=conPO.getConAndOr()!=null?conPO.getConAndOr():""%>";
			initField(document.getElementsByName("conTableName")[<%=i%>]);
			setTimeout(function(){
				document.getElementsByName("conFieldId")[<%=i%>].value = "<%=fieldPO.getFieldId()!=null?fieldPO.getFieldId().toString():""%>";
				//alert('<%=fieldPO.getRealName()!=null?fieldPO.getRealName():""%>');
				//$("#conFieldName_<%=i%> option[value='<%=fieldPO.getRealName()!=null?fieldPO.getRealName():""%>']").attr("selected","selected");
				document.getElementsByName("conFieldName")[<%=i%>].value = "<%=fieldPO.getRealName()!=null?fieldPO.getRealName():""%>";
			
				selCompareOperators(document.getElementsByName("conFieldName")[<%=i%>]);
				document.getElementsByName("conCompare")[<%=i%>].value = "<%=conPO.getConCompare()!=null?conPO.getConCompare():""%>";
				changeInputType(document.getElementsByName("conCompare")[<%=i%>]);
				
				<%
				if("date".equals(fieldPO.getFieldType())){
				%>
				document.getElementsByName("conHiddenValue")[<%=i%>].value="<%=conPO.getConHiddenValue()!=null?conPO.getConHiddenValue().replaceAll("/","-"):""%>";
				<%}else{%>
				document.getElementsByName("conHiddenValue")[<%=i%>].value="<%=conPO.getConHiddenValue()!=null?conPO.getConHiddenValue():""%>";
				<%
				}
				%>
			},1000);
		<%}
	}%>
}

//选择方案
function selSolution(obj){
    location.href="<%=rootPath%>/hrmcustomizereport!customize_query.action?id="+obj.value;
}

//立即查找
function search(){
	if(checkConditions()==false)return;
	if(selectShowFields()==false)return;
	if(getOrderBySql()=='')return;

	addConditionSQL();

	checkSQL();
	if(checkSQLFlag==false)return;

	//序列化列表元素 返回 JSON 数据结构数据
    var formId = "form1";
    var params = $("#"+formId).serializeArray();
    
    var $form = createDynamicForm({id:'exportForm', action:'<%=rootPath%>/hrmcustomizereport!customize_show.action',params:params,method:'post',target:'_blank'});
    
    if($form) {
        $form.submit();
        $("#exportForm").remove();
    }
    
}

var checkSQLFlag = true;

function checkSQL(){
	var selectSQL =  $("#selectSQL").val();
	var fromSQL   =  $("#fromSQL").val();
	var whereSQL  =  $("#whereSQL").val();
	var response = ajaxForSync("<%=rootPath%>/modules/hrm/report/customize/checkSQL_httprequest.jsp?dbType="+dbType+"&selectSQL="+selectSQL+"&fromSQL="+fromSQL+"&whereSQL="+whereSQL,"");
	
  	if(response.indexOf('SQL ERROR')!=-1){
          checkSQLFlag = false;
          if(dbType=='oracle'){
              if(response.indexOf('ORA-00907')!=-1){
              	  whir_alert("查询条件缺少右括号，请检查！",null);
              }else if(response.indexOf('ORA-00933')!=-1){
              	  whir_alert("查询条件括号不匹配，请检查！",null);
              }else if(response.indexOf('ORA-01756')!=-1){
              	  whir_alert("查询条件不能包含单引号，请检查！",null);
              }else{
                  whir_alert("查询条件有误，请检查！",null);
              }
          }else{
          	  whir_alert("查询条件有误，请检查！",null);
          }
  	}else{
          checkSQLFlag = true;
  	}
}

//拼装SQL
function addConditionSQL(){
	//查询条件
	var conditionSql = "";
	var conditionTable = "";
	var conAndOr = document.getElementsByName("conAndOr");
	var conLeft = document.getElementsByName("conLeft");
	var conTableName = document.getElementsByName("conTableName");
	var conFieldId = document.getElementsByName("conFieldId");
	var conFieldName = document.getElementsByName("conFieldName");
	var conCompare = document.getElementsByName("conCompare");
	var conHiddenValue = document.getElementsByName("conHiddenValue");
	var conRight = document.getElementsByName("conRight");
	
	if(conAndOr && conAndOr.length>0){
		var ll = conAndOr.length;
    	for(var i=0; i<ll; i++){
        	var obj = conFieldName[i];
        	var fieldValue = obj.value;
        	var alias = $(conTableName[i].options[conTableName[i].selectedIndex]).attr("alias");
        	//alert(alias);
        	if(fieldValue && fieldValue!=''){
            	conditionTable += conTableName[i].value.toLowerCase() + "." + alias + "=";

            	conditionSql += " " + conAndOr[i].value + " ";
            	conditionSql += conLeft[i].value;

            	conditionSql += alias;
            	conditionSql += ".";
            	conditionSql += fieldValue;

            	conditionSql += " " + conCompare[i].value + " ";

				var fieldType  = $(obj.options[obj.selectedIndex]).attr("fieldType");
				var inputType  = $(obj.options[obj.selectedIndex]).attr("inputType");
				var methodName = $(obj.options[obj.selectedIndex]).attr("methodName");
				var fieldId    = $(obj.options[obj.selectedIndex]).attr("fieldId");
        		//alert(fieldValue + fieldType + inputType + methodName);
				if(fieldType=='varchar'&&inputType=='select'){
                	if(conCompare[i].value!='is null' && conCompare[i].value!='is not null'){
						if(dbType=='sqlserver'){
							conditionSql += "N";
						}
                    	conditionSql += "'" + conHiddenValue[i].value + "'";
                	}
				}else if(fieldType=='number' && inputType=='select'){
                	if(conHiddenValue[i].value!=''){
                    	if(conCompare[i].value!='is null' && conCompare[i].value!='is not null'){
                			conditionSql +=  conHiddenValue[i].value;
                    	}
                	}else{
                    	if(conCompare[i].value!='is null' && conCompare[i].value!='is not null'){
                    		conditionSql += " is null ";
                    	}
                	}
				}else if(fieldType=='date' && inputType=='date') {
                	if(conHiddenValue[i].value!=''){
                    	if(conCompare[i].value!='is null' && conCompare[i].value!='is not null'){
                			if(dbType=='oracle'){
                                conditionSql +=  "EZOFFICE.FN_STRTODATE('" + conHiddenValue[i].value + "','S')";
                			}else if(dbType=='sqlserver'){
                                conditionSql +=  "EZOFFICE.FN_STRTODATE('" + conHiddenValue[i].value + "','S')";
                			}else if(dbType=='mysql'){
                                conditionSql +=  "'" + conHiddenValue[i].value + "'";
                			}else{
                        		conditionSql +=  "'" + conHiddenValue[i].value + "'";
                			}
                    	}
                	}else{
                    	if(conCompare[i].value!='is null' && conCompare[i].value!='is not null'){
                    		conditionSql += " is null ";
                    	}
                	}
				}else if(fieldType=='varchar' && inputType=='text'){
                    if(conCompare[i].value!='is null' && conCompare[i].value!='is not null'){
                        if(conCompare[i].value=='like' || conCompare[i].value=='not like'){
							if(dbType=='sqlserver'){
								conditionSql += "N";
							}
                    		conditionSql +=  "'%" + conHiddenValue[i].value + "%'";
                        }else{
							if(dbType=='sqlserver'){
								conditionSql += "N";
							}
                            conditionSql +=  "'" + conHiddenValue[i].value + "'";
                        }
                    }
				}else{
                	if(conCompare[i].value!='is null' && conCompare[i].value!='is not null'){
        				if(conCompare[i].value=='like' || conCompare[i].value=='not like'){
							if(dbType=='sqlserver'){
								conditionSql += "N";
							}
                    		conditionSql +=  "'%" + conHiddenValue[i].value + "%'";
                        }else{
							if(dbType=='sqlserver'){
								conditionSql += "N";
							}
                            conditionSql +=  "'" + conHiddenValue[i].value + "'";
                        }
                	}
				}
            	conditionSql += conRight[i].value;
        	}
    	}
	}else{
        return;
	}
	
	//alert(conditionSql+"----------"+conditionTable);

	//显示字段
	var tableNames_fieldIds = "";
	var frmNum = $("#frmNum");
	if(frmNum.length>0){
        var num = parseInt(frmNum.val(), 10);
        for(var i=0; i<num; i++){
            var ObjSelect = $("#ObjSelect"+i);
            if(ObjSelect.find("option").length>0){
                tableNames_fieldIds += $("#tableName"+i).val().toLowerCase().substring(0, $("#tableName"+i).val().indexOf(".")) + "." +$("#tableAliasName"+i).val() + "=";
                ObjSelect.find("option").each(function(){
                	tableNames_fieldIds += $(this).attr("value") + ",";
                });
                tableNames_fieldIds += "|";
            }
        }
	}

	//alert(tableNames_fieldIds);

	var tblArr1 = conditionTable.split('=');
	var tblArr2 = tableNames_fieldIds.split('|');

	var orderBySql = getOrderBySql();
	
	var __appSql = orderBySql.substring(orderBySql.indexOf(' order by ')+9);
	    __appSql = __appSql.replace(/ desc /gm,'');
	if( __appSql.indexOf('a1.orgname ') != -1 ){
		__appSql = __appSql.replace('a1.orgname ','c.orgname ');
	}
	    __appSql=__appSql.length>3?","+__appSql:"";

	var __selectSQL = "select distinct a1.emp_id, a1.empname, a1.EMPDUTYLEVEL"+__appSql;
	var __fromSQL   = " from org_employee a1";
	if(conditionSql.indexOf('a1.orgname ')!=-1 || orderBySql.indexOf('a1.orgname ')!=-1){
        __fromSQL += " left join ORG_ORGANIZATION_USER b on a1.emp_id=b.emp_id";
        __fromSQL += " left join ORG_ORGANIZATION c on b.org_id=c.org_id";
        conditionSql = conditionSql.replace(/a1.orgname /igm,'c.ORGNAMESTRING ');
		orderBySql = orderBySql.replace(/a1.orgname /igm,'c.orgname ');
	}
	if(tblArr2 && tblArr2.length>0){
        for(var i=0; i<tblArr2.length; i++){
            if(tblArr2[i] && tblArr2[i]!='');{
                var __tt = tblArr2[i].split('=');
                if(__tt && __tt.length>0){
                	if(__tt[0] && __tt[0]!='' && __tt[0].indexOf('org_employee.a1')==-1){
                    	__fromSQL += " left join " + __tt[0].replace('.', ' ') + " on a1.emp_id="+__tt[0].substring(__tt[0].indexOf(".")+1)+".emp_id";
                    }
                }
            }
        }
	}
	if(tblArr1 && tblArr1.length>0){
    	for(var i=0; i<tblArr1.length; i++){
    		if(tblArr1[i] && tblArr1[i]!='' && tblArr1[i].indexOf('org_employee.a1')==-1){
        		if(__fromSQL.indexOf(tblArr1[i].replace('.', ' '))==-1){
        			__fromSQL += " left join " + tblArr1[i].replace('.', ' ') + " on a1.emp_id="+tblArr1[i].substring(tblArr1[i].indexOf(".")+1)+".emp_id";
        		}
    		}
    	}
	}

    if(__fromSQL.indexOf('a13.emp_id')!=-1)__fromSQL = __fromSQL.replace('a13.emp_id', 'a13.EMPCHANGE_EMPID');

	//alert(__fromSQL);
	var __whereSQL  = " where a1.emp_id!=0 and a1.USERISDELETED=0 and a1.DOMAIN_ID=<%=session.getAttribute("domainId")%>";
		__whereSQL += conditionSql!=""?" and " + conditionSql:"";
	
	__whereSQL += orderBySql + ", a1.emp_id";//排序字段

	//alert(__selectSQL+__fromSQL+__whereSQL);

	$("#selectSQL").val(__selectSQL);
	$("#fromSQL").val(__fromSQL);
	$("#whereSQL").val(__whereSQL);
}

//清除操作
function clearr(){
	 location.href="<%=rootPath%>/hrmcustomizereport!customize_query.action";
}

function checkConditions(){
    var tableName = document.getElementsByName("conTableName");
    var fieldName = document.getElementsByName("conFieldName");
    if(tableName && tableName.length>0){
        for(var i=0; i<tableName.length-1; i++){
            if(tableName[i].value!=''){
                if(fieldName[i].value==''){
                    whir_alert("请选择字段！",function(){
                    	fieldName[i].focus();
                    });
                    return false;
                }
            }else{
                if(tableName.length>2){
                	whir_alert("请选择表！",function(){
                    	tableName[i].focus();
                    });
                	return false;
                }
            }
        }
    }
    return true;
}

function selectShowFields(){
    var tableNames="";
    var fieldIds="";
    var valSource="";

    var frmNum = $("#frmNum");
    if(frmNum.length>0){
        var num = parseInt(frmNum.val(), 10);
        for(var i=0; i<num; i++){
            tableNames += $("#tableName"+i).val().toLowerCase() + "|";
            var ObjSelect = $("#ObjSelect"+i);
            if(ObjSelect.find("option").length>0){
                ObjSelect.find("option").each(function(){
                	fieldIds += $(this).attr("value") + ",";
                    valSource += ($(this).attr("valSource")!=""?$(this).attr("valSource"):";") + "$";
                });
            }else{
                fieldIds += ",";
                valSource += "$";
            }
            fieldIds += "|";
            valSource += "|";
        }
    }
    //alert(fieldIds);alert(valSource);
    if(fieldIds.length<=26){
        whir_alert("请选择报表显示字段！",null);
        return false;
    }

    if(tableNames.length>0){
        tableNames = tableNames.substring(0,tableNames.length-1);
    }
    if(fieldIds.length>0){
        fieldIds = fieldIds.substring(0,fieldIds.length-1);
    }
    if(valSource.length>0){
        valSource = valSource.substring(0,valSource.length-1);
    }

    $("#tableNames").val(tableNames);
    $("#fieldIds").val(fieldIds);
    $("#valSource").val(valSource);
    
    return true;
}

var isExit = false;
//保存方案
function saveSolution(){
	if(checkConditions()==false)return;
	if(selectShowFields()==false)return;
	if(getOrderBySql()=='')return;

	addConditionSQL();

	checkSQL();
	if(checkSQLFlag==false)return;	
	
	
	var page = $("#add").html();
	popup({title: '保存方案',content:"url:<%=rootPath%>/modules/hrm/report/customize/solution_add.jsp",lock:true,width:500,height:130});
	
}

function delSolution(){
	var id = $("#solution").val();
    if(id==''){
        whir_alert('请选择方案！',null);
        return;
    }
    ajaxOperate({urlWithData:"hrmcustomizereport!customize_delete.action?id="+id,tip:"删除",formId:"",callbackfunction:deleteCall});
}

function deleteCall(opeJson,msg_json){
	location.href="<%=rootPath%>/hrmcustomizereport!customize_query.action";
}

function initField(obj){
	
	$.ajax({
            type: "post",
            url: "<%=rootPath%>/modules/hrm/report/customize/initField_httprequest.jsp?tableName="+obj.value,
            data:'date='+Math.random(),
            async: false,
            success: function(msg){
            		$(obj).parent().next().find("select").html(msg);
            		selCompareOperators($(obj).parent().next().find("select").get(0));
            }
    });
}

function selCompareOperators(obj){
    var val = obj.value;
    var fieldType  = $(obj).find('option:selected').attr("fieldType");
    var inputType  = $(obj).find('option:selected').attr("inputType");
    var methodName = $(obj).find('option:selected').attr("methodName");
    var    fieldId = $(obj).find('option:selected').attr("fieldId");
    
    $(obj).parent().prev().val(fieldId);
    
    var nextSelect = $(obj).parent().parent().next().find("select").eq(0);

    if(fieldType=='varchar' && inputType=='select'){
		nextSelect.html('<option value="=">等于</option><option value="!=">不等于</option><option value="is null">为空</option><option value="is not null">不为空</option>');
    }else if(fieldType=='number'){
        nextSelect.html('<option value="=">等于</option><option value="!=">不等于</option><option value="is null">为空</option><option value="is not null">不为空</option>');
    }else if(fieldType=='date' && inputType=='date') {
        nextSelect.html('<option value="=">等于</option><option value="!=">不等于</option><option value=">">大于</option><option value=">=">大于等于</option><option value="<">小于</option><option value="<=">小于等于</option><option value="is null">为空</option><option value="is not null">不为空</option>');
    }else if(fieldType=='varchar' && inputType=='text'){
        nextSelect.html('<option value="=">等于</option><option value="!=">不等于</option><option value="is null">为空</option><option value="is not null">不为空</option><option value="like">包含</option><option value="not like">不包含</option>');
    }else{
        nextSelect.html("<option value=''>--请选择--</option>");
    }
    
    changeInputType(nextSelect[0]);
}

function changeInputType(obj){
	var index = $(obj).parent().parent().index() - 1; 
	var prevSelect = $(obj).parent().prev().find("select").eq(0);
	var nextSpan   = $(obj).parent().next().find("span").eq(0);
    var nextInput  = nextSpan.find("input").eq(0);
    
    var fieldValue = prevSelect.attr("value");
    var fieldType  = prevSelect.find('option:selected').attr("fieldType");
    var inputType  = prevSelect.find('option:selected').attr("inputType");
    var methodName = prevSelect.find('option:selected').attr("methodName");

	var val = '';

    var str = "<input type='text' class='inputText' name='conHiddenValue' id='conHiddenValue_"+index+"' maxlength='20' value='" + val + "' style='width:98%;height:23px;'>";
    if(fieldType=='varchar'&&inputType=='select'){
        str = eval(methodName+"()");
    }else if(fieldType=='number'&&inputType=='select'){
        str = eval(methodName+"()");
    }else if(fieldType=='date'&&inputType=='date') {
    	var ymd = getSmpFormatNowDate(false);
    	str = "<input type='text' class='Wdate' onFocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})\" name='conHiddenValue' id='conHiddenValue_"+index+"'  value='"+ymd+"'   readonly>";
    }
    
    if(obj.value=='is null'||obj.value=='is not null'){
        str = "<input type='text' class='inputText' name='conHiddenValue' id='conHiddenValue_"+index+"' maxlength='20' value='' style='width:98%;height:23px;' readonly>";
    }
    nextSpan.html(str);
}

function selectSort(arg){
	if(arg=='0'){
		$("#tr_sort0,#tr_sort1,#tr_sort2").hide();
		$("#tr_sort0,#tr_sort1,#tr_sort2").find("select option:eq(0)").attr("selected","selected");
		$("#tr_sort0,#tr_sort1,#tr_sort2").find("input[type='checkbox']").prop("checked",false);
		//$("#tr_sort0,#tr_sort1,#tr_sort2").find("input[type='checkbox']").uniform();
	}else{
		$("#tr_sort0,#tr_sort1,#tr_sort2").show();
	}
}

<%if(sortBy!=null&&!"".equals(sortBy)){%>
	selectSort('1');
	document.getElementsByName("sortType")[1].checked=true;
<%}%>

function getOrderBySql(){
	var sortType =  document.getElementsByName("sortType");
	var sortField = document.getElementsByName("sortField");
	var fieldSort = document.getElementsByName("fieldSort");
	var sortDesc =  document.getElementsByName("sortDesc");

	var orderBySql = " order by ";
	if(sortType[1].checked){
		var j=0;
		for(var i=0; i<3; i++){
			if(sortField[i].checked){
				if(fieldSort[i].value==''){
					whir_alert("请选择排序字段！",null);
					fieldSort[i].focus();
					return "";
				}
				orderBySql += (j>0?",":"") + "a1." + fieldSort[i].value + " ";
				j++;
				if(sortDesc[i].checked){					
					orderBySql += " desc ";
				}
			}
		}
		if(orderBySql==" order by "){
			whir_alert("请选择排序字段！",null);
			fieldSort[0].focus();
			return "";
		}
		$("#sortBy").val(orderBySql);
	}else{
		$("#sortBy").val("");
		orderBySql += " a1.EMPDUTYLEVEL, a1.empname ";
	}
	return orderBySql;
}

function saveCall(msg_json){
	if($("#solutionId").val() == ''){
		$("#solution").append("<option value='"+msg_json.data.message+"'>"+$("#solutionName").val()+"</option>"); 
	}else{
		$('#solution option[value="'+msg_json.data.message+'"]').text($("#solutionName").val());
	}
	$("#solutionId").val(msg_json.data.message);
	$('#solution option[value="'+msg_json.data.message+'"]').attr('selected','selected');
}


$(document).ready(function(){
	init();
	//设置表单为异步提交
	initDataFormToAjax({'dataForm':'form1','queryForm':'','reset':'no','tip':'保存','callbackfunction':saveCall});
});

//-->
</script>
