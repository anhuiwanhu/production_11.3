<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.information.channelmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.information.common.util.*"%>
<%@ page import="java.util.Arrays"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:text name="info.InformationList"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<script src="<%=rootPath%>/public/relation/relation.js" language="javascript"></script>
	<script src="<%=rootPath%>/scripts/main/whir.userInfo.card.js" language="javascript"></script>
	<style type="text/css">
		.trigger1:hover{color:red}
    </style>
	<%
	String color = request.getParameter("headColor")!=null?request.getParameter("headColor"):"";
	if(!"".equals(color)){
	%>
	<link href="<%=rootPath%>/themes/department/style.css" rel="stylesheet" type="text/css"/>
	<%
	}
	%>
</head>
<%
  	String informationId  =  EncryptUtil.htmlcode(request,"informationId"); 
  	String relationModule = EncryptUtil.htmlcode(request,"relationModule");
  	String relationIFrame = EncryptUtil.htmlcode(request,"relationIFrame");
  	String moduleType     = EncryptUtil.htmlcode(request,"moduleType");
  	String relation    = request.getAttribute("relation")==null?"":request.getAttribute("relation").toString();
  	String type        = EncryptUtil.htmlcode(request,"type");
  	String checkdepart = EncryptUtil.htmlcode(request,"checkdepart");
  	String hasRight    = request.getAttribute("hasRight")==null?"":request.getAttribute("hasRight").toString();
  	String channelName = EncryptUtil.htmlcode(request,"channelName");
  	String dossierGD   = request.getAttribute("dossierGD")==null?"":request.getAttribute("dossierGD").toString();
  	//2013-09-11-----单位主页归档需要的参数-----start
  	String departchannelId = EncryptUtil.htmlcode(request,"channelId");
  	String departchannelType = EncryptUtil.htmlcode(request,"channelType"); 
  	String departuserChannelName = EncryptUtil.htmlcode(request,"userChannelName");
  	String departuserDefine = EncryptUtil.htmlcode(request,"userDefine"); 
  	String departheadColor = EncryptUtil.htmlcode(request,"headColor"); 
  	String weihuInformation= request.getAttribute("weihuInformation")==null?"":request.getAttribute("weihuInformation").toString();
  	//2013-09-11-----单位主页归档需要的参数-----end
  	//20151010 -by jqq 当前登录用户id和所在组织id，用以新建栏目的权限判断
  	String userId = session!=null&&session.getAttribute("userId")!=null?session.getAttribute("userId").toString():"";
  	String orgId = session!=null&&session.getAttribute("orgId")!=null?session.getAttribute("orgId").toString():"";
  	String orgIdString = session!=null&&session.getAttribute("orgIdString")!=null?session.getAttribute("orgIdString").toString():"";
  	String domainId = session!=null&&session.getAttribute("domainId")!=null?session.getAttribute("domainId").toString():"";
  	java.util.List list_canIssue = InfoUtils.getCanIssueChannel(userId, orgId, orgIdString, domainId);
    String[] obj_canIssueId = new String[list_canIssue.size()];
    if(list_canIssue!=null&&list_canIssue.size()>0){
      	Object[] obj_canIssue = null;
    	for(int x = 0;  x < list_canIssue.size(); x ++){
      		obj_canIssue = (Object[]) list_canIssue.get(x);
      		obj_canIssueId[x] = obj_canIssue != null ? obj_canIssue[0].toString() : "";

      	}
  	}
  	String fromGov = request.getAttribute("fromGov")!=null?request.getAttribute("fromGov").toString():"";
%>

<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="InfoList!list.action" method="post" theme="simple">
	<%@ include file="/public/include/form_list.jsp"%>
    <input type="hidden" name="informationId"  id="informationId"  value="<%=informationId%>" />
    <input type="hidden" name="relationModule" id="relationModule" value="<%=relationModule%>" />
    <input type="hidden" name="relationIFrame" id="relationIFrame" value="<%=relationIFrame%>" />
    <input type="hidden" name="moduleType"     id="moduleType"     value="<%=moduleType%>" />
    <input type="hidden" name="relation"       id="relation"       value="<%=relation%>" />
    <input type="hidden" name="checkdepart"    id="checkdepart"    value="<%=checkdepart%>" />
    <input type="hidden" name="hasRight"       id="hasRight"       value="<%=hasRight%>" />
    <input type="hidden" name="channelName"    id="channelName"    value="<%=channelName%>" />
    
	<s:hidden id="channelType" name="channelType" />
	<s:hidden id="userDefine" name="userDefine" />
	<s:hidden id="userChannelName" name="userChannelName" />
	<s:hidden id="type" name="type" />
	<s:hidden id="channelId" name="channelId" />
	<s:hidden id="listType" name="listType" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="searchTable" class="SearchBar" style="display:none;">
        <tr <s:if test='#request.onlyRetrievalAll == 1'>style="display:none;"</s:if>>
            <td class="whir_td_searchtitle" nowrap><s:text name="info.columnname"/>：</td>
			<td class="whir_td_searchinput">
				<select id="searchChannels" name="searchChannels">
					<option value="0" selected>===<s:text name="info.pselectcolumn"/>===</option>
				</select>
			</td> 
			<td class="whir_td_searchtitle" nowrap><s:text name="info.searchareadepartment"/>：</td>
			<td class="whir_td_searchinput">
				<s:hidden id="searchOrgId" name="searchOrgId"/>
				<s:textfield name="searchOrgName" id="searchOrgName" cssClass="inputText" cssStyle="width:96%" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'searchOrgId', allowName:'searchOrgName', select:'org', single:'yes', show:'org', range:'*0*'});"></a>
			</td>
			<td class="whir_td_searchtitle" nowrap><s:text name="info.searchareakey"/>：</td>
			<td class="whir_td_searchinput">
				<s:textfield name="key" id="key" cssClass="inputText" cssStyle="width:99%"/>
			</td>
        </tr>
		<tr <s:if test='#request.onlyRetrievalAll == 1'>style="display:none;"</s:if>>
			<td class="whir_td_searchtitle" nowrap><s:text name="info.searchareatitle"/>：</td>
			<td class="whir_td_searchinput">
				<s:textfield name="title" id="title" cssClass="inputText" cssStyle="width:96%"/>
			</td>
			<td class="whir_td_searchtitle" nowrap><s:text name="info.newinfosecondtitle"/>：</td>
			<td class="whir_td_searchinput">
				<s:textfield name="subtitle" id="subtitle" cssClass="inputText" cssStyle="width:96%"/>
			</td>
			<td class="whir_td_searchtitle" nowrap><s:text name="info.searchareaattachment"/>：</td>
			<td class="whir_td_searchinput">
				<s:textfield name="append" id="append" cssClass="inputText" cssStyle="width:99%"/>
			</td>
		</tr>
		<tr <s:if test='#request.onlyRetrievalAll == 1'>style="display:none;"</s:if>>
			<td class="whir_td_searchtitle" nowrap><s:text name="info.searchareapublisher"/>：</td>
			<td class="whir_td_searchinput">
				<s:textfield name="searchIssuerName" id="searchIssuerName" cssClass="inputText" cssStyle="width:96%"/>
			</td>
			<td class="whir_td_searchtitle" nowrap><s:text name="info.searchareapubdate"/>：</td>
			<td class="whir_td_searchinput" colspan="2">
				<s:textfield name="startDate" id="startDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'endDate\\')}'})"/>&nbsp;<s:text name="info.to"/>&nbsp;<s:textfield name="endDate" id="endDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'startDate\\')}'})" />
			</td>
			<td class="SearchBar_toolbar">
                <input type="button" class="btnButton4font" onclick="refreshListForm('queryForm');"  value="<s:text name='comm.searchnow'/>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" onclick="resetForm(this);" value="<s:text name='comm.clear'/>" />
            </td>
		</tr>
        <%
        boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);//true-是 false-否
        if(!isCOSClient){
        %>
		<tr>
            <td class="whir_td_searchtitle" nowrap><s:text name='info.wholeSearch'/>：</td>
			<td class="whir_td_searchinput">
				<s:textfield name="retrievalKey" id="retrievalKey" cssClass="inputText" cssStyle="width:96%"/>
			</td> 
			<td colspan="4" align="left">
				<input type="button" class="btnButton4font" onclick="retrievalAllser();"  value="<s:text name='info.wholeSearch'/>" />
			</td>
        </tr>
        <%}%>
    </table>
	<s:if test="#request.relation!=1">
	<table width="100%" height="35px" border="0" cellpadding="0" cellspacing="0" <s:if test='#request.onlyRetrievalAll == 1'>class="toolbarBottomLine"</s:if><s:else>class="inlineBottomLine"</s:else>>  
        <tr>
			<td>
			<s:if test='#request.onlyRetrievalAll != 1 && #request.relationModule!="information"'>
				<div class="whir_public_movebg">  
					<div class="whir_flright Public_tag" style="float:right;padding-right:5px" >  
						<div id="whir_titlesearch">  
							<s:if test="channelId!='' && channelId!=null && (#request.hasRight || #request.channelManager)">
							<input type="button" class="btnButton4font" onclick="batchSetCommend();"  value="<s:text name='info.allsuggest'/>" />
							<input type="button" class="btnButton4font" onclick="transfer();"  value="<s:text name='info.alltransfer'/>" />
							<input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/Information!batchDelete.action','informationId','informationId',this);"  value="<s:text name='info.alldeleteselect'/>" />
							</s:if>
							<%if(!( (!"0".equals(departchannelType)) && ("0".equals(departuserDefine)) )  ){%>
							<%if( ("all".equals(type)) || (Arrays.asList(obj_canIssueId).contains(departchannelId)) ){%>
							<input type="button" class="btnButton4font" onclick="javascript:openWin({url:changeChannel_url('<%=departchannelId%>')+'&channelType=0&userChannelName=<%=departuserChannelName%>&userDefine=0&channelName=<%=channelName%>&channelId=<%=departchannelId%>&type=<%=type%>',isFull:true,winName:'newInfo'})" value="<s:text name='info.newcontent'/>"/>
							<%}%>
							<%}%>
							<input type="button" class="btnButton4font" onclick="chSearch(this);"  value="<s:text name='comm.opensearch'/>"/>
						</div>  
					</div>  
				   
					<s:if test='#request.onlyRetrievalAll != 1 && !(channelType>0 && userDefine==0)'>
					<div class="Public_tag">  
						<ul>  
							<li id="list" onclick="list();"><span class="tag_center"><s:text name="comm.list" /></span><span class="tag_right"></span></li>  
							<li id="detail" class="tag_aon" onclick="detail();"><span class="tag_center"><s:text name="comm.detail" /></span><span class="tag_right"></span></li>
							<s:if test="channelId!='' && channelId!=null">
							<li id="thumb" onclick="thumbnail();"><span class="tag_center"><s:text name="info.allthumbnail" /></span><span class="tag_right"></span></li>
							</s:if>
						</ul>  
					</div>
					</s:if>
				</div>
			</s:if>
			<s:else>
				<div style="float:right;">
				<s:if test='#request.relationModule=="information"'>
				<%
				ChannelBD channelBD = new ChannelBD();
				java.util.List userChannel = channelBD.getUserChannel(""+session.getAttribute("domainId"),""+session.getAttribute("userId"),""+session.getAttribute("orgId"),""+session.getAttribute("orgIdString"));
				String dataType = request.getAttribute("dataType")!=null?request.getAttribute("dataType").toString():"";
				%> 
					<select id="dataType" name="dataType" style="width:200px" onchange="changeRelationType();">
						<option value="0" <%=dataType.equals("0")?"selected":""%>>信息管理</option>
						<option value="-1" <%=dataType.equals("-1")?"selected":""%>>单位主页</option>
				<%
				if(userChannel!=null&&userChannel.size()>0){
					Object[] userobj = null;
					for(int ii = 0;  ii < userChannel.size(); ii ++){
						userobj = (Object[]) userChannel.get(ii);%>
						<option value="<%=userobj[0]%>" <%=dataType.equals(userobj[0].toString())?"selected":""%>><%=userobj[1]%></option>
				<%	}		  
				}
				%>
					</select>
				</s:if>
					<input type="button" class="btnButton4font" onclick="chSearch(this);"  value="<s:text name='comm.opensearch'/>" /> 
				</div>
			</s:else>
			</td>
		</tr>
	</table>
	</s:if>
	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<s:if test="channelId!='' && channelId!=null">
				<td whir-options="field:'informationId',width:'2%',checkbox:true,renderer:childChannel"><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('informationId',this.checked);" ></td>
			</s:if>
				<td nowrap whir-options="field:'informationTitle',width:'45%',renderer:infoTitle"><s:text name="info.searchareatitle"/></td> 
				<td whir-options="field:'informationIssuer',width:'8%',renderer:showCreatedEmp"><s:text name="info.searchareapublisher"/></td> 
				<td whir-options="field:'informationIssueTime', width:'10%',allowSort:true,renderer:common_DateFormat"><s:text name="info.searchareapubdate"/></td> 
				<td whir-options="field:'informationModifyTime', width:'10%',allowSort:true,renderer:common_DateFormat"><s:text name="info.modifydate"/></td> 
				<td whir-options="field:'informationKits',width:'6%',allowSort:true"><s:text name="info.detailclick"/></td> 
			<s:if test="channelId!='' && channelId!=null && (#request.hasRight || #request.channelManager)">
				<td whir-options="field:'informationCommonNum',width:'6%',allowSort:true"><s:text name="info.detailcomment"/></td>
				<td whir-options="field:'',width:'10%',renderer:myOperate"><s:text name="comm.opr"/></td>
			</s:if>
			<s:elseif test="#request.hasRight">
				<td whir-options="field:'orderCode',width:'6%'"><s:text name="info.sort"/></td>
				<td whir-options="field:'',width:'10%',renderer:myOperate"><s:text name="comm.opr"/></td>
			</s:elseif>
			<s:elseif test="#request.relationModule=='information'">
				<td whir-options="field:'informationCommonNum',width:'6%',allowSort:true"><s:text name="info.detailcomment"/></td>
				<%if("all".equals(type)){%><td whir-options="field:'',width:'10%',renderer:myOperate"><s:text name="comm.opr"/></td><%}%>
			</s:elseif>
			<s:else>
				<td whir-options="field:'informationCommonNum',width:'6%',allowSort:true"><s:text name="info.detailcomment"/></td>
			</s:else>
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
<iframe id="gdIframe" src="" frameborder="0" style="display:'none'" height="0"></iframe>
<%@ include file="/public/include/include_extjs.jsp"%>
<script language="javascript">
initListFormToAjax({formId:"queryForm",onLoadSuccessAfter:parentLoad});
/*Ext.onReady(function() {
	var modelCombo = Ext.create('Ext.form.field.ComboBox', {
		id: 'channelId',
		typeAhead: true,
		transform: 'searchChannels',
		hiddenName: 'searchChannel',
		width: 213,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				
			}
		}
	});

	initListFormToAjax({formId:"queryForm",onLoadSuccessAfter:showUserCardInfo});
});*/

//单位主页中刷新父页面高度
function parentLoad(){
    if(window.parent.loadIframe){
        window.parent.loadIframe();
    }
    showUserCardInfo();
}

function childChannel(po,i){
	var html = "";
	if(po.channelId!=$("#channelId").val()){
		html = "disabled";
	}
	return html;
}

function setRelation_all(id,name,href){
	setRelationInfo(id, name, href, 'information', 'relationIFrame');
}

//渲染操作项
function myOperate(po,i){
	var html = '';
	<s:if test="#request.relationModule=='information'">
		html = '<img src="<%=rootPath%>/images/createlink.gif" style="cursor:hand" title="<s:text name="info.setrelatedinfo" />" onClick="setRelation_all(\''+po.informationId+'\',\''+po.informationTitle+'\',\'Information!view.action?informationId='+po.informationId+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'\');" >';
	</s:if>
	<s:else>
		<%if("true".equals(weihuInformation)){%>
			if(po.channelId!=$("#channelId").val()&&$("#channelId").val()!=""){
				html = "";
			}else{
				<s:if test="channelId!='' && channelId!=null && (#request.channelManager||#request.allRight)">
				if(po.channelNeedCheckup =='1' && po.channelNeedCheckupForModi=='1'){
					html += '<a href="javascript:void(0)" onclick="openWin({url:\'Information!restart.action?p_wf_recordId='+po.informationId+'&p_wf_moduleId=4&p_wf_openType=reStart&modifyFlag=1\',isFull:true,winName:\'infoModi\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="info.allmodify"/>"></a>';
				} else {
					html += '<a href="javascript:void(0)" onclick="openWin({url:\'Information!load.action?informationId='+po.informationId+'&channelType='+$("#channelType").val()+'&userDefine='+$("#userDefine").val()+'&userChannelName='+$("#userChannelName").val()+'\',isFull:true,winName:\'infoModi\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="info.allmodify"/>"></a>';
				}
				html += '<a href="javascript:void(0)" onclick="ajaxDelete(\'Information!batchDelete.action?informationId='+po.informationId+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="info.alldelete"/>"></a>';
				<%if("true".equals(dossierGD)){%>
					if(po.dossierStatus!=1){
						html += '<a href="javascript:void(0)" onclick="gd('+po.informationId+','+po.channelId+','+po.informationType+');"><img border="0" src="<%=rootPath%>/images/officeset.gif" title="<s:text name="info.viewarchive"/>"></a>';
					}
				<%}%>
				if(po.informationIsCommend!=1){
					html +='<a href="javascript:void(0)" onclick="setCommend(\'Information!setCommend.action?informationId='+po.informationId+'\');"><img border="0" src="<%=rootPath%>/images/addgood.gif" title="<s:text name="info.SetFeatured"/>"></a>';
				}else{
					html += '<a href="javascript:void(0)" onclick="removeCommend(\'Information!removeCommend.action?informationId='+po.informationId+'\');"><img border="0" src="<%=rootPath%>/images/cancelgood.gif" title="<s:text name="info.cancelsuggest"/>"></a>';
				}
					<s:if test="#request.channelManager">
					if($("#checkdepart").val()=='1'){
						html += '<a href="javascript:void(0)" onclick="openWin({url:\'Information!sort.action?informationId='+po.informationId+'&orderCode='+po.orderCode+'\',width:600,height:120,winName:\'infoSort\'});"><img border="0" src="<%=rootPath%>/images/px.gif" title="<s:text name="info.sort"/>"></a>';
					}
					</s:if>
				</s:if>

				<s:elseif test="(channelId =='' || channelId ==null) && #request.hasRight">
                    if(po.infoManager=='1'){
					    html += '<a href="javascript:void(0)" onclick="openWin({url:\'Information!sort.action?informationId='+po.informationId+'&orderCode='+po.orderCode+'\',width:600,height:120,winName:\'infoSort\'});"><img border="0" src="<%=rootPath%>/images/px.gif" title="<s:text name="info.sort"/>"></a>';
                    }
					if(po.informationIsCommend==1 && $("#type").val()=="good" && po.infoManager=='1'){
						html += '<a href="javascript:void(0)" onclick="removeCommend(\'Information!removeCommend.action?informationId='+po.informationId+'\');"><img border="0" src="<%=rootPath%>/images/cancelgood.gif" title="<s:text name="info.cancelsuggest"/>"></a>';
					}
				</s:elseif>
			}
		<%}%>
	</s:else>
	return html;
}

//列表页签
function list(){
	$("#list").addClass("tag_aon");
	$("#detail").removeClass();
	$("#thumb").removeClass();
	location_href("<%=rootPath%>/InfoList!allInfo.action?type="+$("#type").val()+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$("#channelType").val()+"&userDefine="+$("#userDefine").val()+"&userChannelName="+$("#userChannelName").val()+"&listType=1"+"&channelId="+$("#channelId").val());
}

//详细页签
function detail(){
	$("#detail").addClass("tag_aon");
	$("#list").removeClass();
	$("#thumb").removeClass();
	location_href("<%=rootPath%>/InfoList!allList.action?type="+$("#type").val()+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$("#channelType").val()+"&userDefine="+$("#userDefine").val()+"&userChannelName="+$("#userChannelName").val()+"&channelId="+$("#channelId").val());
}

//缩略图页签
function thumbnail(){
	$("#thumb").addClass("tag_aon");
	$("#list").removeClass();
	$("#detail").removeClass();
	location_href("<%=rootPath%>/InfoList!allThumb.action?type="+$("#type").val()+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$("#channelType").val()+"&userDefine="+$("#userDefine").val()+"&userChannelName="+$("#userChannelName").val()+"&channelId="+$("#channelId").val());
}

//打开/关闭查询
function chSearch(obj){
	if(obj.value == "<s:text name='info.opensearch'/>"){
		obj.value = "<s:text name='comm.closesearch'/>";
		$("#searchTable").show();
		$.ajax({
			type:"post",
			url:"<%=rootPath%>/InfoList!channelList.action?channelType="+$("#channelType").val()+"&userDefine="+$("#userDefine").val(),
			async:true,
			dataType:"Json",
			success:function(data){
				data = eval(data);
				var content = "";
				for(var i=0;i<data.length;i++){
					$("#searchChannels").each(function(){
						$(this).append('<option value="'+data[i].channelId+'">'+data[i].channelName+'</option>');
					});
				}
				Ext.onReady(function() {
					var modelCombo = Ext.create('Ext.form.field.ComboBox', {
						id: 'channelId',
						typeAhead: true,
						transform: 'searchChannels',
						hiddenName: 'searchChannel',
						width: 213,
						forceSelection: true,
						//emptyText: '--请选择--',
						listeners: {
							select: function(combo, record, index) {
							}
						}
					});
				});
			}
		});
		
	}else{
		obj.value = "<s:text name='info.opensearch'/>";
		$("#searchTable").hide();
	}
}


//渲染标题
function infoTitle(po,i){
	var html = "", goodImg="", redTitle="", isNew="", channelName="";
	//全文检索改造20151205 -by jqq 
	var key = $("#retrievalKey").val();
	var retrivalflag = "0";
	if(key == null || key == '' || key == ""){
		retrivalflag = "0";
	}else{
		retrivalflag = "1";
	}
	//是否精华信息
	if(po.informationIsCommend==1){
		goodImg = "<img src='<%=rootPath%>/images/addgood.gif' >&nbsp;"
	}
	//是否红色标题
	if(po.titleColor==1){
		//全文检索使用的查询方法变更，查询的sql语句返回json结果中，id名称改变了
		if(retrivalflag == "1"){
			redTitle = '<a onclick="openWin({url:\'Information!view.action?informationId='+po.information_id+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channel_id+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&gdType=infomation&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.information_id+'\',isFull:true});" style="cursor:pointer"><font color="red">'+HtmlEncode(po.informationTitle)+'</font></a>';
		}else{
			redTitle = '<a onclick="openWin({url:\'Information!view.action?informationId='+po.informationId+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&gdType=infomation&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.informationId+'\',isFull:true});" style="cursor:pointer"><font color="red">'+HtmlEncode(po.informationTitle)+'</font></a>';
		}
	}else{
		if(retrivalflag == "1"){
			redTitle = '<a onclick="openWin({url:\'Information!view.action?informationId='+po.information_id+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channel_id+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&gdType=infomation&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.information_id+'\',isFull:true});" style="cursor:pointer">'+HtmlEncode(po.informationTitle)+'</a>';
		}else{
			redTitle = '<a onclick="openWin({url:\'Information!view.action?informationId='+po.informationId+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&gdType=infomation&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.informationId+'\',isFull:true});" style="cursor:pointer">'+HtmlEncode(po.informationTitle)+'</a>';
		}
	}
	//栏目信息列表中有效期限为短期并且不包括当前时间的信息标题显示灰色(只有信息维护的权限并且权限范围为全部的用户可见)
	//if($("#channelId").val()!=""){
		if(po.informationValidType==1){
			if(compareWithNow(po.validBeginTime)=='>' || compareWithNow(po.validEndTime)=='<'){
				if(retrivalflag == "1"){
					redTitle = '<a onclick="openWin({url:\'Information!view.action?informationId='+po.information_id+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channel_id+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&gdType=infomation&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.information_id+'\',isFull:true});" style="cursor:pointer"><font color="gray">'+HtmlEncode(po.informationTitle)+'</font></a>';
				}else{
					redTitle = '<a onclick="openWin({url:\'Information!view.action?informationId='+po.informationId+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&gdType=infomation&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.informationId+'\',isFull:true});" style="cursor:pointer"><font color="gray">'+HtmlEncode(po.informationTitle)+'</font></a>';
				}
			}
		}
	//}
	//是否新信息
	var informationIssueTime = po.informationIssueTime;//.substring(0,po.informationIssueTime.indexOf(" "));
    //alert(informationIssueTime.replace(/-/g,"/"));
	//var array = informationIssueTime.split("-");
	var now = new Date();
	var issueDate = new Date(informationIssueTime.replace(/-/g,"/"));//new Date(array[0],array[1]-1,array[2]);
    //alert(issueDate);
    var newInfoDeadLine = parseInt(po.newInfoDeadLine);
	if(now.getTime() - issueDate.getTime() < 3600*24*1000*newInfoDeadLine){
		isNew = "<img src='<%=rootPath%>/images/new.gif' width='28' height='11'>";
	}
	var isRelation = "";
	<s:if test="#request.relationModule=='information'">
		isRelation = "&relationModule=information"
	</s:if>
	if(retrivalflag == "1"){
		channelName = "<a onclick='location_href(\"InfoList!allList.action?channelId="+po.channel_id+"&channelName="+po.channelName+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$('#channelType').val()+"&userChannelName="+$('#userChannelName').val()+"&userDefine="+$('#userDefine').val()+isRelation+"\");' style='cursor:pointer'>["+po.channelName+"]</a>&nbsp;";
	}else{
		channelName = "<a onclick='location_href(\"InfoList!allList.action?channelId="+po.channelId+"&channelName="+po.channelName+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$('#channelType').val()+"&userChannelName="+$('#userChannelName').val()+"&userDefine="+$('#userDefine').val()+isRelation+"\");' style='cursor:pointer'>["+po.channelName+"]</a>&nbsp;";
	}
	html = goodImg+channelName+redTitle+isNew;
	return html;
}

//是否显示修改时间
function showModifyTime(po,i){
	var html = "&nbsp;";
	if(po.informationModifyTime > po.informationIssueTime){
		html = po.informationModifyTime.substring(0,10);
	}
	return html;
}

//取消精华
function removeCommend(url){
	whir_confirm("<s:text name='info.confirmcancelsugg'/>",function(){
		ajaxOperate({urlWithData:url,tip:'<s:text name="info.CancelFeatured"/>',isconfirm:false,formId:'queryForm'});
	});
}

//设置精华
function setCommend(url){
	whir_confirm("<s:text name='info.confirmsuggest'/>",function(){
		ajaxOperate({urlWithData:url,tip:'<s:text name="info.SetFeatured"/>',isconfirm:false,formId:'queryForm'});
	});
}

//批量设置精华
function batchSetCommend(url){
	var informationId = getCheckBoxData("informationId", "informationId");
	if(informationId!=""){
		whir_confirm("<s:text name='info.confirmsuggest'/>",function(){
			ajaxOperate({urlWithData:'Information!setCommend.action?informationId='+informationId,tip:'<s:text name="info.SetFeatured"/>',isconfirm:false,formId:'queryForm'});
		});
	}else{
		whir_alert("<s:text name='info.selectrecords'/>！");
	}
}

//全文检索
function retrievalAllser(){
	var key = $("#retrievalKey").val();
	if(key == null || key == '' || key == ""){
		$("#queryForm").attr("action","InfoList!list.action");
		//whir_alert(bbs.pleaseEnterKeyword, null, null);
		refreshListForm('queryForm');
	}else{
		$("#queryForm").attr("action","InfoList!retrieval_new.action");
		refreshListForm('queryForm');
	}
}

//批量转移
function transfer(){
	var informationId = getCheckBoxData("informationId", "informationId");
	if(informationId!=""){
		whir_confirm("<s:text name='info.confirmtransfer'/>",function(){
			openWin({url:'Information!toTransfer.action?informationId='+informationId+'&channelName='+$("#channelName").val()+'&channelId='+$("#channelId").val()+'&userChannelName='+$("#userChannelName").val(),winName:'transferInfo',width:600,height:240});
			//ajaxOperate({urlWithData:'Information!toTransfer.action?informationId='+informationId+'&channelId='+$("#channelId").val(),tip:'转移',isconfirm:false,formId:'queryForm'});
		});
	}else{
		whir_alert("<s:text name='info.selecttransferredrecords'/>！");
	}
}

//归档
function gd(informationId, channelId, informationType){
	var userChannelName = $("#userChannelName").val();
	//2013-09-02-----修改开始
	<%if("1".equals(checkdepart)){%>
		$("#gdIframe").attr("src","Information!view.action?informationId="+informationId+"&informationType="+informationType+"&userChannelName="+encodeURIComponent(userChannelName)+"&channelId="+channelId+"&gd=1&gdType=infomation&userDefine="+$("#userDefine").val()+"&channelType="+$("#channelType").val()+"&gdFromType=checkdepart&departchannelId=<%=departchannelId%>&departchannelType=<%=departchannelType%>&departuserChannelName=<%=departuserChannelName%>&departuserDefine=<%=departuserDefine%>&departheadColor=<%=departheadColor%>");
	<%}else{%>
		$("#gdIframe").attr("src","Information!view.action?informationId="+informationId+"&informationType="+informationType+"&userChannelName="+encodeURIComponent(userChannelName)+"&channelId="+channelId+"&gd=1&gdType=infomation&userDefine="+$("#userDefine").val()+"&channelType="+$("#channelType").val()+"");
	<%}%>
	//2013-09-02-----修改结束
}

function changeRelationType(){
	var flag = $("#dataType").val();
	if(flag=='0'){
		location_href('InfoList!allList.action?type=all&channelType=0&userChannelName=信息管理&userDefine=0&relationModule=information&dataType='+flag);
	}else if(flag=='-1'){
		location_href('InfoList!allList.action?type=all&channelType=-1&userChannelName=单位主页&userDefine=0&checkdepart=1&relationModule=information&dataType='+flag);
	}else{
		var text = $("#dataType").find("option:selected").text();  
		location_href('InfoList!allList.action?type=all&channelType='+flag+'&userChannelName='+text+'&userDefine=1&relationModule=information&dataType='+flag);
	}
}

function showCreatedEmp(po,i){
    var html = "";
    var target = "true";
    var data = whirRootPath + "/public/desktop/getUserCardInfo.jsp?id="+po.informationIssuerId+"&hasMsg="+target;
    html +="<a class=\"trigger1\" rel=\""+data+"\" href=\"javascript:view("+po.informationIssuerId+");\" >"+po.informationIssuer+"</a>";
    return html;
}

function showInfo(){
	$(".trigger1").powerFloat({
        targetMode: "ajax"
    });
}
//20151012 -by jqq 判断是否走审核流程，分别跳转到不同的页面链接
function changeChannel_url(val){
  if(val == null || val == "" || val == ''){
    return 'Information!add.action?original=0';
  }
  var channelId = $.trim(val);
  var url_flow = '';
  $.ajax({
    type: 'POST',
    url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: false,
    dataType: 'json',
    success: function(data){
      if(data!=null && data!=""){
		//是否易播栏目
		var isYiBoChannel = data.isYiBoChannel != null && data.isYiBoChannel != "" && data.isYiBoChannel != '' ? data.isYiBoChannel : "0";
		//whir_alert(isYiBoChannel);
		if(data.processId=="0"){
          //非流程
          url_flow =
            'Information!add.action?original=1'+'&p_wf_pool_processId='+data.processId+'&isyiboflag='+isYiBoChannel;
        }else{
        	url_flow =
            'Information!start.action?original=1'+'&p_wf_pool_processId='+data.processId+'&isyiboflag='+isYiBoChannel;
        }
      } //if data != null
    }
  });
  //alert(url_flow);
  return url_flow;
}
</script>
</body>
</html>