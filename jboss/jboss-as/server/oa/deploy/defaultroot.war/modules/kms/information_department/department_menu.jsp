<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	int menuIndex=0;
	List myOrgList=new ArrayList();
	String  sidelineOrg="";
	com.whir.ezoffice.personalwork.setup.bd.OrgWrapBD orgWrapBD = new com.whir.ezoffice.personalwork.setup.bd.OrgWrapBD();
	List orgWrapBDList=orgWrapBD.getShowOrgList(session.getAttribute("userId").toString());

	if(orgWrapBDList!=null&&orgWrapBDList.size()>0){
	    for(int i=0;i<orgWrapBDList.size();i++){
		    sidelineOrg+="*"+orgWrapBDList.get(i)+"*";
		}
	}else{
		List  userList=new com.whir.org.bd.usermanager.UserBD().getUserInfo(new Long(session.getAttribute("userId").toString()));
		if(userList!=null&&userList.size()>0){
			Object [] userObj=(Object [])userList.get(0);
			//兼职组织的id串
			sidelineOrg  =userObj[23]==null?"":userObj[23].toString();
		}
	}
	sidelineOrg+="*"+session.getAttribute("orgId")+"*";
%>
<script type="text/javascript">
	function setFontCss(treeId,treeNode){
		return treeNode.fontcolor == "1" ? {color:"#696969"} : {color:"#bcbcbc"};
	}
</script>
<script type="text/javascript">
	var setting2 = {
            view: {
                selectedMulti: false,
                fontCss: setFontCss,
				dblClickExpand: false
            },
            check: {
                enable: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            edit: {
                enable: false
            },
			callback: {
			  onClick: onClick2
			} 
		}; 

	function onClick2(e,treeId, treeNode) {
		 var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		 zTree.expandNode(treeNode);
    };  
	var zNodes = [
		{id:'<%=menuIndex%>' ,pId:-1, name:'<bean:message bundle="information" key="info.all" />',url:'<%=rootPath%>/InfoList!allList.action?type=all&channelType=-1&userChannelName=单位主页&userDefine=0&checkdepart=1',target:'mainFrame', iconSkin:"fa fa-file fa", fontcolor:"1"}
	  			<%
	  			String domainId = CommonUtils.getSessionDomainId(request).toString();
	  			OrganizationBD organizationBD = new OrganizationBD();
	  			java.util.List list = organizationBD.getSimpleOrgWithScope(session.getAttribute("userId").toString(), session.getAttribute("orgId").toString(),				 session.getAttribute("orgIdString").toString() , session.getAttribute("ownerGroupIdStr").toString() , domainId);
	  			String orgId = "";
	  			String orgName = "", tmpOrgName="";
	  			int orgLevel = 0;
	  			int orgParentId = 0;
	  			Object[] objj = null;
	  			java.util.ArrayList alist = new java.util.ArrayList();
	  			int a=-1,k=0;
	  			String href = "";
	  			String node;
	  			int orgHasChannel=0;
	  			String orgChannelType="";
	  			String orgChannelUrl="";
	  			String orgStyle = "";
	  			%>
	  			<%
	  			for(int j = 0; j < list.size(); j ++){
	  				String isWebURL ="0";
	  				a ++;
	  				objj    = (Object[]) list.get(j);
	  				orgId   = objj[0].toString();
	  				orgName = objj[1].toString();
	  				orgHasChannel = Integer.parseInt(objj[2].toString());
	  				orgLevel    = Integer.parseInt(objj[3].toString()) + 1;
	  				orgParentId = Integer.parseInt(objj[4].toString());
	  				orgChannelType = objj[5]==null?"":objj[5].toString();
	  				orgChannelUrl = objj[6]==null?"":objj[6].toString();
	  				orgStyle = objj[7]==null?"":objj[7].toString();
	  				if(sidelineOrg.indexOf("*"+orgId+"*")>=0&&orgHasChannel>=1){
	  					String[] myorgString={orgId,orgName,""+orgHasChannel,orgChannelType,orgChannelUrl,orgStyle};
	  					myOrgList.add(myorgString);
	  				}
	  				tmpOrgName = orgName;
	  				if(orgHasChannel >=1 ){
	  					//tmpOrgName = "<img src=images/w.gif>"+tmpOrgName;
	  				}else{
	  					//tmpOrgName = "<font color=\\\"gray\\\">"+tmpOrgName+"</font>";
	  				}
	  				alist.add(j,orgId + "");
	  				if(orgLevel == 1){//第一级
	  					if(orgHasChannel!=0){//有单位主页
	  						href = "modules/kms/information_department/department_index.jsp?orgId="+orgId+"&orgName="+orgName;
	  						if(orgStyle.equals("default/darkblue")){
	  							href = "modules/kms/information_department/department_index1.jsp?orgId="+orgId+"&orgName="+orgName;
	  						}
	  					}else{//没有单位主页
	  						href = "";
	  					}
	  					//当有 单位主页 且 单位主页为外部地址
	  					if(orgHasChannel >=1&&orgChannelType.equals("1")){
	  						href=orgChannelUrl;
	  						isWebURL ="1";
	  					}
	  				}else{//不是第一级 寻找第一级 节点
	  					for(k = 0; k < a; k ++){
	  						if(alist.get(k).equals(orgParentId + "")){
	  							break;
	  						}
	  					}
	  					if(orgHasChannel!=0){//有单位主页
	  						href = "modules/kms/information_department/department_index.jsp?orgId="+orgId+"&orgName="+orgName;
	  						if(orgStyle.equals("default/darkblue")){
	  							href = "modules/kms/information_department/department_index1.jsp?orgId="+orgId+"&orgName="+orgName;
	  						}
	  					}else{//没有单位主页
	  						href="";
	  					}
	  					//当有 单位主页 且 单位主页为外部地址
	  					if(orgHasChannel >=1&&orgChannelType.equals("1")){
	  						href=orgChannelUrl;
	  						isWebURL ="1";
	  					}
	  				}
	  				if("".equals(href)){
	  			%>
	  				,{id:<%=orgId%>,pId:<%=orgParentId%>,name:'<%=tmpOrgName%>',url:'',target:'mainFrame', iconSkin:"fa fa"}
	  			<%	
	  				}else{
	  			%>
	  				<%if("1".equals(isWebURL)){%>
	  				,{id:<%=orgId%>,pId:<%=orgParentId%>,name:'<%=tmpOrgName%>',target:'_blank',url:'<%=href%>', iconSkin:"fa fa", fontcolor:"1"}
	  				<%}else{%>
	  				,{id:<%=orgId%>,pId:<%=orgParentId%>,name:'<%=tmpOrgName%>',target:'_blank',open:false,click:"openWin({url:encodeURI(\'<%=href%>\'),isFull:true,winName:'orgChannelUrl<%=orgId%>'});", iconSkin:"fa fa", fontcolor:"1"}
	  				<%}%>
	  			<%
	  				}
	  			}
	  			%> 
	  			
				<%if(myOrgList!=null&&myOrgList.size()>0){%>
	  			<%menuIndex++;%>
	  			,{id:<%=menuIndex%>,pId:-1,name:'<bean:message bundle="information" key="info.Mydepartment" />',target:'mainFrame', iconSkin:"fa fa-file-text fa"}
	  			
	  			<%
	  			for(int ii=0;ii<myOrgList.size();ii++){
	  				String isWebURL ="0";
	  				String[] myorgString = (String [])myOrgList.get(ii);
	  				String morgId   = myorgString[0].toString();
	  				String morgName = myorgString[1].toString();
	  				String morgHasChannel  = myorgString[2].toString();
	  				String morgChannelType = myorgString[3].toString();
	  				String morgChannelUrl  = myorgString[4].toString();
	  				String morgSytle  = myorgString[5].toString();
	  				int  hasChannel=Integer.parseInt(morgHasChannel);
	  				if(hasChannel!=0){// 默认的第2种样式
	                      href="modules/kms/information_department/department_index.jsp?orgId="+morgId+"&orgName="+morgName;
	  					if(morgSytle.equals("default/darkblue")){
	  						href = "modules/kms/information_department/department_index1.jsp?orgId="+morgId+"&orgName="+morgName;
	  					}
	                  }
	  			    //当有 单位主页 且 单位主页为外部地址
	  				if(hasChannel >=1&&morgChannelType.equals("1")){
	                      href=morgChannelUrl;
	                      isWebURL ="1";
	  				}
	  			%>
	  				<%if("1".equals(isWebURL)){%>
	  				,{id:'my-<%=morgId%>',pId:<%=menuIndex%>,name:'<%=morgName%>',target:'mainFrame',url:'<%=href%>', iconSkin:"fa fa", fontcolor:"1"}
	  				<%}else{%>
	  				,{id:'my-<%=morgId%>',pId:<%=menuIndex%>,name:'<%=morgName%>',target:'mainFrame',open:true,click:"openWin({url:encodeURI(\'<%=href%>\'),isFull:true,winName:'myOrgChannelUrl<%=orgId%>'});", iconSkin:"fa fa", fontcolor:"1"}
	              	<%}%>
	              <%
	  			}
	  			%> 
	  			<%}%>
	  			
				<%menuIndex++;%>
	  			,{id:<%=menuIndex%>,pId:-1,name:'<bean:message bundle="information" key="info.feature" />',url:'<%=rootPath%>/InfoList!allList.action?type=good&channelType=-1&userChannelName=单位主页&userDefine=0&checkdepart=1',target:'mainFrame', iconSkin:"fa fa-file-text fa", fontcolor:"1"}
	  			
	  			<%menuIndex++;%>
	  			<%
	  			String channelType = "-1";
	  			String menutype = "";
	  			if ("-1".equals(channelType)) {
	  				menutype = "dapartment";
	  			}else{
	  				menutype = "userChannel_"+channelType;
	  			}
	  			%>
	  			<%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
	  			
	  			
	  			];
	  			$(document).ready(function(){
	  				$.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
	  			});
</script>

	<div class="wh-l-msg">
    	<a class="clearfix">
        <i class="fa fa-cog fa-color fa-globe"></i>
       	<span><bean:message bundle="common" key="comm.dapartment" /></span>
        </a>
     </div>
     <div class="wh-l-con">
     	<ul id="treeDemo2" class="ztree"></ul>
     </div>