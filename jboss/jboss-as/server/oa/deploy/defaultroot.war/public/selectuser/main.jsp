<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.manager.bd.ManagerBD" %>
<%@ page import="com.whir.component.config.ConfigXMLReader" %>
<%
int dialogWidth = Integer.parseInt(request.getParameter("dialogWidth")!=null?request.getParameter("dialogWidth"):"800");
int dialogHeight = Integer.parseInt(request.getParameter("dialogHeight")!=null?request.getParameter("dialogHeight"):"600");
String showUnitOrg = request.getParameter("showUnitOrg")!=null?request.getParameter("showUnitOrg"):"1";//默认显示
String showPersonalGroup = request.getParameter("showPersonalGroup");
String tagitId = request.getParameter("tagitId")!=null?request.getParameter("tagitId"):"";
String range = (String)request.getAttribute("range");
String selfUnitId = (String)request.getAttribute("selfUnitId");
ConfigXMLReader reader = new ConfigXMLReader();
String orgTreeSetting_expand = reader.getAttribute("OrgTreeSetting", "expand");
String ogp = request.getParameter("ogp")!=null?request.getParameter("ogp"):"";
if(ogp.toLowerCase().indexOf("alert(")!=-1 || ogp.indexOf(" ")!=-1 || ogp.indexOf("\"")!=-1){
    ogp = "";
}
String showShortcut = request.getParameter("showShortcut")!=null?request.getParameter("showShortcut"):"";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:text name="obj.selectorguser"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%
    whir_custom_str="My97DatePicker,easyui";
    %>
	<%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <%@ include file="/public/im/onlinejs.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/ObjectResource.js" type="text/javascript"></script>
    <link   href="<%=rootPath%>/scripts/plugins/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
    <script src="<%=rootPath%>/scripts/plugins/zTree/js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/main/whir.selectuser.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE="JavaScript">
    <!--
        var api = null,  W = null;
        var winModalDialog = '<%=request.getParameter("winModalDialog")%>';       
        if(window.dialogArguments && window.dialogArguments._winModalDialog == 1) {//1-表示window.showModalDialog打开，否则-表示弹出层方式打开 
            W = window.dialogArguments;
        }else{
            api = frameElement.api; 
            W = api.opener;
            if(api.config['parentDialogId']) W = api.get(api.config['parentDialogId']);
        }

        var p_allowId = '<s:property value="allowId"/>';
        var p_allowName = '<s:property value="allowName"/>';
        var selectedId_old = "";
        var selectedName_old = "";
        var selectedName_old_maxlength = -1;
        var isLoadOrg = false;

        function _online(accounts){
            try{
                online(accounts);
            }catch(e){};
        }

        function fixedSurface(){
            if(isSurface()){//fixed 出现双滚动条
                $('#dataDiv').css('height', '<%=dialogHeight-300%>px');
                $('#dataGrid').parent().css('overflow-y', 'hidden');
            }
        }
    //-->
    </SCRIPT>
    <style type="text/css">
        .bodyMainFrameBox{
            height:100%; 
            overflow:hidden;
            overflow-y:auto;
            overflow-y:hidden\0; 
            +overflow:hidden;
            _overflow:hidden;
        }
        .textareaInput {/*position:absolute; bottom:37px;*/margin-left:5px;}
        .bottomBtn {/*position:absolute; bottom:3px;*/padding-left:5px;}
        /*.clsHeightFixed {height:30px;line-height:30px;}
        .clsHeightFixed ul {height:30px;line-height:30px;}
        .clsHeightFixed ul li{height:30px;line-height:30px;}*/
        .Public_tag {height:30px;line-height:30px;}
        .Public_tag ul li,.Public_tag ul li .tag_center,.Public_tag ul li .tag_right {height:30px;line-height:30px;}
        .Public_tag ul li.tag_aon,.Public_tag ul li.tag_aon .tag_center,.Public_tag ul li.tag_aon .tag_right {height:30px;line-height:30px;}
    </style>
    <!--[if lte IE 7]>
    <style type="text/css">
        .bodyMainFrameBox table{width:99%; *width:99%; margin:0 auto;}
        .textareaInput {position:absolute; bottom:20px;margin-left:3px;}
        .bottomBtn {position:absolute; bottom:0px;padding-left:6px;}
    </style>
    <![endif]-->
</head>
<body class="bodyMainFrameBox">
    <!-- SEARCH PART START -->
    <%
        boolean isReHeight = true;
        String _include_jsp = "";
        String select = request.getParameter("select")!=null?request.getParameter("select"):"";
        String show   = request.getParameter("show")!=null?request.getParameter("show"):"";
        String single = request.getParameter("single")!=null?request.getParameter("single"):"";
        if(select.toLowerCase().indexOf("alert(")!=-1 || select.indexOf(" ")!=-1 || select.indexOf("\"")!=-1){
            select = "";
        }
        if(show.toLowerCase().indexOf("alert(")!=-1 || show.indexOf(" ")!=-1 || show.indexOf("\"")!=-1){
            show = "";
        }
        if(single.toLowerCase().indexOf("alert(")!=-1 || single.indexOf(" ")!=-1 || single.indexOf("\"")!=-1){
            single = "";
        }
        boolean isShowOrg = false;//显示组织页签
        boolean isShowGroup = false;//显示群组页签
        boolean isShowShortcut = false;//显示快捷页签
        boolean isShowUnitOrg = true;//显示本组织单位
        if(show.indexOf("org")!=-1){
            isShowOrg = true;
            isShowShortcut = true;
        }
        if(show.indexOf("user")!=-1){
            isShowOrg = true;
            isShowShortcut = true;
        }
        if(show.indexOf("group")!=-1){
            isShowGroup = true;
            isShowShortcut = true;
        }

        //选择范围不显示快捷
        if(range != null && !"".equals(range) && !"null".equals(range) && !"0".equals(range) && !"*0*".equals(range)){
            isShowShortcut = false;
            if(range.indexOf("@")!=-1 && range.indexOf("*")==-1 && range.indexOf("$")==-1){
                isShowShortcut = true;
            }

            isShowShortcut = true;

            if(range.indexOf("@")==-1){
                isShowGroup = false;
            }

            if(range.indexOf("*")==-1){
                //isShowOrg = false;
                isShowUnitOrg = false;
            }
        }

        if("org".equals(show)){
            _include_jsp = "/public/selectuser/include_org_condition.jsp";
        }else if("group".equals(show)){
            _include_jsp = "/public/selectuser/include_group_condition.jsp";
        }else{
            if(show.indexOf("user")>=0){
                isReHeight = false;
                _include_jsp = "/public/selectuser/include_user_condition.jsp";
            }else if(show.indexOf("org")>=0){
                _include_jsp = "/public/selectuser/include_org_condition.jsp";
            }else if(show.indexOf("org")>=0){
                _include_jsp = "/public/selectuser/include_group_condition.jsp";
            }
        }

        //不显示快捷
        if("0".equals(showShortcut)){
            isShowShortcut = false;
            isShowUnitOrg = false;
        }

        if(isShowUnitOrg){
            if(!"1".equals(showUnitOrg)){
                isShowUnitOrg = false;//不显示
            }
        }
    %>

    <jsp:include page="<%=_include_jsp%>" flush="true">
		<jsp:param name="flag" value=""/>
	</jsp:include>

    <!-- SEARCH PART END -->

    <div style="width:100%;height:100px;">
    <table width="100%" height="100%" border="0" cellpadding="1" cellspacing="1">
        <tr>
            <td valign="top" rowspan=2>
                <div class="whir_public_movebg">
                    <!--页签-->
                    <div class="Public_tag Public_tag_all">
                        <ul id="whir_tab_ul">
                            <%
                                if(isShowOrg){
                            %>
                            <li class="tag_aon" whir-options="{target:'tab0', onclick:loadOrg}"><span class="tag_center"><s:text name="obj.org"/></span><span class="tag_right"></span>
                            </li>
                            <%}%>

                            <%
                                if(isShowGroup){
                            %>
                            <li <%=isShowOrg==false?"class=\"tag_aon\"":""%> whir-options="{target:'tab1', onclick:loadGroup}"><span class="tag_center"><s:text name="obj.group"/></span><span class="tag_right"></span>
                            </li>
                            <%}%>

                            <%
                                if(isShowShortcut){
                            %>
                            <li <%=isShowOrg==false && isShowGroup==false?"class=\"tag_aon\"":""%> whir-options="{target:'tab2', onclick:loadShortcut}"><span class="tag_center"><s:text name="obj.shortcut"/></span><span class="tag_right"></span>
                            </li>
                            <%}%>
                        </ul>
                    </div>
                </div>
                <div class="whir_clear"></div>
<%if(isShowOrg){%><!--组织-->
                <div id="tab0" class="grayline">
                    <div style="width:230px;height:<%=dialogHeight-210%>px;overflow-x:auto;overflow-y:auto;" class="hdiv">
                    <div style="padding:3px;height:30px;"><input type="text" name="searchOrgNameTree" maxlength="16" value="" id="searchOrgNameTree" class="inputText" style="width:88%;"/><img id="searchOrgNameTreeImg" src="<%=rootPath%>/images/look.gif" style="vertical-align: middle;cursor:pointer;padding-left:3px;"></div>
                    <div style="border:1px;padding:5px 0 0 10px;display:inline;"><a href="javascript:void(0);" onclick="loadAllOrg(false);"><s:text name="obj.allorg"/></a></div>
                    <ul id="treeOrg" class="ztree"></ul>
                    <SCRIPT type="text/javascript">
                        <!--
                        $('#searchOrgNameTree').keydown(function(event){
                            searchOrgTreeAjax(event);
                        });
                        $('#searchOrgNameTreeImg').click(function(event){
                            searchOrgTreeAjax(null);
                        });

                        var lazyOrg = false;
                        var settingOrg = {
                            view: {
                                showIcon: false,
                                fontCss : {color:"#0055ad"}
                            },
                            async: {
                                enable: true,
                                url:"<%=rootPath%>/SelectOrgAndUser!filterOrgTree.action",
                                autoParam:["parentOrgId"],
                                otherParam:{"select":$('#select').val(), "single":$('#single').val(), "show":$('#show').val(), "range":$('#range').val(), "currentOrgId":$('currentOrgId').val(), "limited":$('#limited').val(), "fromModule":$('#fromModule').val(), "key":$('#key').val(), "scopeType":$('#scopeType').val()}
                            },
                            callback: {
                                //onExpand:onExpandOrg,
                                onClick: onClickOrg,
                                onAsyncSuccess: zTreeOnAsyncSuccess
                                
                            },
                            dataFilter: filterOrg
                        };

                        function onClickOrg(event, treeId, treeNode, clickFlag) {
                            if(treeNode.type=='otheruser'){//选择其它
                                $.ajax({
                                    type: 'post',
                                    url: "<%=rootPath%>/SelectOrgAndUser!otherUser.action",
                                    cache: false,
                                    async: false,
                                    data: "otherDepart=-1&fromModule="+$('#fromModule').val()+"&orgId="+treeNode.id+"&currentOrgId=&orgSerial="+treeNode.serial+"&orgName="+encodeURIComponent(treeNode.name)+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&parentOrgId="+treeNode.id+"&fromParent="+$('#fromParent').val()+"&range="+$('#range').val()+"&scopeType="+$('#scopeType').val(),
                                    dataType: "html",
                                    success: function(content) {
                                        $('#dataGrid').html(content);
                                        loadState("1");
                                    }
                                });
                            }else if(treeNode.isCanLink){
                                $.ajax({
                                    type: 'post',
                                    url: "<%=rootPath%>/SelectOrgAndUser!<%="org".equals(show) || show.indexOf("user")==-1?"getOrgList":"getOrgUserList"%>.action",
                                    cache: false,
                                    async: false,
                                    data: "otherDepart=-1&fromModule="+$('#fromModule').val()+"&orgId="+treeNode.id+"&currentOrgId=&orgSerial="+treeNode.serial+"&orgName="+encodeURIComponent(treeNode.name)+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&parentOrgId="+treeNode.id+"&fromParent="+$('#fromParent').val()+"&range="+$('#range').val()+"&scopeType="+$('#scopeType').val()+"&ogp=<%=ogp%>",
                                    dataType: "html",
                                    success: function(content) {
                                        $('#dataGrid').html(content);
                                        loadState("1");
                                        fixedSurface();
                                    }
                                });
                            }
                        }

                        function filterOrg(treeId, parentNode, childNodes) {
                            if (!childNodes) return null;
                            for (var i=0, l=childNodes.length; i<l; i++) {
                                childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
                            }
                            return childNodes;
                        }

                        //无子节点则取消parent身份，不显示空白.
                        function onExpandOrg(event, treeId, treeNode, clickFlag) {	
                            var zTree = $.fn.zTree.getZTreeObj("treeOrg");
                            var b = treeNode.children!=undefined && treeNode.children!='undefined' && treeNode.children!=null && treeNode.children!='' ;
                            if(!b){
                                zTree.expandNode(treeNode, false, null, null, null);
                                treeNode.isParent = false;
                                zTree.updateNode(treeNode,false);
                            }			
                        }

                        //默认展开一级组织
                        var loadFirstLevel = false;

                        function isLoadFirstLevel(){
                            return loadFirstLevel
                        }

                        function setLoadFirstLevel(flag){
                            loadFirstLevel = flag;
                        }

                        function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
                            <%if("1".equals(orgTreeSetting_expand)){%>
                            if(isLoadFirstLevel()){
                                setLoadFirstLevel(false);

                                //alert(msg);
                                var zTreeObj = $.fn.zTree.getZTreeObj("treeOrg");

                                //默认展开一级组织
                                var nIndex = 1;
                                while(true){
                                    var treeNode = zTreeObj.getNodeByTId("treeOrg_"+nIndex);
                                    if(treeNode){
                                        zTreeObj.expandNode(treeNode, true, false, false);
                                    }else{
                                        break;
                                    }
                                    nIndex++;
                                }
                            }
                            <%}%>
                        }

                        function loadOrg(){
                            //默认展开一级组织,PAD不展开、国产化不展开
                            if(isPad()==false && checkCOS()==false)setLoadFirstLevel(true);

                            //if(lazyOrg == false){
                            var zTreeObj = $.fn.zTree.init($("#treeOrg"), settingOrg);
                                lazyOrg = true;
                            //}

                            loadAllOrg(false);
                        }

                        function loadAllOrg(lazy){
                            $.ajax({
                                type: 'post',
                                url: "<%=rootPath%>/SelectOrgAndUser!<%="org".equals(show) || show.indexOf("user")==-1?"getOrgList":"getOrgUserList"%>.action",
                                cache: false,
                                data: "otherDepart=-1&fromModule="+$('#fromModule').val()+"&orgId=0&currentOrgId=&orgSerial=&orgName=全部组织&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&parentOrgId=0&fromParent="+$('#fromParent').val()+"&range="+$('#range').val(),
                                dataType: "html",
                                success: function(content) {
                                    $('#dataGrid').html(content);
                                    loadState("1");
                                    isLoadOrg = true;
                                    fixedSurface();
                                }
                            });
                        }

                        //已选择用户
                        function _loadStateSelectedUser(){
                            loadState("1");
                            $('#pager_desc').hide();//由于选择组织用户页面较小，翻页信息不能正常显示，隐藏总页数、总记录数信息。
                        }

                        function loadSelectedUser(lazy){
                            $.ajax({
                                type: 'post',
                                url: "<%=rootPath%>/SelectOrgAndUser!selectedUser.action",
                                cache: false,
                                data: "otherDepart=-1&fromModule="+$('#fromModule').val()+"&orgId=0&currentOrgId=&orgSerial=&orgName=全部组织&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&parentOrgId=0&fromParent="+$('#fromParent').val()+"&range="+$('#range').val()+"&selectedUserId="+$.trim(W.document.getElementById(p_allowId).value),
                                dataType: "html",
                                success: function(content) {
                                    $('#dataGrid').html(content);
                                    initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:_loadStateSelectedUser});
                                }
                            });
                        }

                        function loadSelected(){
                            //默认展开一级组织,PAD不展开
                            if(isPad()==false)setLoadFirstLevel(true);

                            //if(lazyOrg == false){
                            var zTreeObj = $.fn.zTree.init($("#treeOrg"), settingOrg);
                                lazyOrg = true;
                            //}
                            
                            loadSelectedUser(false);
                        }

                        $(document).ready(function(){                            
                            <%//if("user".equals(select)){%>
                                var selectedUserId_ = $.trim(W.document.getElementById(p_allowId).value);
                                if(selectedUserId_ != '' && selectedUserId_.indexOf('$') != -1){
                                    loadSelected();
                                }else{
                                    loadOrg();
                                }
                            <%//}else{%>
                                //loadOrg();
                            <%//}%>
                        });
                        //-->
                    </SCRIPT>
                    </div>
                </div>
<%}%>

<%if(isShowGroup){%><!--群组-->
                <div id="tab1" class="grayline" style="display:<%="group".equals(show)||!isShowOrg?"":"none"%>">
                    <div style="width:230px;height:<%=dialogHeight-210%>px;overflow-x:auto;overflow-y:auto;" class="hdiv">
                    <div style="padding:3px;height:30px;"><input type="text" name="searchGroupNameTree" maxlength="16" value="" id="searchGroupNameTree" class="inputText" style="width:88%;"/><img id="searchGroupNameTreeImg" src="<%=rootPath%>/images/look.gif" style="vertical-align: middle;cursor:pointer;padding-left:3px;"></div>
                    <ul id="treeGroup" class="ztree"></ul>
                    <SCRIPT type="text/javascript">
                        <!--
                        $('#searchGroupNameTree').keydown(function(event){
                            searchGroupNameTreeAjax(event);
                        });
                        $('#searchGroupNameTreeImg').click(function(event){
                            searchGroupNameTreeAjax(null);
                        });

                        var lazyGroup = false;
                        var settingGroup = {
                            view: {
                                showIcon: false,
                                fontCss : {color:"#0055ad"}
                            },
                            async: {
                                enable: true,
                                url:"<%=rootPath%>/SelectOrgAndUser!filterGroupTree.action",
                                autoParam:["groupClassId"],
                                otherParam:{"select":$('#select').val(), "single":$('#single').val(), "show":$('#show').val(), "range":$('#range').val(), "currentOrgId":$('currentOrgId').val(), "limited":$('#limited').val(), "fromModule":$('#fromModule').val(), "key":$('#key').val(), "groupType":0}
                            },
                            callback: {
                                //onExpand:onExpandGroup,
                                onClick: onClickGroup,
                                onAsyncSuccess: zTreeOnAsyncSuccessGroup //默认展开群组分类
                                
                            },
                            dataFilter: filterGroup
                        };

                        function onClickGroup(event, treeId, treeNode, clickFlag) {
                            if(treeNode.serial){
                                $.ajax({
                                    type: 'post',
                                    url: "<%=rootPath%>/SelectOrgAndUser!<%=show.indexOf("user")!=-1?"getGroupUserList":"getGroupUserList"%>.action",
                                    cache: false,
                                    async: false,
                                    data: "fromModule="+$('#fromModule').val()+"&groupType=0&currentOrgId=<%=session.getAttribute("orgId").toString()%>&range="+$('#range').val()+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&groupId="+treeNode.id+"&groupName="+encodeURIComponent(treeNode.name)+"&groupCode="+treeNode.serial+"&range="+$('#range').val(),
                                    dataType: "html",
                                    success: function(content) {
                                        $('#dataGrid').html(content);
                                        loadState("3");
                                    }
                                });
                            }
                        }

                        function filterGroup(treeId, parentNode, childNodes) {
                            if (!childNodes) return null;
                            for (var i=0, l=childNodes.length; i<l; i++) {
                                childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
                            }
                            return childNodes;
                        }

                        //无子节点则取消parent身份，不显示空白.
                        function onExpandGroup(event, treeId, treeNode, clickFlag) {	
                            var zTree = $.fn.zTree.getZTreeObj("treeGroup");
                            var b = treeNode.children!=undefined && treeNode.children!='undefined' && treeNode.children!=null && treeNode.children!='' ;
                            if(!b){
                                zTree.expandNode(treeNode, false, null, null, null);
                                treeNode.isParent = false;
                                zTree.updateNode(treeNode,false);
                            }			
                        }

                        //默认展开群组分类-start
                        var loadFirstLevelGroup = false;

                        function isLoadFirstLevelGroup(){
                            return loadFirstLevelGroup
                        }

                        function setLoadFirstLevelGroup(flag){
                            loadFirstLevelGroup = flag;
                        }

                        function zTreeOnAsyncSuccessGroup(event, treeId, treeNode, msg) {
                            if(isLoadFirstLevelGroup()){
                                setLoadFirstLevelGroup(false);

                                //alert(msg);
                                var zTreeObj = $.fn.zTree.getZTreeObj("treeGroup");

                                //默认展开群组分类
                                var nIndex = 1;
                                while(true){
                                    var treeNode = zTreeObj.getNodeByTId("treeGroup_"+nIndex);
                                    if(treeNode){
                                        zTreeObj.expandNode(treeNode, true, false, false);
                                    }else{
                                        break;
                                    }
                                    nIndex++;
                                }
                            }
                        }
                        //默认展开群组分类-end

                        function loadGroup(){
                            //默认展开群组分类,PAD不展开
                            if(isPad()==false)setLoadFirstLevelGroup(true);

                            //if(lazyGroup == false){
                                $.fn.zTree.init($("#treeGroup"), settingGroup);
                                lazyGroup = true;

                                loadPublicGroup();
                            //}
                        }

                        function loadPublicGroup(){
                            $.ajax({
                                type: 'post',
                                url: "<%=rootPath%>/SelectOrgAndUser!getGroupList.action",
                                cache: false,
                                async: false,
                                data: "fromModule="+$('#fromModule').val()+"&groupType=0&currentOrgId=<%=session.getAttribute("orgId").toString()%>&range="+$('#range').val()+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&range="+$('#range').val()+"<%="user".equals(select)?"&notshowgrouplist=1":""%>",
                                dataType: "html",
                                success: function(content) {
                                    $('#dataGrid').html(content);
                                    loadState("3");
                                }
                            });
                        }

<%if("group".equals(show) || !isShowOrg){%>
                        $(document).ready(function(){
                            loadGroup();                            
                        });
<%}%>
                        //-->  
                    </SCRIPT>
                    </div>
                </div>
<%}%>
                <!--快捷-->                
                <div id="tab2" class="grayline" style="display:<%=isShowOrg==false && isShowGroup==false?"":"none"%>">
                    <div style="width:230px;height:<%=dialogHeight-210%>px;overflow-x:auto;overflow-y:auto;" class="hdiv">
                    <ul id="treeShortcut" class="ztree"></ul>
                    <ul id="treeShortcutGroup" class="ztree" style="padding-top:0px;"></ul>
                    <ul id="treeShortcutSelfUnit" class="ztree" style="padding-top:0px;"></ul>
                    <SCRIPT type="text/javascript">
                        <!--
<%if(isShowShortcut && isShowOrg){%>
                        //当前组织
                        var lazyShortcut = false;
                        var settingShortcut = {
                            view: {
                                showIcon: false,
                                fontCss : {color:"#0055ad"}
                            },
                            async: {
                                enable: true,
                                url:"<%=rootPath%>/SelectOrgAndUser!filterOrgTree.action",
                                autoParam:["parentOrgId"],
                                otherParam:{"select":$('#select').val(), "single":$('#single').val(), "show":$('#show').val(), "range":$('#range').val(), "currentOrgId":$('currentOrgId').val(), "limited":$('#limited').val(), "fromModule":$('#fromModule').val(), "key":$('#key').val(), "isShortcut":1, "scopeType":$('#scopeType').val()}
                            },
                            callback: {
                                //onExpand:onExpandShortcut,
                                onClick: onClickShortcut
                                
                            },
                            dataFilter: filterShortcut
                        };

                        function onClickShortcut(event, treeId, treeNode, clickFlag) {
                            //取消节点的选中状态
                            var treeObj = $.fn.zTree.getZTreeObj("treeShortcutGroup");
                            try{treeObj.cancelSelectedNode();}catch(e){}
                            if(treeNode.id != '<%=session.getAttribute("orgId").toString()%>') return false;

                            if(treeNode.isCanLink){
                                $.ajax({
                                    type: 'post',
                                    url: "<%=rootPath%>/SelectOrgAndUser!<%="org".equals(show) || show.indexOf("user")==-1?"getOrgList":"getOrgUserList"%>.action",
                                    cache: false,
                                    async: false,
                                    data: "otherDepart=&fromModule="+$('#fromModule').val()+"&orgId="+treeNode.id+"&currentOrgId=<%=session.getAttribute("orgId").toString()%>&orgSerial="+treeNode.serial+"&orgName="+encodeURIComponent(treeNode.name)+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&parentOrgId="+treeNode.id+"&fromParent="+$('#fromParent').val()+"&isShortcut=1"+"&range="+$('#range').val()+"&scopeType="+$('#scopeType').val(),
                                    dataType: "html",
                                    success: function(content) {
                                        $('#dataGrid').html(content);
                                        loadState("1");
                                    }
                                });
                            }
                        }

                        function showIconForTree(treeId, treeNode) {
                            return false;//!treeNode.isParent;
                        };

                        function filterShortcut(treeId, parentNode, childNodes) {
                            if (!childNodes) return null;
                            for (var i=0, l=childNodes.length; i<l; i++) {
                                childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
                            }
                            return childNodes;
                        }

                        //无子节点则取消parent身份，不显示空白.
                        function onExpandShortcut(event, treeId, treeNode, clickFlag) {	
                            var zTree = $.fn.zTree.getZTreeObj("treeShortcut");
                            var b = treeNode.children!=undefined && treeNode.children!='undefined' && treeNode.children!=null && treeNode.children!='' ;
                            if(!b){
                                zTree.expandNode(treeNode, false, null, null, null);
                                treeNode.isParent = false;
                                zTree.updateNode(treeNode,false);
                            }			
                        }

                        function loadSelfOrg(){
                            $.ajax({
                                type: 'post',
                                url: "<%=rootPath%>/SelectOrgAndUser!<%="org".equals(show) || show.indexOf("user")==-1?"getOrgList":"getOrgUserList"%>.action",
                                cache: false,
                                async: false,
                                data: "otherDepart=&fromModule="+$('#fromModule').val()+"&orgId=<%=session.getAttribute("orgId").toString()%>&currentOrgId=<%=session.getAttribute("orgId").toString()%>&orgSerial=<%=session.getAttribute("orgSerial")!=null?session.getAttribute("orgSerial").toString():""%>&orgName=<%=session.getAttribute("orgSelfName").toString()%>&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&parentOrgId=<%=session.getAttribute("orgId").toString()%>&fromParent="+$('#fromParent').val()+"&isShortcut=1"+"&range="+$('#range').val(),
                                dataType: "html",
                                success: function(content) {
                                    $('#dataGrid').html(content);
                                    loadState("1");
                                    fixedSurface();
                                }
                            });
                        }
<%}%>

                        function loadShortcut(){
                            //if(lazyShortcut == false){
                                //$.fn.zTree.init($("#treeShortcut"), settingShortcut);
                                //lazyShortcut = true;
                            //}
                            
                            var isOnlyGroup = true;

                            <%if(isShowOrg || isShowGroup==false){%>
                            if(typeof loadSelfOrg == 'function'){
                                $.fn.zTree.init($("#treeShortcut"), settingShortcut);
                                lazyShortcut = true;
                                
                                <%if(range != null && !"".equals(range) && !"null".equals(range) && !"0".equals(range) && !"*0*".equals(range)){%>
                                <%}else{%>
                                    loadSelfOrg();
                                <%}%>

                                isOnlyGroup = false;
                            }
                            <%}%>

                            <%if(!"0".equals(showPersonalGroup)){//0-不显示个人群组%>
                            if(typeof loadShortcutGroup == 'function'){
                                loadShortcutGroup();
                                if(isOnlyGroup){
                                    loadTopGroup('<s:text name="obj.selectobject.custgroup"/>');
                                }
                            }
                            <%}%>

                            //loadOrg_selfUnit()
                            if(typeof loadOrg_selfUnit == 'function'){
                                loadOrg_selfUnit();
                            }
                        }

<%if(isShowGroup && isShowShortcut){%>
                        //自定义群组
                        var lazyShortcutGroup = false;
                        var settingShortcutGroup = {
                            view: {
                                showIcon: false,
                                fontCss : {color:"#0055ad"}
                            },
                            async: {
                                enable: true,
                                url:"<%=rootPath%>/SelectOrgAndUser!filterGroupTree.action",
                                autoParam:["pId"],
                                otherParam:{"select":$('#select').val(), "single":$('#single').val(), "show":$('#show').val(), "range":$('#range').val(), "currentOrgId":$('currentOrgId').val(), "limited":$('#limited').val(), "fromModule":$('#fromModule').val(), "key":$('#key').val(), "isShortcut":1, "groupType":1}
                            },
                            callback: {
                                //onExpand:onExpandShortcutGroup,
                                onClick: onClickShortcutGroup
                                
                            },
                            dataFilter: filterShortcutGroup
                        };

                        function onClickShortcutGroup(event, treeId, treeNode, clickFlag) {
                            try{
                                //取消节点的选中状态
                                var treeObj = $.fn.zTree.getZTreeObj("treeShortcut");
                                treeObj.cancelSelectedNode();
                            }catch(e){}

                            if(treeNode.id == '0'){
                                loadTopGroup(treeNode.name);
                            }else{
                                $.ajax({
                                    type: 'post',
                                    url: "<%=rootPath%>/SelectOrgAndUser!<%=show.indexOf("user")!=-1?"getGroupUserList":"getGroupUserList"%>.action",
                                    cache: false,
                                    async: false,
                                    data: "fromModule="+$('#fromModule').val()+"&groupType=1&currentOrgId=<%=session.getAttribute("orgId").toString()%>&range="+$('#range').val()+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&groupId="+treeNode.id+"&groupName="+encodeURIComponent(treeNode.name)+"&groupCode="+treeNode.serial+"&range="+$('#range').val(),
                                    dataType: "html",
                                    success: function(content) {
                                        $('#dataGrid').html(content);
                                        loadState("3");
                                    }
                                });
                            }
                        }

                        function loadTopGroup(name) {
                            $.ajax({
                                type: 'post',
                                url: "<%=rootPath%>/SelectOrgAndUser!getGroupList.action",
                                cache: false,
                                async: false,
                                data: "fromModule="+$('#fromModule').val()+"&groupType=1&currentOrgId=<%=session.getAttribute("orgId").toString()%>&orgSerial=&orgName="+name+"&range="+$('#range').val()+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&range="+$('#range').val()+"<%="user".equals(select)?"&notshowgrouplist=1":""%>",
                                dataType: "html",
                                success: function(content) {
                                    $('#dataGrid').html(content);
                                    loadState("3");
                                }
                            });
                        }

                        function filterShortcutGroup(treeId, parentNode, childNodes) {
                            if (!childNodes) return null;
                            for (var i=0, l=childNodes.length; i<l; i++) {
                                childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
                            }
                            return childNodes;
                        }

                        //无子节点则取消parent身份，不显示空白.
                        function onExpandShortcutGroup(event, treeId, treeNode, clickFlag) {	
                            var zTree = $.fn.zTree.getZTreeObj("treeShortcutGroup");
                            var b = treeNode.children!=undefined && treeNode.children!='undefined' && treeNode.children!=null && treeNode.children!='' ;
                            if(!b){
                                zTree.expandNode(treeNode, false, null, null, null);
                                treeNode.isParent = false;
                                zTree.updateNode(treeNode,false);
                            }			
                        }

                        function loadShortcutGroup(){
                            //if(lazyShortcutGroup == false){
                                $.fn.zTree.init($("#treeShortcutGroup"), settingShortcutGroup);
                                lazyShortcutGroup = true;
                            //}
                        }
<%}%>

<%if(isShowUnitOrg){%>
                        //本单位组织架构-----------------start
                        var lazyOrg_selfUnit = false;
                        var settingOrg_selfUnit = {
                            view: {
                                showIcon: false,
                                fontCss : {color:"#0055ad"}
                            },
                            async: {
                                enable: true,
                                url:"<%=rootPath%>/SelectOrgAndUser!filterOrgTree.action",
                                autoParam:["parentOrgId"],
                                otherParam:{"select":$('#select').val(), "single":$('#single').val(), "show":$('#show').val(), "range":"*<%=selfUnitId%>*", "currentOrgId":$('currentOrgId').val(), "limited":$('#limited').val(), "fromModule":$('#fromModule').val(), "key":$('#key').val(), "selfUnit":"1", "selfUnitId":"<%=selfUnitId%>"}
                            },
                            callback: {
                                onClick: onClickOrg_selfUnit
                                
                            },
                            dataFilter: filterOrg_selfUnit
                        };

                        function onClickOrg_selfUnit(event, treeId, treeNode, clickFlag) {
                            if(treeNode.isCanLink){
                                $.ajax({
                                    type: 'post',
                                    url: "<%=rootPath%>/SelectOrgAndUser!<%="org".equals(show) || show.indexOf("user")==-1?"getOrgList":"getOrgUserList"%>.action",
                                    cache: false,
                                    async: false,
                                    data: "otherDepart=-1&fromModule="+$('#fromModule').val()+"&orgId="+treeNode.id+"&currentOrgId=&orgSerial="+treeNode.serial+"&orgName="+encodeURIComponent(treeNode.name)+"&key="+$('#key').val()+"&single="+$('#single').val()+"&show="+$('#show').val()+"&select="+$('#select').val()+"&parentOrgId="+treeNode.id+"&fromParent="+$('#fromParent').val()+"&range=*<%=selfUnitId%>*",
                                    dataType: "html",
                                    success: function(content) {
                                        $('#dataGrid').html(content);
                                        loadState("1");
                                        fixedSurface();
                                    }
                                });
                            }
                        }

                        function filterOrg_selfUnit(treeId, parentNode, childNodes) {
                            if (!childNodes) return null;
                            for (var i=0, l=childNodes.length; i<l; i++) {
                                childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
                            }
                            return childNodes;
                        }

                        //无子节点则取消parent身份，不显示空白.
                        function onExpandOrg_selfUnit(event, treeId, treeNode, clickFlag) {	
                            var zTree = $.fn.zTree.getZTreeObj("treeOrg");
                            var b = treeNode.children!=undefined && treeNode.children!='undefined' && treeNode.children!=null && treeNode.children!='' ;
                            if(!b){
                                zTree.expandNode(treeNode, false, null, null, null);
                                treeNode.isParent = false;
                                zTree.updateNode(treeNode,false);
                            }			
                        }
                        function loadOrg_selfUnit(){
                            var zTreeObj = $.fn.zTree.init($("#treeShortcutSelfUnit"), settingOrg_selfUnit);
                        }
                        //本单位组织架构-----------------end
<%}%>
                        //-->
                    </SCRIPT>
                    </div>
                </div>
            </td>
            <td width="90%" valign="top" style="padding-left:5px;">
                <div style="width:100%;height:<%=dialogHeight-283%>px;padding:0px;overflow-x:hidden;overflow-y:auto;">
                    <div id="dataGrid">
                    </div>
                </div>
            </td>            
        </tr>
        <tr>
            <td valign="bottom" width="width:<%=dialogWidth-260%>px">
                <div class="textareaInput">
                    <textarea id="selectedName" name="selectedName" class="inputTextarea" style="width:<%=dialogWidth-260%>px;height:100px;text-align:left;" readonly="readonly"></textarea><!--cols=220 99.5%-->
                    <input type="hidden" id="selectedId" name="selectedId" value=""/>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td valign="bottom" width="90%" nowrap>
                <div class="bottomBtn">
                    <input name="okBtn" type="button" value="<s:text name="comm.confirm"/>" class="btnButton4font" onclick="okSelected();"/>
                    <input name="resetBtn" type="button" value="<s:text name="comm.reset"/>" class="btnButton4font" onclick="resetSelected();"/>  
                    <input name="clearBtn" type="button" value="<s:text name="comm.clear"/>" class="btnButton4font" onclick="clearSelected();"/>
                </div>
            </td>
        </tr>
    </table>

    </div>
<%
    if(realtimemessage_use){
        if("rtx".equals(realtimemessage_type)){
%>
    <div style="display:none;"><img align="absbottom" width="16" height="16" src="<%=rootPath%>/images/rtx/blank.gif" onload="_online('_test_001_');"></div>
<%}}%>
</body>
</html>
<%@ include file="/public/include/include_extjs.jsp"%>
<script type="text/javascript">
var isInitData = false;
Ext.onReady(function() {

<%if(_include_jsp.indexOf("include_user_condition")!=-1){%>
    var combo1 = Ext.create('Ext.form.field.ComboBox', {
        id: 'searchDutyOpr_',
        typeAhead: true,
        transform: 'searchDutyOpr_',
        width: 160,
        forceSelection: true
    });

    var combo2 = Ext.create('Ext.form.field.ComboBox', {
        id: 'searchDutyLevel_',
        typeAhead: true,
        transform: 'searchDutyLevel_',
        width: 240,
        forceSelection: true
    });
<%}%>

    //缓存父窗口数据
    initOldData();

    try{
        //初始化数据到当前页面输入域
        isInitData = true;
        initData();
    }catch(e){
        alert("初始加载数据错误：\n"+e.message);
    }

    $('#whir_tab_ul li:first-child').addClass('tag_aon');

<%if(isReHeight){%>
    $('div[id^=tab] div.hdiv').each(function(i){
        $(this).css('height', '<%=dialogHeight-113%>px');//+82px
    });
    $('#dataGrid').parent().css('height', '<%=dialogHeight-195%>px');
<%}%>

    initTab('whir_tab_ul');

    if($.browser.msie){
        $('#selectedName').css("width", "<%=dialogWidth-250%>px");
        var ver = $.browser.version;
        if(ver <= 7.0){
            $('#selectedName').css("width", "<%=dialogWidth-258%>px");
            $('#dataGrid').css("width", "97.5%");
        }else if(ver <= 8.0){
            $('#selectedName').css("width", "<%=dialogWidth-260%>px");
            $('#dataGrid').css("width", "98.8%");
        }else if(ver <= 11.0){
            $('#dataGrid').css("width", "98.8%");
            $('#selectedName').css("width", "<%=dialogWidth-258%>px");
        }

        if(isSurface()){//fixed 出现双滚动条
            $('#selectedName').css("width", "<%=dialogWidth-263%>px");
        }
    }else if($.browser.mozilla && $.browser.version == 11.0){
        $('#selectedName').css("width", "<%=dialogWidth-260%>px");
    }else{
        $('#selectedName').css("width", "<%=dialogWidth-260%>px");
    }

    $('.SearchBar input:text').keydown(function(event){
        if(event.keyCode == 13) {
            submitForm();
            event.preventDefault();
            event.stopPropagation();
        }
    });

});

function reHeight(){
<%if(isReHeight){%>
    //$('#dataDiv').css('height', '<%=dialogHeight-223%>px');
<%}%>

    if(isSurface()){//fixed 出现双滚动条
        $('#dataDiv').css('height', '<%=dialogHeight-230%>px');
        $('#dataGrid').parent().css('overflow-y', 'hidden');
    }
}

//缓存父页面数据到当前页面
function initOldData(){
    selectedId_old   = $.trim(W.document.getElementById(p_allowId).value);
    selectedName_old = $.trim(W.document.getElementById(p_allowName).value);

    var _selectedMaxlength = W.document.getElementById(p_allowName).getAttribute("maxlength");
    if(_selectedMaxlength != null){
        selectedName_old_maxlength = parseInt(_selectedMaxlength, 10);
    }
}

//初始化-原始数据
function initData(){
    <%if("no".equals(single)){%>
        if(isInitData){
            if(selectedId_old != ''){
                $.ajax({
                    url: whirRootPath + "/SelectOrgAndUser!getScopeFilter.action",
                    type: "POST",
                    cache: false,
                    async: false,
                    dataType: 'json',
                    data: {"filter_scopeIds":selectedId_old, "single":<%if("yes".equals(single)){%>true<%}else{%>false<%}%>, "show":"<%=show%>", "select":"<%=select%>", "key":$('#key').val()},
                    success: function(data){
                        //json
                        var selectedId    = data.scopeIdStr;
                        var selectedName  = data.scopeNameStr;
                        if(selectedId != ''){
                            $('#selectedId').val(selectedId);
                            $('#selectedName').val(selectedName);
                            if(isLoadOrg){//加载选中状态
                                loadState("1");
                            }
                        }
                    }
                });
            }
            isInitData = false;
        }
    <%}else{%>
        $('#selectedId').val(selectedId_old);
        $('#selectedName').val(selectedName_old);
    <%}%>
}

//btn-清除
function clearSelected(){
    $('#selectedId').val('');
    $('#selectedName').val('');

    $('input:radio, input:checkbox').each(function(i){
        $(this).attr("checked", false);
        $(this).attr("disabled", false);
    });

    //回调
    if($('#callbackCancel').val()!=''){
        try{
            var cb = eval('W.'+$('#callbackCancel').val());cb.call(this);
        }catch(e){}
    }
}

//btn-重置
function resetSelected(){
    document.getElementById('searchForm').reset();

    clearSelected();

    //初始化-原始数据
    isInitData = true;
    initData();

    loadState("1");
}

//btn-确定
function okSelected(){
    var ret_selectedName = $('#selectedName').val();
    if(selectedName_old_maxlength > 0 ){//验证选择最大数量
        if(selectedName_old_maxlength < ret_selectedName.length){
            whir_alert("<s:text name="obj.selecttip"/>", null, api);
            return;
        }
    }

    if(ret_selectedName.length > 0){
        var startStr = ret_selectedName.substring(0, 1);
        if(startStr == ','){
            ret_selectedName = ret_selectedName.substring(1);
        }
    }

    var ret_selectedId = $('#selectedId').val();
    var specialChar0 = ["*", "$", "@"];
    var specialChar1 = ["**", "$$", "@@", "*$", "*@", "$*", "$@", "@*", "@$"];
    for (var i = 0, j = specialChar0.length; i < j; i++) {
        if (ret_selectedId == specialChar0[i]) {
            ret_selectedId = "";
            break;
        }
    }
    for (var i = 0, j = specialChar1.length; i < j; i++) {
        if (ret_selectedId == specialChar1[i]) {
            ret_selectedId = "";
            break;
        }
        if (ret_selectedId.indexOf(specialChar1[i]) == 0) {
            ret_selectedId = ret_selectedId.substring(1);
        }
    }

    W.document.getElementById(p_allowId).value   = ret_selectedId;
    W.document.getElementById(p_allowName).value = ret_selectedName;

    //回调
    if($('#callbackOK').val()!=''){
        try{
            var cb = eval('W.'+$('#callbackOK').val());cb.call(this);
        }catch(e){}
    }

    <%
        if(tagitId != null && !"".equals(tagitId) && !"null".equals(tagitId)){
    %>
        //回调tagit
        W.callbackTagit({tagitId:'<%=tagitId%>', inputId:p_allowId, inputName:p_allowName, single:<%if("yes".equals(single)){%>true<%}else{%>false<%}%>});
    <%}%>
    
    closeWin(null);
}

function look(evt){
    var keyCode = window.event?window.event.keyCode:evt.which;
	if(keyCode=="13"){
        submitForm();
	}
}

function closeWin(obj){
    if(api){
        api.close();
    }else{
        window.close();
    }
}
</script>