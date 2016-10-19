<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD"%>
<%@ include file="/public/include/init.jsp"%>
<%
   String localcom = session.getAttribute("org.apache.struts.action.LOCALE").toString();
   Object[] obj =null;
   java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
   java.util.List officelist_w = new WorkFlowBD().getOffiDict(session.getAttribute("userId").toString(), session.getAttribute("domainId").toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=Resource.getValue(localcom,"filetransact","file.bulkhandling")+Resource.getValue(localcom,"filetransact","file.review")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	 <SCRIPT LANGUAGE="JavaScript">
	 <!--
	 var api =null;
	 var W=null;
     //api=frameElement.api, W = api.opener; 
	 //-->
	 </SCRIPT>
	 <style type="text/css">
		<!--
		#noteDiv {
			position:absolute;
			width:220px;
			height:126px;
			z-index:1;
			overflow:auto;
			border:1px solid #829FBB;
			display:none;
			background-color:#ffffff;
		}
		#noteDiv1 {
			position:absolute;
			width:220px;
			height:126px;
			z-index:1;
			overflow:auto;
			border:1px solid #829FBB;
			display:none;
		}
		.divOver{
			background-color:#003399;
			color:#FFFFFF;
			border-bottom:1px dashed #cccccc;
			width:100%;
			height:20px;
			line-height:20px;
			cursor:default;
			padding-left:5px;
		}
		.divOut{
			background-color:#ffffff;
			color:#000000;
			border-bottom:1px dashed #cccccc;
			width:100%;
			height:20px;
			line-height:20px;
			cursor:default;
			padding-left:5px;
			white-space:nowrap;
		}
		-->
	</style>
</head>
<body >
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	      <s:form name="dataForm" id="dataForm" action="wfoperate!batchRead.action" method="post" theme="simple" >
		     <input type="hidden" name="addDivContent"  id="addDivContent" value=""> <!-- 在  常用语中用到-->
		     <%@ include file="/public/include/form_detail.jsp"%>
		     <s:hidden  name="batchValues" id="batchValues" />
			 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Table_bottomline" >
			 <tr>
				  <td width="85" valign="top"  class="td_lefttitle"  > </td>
				  <td> 
					 <div align="right"   style="text-align:right;"><a  id="trigger1" href="javascript:;"  rel="noteDiv" ><!-- 常用语 --><%=Resource.getValue(localcom,"workflow","workflow.Frequentusedwords")%></a></div>
					 <div id="noteDiv"  value="content" >
						<%
						  if(officelist_w!=null&&officelist_w.size()>0){
						   for(int i=0;i<officelist_w.size();i++){
							 String offContent=""+officelist_w.get(i);%>
							  <div class="divOut"  onmouseover="this.className='divOver'" onmouseout="this.className='divOut'" onclick="include_set_comment(this,'content')"><%=offContent%></div>
						   <%}
						}
						%>
						 <div class="divOut"><a href="#"  onclick="addOffical();">>><!-- 添加 --><%=Resource.getValue(localcom,"workflow","workflow.newactivitydefineadd")%></a></div>
					 </div> 
				  </td>
				  <td>&nbsp;</td>
				</tr> 
				<tr>
				  <td width="85" valign="top"  class="td_lefttitle"  for='<bean:message bundle="filetransact" key="file.dealcomment"/>'>
				  <bean:message bundle="filetransact" key="file.dealcomment"/>：
				  </td>
				  <td ><textarea  name="content"  id="content" cols="50" Class="inputTextarea"  style="height:120px;width:100%;border:1px solid #cccccc;height:expression((this.scrollHeight+2)<120?120:this.scrollHeight+2)" whir-options="vtype:[{'maxLength':1000},'spechar3'] "   >已阅</textarea>	
				  </td>
				  <td>&nbsp;</td>
				</tr> 
				<tr class="Table_nobttomline">
				  <td></td>
				  <td colspan="2">
					   <input name="input2" type="button" value='<%=Resource.getValue(localcom,"workflow","workflow.button_ok")%>' class="btnButton4font" onclick="ok('0',this);" />
					   <input name="input2"  type="button" value='<%=Resource.getValue(localcom,"workflow","workflow.button_cancel")%>' class="btnButton4font" onclick="thisClose();" />
				  </td>
				</tr>
			  </table>
	      </s:form>
		</div>
	</div>
</body>
<script type="text/javascript">

    initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'<%=Resource.getValue(localcom,"workflow","workflow.deal")%>'});

	 /**
	 常用语添加
	*/
	function addDivContent(){
		var adddivcontent=$("#addDivContent").val();
		var comment=document.getElementById("noteDiv").getAttribute("value");
		document.getElementById("noteDiv").innerHTML= ""+"<div class='divOut' onmouseover='this.className=\"divOver\"' onmouseout='this.className=\"divOut\"' onclick=\"include_set_comment(this,\'"+comment+"\');\">"+adddivcontent+"<\/div>"+document.getElementById("noteDiv").innerHTML;
	}

	/**
	新加常用语
	*/
	function  addOffical(){
		//
		var openurl='<%=rootPath%>/OfficalDictionAction!addOfficalDiction.action';
		openWin({url:openurl,width:600,height:300,winName:''});
	}

 
    // 给 常用语添加 弹出层
    $("#trigger1").powerFloat();

	/**
	设置批示意见框里的值
	*/
	function include_set_comment(obj,commentName){
		var val=$(obj).text();
		var  cobj=document.getElementById(commentName);
		if(cobj.length){
			cobj[0].value=cobj[0].value+val;
		} else{
			cobj.value=cobj.value+val;
		}
	}
 
	/**
	关闭当前的对话框
	*/
	 function  thisClose(){
		 // $.dialog({id:'workflowDialog'}).close(); 
		 window.close();
	 }

</script>
</html>
 