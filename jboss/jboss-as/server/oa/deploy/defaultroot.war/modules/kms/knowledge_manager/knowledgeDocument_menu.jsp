<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.resource.bd.*" %>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.booksmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.Long" %>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.ezoffice.workflow.vo.*" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD,com.whir.ezoffice.officemanager.bd.EmployeeBD" %>
<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	int menuIndex=0;
	//此处公共业务逻辑
	ManagerBD mBD = new ManagerBD();
	com.whir.ezoffice.workflow.newBD.ProcessBD procbd = new com.whir.ezoffice.workflow.newBD.ProcessBD();
	
	String domainId    = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
	String userId      = session.getAttribute("userId").toString();
	String orgId       = session.getAttribute("orgId").toString();
	String orgIdString = session.getAttribute("orgIdString").toString();
	
	EmployeeBD empBD=new EmployeeBD();
	List singleEmpList = empBD.selectSingle(new Long(userId));
	String sidelineorgStr = "";
	if(singleEmpList!=null&&singleEmpList.size()>0){
		Object[] __empObj = (Object[])singleEmpList.get(0);
		com.whir.org.vo.usermanager.EmployeeVO __empVO = (com.whir.org.vo.usermanager.EmployeeVO)__empObj[0];
		sidelineorgStr = __empVO.getSidelineOrg()!=null?__empVO.getSidelineOrg():"";
	}
	
	CustomerMenuDB cmdb=new CustomerMenuDB();
	String codes=",officemanager_resource,officemanager_resource_voiture,officemanager_resource_books,officemanager_resource_boardroom,officemanager_resource_equipment,officemanager_voituremanager,officemanager_goodsmanager,officemanager_humanresouce,officemanager_booksmanager,officemanager_cardmanager,officemanager_netsurvey,officemanager_question,officemanager_dossier,officemanager_meeting,officemanager_equipmentmanger,officemanager_examination,officemanager_keepwatchplan,officemanager_projectmanager,officemanager_namecard,officemanager_assetManger,officemanager_contractmanager,hospital_checkwork,hospital_scheduling,";
	String canShowMenus=cmdb.getShowMenu(codes,domainId);
	List archProcList = procbd.getUserProcess(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), "12");
	String[] tmpStr = {"0", "", "0", ""};
	
    //boolean setRight=managerBD.hasRight(session.getAttribute("userId").toString(), "02*02");
    com.whir.ezoffice.knowledge.bd.CategoryBD bd1=new com.whir.ezoffice.knowledge.bd.CategoryBD();
    List list =bd1.getAllCategory();
%>
<script type="text/javascript">
	var zNodes = [
	  			{id:<%=menuIndex%> ,pId:-1, name:'我的文档',url:'Document!list.action',target:'mainFrame',  iconSkin:"fa fa-folder fa"}
	  			<%
	  			int channelLevel = 0;
	  			String channelId = "";
	  			String channelName = "";
	  			int channelParentId = 0;
	  			int a=1,m=0;
	  			String href = "";
	  			ArrayList alist = new ArrayList();
	  			%>
	  			<%
	  			for(int j = 0; j < list.size(); j ++){
	  				a = a + 1;
	  				Object[] obj = (Object[]) list.get(j);
	  				channelId = obj[0].toString();
	  				channelName = obj[1].toString();
	  				channelParentId = Integer.parseInt(obj[2].toString());
	                  channelLevel = Integer.parseInt(obj[3].toString());
	  				
	  				alist.add(j,channelId+"");
	  				if(channelLevel == 1){
	  					
	  						href = "Document!list.action?channelId=" + obj[0] + "&channelName=" + obj[1];
	  					
	  			%>
	  			,{id:<%=channelId%>,pId:<%=menuIndex%>,name:'<%=channelName%>',url:'<%=href%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  				}else{
	  					for(m = 0; m < a ; m ++){
	  						if(alist.get(m).equals(channelParentId+"")){
	  							break;
	  						}
	  					}
	  					
	  						href = "Document!list.action?channelId=" + obj[0] +  "&channelName=" + obj[1];
	  			%>
	  			,{id:<%=channelId%>,pId:<%=channelParentId%>,name:'<%=channelName%>',url:'<%=href%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  				}
	  			}
	  			%>
	  			
	  			<%menuIndex++;%> 
	  			,{id:'a-<%=menuIndex%>' ,pId:-1, name:'所有文档',url:'Document!listAll.action',target:'mainFrame', iconSkin:"fa fa-folder fa"}
	  			<%
	  			int channelLevel1 = 0;
	  			String channelId1 = "";
	  			String channelName1 = "";
	  			int channelParentId1 = 0;
	  			int b=1,n=0;
	  			String href1 = "";
	  			ArrayList alist1 = new ArrayList();
	  			%>
	  			<%
	  			for(int i = 0; i < list.size(); i ++){
	  				b = b + 1;
	  				Object[] obj1 = (Object[]) list.get(i);
	  				channelId1 = obj1[0].toString();
	  				channelName1 = obj1[1].toString();
	  				channelParentId1 = Integer.parseInt(obj1[2].toString());
	                  channelLevel1 = Integer.parseInt(obj1[3].toString());
	  				
	  				alist1.add(i,channelId1+"");
	  				if(channelLevel1 == 1){
	  					
	  						href1 = "Document!listAll.action?channelId1=" + obj1[0] + "&channelName1=" + obj1[1];
	  					
	  			%>
	  			,{id:'b-<%=channelId1%>',pId:'a-<%=menuIndex%>',name:'<%=channelName1%>',url:'<%=href1%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  				}else{
	  					for(n = 0; n < b ; n ++){
	  						if(alist1.get(n).equals(channelParentId1+"")){
	  							break;
	  						}
	  					}
	  					href1 = "Document!listAll.action?channelId1=" + obj1[0] +  "&channelName1=" + obj1[1];
	  			%>
	  			,{id:'b-<%=channelId1%>',pId:'b-<%=channelParentId1%>',name:'<%=channelName1%>',url:'<%=href1%>',target:'mainFrame', iconSkin:"fa fa"}
	  			<%
	  				}
	  			}
	  			%>
	  			<%menuIndex++;%>
	        <%if(mBD.hasRight(userId, "KNOWLEDGEDOC*01*01")){ %> 
	  			,{id:'menuTitleBox<%=menuIndex%>' ,pId:'-1', name:'分类设置',url:'<%=rootPath%>/Category!list.action',target:'mainFrame', iconSkin:"fa fa-cog fa"}
	  			<%menuIndex++;%>
	  		 <%}%>
	         <%
	            String menutype = "knowledge_document";
	         %>
	         <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
	  		];
			/*$(document).ready(function(){ 
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			});*/
		function whir_initMenu(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		}
	</script>
	
	<div class="wh-l-msg">
    	<a class="clearfix">
        <i class="fa fa-color fa-book"></i>
       	<span>文库</span>
        </a>
    </div>
    <div class="wh-l-con">
     	<ul id="treeDemo" class="ztree"></ul>
    </div>