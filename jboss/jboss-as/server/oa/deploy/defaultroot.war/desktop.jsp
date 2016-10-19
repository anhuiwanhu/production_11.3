<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.i18n.Resource" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session==null || session.getAttribute("userId")==null){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
location.href="login.jsp";
//-->
</SCRIPT>
<%
}else{
%>
<%@ include file="/public/desktop/include_desktop_menubaseInfo.jsp"%> 
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=webTitle%></title> 
	<script>
		var _usePortalLayout = false;
		<%if(session.getAttribute("layoutId")!=null){%>
			_usePortalLayout = true;
		<%}%>



		function openDesktopNew(){
			//是否启用个人门户。
			var clickFirst=$("#desktop_hidden_isfirstClick").val(); 
			//false 此判断功能去掉
			if(false&&clickFirst=="1"){
				//默认个人门户
				var defaultId=$("#desktop_hidden_defaultMyLayoutId").val();
				if(defaultId!=""&&defaultId!="null"){
					selectLayout(defaultId);
				} 
			}else{
				var layoutId=Cookie("ezofficePortal<%=userId%>");
				if(layoutId==null || layoutId=="" || layoutId=="null"){
					layoutId = initPortalNew('');
					selectLayout(layoutId);
				}else{
					layoutId = initPortalNew(layoutId);
					if(layoutId==''){
						layoutId = initPortalNew('');
					}
					selectLayout(layoutId);
				}   
			
			}  
		};

		/**
		切换门户
		*/
		function selectLayout(layoutId){ 
			 
			setCookie("ezofficePortal<%=userId%>",layoutId,expdate, "/", null, false);
			var portalURL="";
			<%if(session.getAttribute("layoutId")!=null){%>
				if(_usePortalLayout){
					_usePortalLayout = false;
					portalURL = whirRootPath+"/platform/portal/portal_main.jsp?preview=1&id=<%=session.getAttribute("layoutId")%>&ismain=1";//+layoutId;
				}else{
					portalURL = whirRootPath+"/platform/portal/portal_main.jsp?preview=1&id="+layoutId+"&ismain=1";
				}
			<%}else{%>
				portalURL = whirRootPath+"/platform/portal/portal_main.jsp?preview=1&id="+layoutId+"&ismain=1";
			<%}%>
			//class="current"

			$("#mainFrame").attr("src",portalURL);  
			$("#desktop_leftTh").hide();  
			//initPortalNew(layoutId);
			//设置选中的样式 ，没有选中删除样式
            $("#gateway_div a[id^=Layout]").removeClass("current");
			$("#Layout"+layoutId).addClass("current");//.siblings().removeClass("current");

			addDesktopBJ();
		}
		 
    </script>
    <%@ include file="/public/include/meta_desktop_base.jsp"%> 
</head>
<body>
<div class="wh-wrapper">
    <div class="wh-header">
        <div class="wh-container clearfix"  id="desktop_container_div"> 
			<!-- <a href="#" class="wh-logo" style="background-image: url('<%=logoFile%>')"></a> --> 
		    <a href="#" class="wh-logo" id="desktop_logo_a"><img src="<%=logoFile%>" alt=""  id="desktop_logoFileImage"  data-pich="50" /></a>
			<%@ include file="/public/desktop/include_desktop_menu.jsp"%>   
		    <ul class="wh-hd-r-nav clearfix" id="desktop_right_ul">
                <li>
                    <a href="javascript:void(0)" class="wh-hd-user-info"  onclick="chooseDefaultMyLayout(); return false;" ><img src="<%=_userImage_small%>" alt=""/></a>
                    <div class="wh-hd-user-detail wh-hd-box-shadow" >
                        <div class="wh-hd-user-welcome">
                            <p class="wh-hd-user-welcome-title clearfix">
                                <a href="#"><img src="<%=_userImage_small%>" alt="#" onclick="modiMyPhoto(); return false;"/></a>
                                <a href="javascript:void(0)"  onclick="modiMyInfo(); return false;"  class="wel-p-info" title="<%=Resource.getValue(local,"common","comm.myinfos")%>"><%=Resource.getValue(local,"common","comm.myinfos")%><!--个人资料--></a>
                                <span>|</span>
                                <!-- <a href="javascript:void(0)"  class="wh-hd-user-center welcomea wh-hd-user-faclick"><span onclick="chooseDefaultMyLayout(); return false;" title="<%=Resource.getValue(local,"common","comm.mylayout")%>"><%=Resource.getValue(local,"common","comm.mylayout")%></span> <i class="fa fa-angle-right"></i></a> --> 
								<a href="javascript:void(0)" title="<%=Resource.getValue(local,"common","comm.peels")%>" class="wh-sys-setting-skin-change welcome-skin-btn"  onclick="modiMySkinSC();return false;"><i class="fa fa-skin fa-color"></i></a> 
                                <a href="javascript:void(0)" title="<%=Resource.getValue(local,"common","comm.help")%>" class="welcome-help-btn" onClick="openHelp();"><i class="fa fa-info-circle fa-color"></i></a> 
                            </p>
                            <a href="javascript:void(0)" class="welcomea"><span title="<%=Resource.getValue(local,"common","comm.welcomeyou")%>"><%=Resource.getValue(local,"common","comm.welcomeyou")%><!-- 欢迎您 --></span>：<em title="<%=session.getAttribute("userName")%>"><%=session.getAttribute("userName")%></em></a>
                            <!--<i class="fa fa-circle-o"></i>-->
                            <a href="javascript:void(0)" class="wh-hd-user-click-change welcomea wh-hd-user-faclick"><span title="<%=Resource.getValue(local,"common","comm.status")%>"><%=Resource.getValue(local,"common","comm.status")%><!-- 状态 --></span>：<em id="desktop_userstatus_em">上班</em><i class="fa fa-angle-right"></i></a>
                            <a href="javascript:void(0)" class="wh-hd-group-click-change wh-hd-user-click-change welcomea wh-hd-user-faclick"><span title="<%=Resource.getValue(local,"common","comm.orgnization")%>"><%=Resource.getValue(local,"common","comm.orgnization")%><!-- 组织 --></span>：<em id="currentOrgName" title="<%=orgSimpleName%>"><%=orgSimpleName%></em><i class="fa fa-angle-right"></i></a>
							<input type="hidden" name="gggggggg" value="<%=whir_pageFontSize%>">
							<%
							String smallClass="";
							String bigClass="";
							//字号大小
							if(whir_pageFontSize.equals("14")){
								smallClass=" noselect";
							}else{
								bigClass=" noselect";
							}  
							%>
							<a href="javascript:void(0)" class="wh-hd-font-click-change welcomea"><span title="<%=Resource.getValue(local,"common","comm.pageFontsize")%>"><%=Resource.getValue(local,"common","comm.pageFontsize")%></span>：<em class="wh-font-small<%=smallClass%>" onclick="updatePagaFontSize('12')" title="12">-A</em><em class="wh-font-big<%=bigClass%>" onclick="updatePagaFontSize('14')"  title="14">+A</em></a>

                        </div>
                        <!--div class="wh-hd-center-state wh-hd-state"> 
						
                        </div-->
                        <div class="wh-hd-user-state wh-hd-user-hidden wh-hd-state" id="destop_user_state_div">  
                        </div>
                        <div class="wh-hd-group-state wh-hd-state">
						<input type="hidden" id="curOrgId" name="curOrgId" value="<%=orgId%>">
					   <%
						for(int m=0; m<allOrgList.size(); m++){
							Object[] objSideOrg = (Object[])allOrgList.get(m);
							String _objSideOrg_name = (String)objSideOrg[3];
							if(_objSideOrg_name.length()>10){
								_objSideOrg_name = _objSideOrg_name.substring(0, 9) + "...";
							}
							String org_class="";
							if(orgId.equals(objSideOrg[0]+"")){
								org_class="class=\"current\"";
							}
						%> 
							 <a href="javascript:void(0)" <%=org_class%> onClick="changeCurOrg('<%=objSideOrg[0]%>','<%=objSideOrg[1]%>','<%=objSideOrg[2]%>','<%=objSideOrg[3]%>','<%=objSideOrg[4]%>');"><span title="<%=objSideOrg[3]%>"><%=_objSideOrg_name%></span><i class="fa"></i></a>
						<%}%> 
                        </div>
                    </div>
                </li>

				<li class="wh-sys-quickset"> 
					<a href="javascript:void(0);" class="wh-r-nav-a" title="<%=Resource.getValue(local,"common","comm.create")%>">
						<i class="fa fa-plus fa-color"></i>
					</a>
					<div class="wh-sys-quicksetting-list wh-hd-box-shadow">
						<div>  
							 <p><i class="fa fa-envelope"></i><a href="#" title="<%=Resource.getValue(local,"common","comm.mail")%>" onClick="javascript:openWin({url:'<%=rootPath%>/innerMail!openAddMail.action',isFull:true,winName:'newMail'});"><%=Resource.getValue(local,"common","comm.mail")%></a></p>  
							 <p><i class="fa fa-comments-o"></i><a href="#" title="<%=Resource.getValue(local,"common","comm.newinfo")%>" onClick="javascript:openWin({url:'<%=rootPath%>/Information!add.action?channelType=0&userChannelName=信息管理&userDefine=0',isFull:true,winName:'newinfo'});"><%=Resource.getValue(local,"common","comm.newinfo")%></a> </p>
							 <p><i class="fa fa-pencil"></i><a href="#"  title="<%=Resource.getValue(local,"common","comm.worklog")%>"onClick="javascript:openWin({url:'<%=rootPath%>/WorkLogAction!addMyWorkLog.action',isFull:true,winName:'worklog'});"><%=Resource.getValue(local,"common","comm.worklog")%></a> </p>
							 <p><i class="fa fa-work-rep"></i><a href="#" title="<%=Resource.getValue(local,"common","comm.workreport")%>" onClick="javascript:openWin({url:'<%=rootPath%>/WorkReportAction!addWorkReport.action?isFromDesktop=1&reportType=week',isFull:true,winName:'workreport'});"><%=Resource.getValue(local,"common","comm.workreport")%></a> </p>
							 <p><i class="fa fa-attendance-mana"></i><a href="#" title="<%=Resource.getValue(local,"common","comm.schedule")%>" onClick="javascript:openWin({url:'<%=rootPath%>/EventAction!addMyEvent.action?flagChangeEventType=1',isFull:true,winName:'taskcenter'});"><%=Resource.getValue(local,"common","comm.schedule")%></a> </p>   
						</div>
					</div>
				</li>

                <li>
                    <a href="#" class="wh-r-nav-a"><i class="fa fa-search fa-color"></i></a>
                    <div class="wh-hd-search wh-hd-box-shadow" >
                        <div class="wh-sys-notice-list-form">
                            <input type="text" class="wh-hd-search-text" id="searchKey" name="searchKey" />
                            <div class="wh-hd-search-box clearfix"><a href="javascript:void(0);" class="fa wh-hd-search-info"><em id="searchType_span"><%=Resource.getValue(local,"common","comm.information1")%></em><i class="fa fa-angle-right"></i> </a><input type="button" class="wh-hd-search-btn" value="<%=Resource.getValue(local,"common","comm.search")%>" onclick="ezLuceneSearch();"/></div>
							<input type="hidden" name="searchType" id="searchType" value="info">
                        </div>
                        <div class="wh-hd-user-state wh-hd-state wh-hd-user-search-list">
                            <a href="javascript:void(0)" class="current" onclick="changeSearchType('info','<%=Resource.getValue(local,"common","comm.information1")%>',this);"><span title="<%=Resource.getValue(local,"common","comm.information1")%>"><%=Resource.getValue(local,"common","comm.information1")%><!-- 信息 --></span><i class="fa"></i></a>
                            <a href="javascript:void(0)" onclick="changeSearchType('sendfile','<%=Resource.getValue(local,"common","comm.sendfile1")%>',this);"><span title="<%=Resource.getValue(local,"common","comm.sendfile1")%>"><%=Resource.getValue(local,"common","comm.sendfile1")%><!-- 发文 --></span><i class="fa"></i></a>
                            <a href="javascript:void(0)" onclick="changeSearchType('receivefile','<%=Resource.getValue(local,"common","comm.receivefile1")%>',this);"><span title="<%=Resource.getValue(local,"common","comm.receivefile1")%>"><%=Resource.getValue(local,"common","comm.receivefile1")%><!-- 收文 --></span><i class="fa"></i></a>
                            <a href="javascript:void(0)" onclick="changeSearchType('govcheck','<%=Resource.getValue(local,"common","comm.govsendcheck")%>',this);"><span title="<%=Resource.getValue(local,"common","comm.govsendcheck")%>"><%=Resource.getValue(local,"common","comm.govsendcheck")%><!-- 送审 --></span><i class="fa"></i></a>
                            <a href="javascript:void(0)" onclick="changeSearchType('contract','<%=Resource.getValue(local,"common","comm.contract1")%>',this);"><span title="<%=Resource.getValue(local,"common","comm.contract1")%>"><%=Resource.getValue(local,"common","comm.contract1")%><!-- 合同 --></span><i class="fa"></i></a>
                            <a href="javascript:void(0)" onclick="changeSearchType('forum','<%=Resource.getValue(local,"common","comm.forum1")%>',this);"><span title="<%=Resource.getValue(local,"common","comm.forum1")%>"><%=Resource.getValue(local,"common","comm.forum1")%><!-- 论坛 --></span><i class="fa"></i></a>
                            <a href="javascript:void(0)" onclick="changeSearchType('document','<%=Resource.getValue(local,"common","comm.knowledge_document")%>',this);"><span  title="<%=Resource.getValue(local,"common","comm.knowledge_document")%>"><%=Resource.getValue(local,"common","comm.knowledge_document")%><!-- 知识 --></span><i class="fa"></i></a>
                        </div>
                    </div>
                </li>
                <li class="wh-sys-setting-dialog-click">
                    <span class="wh-sys-warn-pos"  id="desktop_all_remindNum_span"></span>
                    <a href="javascript:void(0);" class="wh-r-nav-a wh-sys-sdc" id="desktop_all_remindNum_a">
                        <i class="fa fa-bell fa-color"></i>
                    </a>
                    <div class="wh-sys-notice-list wh-hd-box-shadow">
                        <div id="desktop_remindModule1_div">
                            <p remindModule="waitFile"  <%=_remindShow1%>><i class="fa fa-pencil-square-o"></i><a href="#" onclick="jumpnew('platform/bpm/bpm_menu.jsp?expNodeCode=myWatingDeal','wfdealwith!dealwithList.action?openType=waitingDeal&noTreatment=0');"
							 title="<%=Resource.getValue(local,"common","comm.docWaitForProcess")%>"><%=Resource.getValue(local,"common","comm.docWaitForProcess")%><!--待办文件--></a><span>(0)</span></p>
							<p remindModule="waitRead" <%=_remindShow2%>><i class="fa fa-receiving-doc"></i><a href="#" onclick="jumpnew('platform/bpm/bpm_menu.jsp?expNodeCode=myWatingRead','wfdealwith!dealwithList.action?openType=waitingRead&noTreatment=0');"  title="<%=Resource.getValue(local,"common","comm.docWaitForReview")%>"><%=Resource.getValue(local,"common","comm.docWaitForReview")%></a><span>(0)</span></p>
                            <p remindModule="matureFile" <%=_remindShow3%>><i class="fa fa-inbox"></i><a href="#"  onclick="javascript:jumpnew('/defaultroot/GovDoc!menu.action?expNodeCode=notRead','/defaultroot/GovRecvDocSet!notRead.action');"  title="<%=Resource.getValue(local,"common","comm.newgovdocumentfile")%>" ><%=Resource.getValue(local,"common","comm.newgovdocumentfile")%><!-- 新收文 --></a><span>(0)</span> </p>
                            <p remindModule="newMail" <%=_remindShow4%>><i class="fa fa-envelope"></i><a href="#" onclick="javascript:jumpnew('/defaultroot/innerMail!innermailMenu.action?expNodeCode=mymail','/defaultroot/innerMail!notreadMailList.action');"  title="<%=Resource.getValue(local,"common","comm.newemail")%>"><%=Resource.getValue(local,"common","comm.newemail")%><!--新邮件--></a><span>(0)</span></p>
							<p remindModule="newTask" <%=_remindShow5%>><i class="fa fa-flag"></i><a href="#"  onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=newTask','/defaultroot/taskCenter!selectPrincipalTask.action');" title="<%=Resource.getValue(local,"common","comm.newtask")%>"><%=Resource.getValue(local,"common","comm.newtask")%><!--新任务--></a><span>(0)</span></p>
							<p remindModule="newEvent" <%=_remindShow6%>><i class="fa fa-comment"></i><a href="#" onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=newEvent','/defaultroot/EventAction!eventList.action?menuType=mine');" title="<%=Resource.getValue(local,"common","comm.newevent")%>"><%=Resource.getValue(local,"common","comm.newevent")%><!--新事件--></a><span>(0)</span></p>
							<p remindModule="newPress" <%=_remindShow7%>><i class="fa fa-clock-o"></i><a href="#" onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=pressdeal','/defaultroot/PressManageAction!receivePressList.action');" title="<%=Resource.getValue(local,"common","comm.newpress")%>"><%=Resource.getValue(local,"common","comm.newpress")%><!--新催办--></a><span>(0)</span></p> 
							<p remindModule="newContract" <%=_remindShow8%>><i class="fa fa-contract-mana"></i><a href="#" onclick="javascript:jumpnew('/defaultroot/subsidiaryMenu!toSubsidiaryMenu.action?expNodeCode=contract','/defaultroot/contract!reminderList.action');" title="<%=Resource.getValue(local,"common","comm.newhetong")%>"><%=Resource.getValue(local,"common","comm.newhetong")%><!--合同提醒--></a><span>(0)</span></p>  
                        </div>
                    </div>
                </li>
                <!-- <li  class="wh-sys-setting-skin-change"><a href="#" class="wh-r-nav-a" title="<%=Resource.getValue(local,"common","comm.peels")%>" onclick="modiMySkinSC();return false;"><i class="fa fa-skin fa-color"></i></a></li>
                <li><a href="#" class="wh-r-nav-a"  onClick="window.open('help/index.html');" title="<%=Resource.getValue(local,"common","comm.help")%>"><i class="fa fa-info-circle fa-color"></i></a></li> -->
                
                <li>
                    <a href="#" class="wh-r-nav-a"><i class="fa fa-users fa-color"></i></a>
                    <div class="wh-hd-group-num wh-hd-box-shadow" >
                        <div class="wh-hd-group-a clearfix"><a href="#" class="fl"  onclick="openInnerUser();return false;"><%=Resource.getValue(local,"common","comm.allusers")%><!-- 全部人数：<span><em id="alluserNum">434</em>人</span> --><i class="fa fa-user fa-color"></i></a></div>
                        <div class="wh-hd-group-a clearfix"><a href="#" class="fl" onclick="openUserList();return false;"><%=Resource.getValue(local,"common","comm.currentin")%><!-- 当前在线：<span><em id="nowuserNum">334</em>人</span> --><i class="fa fa-angle-right"></i></a></div>
                    </div>
                </li>
                
                <li><a href="#" class="wh-r-nav-a" title="<%=Resource.getValue(local,"common","comm.saftlogout")%>" onClick="reLog();return false;" ><i class="fa fa-power-off fa-color"></i></a></li>
            </ul>
        </div>
        <div style="position: absolute; top: 0; right: 10px; "> 
        </div>
    </div>

    <!--container -->
    <div class="wh-content">
        <div class="wh-container clearfix">
            <span id="switchShow" class="btn-switch-show"><i class="fa fa-caret-right"></i></span>
            <table class="wh-con-table" cellspacing="0" cellpadding="0">
                <tr>
                    <th id="desktop_leftTh">
                        <div class="wh-l-content">
						    <span id="switchHide" class="btn-switch-hide"><i class="fa fa-caret-left"></i></span>
                            <div class="wh-left-menuList" id="leftMenuDiv"></div>
                        </div>
                    </th>
                    <td>
                    	<div class="wh-r-content wh-ios-iframe-bug">
                    		<iframe src="" allowtransparency="transparent" scrolling="auto" class="wh-portal" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" id="mainFrame" name="mainFrame" ></iframe>
                    	</div>
                    </td>
                </tr>
            </table>
        </div>
    </div> 

    <!--提醒事项-->
    <div class="wh-sys-setting-dialog" style="display: none">
        <div class="wh-sys-notice wh-sys-notice-list-setting">
            <div class="setting-contents clearfix" id="desktop_remindmodule_div">
				<div remindModule="waitFile" <%=_remindShow1%> onclick="jumpnew('platform/bpm/bpm_menu.jsp?expNodeCode=myWatingDeal','wfdealwith!dealwithList.action?openType=waitingDeal&noTreatment=0');closeRemindEdit();" >
                    <i class="fa fa-pencil-square-o">&#xf060;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.docWaitForProcess")%>"><%=Resource.getValue(local,"common","comm.docWaitForProcess")%></p> 
                </div>
                <div remindModule="waitRead" <%=_remindShow2%>  onclick="jumpnew('platform/bpm/bpm_menu.jsp?expNodeCode=myWatingRead','wfdealwith!dealwithList.action?openType=waitingRead&noTreatment=0');closeRemindEdit();">
                    <i class="fa fa-receiving-doc">&#xf06a;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.docWaitForReview")%>"><%=Resource.getValue(local,"common","comm.docWaitForReview")%></p> 
                </div>
                <div remindModule="matureFile" <%=_remindShow3%>   onclick="javascript:jumpnew('/defaultroot/GovDoc!menu.action?expNodeCode=notRead','/defaultroot/GovRecvDocSet!notRead.action');closeRemindEdit();">
                    <i class="fa fa-inbox">&#xf077;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.newgovdocumentfile")%>"><%=Resource.getValue(local,"common","comm.newgovdocumentfile")%></p> 
                </div>
                <div remindModule="newMail" <%=_remindShow4%> onclick="javascript:jumpnew('/defaultroot/innerMail!innermailMenu.action?expNodeCode=mymail','/defaultroot/innerMail!notreadMailList.action');closeRemindEdit();">
                    <i class="fa fa-envelope">&#xf02a;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.newemail")%>"><%=Resource.getValue(local,"common","comm.newemail")%><!--新邮件--></p> 
                </div>
                <div remindModule="newTask" <%=_remindShow5%>  onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=newTask','/defaultroot/taskCenter!selectPrincipalTask.action');closeRemindEdit();">
                    <i class="fa fa-flag">&#xf07e;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.newtask")%>"><%=Resource.getValue(local,"common","comm.newtask")%><!--新任务--></p> 
                </div>
                <div remindModule="newEvent" <%=_remindShow6%> onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=newEvent','/defaultroot/EventAction!eventList.action?menuType=mine');closeRemindEdit();">
                    <i class="fa fa-comment">&#xf072;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.newevent")%>"><%=Resource.getValue(local,"common","comm.newevent")%><!--新事件--></p> 
                </div>
			    <div remindModule="newPress" <%=_remindShow7%>  onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=pressdeal','/defaultroot/PressManageAction!receivePressList.action');closeRemindEdit();">
                    <i class="fa fa-clock-o">&#xf04f;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.newpress")%>"><%=Resource.getValue(local,"common","comm.newpress")%><!--新催办--></p> 
                </div>  
                <div remindModule="newContract" <%=_remindShow8%> onclick="javascript:jumpnew('/defaultroot/subsidiaryMenu!toSubsidiaryMenu.action?expNodeCode=contract','/defaultroot/contract!reminderList.action');closeRemindEdit();">
                    <i class="fa fa-contract-mana">&#xf024;</i>
					<span>0</span>
                    <p title="<%=Resource.getValue(local,"common","comm.newhetong")%>"><%=Resource.getValue(local,"common","comm.newhetong")%><!--合同提醒--></p> 
                </div>
              
                <div class="edit-notice">
                    <i class="fa fa-plus">&#xf001;</i>
                    <p title="<%=Resource.getValue(local,"common","comm.editremind")%>"><%=Resource.getValue(local,"common","comm.editremind")%><!--编辑提醒--></p>
                </div>
            </div>
        </div>
        <div class="wh-sys-notice wh-sys-notice-list-setting-edit">
             <div class="setting-tips setting-tips-to-close">
                <i class="fa fa-angle-left setting-edit-back"></i>
                <p title="<%=Resource.getValue(local,"common","comm.backlast")%>"><%=Resource.getValue(local,"common","comm.backlast")%><!--返回上页--></p>
            </div>
            <div class="setting-contents-edit clearfix"  id="desktop_remind_editshowhide_div">
                <div remindModule="waitFile">
                    <i class="fa fa-pencil-square-o"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.docWaitForProcess")%>"><%=Resource.getValue(local,"common","comm.docWaitForProcess")%></p>
                    <%=_remindSpan1%>
                </div>
                <div remindModule="waitRead">
                    <i class="fa fa-receiving-doc"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.docWaitForReview")%>"><%=Resource.getValue(local,"common","comm.docWaitForReview")%></p>
                    <%=_remindSpan2%>
                </div>
                <div remindModule="matureFile">
                    <i class="fa fa-inbox"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.newgovdocumentfile")%>"><%=Resource.getValue(local,"common","comm.newgovdocumentfile")%></p>
                    <%=_remindSpan3%>
                </div>
                <div remindModule="newMail">
                    <i class="fa fa-envelope"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.newemail")%>"><%=Resource.getValue(local,"common","comm.newemail")%><!--新邮件--></p>
                    <%=_remindSpan4%>
                </div>
                <div remindModule="newTask">
                    <i class="fa fa-flag"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.newtask")%>"><%=Resource.getValue(local,"common","comm.newtask")%><!--新任务--></p>
                    <%=_remindSpan5%>
                </div>
                <div remindModule="newEvent">
                    <i class="fa fa-comment"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.newevent")%>"><%=Resource.getValue(local,"common","comm.newevent")%><!--新事件--></p>
                    <%=_remindSpan6%>
                </div>
               <div remindModule="newPress">
                    <i class="fa fa-contract-mana"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.newpress")%>"><%=Resource.getValue(local,"common","comm.newpress")%><!--新催办--></p>
                    <%=_remindSpan7%>
                </div>
                <div remindModule="newContract">
                    <i class="fa fa-clock-o"></i>
                    <p title="<%=Resource.getValue(local,"common","comm.newhetong")%>"><%=Resource.getValue(local,"common","comm.newhetong")%><!--合同提醒--></p>
                    <%=_remindSpan8%>
                </div>  
            </div>
        </div>
    </div>
</div> 
<%@ include file="/public/desktop/include_desktop_other.jsp"%>
<%@ include file="/public/desktop/include_desktop_window.jsp"%> 
<div style="display:none">
  <form id="frm">
    <input type="hidden" name="docKeyCode" value="0">
  </form>
  <iframe id="iframe1" src="" scrolling="no"></iframe>
  <iframe id="iframe2" src="" scrolling="no"></iframe>
</div> 
</body>
</html>
<%}%>