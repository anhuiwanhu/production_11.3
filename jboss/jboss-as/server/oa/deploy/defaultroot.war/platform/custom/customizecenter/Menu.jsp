<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.customize.customerCenter.common.CustomerCenterConfig" %>
<%@ page import="com.whir.ezoffice.customize.customerCenter.po.CustomerCenterModPO" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD" %>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader ("Expires", 0);   
int menuIndex=0;  
%>  
<div class="wh-l-msg">
	<a href="#" class="clearfix">
		<i class="fa fa-link fa-color"></i>
		<span>
			关系
		</span>
	</a>
</div>
<div class="wh-l-con">
	<ul id="treeDemo" class="ztree"></ul>
</div>
   
<SCRIPT type="text/javascript">    
	<!--    
	var zNodes =[   
	<%
	  boolean add_dh=false;
	  List ModList = (List)request.getAttribute("ModList");
	  List ScopeList = (List)request.getAttribute("ScopeList");

	  if(ModList.size() >0){
		   String    Id ;
		   String  ModName ;
		   String  ModLevel;
		   String ParentId;
		   String  TableId;
		   String  ModClassId;
		   String rightscope;
		   String rightcode;

		   for(int i=0;i<ModList.size();i++){
		   
			  CustomerCenterModPO po = (CustomerCenterModPO) ModList.get(i);
			  Id = po.getId()+"";
			  ModName = po.getModName();
			  ModLevel = po.getModLevel();
			  ParentId = po.getParentId()+"";
			  TableId = po.getTableId()+"";
			  ModClassId = po.getModClassId();
			  rightscope = (String) ScopeList.get(i);
			  rightcode = po.getRightCode();

			String rightcodemanage="";
			if(rightcode != null && !"".equals(rightcode)){
			
				String[] rightcodes = rightcode.split("\\*") ;
				String tmp0 = rightcodes[0] +"*"+ rightcodes[1];
				String tmp1 = "*"+"02";
				rightcodemanage= tmp0 + tmp1;

			}

	%>

		  <%if("1".equals(ModLevel)){%>
			<%if(add_dh){%>,<%}else{add_dh=true;}%>{ id:<%=Id%>, pId:-1, name:"<%=ModName%>", target:'mainFrame',iconSkin:"fa fa"}
		  <%}else{%>
			<%if(add_dh){%>,<%}else{add_dh=true;}%>{ id:<%=Id%>, pId:<%=ParentId%>, name:"<%=ModName%>", target:'mainFrame', open:true, url:"<%=rootPath%>/custinfo!custRightList.action?CENTERID=<%=Id%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>",iconSkin:"fa fa"}
		  <%}%>

		  <%}%>
	  <%}%> 

	  <%menuIndex=111111;%> 
	  <%
		String menutype = "customercenter";
	  %>
	  <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>

	 ];  
     
	  

      if(zNodes.length>0){
			 var first=zNodes[0];
			 if(typeof first == "undefined"){
				   zNodes.splice(0,1); 
			 }else{ 
			 }   
	  } 

	  /* 
	  var resultStr=testStr.replace(/\ +/g,"");//去掉空格
      resultStr=testStr.replace(/[ ]/g,"");    //去掉空格
      resultStr=testStr.replace(/[\r\n]/g,""));//去掉回车换行 
	  
	  */

	 $(document).ready(function(){
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	}); 
	//-->    
</SCRIPT>            
<SCRIPT LANGUAGE="JavaScript">  
<!--  
$(function() {  
    OpenCloseSubMenu(0);  
});  
//-->  
</SCRIPT> 