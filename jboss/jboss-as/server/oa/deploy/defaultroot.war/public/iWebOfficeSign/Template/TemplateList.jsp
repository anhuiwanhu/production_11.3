<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%
request.setCharacterEncoding("UTF-8");
String  moduleType=request.getParameter("moduleType")==null?"govdocument":request.getParameter("moduleType").toString();

String search_tempName=request.getParameter("search_tempName")==null?"":request.getParameter("search_tempName").toString();
//String rootPath ="defaultroot";
%>
<html>
<head>
<title>模板管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
	<%@ include file="/public/include/meta_base.jsp"%>
<link href="skin/<%=session.getAttribute("skin")%>/style.css" rel="stylesheet" type="text/css" />
<script language="javascript">
function ConfirmDel(FileUrl){
	if( confirm('确定删除该模板吗？' ))
	location_href(FileUrl);// location.href=FileUrl;
}
<%
String haveRight=request.getParameter("haveRight")+"";
%>
function init(){
<%if("yes".equals(haveRight)){
	if("false".equals(request.getParameter("mResult"))){
%>
		alert("保存失败，数据库中已存在相同的模板");
<%}}else{%>
	//window.opener='xxx';
	//window.close();
<%}%>
}

<%
if("xxbs".equals(request.getParameter("moduleType"))){
	com.whir.org.manager.bd.ManagerBD mBD =  new com.whir.org.manager.bd.ManagerBD();
	boolean sz = mBD.hasRight(session.getAttribute("userId").toString(), "sft*01*03");
	if(!sz){
		%>
			window.close();		
		<%
	}
}
%>
</script>
</head>

<body class="MainFrameBox" onLoad="init();">
	<div align="center" style="font-size:16"><font  style="FONT-SIZE: 18px" color=ff0000>模板管理</font></div>

	<!--这里的表单id queryForm 允许修改 -->
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
		
         <tr>
            <td  class="TDStyle">&nbsp;&nbsp;模板名称：<input type="text" id="search_tempName" name="search_tempName" size="16" cssClass="inputText" Class="inputText"  style="width:200px;" value="<%=search_tempName%>" onkeydown="var keycode = event.keyCode;if(13==keycode) searcher()"/>
			<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="searcher();"  value="立即查找" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="清  除" onclick="unsearcher();" />
			
			</td>
            <td colspan="6" class="TDStyle">
				 
	        </td>
            <td colspan="2" align="right">
				
				
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    

	

<body bgcolor="#ffffff" >


<SCRIPT LANGUAGE="JavaScript">
<!--

$(document).ready(function(){		
			
	});
    function keydown(){
	     if(window.event)
             keyPressed = window.event.keyCode; // IE
         else
             keyPressed = e.which; // Firefox
         if(keyPressed==13)
         { 
             searcher();            
           return false;
         }
    }
    
	function  searcher(){

		if(document.getElementsByName("search_tempName")[0].value.indexOf("'")>=0 ){
			alert("模板名称查询条件不能有非法字符！");	
		}else{
			//window.location.href=encodeURI("/defaultroot/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=<%=haveRight%>&search_tempName="+document.getElementsByName("search_tempName")[0].value+"&moduleType=<%=moduleType%>");
			location_href(encodeURI("/defaultroot/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=<%=haveRight%>&search_tempName="+document.getElementsByName("search_tempName")[0].value+"&moduleType=<%=moduleType%>"));
		}
	}

    function unsearcher(){
		location_href("<%=rootPath%>/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=<%=haveRight%>&moduleType=<%=moduleType%>");
		//window.location.href="<%=rootPath%>/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=<%=haveRight%>&moduleType=<%=moduleType%>";

	}

//-->
</SCRIPT>
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
	<tr>
		<td colspan=3 class="TDTitleStyle" nowrap>
		  <input type=button name="AddDocTemplate" value="新建Word模板"  onclick="javascript:location_href('TemplateEdit.jsp?FileType=.doc&moduleType=<%=moduleType%>');">
		  <%
			if(!"hrm".equals(moduleType)){
		  %>
		  <input type=button name="AddXslTemplate" value="新建Excel模板" onClick="javascript:location_href('TemplateEdit.jsp?FileType=.xls&moduleType=<%=moduleType%>');">
		  <%}%>
		  <!-- <input type=button name="Return" value="返 回"  onclick="javascript:location.href='../DocumentList.jsp';"> -->
		</td>
		<td colspan=3 class="TDTitleStyle">&nbsp;</td>
	</tr>
	<tr>
		<td nowrap align=center class="TDTitleStyle" height="26">编号</td>
		<td nowrap align=center class="TDTitleStyle">模板名称</td>
		<td nowrap align=center class="TDTitleStyle">模板类型</td>
		<td nowrap align=center class="TDTitleStyle">模板说明</td>
		<td nowrap align=center class="TDTitleStyle">操作</td>
	</tr>
<%
  
  String domainId = session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString();

   ManagerBD  managerBD =new ManagerBD();
   String scopeSQl= managerBD.getRightFinalWhere(session.getAttribute("userId").toString(),session.getAttribute("orgId").toString(),"03*03*01", "Template_File.createOrg", "Template_File.createEmp");

  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  
  if (DbaObj.OpenConnection())
  {
    try
    {
         String addwhere=" ";
		 if(search_tempName!=null&&!search_tempName.equals("")){
	      addwhere="  and FileName like '%"+search_tempName+"%'  ";    
	    }

	    String sqls="Select RecordID,FileName,FileType,Descript From Template_File where DOMAIN_ID=" + domainId + "  and (createEmp="+session.getAttribute("userId").toString()+" or ( "+scopeSQl+" ) or  createEmp is null or canModifyEmpId like '%$"+session.getAttribute("userId").toString()+"$%')  and    moduleType='"+moduleType+"'"+addwhere+" order by TemplateID desc";
	 
      ResultSet result=DbaObj.ExecuteQuery(sqls) ;
      while ( result.next() )
      {
        String mRecordID=result.getString("RecordID");
        String mFileName=result.getString("FileName");
        String mFileType=result.getString("FileType");
        String mDescript=result.getString("Descript");
%>
	<tr>
		<td class="TDStyle"><%=mRecordID%>&nbsp;</td>
		<td class="TDStyle"><%=mFileName%>&nbsp;</td>
		<td class="TDStyle"><%=mFileType%>&nbsp;</td>
		<td class="TDStyle"><%=mDescript==null?"":mDescript%>&nbsp;</td>
		<td class="TDStyle" width=148 nowrap>
			<input type=button onClick="location_href('TemplateEdit.jsp?RecordID=<%=mRecordID%>&FileType=<%=mFileType%>&moduleType=<%=moduleType%>');" name="Edit" value=" 修 改 ">
			<input type=button onClick="javascript:ConfirmDel('TemplateDel.jsp?RecordID=<%=mRecordID%>&moduleType=<%=moduleType%>');" name="Del" value=" 删 除 ">
		</td>
	</tr>
<%
      }
      result.close() ;
    }
    catch(Exception e)
    {
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }
  else
  {
    out.println("OpenDatabase Error") ;
  }
%>
</table>

</body>
</html>
