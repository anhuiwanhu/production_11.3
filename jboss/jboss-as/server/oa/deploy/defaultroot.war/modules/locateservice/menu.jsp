<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.govezoffice.documentmanager.bd.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

//此处公共业务逻辑
%>
<%@ page import="com.whir.ezoffice.resource.bd.*" %>

<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.booksmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD" %>
<%@ page import="java.lang.Long" %>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.ezoffice.workflow.vo.*" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD,com.whir.ezoffice.officemanager.bd.EmployeeBD" %>
<%@ page import="com.whir.ezoffice.dossier.bd.DossierBD" %>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
int menuIndex=0;

String userId = session.getAttribute("userId").toString();
String domainId = session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString();
String orgId = session.getAttribute("orgId").toString();
String orgIdString = session.getAttribute("orgIdString").toString();

ManagerBD mbd = new ManagerBD();
boolean hasRight = mbd.hasRight(String.valueOf(userId), "07*99*01");
DossierBD dossierBD = new DossierBD();
boolean isDossierAdmin = dossierBD.isDossierAdmin(new Long(userId), new Long(domainId))==Boolean.TRUE?true:false;

String databaseType = com.whir.common.config.SystemCommon.getDatabaseType();
%>
		<SCRIPT type="text/javascript">    
            var zNodes =[
            	{ id:10000000, pId:-1, name:"人员轨迹",target:'mainFrame',open:true,url:"/defaultroot/LocateServiceAction!userList.action",iconSkin:"fa fa-cog fa"}
            	<%menuIndex++;%>
            	,{ id:20000000, pId:-1, name:"人员位置",target:'mainFrame',open:true,url:"/defaultroot/LocateServiceAction!locatePersonList.action",iconSkin:"fa fa-cog fa"}
            	<%menuIndex++;%>
            	,{ id:30000000, pId:-1, name:"考勤信息",target:'mainFrame',open:true,url:"/defaultroot/LocateServiceAction!userAttendanceList.action",iconSkin:"fa fa-cog fa"}
            	<%menuIndex++;%>
            	,{ id:40000000, pId:-1, name:"定位白名单",target:'mainFrame',open:true,url:"/defaultroot/LocateServiceAction!whiteList.action",iconSkin:"fa fa-cog fa"}
            ];  
        
            $(document).ready(function(){    
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);    
            });    
        </SCRIPT>  
	
		<div class="wh-l-msg">
			<a href="javascript:void(0)" class="clearfix" style="cursor:default">
				<i class="fa fa-color fa-map-marker"></i>
				<span>
					定位
				</span>
			</a>
		</div>
	    <div class="wh-l-con">
	        <ul id="treeDemo" class="ztree"></ul>
	    </div>
