<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Calendar" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>关于</title>
<script src="<%=rootPath%>/scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
<script src="js.js" type="text/javascript"></script>
<style>
table {
	font-family: "宋体";
	font-size: 12px;
	line-height: 150%;
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<%
	//------获得系统版本信息 取最新版本----2009-04-18----start
	com.whir.org.basedata.bd.PatchInfoBD patchBD = new com.whir.org.basedata.bd.PatchInfoBD();
	java.util.List pathchList = (java.util.List)patchBD.getAllPatchInfo();
	com.whir.org.basedata.po.PatchInfoPO patchPO = new com.whir.org.basedata.po.PatchInfoPO();
	if(pathchList!=null&&pathchList.size()>0){
		patchPO = (com.whir.org.basedata.po.PatchInfoPO)pathchList.get(0);
	}
	//------获得系统版本信息 取最新版本----2009-04-18----end

    //------获得系统版本信息 取最新版本----2009-04-18----start
	java.util.List evopathchList = (java.util.List)patchBD.getAllEvoPatchInfo();
	com.whir.org.basedata.po.PatchInfoPO evopatchPO = new com.whir.org.basedata.po.PatchInfoPO();
	if(evopathchList!=null&&evopathchList.size()>0){
		evopatchPO = (com.whir.org.basedata.po.PatchInfoPO)evopathchList.get(0);
	}
	//------获得系统版本信息 取最新版本----2009-04-18----end

	com.whir.org.bd.usermanager.UserBD userBD = new com.whir.org.bd.usermanager.UserBD();
    int currentUserNum = userBD.getSysActivityUserCount();//获得系统中活动的用户数(没有被删除或禁用并且是正式的用户总数)
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	com.whir.common.init.DogManager dm = com.whir.common.init.DogManager.getInstance();
    String[] dogInfo = (String[]) dm.getDogkey();

	Calendar c = Calendar.getInstance();
    c.setTimeInMillis(Long.parseLong(dogInfo[0]));
%>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="490" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="73"><img src="logo_whir.jpg" width="73" height="342"></td>
    <td width="417" align="center" valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center"><img src="logo_ezoffice.jpg" width="370" height="76"></td>
        </tr>
      </table>
      <table width="370" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan=2>&nbsp;</td>
        </tr>
		<%com.whir.org.vo.organizationmanager.DomainVO domainVO = new com.whir.org.bd.organizationmanager.OrganizationBD().loadDomain(session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString());%>
        <tr> 
          <td colspan=2>版权所有@1998-2013 万户网络技术有限公司。保留所有权利。</td>
        </tr>
        <tr height=26>
            <td>
            ezOFFICE版本信息：<%=(patchPO!=null&&patchPO.getPatchVersion()!=null)?patchPO.getPatchVersion():Resource.getValue(whir_locale,"common","comm.version")%></td>
            <td><span align=right><img src="update.jpg" width="63" height="20" onClick="openWin({url:'<%=rootPath%>/PatchInfo!initlist.action',width:'550',height:'400',winName:'winName_1'});"></span></td>
        </tr>
        <tr height=26>
            <td>
            EVO版本信息：<%=(evopatchPO!=null&&evopatchPO.getPatchVersion()!=null)?evopatchPO.getPatchVersion():"无"%></td>
            <td><span align=right><img src="update.jpg" width="63" height="20" onClick="openWin({url:'<%=rootPath%>/PatchInfo!initEvoList.action',width:'550',height:'400',winName:'winName_2'});"></span><td>
        </tr>
        <tr>
            <td colspan=2>
			加密狗信息：授权数&nbsp;<%=dogInfo[1]%><br>
            <%if(dogInfo.length>3){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;移动用户数&nbsp;<%=dogInfo[3]%><br><%}%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;授权期限&nbsp;<%=sdf2.format(c.getTime())%>
            <!-- 使用单位：<%=domainVO.getDomainName()%><br>
            许可证数：<%=domainVO.getUserNum()%> --></td>
        </tr>
        <tr> 
          <td colspan=2>&nbsp;</td>
        </tr>
        <tr> 
          <td colspan=2>警告：本计算机程序受著作权法与国际公约的保护，未经授权<br>
            擅自复制与传播本程序的部分或全部内容可能受到严厉的民事或刑<br>
            事制裁，并将在法律许可的范围内受到最大可能的起诉。</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="370" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="196">&nbsp;</td>
          <!--td width="71"><img src="update.jpg" width="63" height="20" onclick="window.open('<%=rootPath%>/PatchInfoAction.do?action=evolist','','menubar=0,scrollbars=yes,width=550,height=400,resizable=no')"></td>
          <td width="71"><img src="update.jpg" width="63" height="20" onclick="window.open('<%=rootPath%>/PatchInfoAction.do?action=list','','menubar=0,scrollbars=yes,width=550,height=400,resizable=no')"></td-->
          <td width="103"><img src="close.jpg" width="63" height="20"  onclick="window.close()"></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
