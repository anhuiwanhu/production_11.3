<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_detail.jsp"%>
    <style type="text/css">
    /*带标题模板*/
    .templateBox{ clear:both;}
    .templateBox .templateBoxline{ border:1px solid #dcdcdc; padding:0 20px; margin:0; min-height: 100px;  height: auto !important;  height: 100px;}
    .templateBox .templateTitle{ height:28px; line-height:28px; font-weight:bold; color:#000; font-size:12px; margin:0; padding:0 15px;}
    .templateBox .templateContent{
        width:98%;
        border-collapse: collapse;
        clear: both;
        display: table;
        border-spacing: 0;
        table-layout: auto;
    }

    .relationObjDiv{
        width:98%;
        float:left;
        margin:5px;
        /*display:inline;*/
        display: table-cell;
        vertical-align: top;
    }

    .templateBox .templateContent .relationObjDiv_outter{
        width:49%;
        float:left;
    }

    .dataDiv{
    }
    </style>
</head>
<body class="MainFrameBox" style="height:auto;">
<%
EncryptUtil encutil = new EncryptUtil();

String tagName = encutil.htmlcode(request,"tagName");
String iframeName = encutil.htmlcode(request,"iframeName");

String relationview = encutil.htmlcode(request,"relationview"); request.getParameter("relationview");
String relationadd = encutil.htmlcode(request,"relationadd"); request.getParameter("relationadd");

boolean isRelationadd  = "1".equals(relationadd)?true:false;
boolean isRelationview = "1".equals(relationview)?true:false;

String moduleType = encutil.htmlcode(request,"moduleType");
String infoId = encutil.htmlcode(request,"infoId");

//来自工作流子表标记，去除删除
String isNewRelation = (String)request.getParameter("isNewRelation");

String relationObjType = request.getParameter("relationObjType")==null?"project,information,flow,forum,contract,person":request.getParameter("relationObjType");

List flowList = (List)request.getAttribute("flowList");
List forumList = (List)request.getAttribute("forumList");
List contractList = (List)request.getAttribute("contractList");
List personList = (List)request.getAttribute("personList");
List informationList = (List)request.getAttribute("informationList");
List projectList = (List)request.getAttribute("projectList");

com.whir.org.manager.bd.ManagerBD mbd = new com.whir.org.manager.bd.ManagerBD();
String delDataIds = "";

int flownum = 0;
if(flowList != null){
   flownum = flowList.size();
}

int forumnum = 0;
if(forumList != null){
   forumnum = forumList.size();
}

int projectnum = 0;
if(projectList != null){
    projectnum = projectList.size();
}

int informationnum = 0;
if(informationList != null){
    informationnum = informationList.size();
}

int contractnum = 0;
if(contractList != null){
    contractnum = contractList.size();
}

int personnum = 0;
if(personList != null){
    personnum = personList.size();
}

int dIndex = 0;
%>
<script type="text/javascript">
//避免重复执行脚本
var isAdd2ParentHtml = true;

function add2ParentHtml(iframeName, tagName, module, relationInfoName, relationInfoHref, relationInfoId){
    if(isAdd2ParentHtml){
        var parentCon = parent.document.getElementById(tagName).innerHTML;
        parentCon += "<div id="+module+relationInfoId+"><input type=\"hidden\" name=\""+module+"RelationName\" value=\""+relationInfoName+"\">";
        parentCon += "<input type=\"hidden\" name=\""+module+"RelationHref\" value=\""+relationInfoHref+"\">";
        parentCon += "<input type=\"hidden\" name=\""+module+"RelationId\" value=\""+relationInfoId+"\"></div>";
        parent.document.getElementById(tagName).innerHTML=parentCon;
        //parent.document.getElementById(iframeName).height=parseInt(parent.document.getElementById(iframeName).height)+30;
    }
}

function deleteRelationDataId(tagName, module, delDataIds){
    if(isAdd2ParentHtml){
        var parentCon = parent.document.getElementById(tagName).innerHTML;
        parentCon += "<input name=\""+module+"DeleteRelationDataId\" type=\"hidden\" value=\""+delDataIds+"\">";
        parent.document.getElementById(tagName).innerHTML=parentCon;
    }
}
</script>
<input name="relation_iframeName" id="relation_iframeName" type="hidden" value="<%=iframeName%>">
<input name="relation_tagName" id="relation_tagName" type="hidden" value="<%=tagName%>">
<input name="relation_moduleType" id="relation_moduleType" type="hidden" value="<%=moduleType%>">
<input name="relation_infoId" id="relation_infoId" type="hidden" value="<%=infoId%>">
<input name="isRelationadd" id="isRelationadd" type="hidden" value="<%=isRelationadd%>">
<div class="templateBox">
    <fieldset  class="templateBoxline">
        <legend class="templateTitle">关联性</legend>
        <div class="templateContent">
            <div class="relationObjDiv_outter" id="col0"></div>
            <div class="relationObjDiv_outter" id="col1"></div>

<%if(relationObjType.indexOf("flow")!=-1){%>
            <div class="relationObjDiv" dIndex="<%=dIndex++%>">
                <%if(!isRelationadd){%><a href="JavaScript:void(0);" onclick="seelinkflow('<%=infoId%>');"><%}%><strong>相关流程</strong><%if(!isRelationadd){%></a><%}%><font color=red>(<span id='span_flow'><%=flownum%></span>)</font>
                <%if(!isRelationview){%>
                <button class="btnButton4font" onclick="linkflow('<%=infoId%>')">关　联</button>
                <%--button class="btnButton4font" onclick="addflow('<%=infoId%>')">新建</button--%>
                <%}%>
                <div id="flow" class="dataDiv">
                <%
                delDataIds = "";
                if(flowList != null){
                    for(int i=0,ilen=flowList.size(); i<ilen; i++){
                        if(i==8) break;
                        Object[] _list = (Object[]) flowList.get(i);
                        String relationInfoName = (String) _list[0];
                        String relationInfoId = (String) _list[1];
                        String relationInfoHref = ((String) _list[2])+"&fromdesktop=2";
                        String dataId = (String) _list[5];
                        if(!"1".equals(isNewRelation)){
                            delDataIds += dataId+",";
                        }
                        %>
                        <script>
                            add2ParentHtml('<%=iframeName%>', '<%=tagName%>', 'flow', '<%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%>', '<%=relationInfoHref%>', '<%=relationInfoId%>');
                        </script>
                        <div id="<%=relationInfoId%>">&nbsp;&nbsp;<a href="javascript:void(0);" onclick="javascript:void(0);hasworkFlow('<%=relationInfoId%>','<%=relationInfoHref%>')"><%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%></a><%if(!"1".equals(relationview)){%><img border="0" src="<%=rootPath%>/images/del.gif" style="cursor:pointer" alt="删除" onclick="deleteInfo(<%=relationInfoId%>,'flow');" ><%}%>
                        </div>
                    <%}%>
                <%}%>
                </div>
                <script>
                    deleteRelationDataId('<%=tagName%>', 'flow', '<%=delDataIds%>');
                </script>
            </div>
<%}%>

<%if(relationObjType.indexOf("forum")!=-1){%>
            <div class="relationObjDiv" dIndex="<%=dIndex++%>">
                <%if(!isRelationadd){%><a href="JavaScript:void(0);" onclick="seelinkforum('<%=infoId%>')"><%}%><strong>相关讨论</strong><%if(!isRelationadd){%></a><%}%><font color=red>(<span id='span_forum'><%=forumnum%></span>)</font>
                <%if(!isRelationview){%>
                    <button class="btnButton4font" onclick="linkforum('<%=infoId%>')">关　联</button>
                    <button class="btnButton4font" onclick="addforum('<%=infoId%>')">新　建</button>
                <%}%>
                <div id="forum" class="dataDiv">
                <%
                delDataIds = "";
                if(forumList != null){
                    for(int i=0,ilen=forumList.size(); i<ilen; i++){
                        if(i==8) break;
                        Object[] _list = (Object[]) forumList.get(i);
                        String relationInfoName = (String) _list[0];
                        String relationInfoId = (String) _list[1];
                        String relationInfoHref = (String) _list[2];
                        String dataId = (String) _list[5];
                        if(!"1".equals(isNewRelation)){
                            delDataIds += dataId+",";
                        }
                        %>
                        <script>
                            add2ParentHtml('<%=iframeName%>', '<%=tagName%>', 'forum', '<%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%>', '<%=relationInfoHref%>', '<%=relationInfoId%>');
                        </script>
                        <div id="<%=relationInfoId%>">&nbsp;&nbsp;<a href="javascript:void(0);" onclick="getHasInfo('<%=relationInfoId%>','forum','<%=relationInfoHref%>','讨论');"><%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%></a><%if(!"1".equals(relationview)){%><img border="0" src="<%=rootPath%>/images/del.gif" style="cursor:pointer" alt="删除" onclick="deleteInfo(<%=relationInfoId%>,'forum');" ><%}%>
                        </div>
                    <%}%>                
                <%}%>
                </div>
                <script>
                    deleteRelationDataId('<%=tagName%>', 'forum', '<%=delDataIds%>');
                </script>
            </div>
<%}%>

<%if(relationObjType.indexOf("project")!=-1){%>
            <div class="relationObjDiv" dIndex="<%=dIndex++%>">
                <%if(!isRelationadd){%><a href="JavaScript:void(0);" onclick="seelinkproject('<%=infoId%>')"><%}%><strong>相关项目</strong><%if(!isRelationadd){%></a><%}%><font color=red>(<span id='span_project'><%=projectnum%></span>)</font>
                <%if(!isRelationview){%>
                    <button class="btnButton4font" onclick="linkproject('<%=infoId%>')">关　联</button>
                    <%--button class="btnButton4font" onclick="addproject('<%=infoId%>')">新建</button--%>
                <%}%>
                <div id="project" class="dataDiv">
                <%
                delDataIds = "";
                if(projectList != null){
                    for(int i=0,ilen=projectList.size(); i<ilen; i++){
                        if(i==8) break;
                        Object[] _list = (Object[]) projectList.get(i);
                        String relationInfoName = (String) _list[0];
                        String relationInfoId = (String) _list[1];
                        String relationInfoHref = (String) _list[2];
                        if(relationInfoHref != null && relationInfoHref.indexOf("verifyCode") == -1){
                            relationInfoHref += "&verifyCode=" + encutil.getSysEncoderKeyVlaue("projectId", relationInfoId, "ProjectAction");
                        }
                        String dataId = (String) _list[5];
                        if(!"1".equals(isNewRelation)){
                            delDataIds += dataId+",";
                        }
                        %>
                        <script>
                            add2ParentHtml('<%=iframeName%>', '<%=tagName%>', 'project', '<%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%>', '<%=relationInfoHref%>', '<%=relationInfoId%>');
                        </script>
                        <div id="<%=relationInfoId%>">&nbsp;&nbsp;<a href="javascript:void(0);" onclick="getHasInfo('<%=relationInfoId%>','project','<%=relationInfoHref%>','项目');"><%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%></a><%if(!"1".equals(relationview)){%><img border="0" src="<%=rootPath%>/images/del.gif" style="cursor:pointer" alt="删除" onclick="deleteInfo(<%=relationInfoId%>,'project');" ><%}%>
                        </div>
                    <%}%>
                <%}%>
                </div>
                <script>
                    deleteRelationDataId('<%=tagName%>', 'project', '<%=delDataIds%>');
                </script>
            </div>
<%}%>

<%if(relationObjType.indexOf("information")!=-1){%>
            <div class="relationObjDiv" dIndex="<%=dIndex++%>">
                <%if(!isRelationadd){%><a href="JavaScript:void(0);" onclick="seelinkinformation('<%=infoId%>')"><%}%><strong>相关信息</strong><%if(!isRelationadd){%></a><%}%><font color=red>(<span id='span_information'><%=informationnum%></span>)</font>
                <%if(!isRelationview){%>
                    <button class="btnButton4font" onclick="linkinformation('<%=infoId%>')">关　联</button>
                    <button class="btnButton4font" onclick="addinformation('<%=infoId%>')">新　建</button>
                <%}%>
                <div id="information" class="dataDiv">
                <%
                delDataIds = "";
                if(informationList != null){
                    for(int i=0,ilen=informationList.size(); i<ilen; i++){
                        if(i==8) break;
                        Object[] _list = (Object[]) informationList.get(i);
                        String relationInfoName = (String) _list[0];
                        String relationInfoId = (String) _list[1];
                        String relationInfoHref = (String) _list[2];
                        String dataId = (String) _list[5];
                        if(!"1".equals(isNewRelation)){
                            delDataIds += dataId+",";
                        }
                        %>
                        <script>
                            add2ParentHtml('<%=iframeName%>', '<%=tagName%>', 'information', '<%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%>', '<%=relationInfoHref%>', '<%=relationInfoId%>');
                        </script>
                        <div id="<%=relationInfoId%>">&nbsp;&nbsp;<a href="javascript:void(0);" onclick="getHasInfo('<%=relationInfoId%>','information','<%=relationInfoHref%>','信息');"><%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%></a><%if(!"1".equals(relationview)){%><img border="0" src="<%=rootPath%>/images/del.gif" style="cursor:pointer" alt="删除" onclick="deleteInfo(<%=relationInfoId%>,'information');" ><%}%>
                        </div>
                    <%}%>
                <%}%>
                </div>
                <script>
                    deleteRelationDataId('<%=tagName%>', 'information', '<%=delDataIds%>');
                </script>
            </div>
<%}%>

<%if(relationObjType.indexOf("contract")!=-1){%>
            <div class="relationObjDiv" dIndex="<%=dIndex++%>">
                <%if(!isRelationadd){%><a href="JavaScript:void(0);" onclick="seelinkcontract('<%=infoId%>');"><%}%><strong>相关合同</strong><%if(!isRelationadd){%></a><%}%><font color=red>(<span id='span_contract'><%=contractnum%></span>)</font>
                <%if(!isRelationview){%>
                    <button class="btnButton4font" onclick="linkcontract('<%=infoId%>')">关　联</button>
                <%}%>
                <div id="contract" class="dataDiv">
                <%
                delDataIds = "";
                if(contractList != null){
                    for(int i=0,ilen=contractList.size(); i<ilen; i++){
                        if(i==8) break;
                        Object[] _list = (Object[]) contractList.get(i);
                        String relationInfoName = (String) _list[0];
                        String relationInfoId = (String) _list[1];
                        String relationInfoHref = (String) _list[2];
                        String dataId = (String) _list[5];
                        if(!"1".equals(isNewRelation)){
                           delDataIds += dataId+",";
                        }
                        %>
                        <script>
                            add2ParentHtml('<%=iframeName%>', '<%=tagName%>', 'contract', '<%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%>', '<%=relationInfoHref%>', '<%=relationInfoId%>');
                        </script>
                        <div id="<%=relationInfoId%>">&nbsp;&nbsp;<a href="JavaScript:void(0);" onclick="getHasInfo('<%=relationInfoId%>','contract','<%=relationInfoHref%>','合同');"><%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%></a><%if(!"1".equals(relationview)){%><img border="0" src="<%=rootPath%>/images/del.gif" style="cursor:pointer" alt="删除" onclick="deleteInfo(<%=relationInfoId%>,'contract');" ><%}%>
                        </div>
                    <%}%>
                <%}%>
                </div>
                <script>
                    deleteRelationDataId('<%=tagName%>', 'contract', '<%=delDataIds%>');
                </script>
            </div>
<%}%>

<%if(relationObjType.indexOf("person")!=-1){%>
            <div class="relationObjDiv" dIndex="<%=dIndex++%>">
                <%if(!isRelationadd){%><a href="JavaScript:void(0);" onclick="seelinkperson('<%=infoId%>');"><%}%><strong>公共联系人</strong><%if(!isRelationadd){%></a><%}%><font color=red>(<span id='span_person'><%=personnum%></span>)</font>
                <%if(!isRelationview){%>
                    <button class="btnButton4font" onclick="linkperson('<%=infoId%>')">关　联</button>
                    <%if (mbd.hasRight(CommonUtils.getSessionUserId(request).toString(), "08*02")&&mbd.hasRight(CommonUtils.getSessionUserId(request).toString(), "08*01*02")) {%>
                    <button class="btnButton4font" onclick="addperson('<%=infoId%>')">新　建</button>
                    <%}%>
                <%}%>
                <div id="person" class="dataDiv">
                <%
                delDataIds = "";
                if(personList != null){
                    for(int i=0,ilen=personList.size(); i<ilen; i++){
                        if(i==8) break;
                        Object[] _list = (Object[]) personList.get(i);
                        String relationInfoName = (String) _list[0];
                        String relationInfoId = (String) _list[1];
                        String relationInfoHref = (String) _list[2];
                        String dataId = (String) _list[5];
                        if(!"1".equals(isNewRelation)){
                            delDataIds += dataId+",";
                        }
                        %>
                        <script>
                            add2ParentHtml('<%=iframeName%>', '<%=tagName%>', 'person', '<%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%>', '<%=relationInfoHref%>', '<%=relationInfoId%>');
                        </script>
                        <div id="<%=relationInfoId%>">&nbsp;&nbsp;<a href="javascript:void(0);" onclick="getHasInfo('<%=relationInfoId%>','person','<%=relationInfoHref%>','公共联系人');"><%=relationInfoName.replaceAll("<","&lt;").replaceAll(">","&gt;")%></a><%if(!"1".equals(relationview)){%><img border="0" src="<%=rootPath%>/images/del.gif" style="cursor:pointer" alt="删除" onclick="deleteInfo(<%=relationInfoId%>,'person');" ><%}%>
                        </div>
                    <%}%>
                <%}%>
                </div>
                <script>
                    deleteRelationDataId('<%=tagName%>', 'person', '<%=delDataIds%>');
                </script>
            </div>
<%}%>

        </div>
    </fieldset>
</div>
</body>
</html>
<script src="<%=rootPath%>/public/relation/relation.js" language="javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
$(document).ready(function(){			
	loadRelationInit();

	//background:none repeat scroll 0% 0% rgb(247, 247, 247);
	<%if(moduleType != null && !moduleType.startsWith("customdb_")){%>
	if($('.Pupwin', parent.document).length > 0){
		$(document.body).css('background', 'none repeat scroll 0% 0% rgb(247, 247, 247)');		
	}
	if($.browser.msie){
		$(document.body).css('background-color', '#F7F7F7');
	}
	<%}%>
});
//-->
</SCRIPT>