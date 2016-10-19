<%@ include file="/public/include/xhtml1.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	List list = (List) request.getAttribute("channelList");
	String channelType = request.getAttribute("channelType").toString();
	String userChannelName = request.getAttribute("userChannelName").toString();
	String menuName = request.getParameter("menuName")==null?"":request.getParameter("menuName").toString();
	String userDefine = request.getParameter("userDefine")==null?"0":request.getParameter("userDefine");
	int menuIndex=0;
    String workflowType = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("workflowType", session.getAttribute("domainId")+"");
    String expNodeCode = request.getParameter("expNodeCode");
%>

<script type="text/javascript">
	var zNodes = [
		{id:'a-<%=menuIndex%>' ,pId:-1, name:'<bean:message bundle="information" key="info.all" />',url:'InfoList!allList.action?type=all&channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>',target:'mainFrame', iconSkin:"fa fa-file fa"}
	  			<%
	  			int channelLevel = 0;
	  			String channelId = "";
	  			String channelName = "";
	  			int channelParentId = 0;
	  			int a=1,k=0;
	  			String canReadChannel = request.getAttribute("canReadChannel").toString();
	  			String href = "";
	  			ArrayList alist = new ArrayList();
	  			%> 
	  			<%
	  			for(int j = 0; j < list.size(); j ++){
	  				a = a + 1;
	  				Object[] obj = (Object[]) list.get(j);
	  				channelId = obj[0].toString();
	  				channelName = obj[1].toString();
	  				channelLevel = Integer.parseInt(obj[2].toString());
	  				channelParentId = Integer.parseInt(obj[3].toString());
	  				
	  				alist.add(j,channelId+"");
	  				if(channelLevel == 1){
	  					if(canReadChannel.indexOf(obj[0]+"") >= 0){
	  						href = "InfoList!allList.action?channelId=" + obj[0] + "&channelType=" + channelType + "&channelName=" + obj[1]  + "&userChannelName=" + userChannelName + "&channelShowType=" + obj[4] + "&userDefine=" + userDefine;
	  					}else{
	  						href = "";
	  					}
	  			%>
	  			,{id:'<%=channelId%>',pId:'a-<%=menuIndex%>',name:'<%=channelName%>',url:'<%=href%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  				}else{
	  					/*for(k = 0; k < a ; k ++){
	  						if(alist.get(k).equals(channelParentId+"")){
	  							break;
	  						}
	  					}*/
	  					if(canReadChannel.indexOf(obj[0]+"") >= 0){
	  						href = "InfoList!allList.action?channelId=" + obj[0] + "&channelType=" + channelType + "&channelName=" + obj[1]  + "&userChannelName=" + userChannelName + "&channelShowType=" + obj[4] + "&userDefine=" + userDefine;
	  					}else{
	  						href = "";
	  					}
	  			%>
	  			,{id:'<%=channelId%>',pId:'<%=channelParentId%>',name:'<%=channelName%>',url:'<%=href%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  				}
	  			}
	  			%>
	  			<%menuIndex++;%>
	  			,{id:'b-<%=menuIndex%>',pId:-1,name:'<bean:message bundle="information" key="info.feature" />',url:'InfoList!allList.action?type=good&channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>',target:'mainFrame', iconSkin:"fa fa-file-text fa"}
	  			 
	  			<%menuIndex++;%> 
	  			,{id:'b-<%=menuIndex%>',pId:-1,name:'<bean:message bundle="information" key="info.wholeSearch" />',url:'InfoList!allList.action?type=all&channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>&onlyRetrievalAll=1',target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  	  		String infoMana = request.getAttribute("infoMana").toString();
	  	  		String addTemplate = request.getAttribute("addTemplate").toString();
	  	  		int j = 0;
	  	  		%>
	  			<%if(((Integer)request.getAttribute("userIssueInfoCount")).intValue() > 0){
	  		   	menuIndex++;%>
	   			,{id:'d-<%=menuIndex%>',pId:-1,name:'<bean:message bundle="information" key="info.mypulication" />',url:'InfoList!myIssue.action?channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>',target:'mainFrame', iconSkin:"fa fa-my-release fa"}
	  			<%}
	  			if(request.getAttribute("canIssue").toString().equals("1")){
	  			%>
	  	  	<%menuIndex++;%> 
	  	   	,{id:'d-<%=menuIndex%>',pId:-1,name:'<bean:message bundle="information" key="info.newcontent" />',url:'', click:"javascript:openWin({url:'Information!add.action?channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>',isFull:true,winName:'newInfo'})",target:'mainFrame', iconSkin:"fa fa-pencil-square-o fa"}
	  			<%}%>
	  			
	  			<%if(infoMana.equals("1")){%>
	  	  		<%menuIndex++;%> 
	  	   	,{id:'d-<%=menuIndex%>',pId:-1,name:'<bean:message bundle="information" key="info.transactionReview" />',url:'InfoList!allDeal.action?type=all&channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%}%> 
	  		
	  		<%
	  	  	if(infoMana.equals("1")){
	  	  	%>
	  	  	<%menuIndex++;%>
	  		,{id:'c-<%=menuIndex%>',pId:-1,name:'<bean:message bundle="information" key="info.statistics" />',url:'InfoList!allList.action?type=all&channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>&onlyRetrievalAll=1',target:'mainFrame', iconSkin:"fa fa-pie-chart fa"}
	  			
	  			,{id:101, pId:'c-<%=menuIndex%>', name:"<s:text name='info.StatisticsByOrganization'/>", url:"InfoStat!orgStat.action", target:'mainFrame', iconSkin:"fa fa"}   			
				,{id:102, pId:'c-<%=menuIndex%>', name:"<s:text name='info.StatisticsBystaff'/>", url:"InfoStat!userStat.action", target:'mainFrame', iconSkin:"fa fa"}   
	  			,{id:103, pId:'c-<%=menuIndex%>', name:"<s:text name='info.statisticsauthor'/>", url:"InfoStat!authorStat.action", target:'mainFrame', iconSkin:"fa fa"}  
	  			,{id:104, pId:'c-<%=menuIndex%>', name:"<s:text name='info.Statisticsbychannel'/>", url:"InfoStat!channelStat.action", target:'mainFrame', iconSkin:"fa fa"}   				
				,{id:105, pId:'c-<%=menuIndex%>', name:"<s:text name='info.Statisticsbyinformation'/>", url:"InfoStat!infoStat.action", target:'mainFrame', iconSkin:"fa fa"}   			
				,{id:106, pId:'c-<%=menuIndex%>', name:"<s:text name='info.OrganizationTrend'/>", url:"InfoStat!orgStatGraph.action", target:'mainFrame', iconSkin:"fa fa"}   				
				,{id:107, pId:'c-<%=menuIndex%>', name:"<s:text name='info.InformationTrends'/>",url:"InfoStat!infoStatGraph.action", target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  			 com.whir.org.manager.bd.ManagerBD  managerBD=new  com.whir.org.manager.bd.ManagerBD();
	  		     List  manangerList=managerBD.getRightScope(session.getAttribute("userId").toString(),"01*02*01");
	  			 Object[]  manangerobj = (Object[]) manangerList.get(0);
	  	         String manangerscopeType = manangerobj[0].toString();
	  			 if(manangerscopeType.equals("0")){
	  			%>
	  			,{id:108, pId:'c-<%=menuIndex%>', name:"<s:text name='info.PointProgramSet'/>", url:"InfoStat!statSet.action", target:'mainFrame', iconSkin:"fa fa"}
	  			<%}%>
	  		<%}%>

	  		<%menuIndex++;%>	
	  		<%if( (infoMana.equals("1") && !isPad) || (addTemplate.equals("1") && !isPad) ){%>
	  		,{id:'d-<%=menuIndex%>',pId:-1,name:'<bean:message bundle="information" key="info.infosetup" />',url:'',target:'mainFrame', iconSkin:"fa fa"}
	  		<%}%>
			<%if(infoMana.equals("1") && !isPad){%>
	  	  	,{id:201,pId:'d-<%=menuIndex%>',name:'<bean:message bundle="information" key="info.columnsetup" />',url:'Channel!channelList.action?channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%if("2".equals(workflowType) || "1".equals(workflowType)){%>
	  	  	
	  	  	,{id:202,pId:'d-<%=menuIndex%>',name:'<bean:message bundle="information" key="info.processsetup" />',url:'wfprocess!processList.action?moduleId=4',target:'mainFrame', iconSkin:"fa fa"}
	  			<%}%>
	        	<%if("2".equals(workflowType) || "0".equals(workflowType)){%>
	  	  	,{id:203,pId:'d-<%=menuIndex%>',name:'<bean:message bundle="information" key="info.processsetup" />(ezFlow)',url:'ezflowprocess!ezFlowList.action?moduleId=4',target:'mainFrame', iconSkin:"fa fa"}
	  			<%}%>
			<%}%>
	  		<%if(addTemplate.equals("1") && !isPad){%>
	  		,{id:204,pId:'d-<%=menuIndex%>',name:'<bean:message bundle="information" key="info.templatesetup" />',url:'Template!templateList.action',target:'mainFrame', iconSkin:"fa fa"}
	  		,{id:205,pId:'d-<%=menuIndex%>',name:'<bean:message bundle="information" key="info.LabelSettings" />',url:'Template!loadTag.action',target:'mainFrame', iconSkin:"fa fa"}
	  		<%}%>
	      	<%menuIndex++;%>
	  			<%
	  			String menutype = "";
	  			if ("0".equals(channelType)) {
	  				menutype = "information";
	  			}else{
	  				menutype = "userChannel_"+channelType;
	  			}
	  			%>
	  			<%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
	  			
	  			];
	  			
	  			$(document).ready(function(){ 
	  				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	  			});
</script>

<div class="wh-l-msg">
    <% if(!"0".equals(channelType)){ %>
		<a class="clearfix">
	        <i class="fa fa-custom-mod fa"></i>
	       	<span>
		   		<%=menuName%>
	        </span>
		</a>
	<%} else {%>
    	<a href="javascript:void(0)" class="clearfix">
	        <i class="fa fa-comments-o fa"></i>
	       	<span>
		   		<bean:message bundle="information" key="info.information" />
	        	<i class="fa fa-pencil-square-o fa" onClick="javascript:openWin({url:'Information!add.action?channelType=<%=channelType%>&userChannelName=<%=userChannelName%>&userDefine=<%=userDefine%>',isFull:true,winName:'newInfo'})" style="cursor:pointer" title="<bean:message bundle="information" key="info.newcontent" />"></i>
	       	</span>
		</a>
	<%}%>
     </div>
     <div class="wh-l-con">
     	<ul id="treeDemo" class="ztree"></ul>
     </div>

<SCRIPT LANGUAGE="JavaScript">  
$(function() {  
	<%
	  	for(int x = 0; x < list.size(); x ++){
	  		Object[] obj = (Object[]) list.get(x);
	  		String channelId1 = obj[0].toString();
	%>
	if('<%=expNodeCode%>'=='<%=channelId1%>'){
	    OpenCloseSubMenu('<%=expNodeCode%>');   
	}
	<%}%>
});
</SCRIPT>  