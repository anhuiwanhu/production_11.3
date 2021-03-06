<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.vo.*"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<%
  CustomerMenuDB  menubd = new CustomerMenuDB();
  String allMenuList = (String)request.getAttribute("allMenuList");
  List workFlows = (List)request.getAttribute("workFlows");
  String[][] modellist = (String[][])request.getAttribute("modellist");
  String rightRange = (String)request.getAttribute("rightRange");
%>
<head>  
	<title>新增自定义模块</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_detail.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
  
</head>  
  
<body class="Pupwin" >  
	<div class="BodyMargin_10">    
		<div class="docBoxNoPanel">  
		<s:form name="dataForm" id="dataForm" action="custormermenu!saveCustMenu.action" method="post" theme="simple" >  
         <%@ include file="/public/include/form_detail.jsp"%>  
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">  
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   模块名称<span class="MustFillColor">*</span>：    
			   </td>    
			   <td>
				   <input class="inputText"  name="menuName" id="menuName"  style="width:444px;">
			   </td>    
		   </tr>
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   所属模块<span class="MustFillColor">*</span>：    
			   </td>    
			   <td>
				   <select id="menuBlone"  name="menuBlone" class="selectlist" style="width:200px;" onchange="changeSub(this.value);">    
						<option value="-1">主菜单</option>
						<%=allMenuList%>  
					</select> 
				    <div id="mainmenuorder" style="display:inline;">
                     主菜单排序码：<input class="inputText"  name="parentOrder" id="parentOrder" style="width:150px;" maxlength="9">
					</div>
			   </td>    
		   </tr>
           <tr>    
			   <td width="100" class="td_lefttitle">模块位置：</td>    
			   <td>
				    <select id="menuLocation"  name="menuLocation" class="selectlist" style="width:202px;">    
					</select>
					<span id="orderSet" style="display:">
                      <input type="radio" name="zorder" id="zorder" value="0"/>前 
					  <input type="radio" name="zorder" id="zorder" value="1" checked/>后
                    </span>
			   </td>    
		   </tr>
		   <tr>    
			   <td for="适用范围" width="100" class="td_lefttitle">适用范围<span class="MustFillColor">*</span>：</td>    
			   <td>
				   <input type="hidden" id="menuViewId" name="menuViewId" />
                   <textarea class="inputTextarea" style="width:444px;" id="menuView" name="menuView" readonly="readonly"></textarea><a href="javascript:void(0);" class="selectIco textareaIco" style="cursor:pointer" onClick="openSelect({allowId:'menuViewId', allowName:'menuView', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',limited:'1'});"></a>  
			   </td>    
		   </tr>
		   <tr id="activityDiv">
			  <td colspan="2">
			    <table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr height="1" bgcolor="#808080">
					<td style="padding:0;"></td>
				  </tr>
				  <tr height="1"  bgcolor="#FFFFFF">
					<td style="padding:0;"></td>
				  </tr>
				</table>
			  </td>
		  </tr>
		   <!-- ***************************************************************************** -->
		  <tr>    
		    <td width="100" class="td_lefttitle">模块属性：</td>    
		    <td>&nbsp;</td>    
	      </tr>
		  <tr id="linktitleTR1" style="display:">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="1" id="readCK1" name="readCK" checked onclick="cleanData(1);"/>地址链接</td>
		  </tr>
		  <tr id="linkTR1" style="display:">
             <td>&nbsp;</td>    
		     <td>
			   <table >
                    <tr>
                        <td valign="top">&nbsp;&nbsp;链接地址：
						  <input class="inputText"  name="menuAction" id="menuAction"  style="width:360px;">
                        </td>
                      </tr>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名一：
						      <input class="inputText"  name="paraPre1" id="paraPre1"  style="width:150px;">值
						      <select id="params1" name="params1" class="selectlist" style="width:150px;">    
								<option value="1" selected="selected">登录用户 </option>
                                <option value="2">登录密码 </option>
                                <option value="3">登录组织 </option>
							  </select>
                        </td>
                      </tr>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名二：
                          <input class="inputText"  name="paraPre2" id="paraPre2"  style="width:150px;">值
						  <select id="params2" name="params2" class="selectlist" style="width:150px;">    
							<option value="1" selected="selected">登录用户 </option>
							<option value="2">登录密码 </option>
							<option value="3">登录组织 </option>
						  </select>
                        </td>
                      </tr>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名三：
                          <input class="inputText"  name="paraPre3" id="paraPre3"  style="width:150px;">值
						  <select id="params3" name="params3" class="selectlist" style="width:150px;">    
							<option value="1" selected="selected">登录用户 </option>
							<option value="2">登录密码 </option>
							<option value="3">登录组织 </option>
						  </select>
                          </td>
                      </tr>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名四：
                          <input class="inputText"  name="paraPre4" id="paraPre4"  style="width:150px;">值
						  <select id="params4" name="params4" class="selectlist" style="width:150px;">    
							 <option value="4">常值</option>
						  </select>
						  <input class="inputText"  name="menuActionParams4Value" id="menuActionParams4Value"  style="width:85px;">
                        </td>
                      </tr>
                  </table>
			 </td>    
	      </tr>
		  
		  <tr id="linktitleTR2" style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="2" id="readCK2" name="readCK" onclick="cleanData(2);"/>启动信息列表项</td>
		  </tr>
		  <tr id="linkTR2" id style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left">
                <!----------------------------------------------------------------------------------------------------------------------------------->
				<table>
					  <tr>
                        <td valign="top">数据表分类：
						     <select id="menuListTableModelMapSel" name="menuListTableModelMapSel"  class="selectlist" style="width:200px;" onchange="initListTalbes(this.value);">
								<option value=''>--请选择--</option>
							    <%
								  if(modellist!=null){
									   for(int i=0;i<modellist.length;i++){
										   String[] obj = (String[]) modellist[i];
								%>
								<option value="<%=obj[0]%>"><%=obj[2]%> </option>
								<%     }
								  }
								%>
							  </select>
                        </td>
                      </tr>
                      <tr>
                        <td valign="top">数据表：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						     <!--select id="menuListTableMapSel" name="menuListTableMapSel" class="easyui-combobox" data-options="panelHeight:'260',valueField:'id',textField:'text',onSelect: function(record){  
									selmenuListTab($('#menuListTableMapSel').combobox('getValue'),'');  
								}" style="width:200px;">
							 </select-->
							 <div id="menuListTableMapSelCombo"></div>
                        </td>
                      </tr>
                      <tr>
                        <td valign="top">维护表单：&nbsp;&nbsp;&nbsp;
						<select id="menuSearchBound" name="menuSearchBound" class="selectlist" style="width:200px;" onchange="setFields(this.value);$('#menuWhereSql').val('');" >
						</select>
                        </td>
                     </tr>

					 <tr>
					  <td>表单字段控制：<input type="button" id="formfieldCK" class="btnButton4font" onClick="opensetField(this);" value="打开" />
					  </td>
					</tr>
					<input name="formfieldFlag" id="formfieldFlag" type="hidden">
					<tr>
                       <td>
						    <table width="100%" id="actionTb3" style="display:none">
                             <tr>
                              <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                              <td height="357" colspan="3" valign="top">
							    <table width="100%" border="0" cellspacing="1" cellpadding="0">
                                  <tr>
                                    <td width="46%">源字段：</td>
                                    <td height="22" colspan="2">读字段</td>
                                  </tr>
                                  <tr>
                                    <td width="46%" rowspan="6">
                                        <select id="fountainField" name="fountainField" size="19" multiple="multiple" style="width:100px;"></select>
                                    </td>
                                    <td width="7%" height="100"> <div align="center">
                                        <input type="button" id="readrightbut" value="> ">
                                        <br>
                                        <br>
                                        <input type="button" id="readrightallbut" value=">>">
                                        <br>
                                        <br>
                                        <input type="button" id="readleftbut" value="< ">
                                        <br>
                                        <br>
                                        <input type="button" id="readleftallbut" value="<<">
                                      </div></td>
                                    <td width="47%">
                                        <select id="readField" name="readField" size="8" multiple="multiple" style="width:100px;"></select>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">写字段</td>
                                  </tr>
                                  <tr>
                                    <td height="94"> <div align="center">
                                        <input type="button" id="writerightbut" value="> ">
                                        <br>
                                        <br>
                                        <input type="button" id="writerightallbut" value=">>">
                                        <br>
                                        <br>
                                        <input type="button" id="writeleftbut" value="< ">
                                        <br>
                                        <br>
                                        <input type="button" id="writeleftallbut" value="<<">
                                      </div></td>
										<td>
											<select id="writeField" name="writeField" size="8" multiple="multiple" style="width:100px;"></select>
										</td>
								  </tr>

								  <tr>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">隐藏字段</td>
                                  </tr>
                                  <tr>
								  <td >&nbsp;</td>
                                    <td height="94"> <div align="center">
                                        <input type="button" id="hiderightbut" value="> ">
                                        <br>
                                        <br>
                                        <input type="button" id="hiderightallbut" value=">>">
                                        <br>
                                        <br>
                                        <input type="button" id="hideleftbut" value="< ">
                                        <br>
                                        <br>
                                        <input type="button" id="hideleftallbut" value="<<">
                                      </div></td>
										<td>
											<select id="hiddenField" name="hiddenField" size="8" multiple="multiple" style="width:100px;"></select>
									  </td>
								    </tr>
								  </table>

                                  </td>
								</tr>
							 </table>
                       </td>
					</tr>
					<tr>
                          <td>列表字段控制：<input type="button" id="listfieldCK" class="btnButton4font" onClick="opensetField1(this);" value="打开" /></td>
                    </tr>
                    <input name="listfieldFlag" id="listfieldFlag" type="hidden">
				    <tr>
					   <td>
							<table width="100%" id="actionTb4" style="display:none">
							 <tr>
							  <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							  <td height="200" colspan="3" valign="top">
									<table width="100%" border="0" cellspacing="1" cellpadding="0">
									  <tr>
										<td width="46%">源字段:</td>
										<td height="22" colspan="2">可编辑:</td>
									  </tr>
									  <tr>
										<td width="46%" rowspan="6">
											<select id="fountainField1" name="fountainField1" size="19" multiple="multiple" style="width:100px;height:300px;"></select>
										</td>
										<td width="7%" height="200"> <div align="center">
											<input type="button" id="modirightbut" value="> ">
											<br>
											<br>
											<input type="button" id="modirightallbut" value=">>">
											<br>
											<br>
											<input type="button" id="modileftbut" value="< ">
											<br>
											<br>
											<input type="button" id="modileftallbut" value="<<">
										  </div></td>
										<td width="47%">
											<select id="listWriteField" name="listWriteField" size="19" multiple="multiple" style="width:100px;height:300px;"></select>
										</td>
									  </tr>
									</table>
						         </td>
						       </tr>
						     </table>
                          </td>
					  </tr>

					  <tr>
						<td>
							<table cellspacing=0 cellpadding=0>
								<tr>
									<td colspan=7>主表约束：</td>
								</tr>
								<tr>
									<td>
										<select id="mainTblField1" name="mainTblField1" class="selectlist" style="width:100px;"></select>
									</td>
									<td>
										<select id="mainoper1" name="mainoper1" class="selectlist" style="width:50px;">
												<option value=">">></option>
												<option value="<"><</option>
												<option value=">=">>=</option>
												<option value="<="><=</option>
												<option value="=">=</option>
												<option value="<>"><></option>
												<option value="like">like</option>
												<option value="is">is</option>
										</select>
									</td>
									<td width="115">
									   <select id="mainval1" name="mainval1" class="selectlist" style="width:120px;">
											<option value=""></option>
											<option value="&userAccounts">＆userAccounts</option>
											<option value="&userOrgID">＆userOrgID</option>
											<option value="&empidcard">＆empidcard</option>
											<option value="&uid">＆uid</option>
											<option value="&Currenttime">＆Currenttime</option>
									   </select>
									</td>
									<td>
										 <select id="mainuion" name="mainuion" class="selectlist" style="width:50px;">
												<option value="-1">关系</option>
												<option value="and">并且</option>
												<option value="or">或者</option>
										  </select>		
									</td>
									<td>
										<select id="mainTblField2" name="mainTblField2" class="selectlist"  style="width:100px;"></select>
									</td>
									<td>
									   <select id="mainoper2" name="mainoper2" class="selectlist" style="width:50px;">
												<option value=">">></option>
												<option value="<"><</option>
												<option value=">=">>=</option>
												<option value="<="><=</option>
												<option value="=">=</option>
												<option value="<>"><></option>
												<option value="like">like</option>
												<option value="is">is</option>
										</select>
									 </td>
									<td width="115">
									   <select id="mainval2" name="mainval2" class="selectlist" style="width:120px;">
											<option value=""></option>
											<option value="&userAccounts">＆userAccounts</option>
											<option value="&userOrgID">＆userOrgID</option>
											<option value="&empidcard">＆empidcard</option>
											<option value="&uid">＆uid</option>
											<option value="&Currenttime">＆Currenttime</option>
									   </select>
									</td>
								</tr>
								<tr height="30">
									<td colspan=7>
									  <input id="constrainA" type="button" class="btnButton4font"  value="确定" />
									  <input id="constrainB" type="button" class="btnButton4font"  value="清除" />
									</td>
								</tr>
								<tr height="30">
									<td colspan=7>
									   <textarea class="inputTextarea" style="width:650px;" rows="5" id="menuWhereSql" name="menuWhereSql"></textarea>
									</td>
								</tr>
								<tr height="30">
									<td colspan=7>
									<font color="red">当前用户Id: &uid; 当前用户帐号: &userAccounts; 当前用户组织id: &userOrgID; 当前用户身份证号: &empidcard;</font>
									</td>
								</tr>
							</table>
						</td>
                    </tr>

					<tr>
							<td>排序：&nbsp;&nbsp;&nbsp;
								<input type="radio" id="defOrder1" name="defOrder" value="-1" checked="checked" onclick="changeDef(this.value);"/>默认
								<input type="radio" id="defOrder2" name="defOrder" value="0" onclick="changeDef(this.value);"/>设置
							</td>
					</tr>
                    <tr>
                     <td>
							<table width="100%" id="taborder" style="display:none">
								<tr>
									<td align="left">
										<select id="fieldName1" name="fieldName1" class="selectlist" style="width:100px;"></select>
										<input type="checkbox" id="field1Desc1" name="field1Desc1" value="desc"/>降序
										<input id="orderbutA" type="button" class="btnButton4font"  value="确定" />
										<input id="orderbutB" type="button" class="btnButton4font"  value="清除" />
									</td>
								</tr>
								<tr>
									<td valign="top" align="left">
										 <textarea class="inputTextarea" style="width:650px;" rows="5" id="orderStr" name="orderStr"></textarea>
									</td>
								</tr>
							 </table>
			         </td>
				</tr>

				   
                <tr>
                  <td>相关流程：
				      <select id="menuRefFlow"  name="menuRefFlow_" class="xeasyui-combobox" data-options="panelHeight:200" style="width:260px;">
					   <%
						  if (workFlows != null && workFlows.size() > 0) {
							for(int i = 0; i < workFlows.size(); i++) {
							  ListItem item = (ListItem)workFlows.get(i);
						%>
							<option value="<%=item.getId()%>"><%=item.getName()%></option>
						<%}}%>
					</select> 
				  </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
                <tr>
				  <td>
				      列表自定义按钮：<input id="listtabbutadd" type="button" class="btnButton4font" value="新增" />
				  </td>
                </tr>

                <tr>
					<td  valign="top" width="100%">
						  <table border="0" width="82%" bordercolor="" cellpadding="0" cellspacing="0" id="actionTbl" class="listTable" style="border-top: 1px solid #e7e7e7;">
								<tr>
									<td class="listTableLine1" align="center" width="100">操作名称</td>
									<td class="listTableLine1" align="center" width="100">动作属性</td>
									<td class="listTableLine1" align="center" width="100">链接文件</td>
									<td class="listTableLine1" align="center" width="150">查看权限</td>
									<td class="listTableLine1"  width="60">操作</td>
								</tr>
							</table>
					</td>
                </tr>
				<tr>
                    <td height="10"></td>
                </tr>
     
				<tr>
				  <td>
					列表动作：<input id="actionTbutton1" type="button" class="btnButton4font" value="打开" />
				  </td>
				</tr>
				
				<tr>
				  <td>
					  <table border="0" bordercolor="gray" cellpadding="0" cellspacing="0" id="actionTb1" class="listTable" style="width:610px;display:none;border-top: 1px solid #e7e7e7;">
								<tr>
									<td width="40%" class="listTableLine1" align="center" nowrap>列表处理文件：</td>
									<td width="60%">
										<input type="text" name="listtabrealFileName" id="listtabrealFileName" style="width:350px;" value=""/>   
										<input type="hidden" name="listtabsaveFileName" id="listtabsaveFileName" style="width:800px;" value=""/> 
											<%-- <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
										   <jsp:param name="dir"      value="/modulesext/devform/customize/" />
										   <jsp:param name="uniqueId"    value="listId" />
										   <jsp:param name="realFileNameInputId"    value="listtabrealFileName" />
										   <jsp:param name="saveFileNameInputId"    value="listtabsaveFileName" />
										   <jsp:param name="canModify"   value="yes" />
										   <jsp:param name="width"        value="90" />
										   <jsp:param name="height"       value="20" /> 
										   <jsp:param name="multi"        value="false" />
										   <jsp:param name="buttonText"       value="上传jsp" />
										   <jsp:param name="buttonClass" value="upload_btn" />
										   <jsp:param name="fileSizeLimit"        value="0" />
										   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
										   <jsp:param name="uploadLimit"      value="1" />
										</jsp:include>--%>
									</td>
								</tr>
								<tr>
									<td class="listTableLine1" align="center" width="150">操作名称</td>
									<td class="listTableLine1" align="center" width="250">方法名</td>
								</tr>
								<tr>

										<td class="listTableLine1" align="center">删除加载</td>
										<td class="listTableLine1" align="center"><input type="text" id="delLoad" name="delLoad" class="inputText" style="width:350px;"/></td>
								</tr>
								<tr>

										<td class="listTableLine1" align="center">批量删除加载</td>
										<td class="listTableLine1" align="center"><input type="text" id="delAllLoad" name="delAllLoad" class="inputText" style="width:350px;"/></td>
								</tr>
								<tr>

										<td class="listTableLine1" align="center">批量保存加载</td>
										<td class="listTableLine1" align="center"><input type="text" id="saveAllLoad" name="saveAllLoad" class="inputText" style="width:350px;"/></td>
								</tr>

						</table>

					 </td>
				  </tr>
				  <tr>
                    <td height="10"></td>
                </tr>

				<tr>
				   <td>
					 表单动作：<input id="actionTbutton2" type="button" class="btnButton4font" value="打开" />
				   </td>
                </tr>
				<tr>
				  <td>
						<table border="0" bordercolor="gray" cellpadding="0" cellspacing="0" id="actionTb2" class="listTable" style="width:610px;display:none;border-top: 1px solid #e7e7e7;">
							<tr>
									<td width="40%" class="listTableLine1" align="center" nowrap>表单处理文件：</td>
									<td width="60%">
										<input type="text" name="formtabrealFileName" id="formtabrealFileName" style="width:350px;" value=""/>   
										<input type="hidden" name="formtabsaveFileName" id="formtabsaveFileName" style="width:800px;" value=""/> 
											<%-- <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
										   <jsp:param name="dir"      value="/modulesext/devform/customize/" />
										   <jsp:param name="uniqueId"    value="formId" />
										   <jsp:param name="realFileNameInputId"    value="formtabrealFileName" />
										   <jsp:param name="saveFileNameInputId"    value="formtabsaveFileName" />
										   <jsp:param name="canModify"   value="yes" />
										   <jsp:param name="width"        value="90" />
										   <jsp:param name="height"       value="20" /> 
										   <jsp:param name="multi"        value="false" />
										   <jsp:param name="buttonClass" value="upload_btn" />
										   <jsp:param name="buttonText"       value="上传jsp" />
										   <jsp:param name="fileSizeLimit"        value="0" />
										   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
										   <jsp:param name="uploadLimit"      value="1" />
										</jsp:include>--%>
									</td>
							</tr>
							<tr>
								<td class="listTableLine1" align="center" width="150">操作名称</td>
								<td class="listTableLine1" align="center" width="250">方法名</td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">新增加载</td>
									<td class="listTableLine1" align="center"><input type="text" id="addLoad" name="addLoad" class="inputText" style="width:350px;"/></td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">修改加载</td>
									<td class="listTableLine1" align="center"><input type="text" id="modiLoad" name="modiLoad" class="inputText" style="width:350px;"/></td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">新增保存</td>
									<td class="listTableLine1" align="center"><input type="text" id="addSaveLoad" name="addSaveLoad" class="inputText" style="width:350px;"/></td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">修改保存:</td>
									<td class="listTableLine1" align="center"><input type="text" id="modiSaveLoad" name="modiSaveLoad" class="inputText" style="width:350px;"/></td>
							</tr>
						</table>
					 </td>
				  </tr>
				  <tr>
					  <td>数据查看范围：
						  <input type="radio" id="menuSeeAuth" name="menuSeeAuth" value="0" onclick="changeDef(this.value);" checked/>不设查看权限看不见数据&nbsp;
						  <input type="radio" id="menuSeeAuth" name="menuSeeAuth" value="1" onclick="changeDef(this.value);"/>不设查看权限看到所有数据
					  </td>
					</tr>
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
					  <td>查询方案：
						  <input type="radio" name="queryradio" checked  value="0" onclick="showQuery(this.value);"/>默认&nbsp;
						  <input type="radio" name="queryradio"  value="1" onclick="showQuery(this.value);"/>重新定义
					  </td>
				   </tr>
				   <tr id="queryF" style="display:none">
                   
                    <td>
                        <table border="0">
                            <tr>
                                <td colspan="3">已有方案：
									<select id="queryCasesSel" name="queryCasesSel" class="selectlist" onchange="selplan(0);" style="width:150px;">
							        </select>
                                </td>
                            </tr>
                            <tr id="caseName" style="display:none">
                                <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input class="inputText" name="queryCaseName" id="queryCaseName"  style="width:150px;"><span class="MustFillColor">*</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <select size="7" id="fieldQuerySel" name ="fieldQuerySel" multiple="true"></select>
								</td>
                                <td>
								    <input type="button" id="goSelBtn" value="> "><br/>
									<input type="button" id="goAllBtn" value=">>"><br/>
									<input type="button" id="backSelBtn" value="< "><br/>
									<input type="button" id="backAllBtn" value="<<">
                                </td>
                                <td align="left">
                                    <select size=7 id="queryFieldSel" name="queryFieldSel" multiple="true"></select>
                                </td>
                            </tr>
                            <tr>
                            	<td colspan="3">
								    <input id="saveQuery" type="button" class="btnButton4font"  value="保存" />
									<input id="delQuery" type="button" class="btnButton4font"  value="删除" />
                               </td>
                            </tr>
                        </table>
                     </td>
                  </tr>
                  <tr>
                    <td height="10"></td>
                  </tr>
                   <tr>
                  <td>列表标题：
                      <input type="radio" name="titleradio"  value="0" checked onclick="showTitle(this.value);"/>默认&nbsp;
                      <input type="radio" name="titleradio"  value="1" onclick="showTitle(this.value);"/>重新定义
                  </td>
              </tr>
                <tr id="titleF" style="display:none">
                    <td class="5">
                        <table>
                            <tr>
                                <td colspan="3">已有方案：
									<select id="listCasesSel" name="listCasesSel" class="selectlist" onchange="selplan(1);"  style="width:150px;">
                                </td>
                            </tr>
                            <tr id="caseLName" style="display:none">
                                <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                     <input class="inputText" name="listCaseName" id="listCaseName"  style="width:150px;"><span class="MustFillColor">*</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
									 <select size="7" id="fieldL" name ="fieldL" multiple="true"></select>
                                </td>
                                <td>
								    <input type="button" id="goSelBtn1" value="> "><br/>
									<input type="button" id="goAllBtn1" value=">>"><br/>
									<input type="button" id="backSelBtn1" value="< "><br/>
									<input type="button" id="backAllBtn1" value="<<">
                                </td>
                                <td>
                                    <select size=7 name="listField" id="listField" multiple="true"></select>
                                </td>
                            </tr>
                            <tr>
                            	<td colspan="3">
								    <input id="saveList" type="button" class="btnButton4font"  value="保存" />
									<input id="delList" type="button" class="btnButton4font"  value="删除" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                 <tr>
                    <td height="10"></td>
                </tr>
				<tr>
                  
                  <td>导出字段：
                  	  <input type="radio" name="expfieldradio"  value="2" checked onclick="showexp(this.value);"/>默认&nbsp;
                      <input type="radio" name="expfieldradio"  value="0" onclick="showexp(this.value);"/>全部&nbsp;
                      <input type="radio" name="expfieldradio"  value="1" onclick="showexp(this.value);"/>重新定义
                  </td>
              </tr>
                <tr id="ExpFieldE" style="display:none">
 
                    <td>
                        <table>
                            <tr>
                                <td colspan="3">已有方案：
									<select id="listCasesSel2" name="listCasesSel2" class="selectlist" onchange="selplan(2);" style="width:150px;">
                                </td>
                            </tr>
                            <tr id="caseLName2" style="display:none">
                                <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input class="inputText" name="listCaseName2" id="listCaseName2"  style="width:150px;"><span class="MustFillColor">*</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
									 <select size="7" id="fieldL2" name ="fieldL2" multiple="true"></select>
                                </td>
                                <td>
								    <input type="button" id="goSelBtn2" value="> "><br/>
									<input type="button" id="goAllBtn2" value=">>"><br/>
									<input type="button" id="backSelBtn2" value="< "><br/>
									<input type="button" id="backAllBtn2" value="<<">
                                </td>
                                <td>
                                    <select size=7 name="listField2" id="listField2" multiple="true">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                            	  <td colspan="3">
								    <input id="saveList2" type="button" class="btnButton4font"  value="保存" />
									<input id="delList2" type="button" class="btnButton4font"  value="删除" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                 <tr>
                    <td height="10"></td>
                </tr>
                <tr>
                  <td>链接字段：<select id="menuMaintenanceSubTableName" name="menuMaintenanceSubTableName" class="selectlist" style="width:100px;">
				  </td>
                </tr>

	          </table>

			  <!----------------------------------------------------------------------------------------------------------------------------------->

             </td>
		  </tr>


		  <tr id="linktitleTR3" style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="3" id="readCK4" name="readCK" onclick="cleanData(3);"/>启动一个流程</td>
		  </tr>
		  <tr id="linkTR3" id style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left">
			   <table >
					  <tr>
                        <td valign="top">
							  <select id="menuStartFlow"  name="menuStartFlow_" class="xeasyui-combobox" data-options="panelHeight:200" style="width:260px;">
							   <%
								  if (workFlows != null && workFlows.size() > 0) {
									for(int i = 0; i < workFlows.size(); i++) {
									  ListItem item = (ListItem)workFlows.get(i);
								%>
									<option value="<%=item.getId()%>"><%=item.getName()%></option>
								<%}}%>
							 </select> 
						 </td>
                     </tr>
			  </table>
			</td>
		  </tr>
		  <tr id="linktitleTR4" style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="4" id="readCK5" name="readCK" onclick="cleanData(4);"/>链接一个文件</td>
		  </tr>
		  <tr id="linkTR4" id style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left">
			  <table >
					  <tr>
                        <td valign="top">
                            <input type="hidden" name="menuFileLink" id="menuFileLink" style="width:800px;" value=""/>   
							<input type="hidden" name="menuHtmlLink" id="menuHtmlLink" style="width:800px;" value=""/> 
							<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
							   <jsp:param name="dir"      value="customize" />
							   <jsp:param name="uniqueId"    value="linkfileId" />
							   <jsp:param name="realFileNameInputId"    value="menuFileLink" />
							   <jsp:param name="saveFileNameInputId"    value="menuHtmlLink" />
							   <jsp:param name="canModify"   value="yes" />
							   <jsp:param name="multi"        value="false" />
							   <jsp:param name="buttonClass" value="upload_btn" />
							   <jsp:param name="fileSizeLimit"        value="0" />
							   <jsp:param name="uploadLimit"      value="1" />
							</jsp:include>
					    </td>
                     </tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			  <td colspan="2">
			    <table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr height="1" bgcolor="#808080">
					<td style="padding:0;"></td>
				  </tr>
				  <tr height="1"  bgcolor="#FFFFFF">
					<td style="padding:0;"></td>
				  </tr>
				</table>
			  </td>
		  </tr>
		   <!-- ***************************************************************************** -->
		   <tr>
			<td>显示方式：</td>
			<td valign="top" align="left">
              <input type="radio" name="menuOpenStyle" value="0" checked/>内嵌 
			  <input type="radio" name="menuOpenStyle" value="1"/>弹出
			</td>
		  </tr>


		   <tr class="Table_nobttomline">    
			<td > </td>   
			   <td nowrap>    
				   <input type="button" class="btnButton4font" onClick="saveclose(this);" value="<%=Resource.getValue(whir_locale,"common","comm.saveclose")%>" />
				   <input type="button" class="btnButton4font" onClick="savecontinue(this);" value="<%=Resource.getValue(whir_locale,"common","comm.savecontinue")%>" />
				   <input type="button" class="btnButton4font" onClick="resetDataForm();"     value="<%=Resource.getValue(whir_locale,"common","comm.reset")%>" />    
				   <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<%=Resource.getValue(whir_locale,"common","comm.exit")%>" />    
			   </td>    
		   </tr>    
		</table>  
		 
		</s:form>  
		</div>  
	</div>  
</body>  
<%@ include file="/public/include/include_extjs.jsp"%>
<script type="text/javascript">  
//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//设置表单为异步提交  
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});  

//*************************************下面的函数属于各个模块 完全 自定义的*********************************************//

function resetDataForm(){
  location_href('<%=rootPath%>/custormermenu!addCustMenu.action?validate=<%=request.getParameter("validate")%>');
}

</script>  
<script src="<%=rootPath%>/platform/custom/customize/js/common.js" language="javascript"></script>
<script src="<%=rootPath%>/platform/custom/customize/js/common_add.js" language="javascript"></script>
</html>  