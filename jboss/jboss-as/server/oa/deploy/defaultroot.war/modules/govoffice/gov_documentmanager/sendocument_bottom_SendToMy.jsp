<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>


<%

com.whir.integration.realtimemessage.Realtimemessage rutil = new com.whir.integration.realtimemessage.Realtimemessage();

String  nowSend=rutil.getRealTimeMessageType();

String toPerson1Id=request.getParameter("toPerson1Id")==null?"":request.getParameter("toPerson1Id");
String toPerson2Id=request.getParameter("toPerson2Id")==null?"":request.getParameter("toPerson2Id");
String toPersonBaoId=request.getParameter("toPersonBaoId")==null?"":request.getParameter("toPersonBaoId");
String toPersonInnerId=request.getParameter("toPersonInnerId")==null?"":request.getParameter("toPersonInnerId");


String toPerson1=request.getParameter("toPerson1")==null?"":request.getParameter("toPerson1");
String toPerson2=request.getParameter("toPerson2")==null?"":request.getParameter("toPerson2");
String toPersonBao=request.getParameter("toPersonBao")==null?"":request.getParameter("toPersonBao");
String toPersonInner=request.getParameter("toPersonInner")==null?"":request.getParameter("toPersonInner");


String allId=toPerson1Id+toPerson2Id+toPersonBaoId+toPersonInnerId;



String allContent="";
if(!toPerson1.equals("")){
 allContent+=toPerson1+",";
}

if(!toPerson2.equals("")){
allContent+=toPerson2+",";
	
}

if(!toPersonBao.equals("")){
allContent+=toPersonBao+",";
}
if(!toPersonInner.equals("")){
allContent+=toPersonInner+",";
}

//分发范围
String processId = request.getParameter("processId")==null?"":request.getParameter("processId").toString();
String tableId = request.getParameter("tableId")==null?"":request.getParameter("tableId").toString();
String activityId = request.getParameter("activityId")==null?"":request.getParameter("activityId").toString();
String recordId = request.getParameter("recordId")==null?"":request.getParameter("recordId").toString();

String curActivityId = request.getParameter("activityId")==null?"":request.getParameter("activityId").toString();
String participantUserField = "";//表单中的某个字段名
String participantUserFieldType="";//某个字段的类型
 

//参与者类型
//0 流程启动人的上级领导
//1 由上一活动参与者从所有用户中选择
//2 从候选人员中指定
//3 指定全部办理人
//4 由表单中的某个字段值决定
//System.out.println("参与人类型："+nextUser[0]);
String selectUser = "";//待选人员
String selectUserName = "";//待选人员
String selectUserAccounts = "";//待选人员


String tranType = "0";
String tranCustomExtent = "";
String tranCustomExtentId = "";

String range = "*0*";//指定范围
String show = "userorggroup";//显示
String iscontrolRange="1";//是否控制范围；

com.whir.ezoffice.workflow.bd.WorkFlowFormBD workFlowFormBD = new com.whir.ezoffice.workflow.bd.WorkFlowFormBD();
com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD workFlowButtonBD = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD();
com.whir.ezoffice.workflow.newBD.WorkFlowBD workFlowBD = new com.whir.ezoffice.workflow.newBD.WorkFlowBD();
com.whir.ezoffice.workflow.vo.WorkVO vo = new com.whir.ezoffice.workflow.vo.WorkVO();

String[] nextUser = workFlowFormBD.getProcActiUser(tableId,recordId,activityId);
tranType = nextUser[44];
tranCustomExtent = nextUser[45];
tranCustomExtentId = nextUser[46];
//System.out.println("tranType---------------------------------------------"+tranType);
//转本部门
if(request.getParameter("tranType") != null && !"".equals(request.getParameter("tranType"))){
	tranType=request.getParameter("tranType");
}
   

   if("0".equals(tranType) || tranType == null || "".equals(tranType) ){		
		//全部办理人
		range = "*0*";//指定范围
		show = "userorggroup";//显示

	}else if("1".equals(tranType)){
		//本部门
		String sidelineOrg = workFlowButtonBD.getUserSideLineOrgId(session.getAttribute("userId").toString())==null?"":workFlowButtonBD.getUserSideLineOrgId(session.getAttribute("userId").toString());
	    range = "*"+session.getAttribute("orgId")+"*"+sidelineOrg;
		show = "userorg";//显示
		
	} else if("2".equals(tranType)){
		//本单位
		range = "*"+session.getAttribute("orgId").toString()+"*";//指定范围
		show = "userorg";//显示

	} else if("4".equals(tranType)){
		//自定义
		range = tranCustomExtentId;//指定范围
		if(range != null && !range.equals("") && range.indexOf("@") < 0 && range.indexOf("*") < 0){
			show = "user";
		}else if(range != null && !range.equals("") && range.indexOf("@") < 0){
			show = "userorg";
		}else if(range != null && !range.equals("") && range.indexOf("*") < 0){
			show = "usergroup";
		}

	} else if("3".equals(tranType)){

		  //本活动办理人
		if(nextUser[0]!=null && nextUser[0].equals("3")){
			range="";
			//指定全部办理人
			java.util.List candidate = workFlowFormBD.getCandidate(nextUser[1],nextUser[2]);
			for(int i=0;i<candidate.size();i++){
				Object[] tmp = (Object[])candidate.get(i); 
				range +="$"+tmp[0]+"$";
			
			}		 
			show = "userorggroup";

		}

		if(nextUser[0]!=null && nextUser[0].equals("2")){
			//从候选人中指定
			range="";
			java.util.List candidate = workFlowFormBD.getCandidate(nextUser[1],nextUser[2]);
			for(int i=0;i<candidate.size();i++){
				Object[] tmp = (Object[])candidate.get(i); 
				range +="$"+tmp[0]+"$";
				 
			}
			show = "user";
		}

        ///----------------------暂时未确定
		if(nextUser[0]!=null && nextUser[0].equals("4")){
			  //由表单中的某个字段值决定
			  participantUserField = nextUser[4];
			  participantUserFieldType=nextUser[32];	 
			  participantUserField = workFlowButtonBD.getFieldInfoByFieldId(participantUserField);
		}

		if(nextUser[0]!=null && nextUser[0].equals("8")){
			//从指定范围中选定
			range = nextUser[22].toString();
			if(range != null && !range.equals("") && range.indexOf("@") < 0 && range.indexOf("*") < 0){
				show = "user";
			}else if(range != null && !range.equals("") && range.indexOf("@") < 0){
				show = "userorg";
			}else if(range != null && !range.equals("") && range.indexOf("*") < 0){
				show = "usergroup";
			}
		}

		if(nextUser[0]!=null && nextUser[0].equals("9")){
			//由上一活动参与者从所在组织中选择
			//range = "*"+session.getAttribute("orgId")+"*";
			//show = "user";
		}
        
		if(nextUser[0]!=null && nextUser[0].equals("10")){
			//组织领导
			//range = "*"+session.getAttribute("orgId")+"*";
			//show = "org";
		}
         
		if(nextUser[0]!=null && nextUser[0].equals("13")){
			//由上一活动参与者从所有群组中选择
			 //show += "group";
			 range =  nextUser[22].toString();
			 if(range != null){
				show = "usergroup";
			 }
		}

		if(nextUser[0]!=null && nextUser[0].equals("12")){
			//由上一活动参与者从所有组织中选择
			 show = "org";
		}

		if(nextUser[0]!=null && nextUser[0].equals("1")){
			//由上一活动参与者从所有用户中选择
			 show = "user";
		}

		if(nextUser[0]!=null && nextUser[0].equals("11")){
			//上一活动所有参与者
			vo.setProcessId(Long.valueOf(processId));
			vo.setTableId(Long.valueOf(tableId));
			vo.setRecordId(Long.valueOf(recordId));
			vo.setActivity(Long.valueOf(curActivityId));
			range="";

			java.util.List candidate = workFlowButtonBD.getFrontActivityOper(vo);
			for(int i=0;i<candidate.size();i++){
				Object[] tmp = (Object[])candidate.get(i); 
				range += "$"+tmp[0]+"$";
			}
			 
			show = "user";
		}

		if(nextUser[0]!=null && nextUser[0].equals("7")){
			//上一活动办理人的上级领导
			range="";
			String tranFromPersonId = request.getParameter("tranFromPersonId");
			java.util.List leaderList = workFlowBD.getLeaderList(("-1".equals(tranFromPersonId)?session.getAttribute("userId").toString():tranFromPersonId));

			for(int i=0;i<leaderList.size();i++){
				Object[] tmp = (Object[])leaderList.get(i); 
				range += "$"+tmp[0]+"$";
			}
 
			show = "user";
		}

		if(nextUser[0]!=null && nextUser[0].equals("0")){
			//流程启动人的上级领导 
			range="";
			java.util.List leaderList = workFlowBD.getLeaderList(request.getParameter("submitPersonId"));

			for(int i=0;i<leaderList.size();i++){
				Object[] tmp = (Object[])leaderList.get(i); 
				range += "$"+tmp[0]+"$";
			}
			show = "user";
		}

		if(nextUser[0]!=null && nextUser[0].equals("5")){
			//流程启动人
			range = "$"+request.getParameter("submitPersonId")+"$";
			show = "user";
		}

		if(nextUser[0]!=null && nextUser[0].equals("6")){
			range="";
			//从角色中指定 
			java.util.List candidate = workFlowBD.getRoleUserIDAndName(nextUser[18], request.getParameter("submitPersonId"));
			for(int i=0;i<candidate.size();i++){
				Object[] tmp = (Object[])candidate.get(i); 
				range += "$"+tmp[0]+"$";
			} 
			show = "user";
		}


 
	       if(nextUser[0]!=null && nextUser[0].equals("20")){
			  // 选中活动办理者
				java.util.List candidate = workFlowButtonBD.getDealedActivityUserList(tableId,processId,recordId,""+nextUser[18]);
		        range="";
				for(int i=0;i<candidate.size();i++){
					Object[] tmp = (Object[])candidate.get(i); 
					range += "$"+tmp[0]+"$";
					show = "userorg";
				} 
			}
			if(nextUser[0]!=null && nextUser[0].equals("21")){
				 // 选中活动办理者上级领导
				java.util.List candidate = workFlowButtonBD.getDealedActivityUserLeaderList(tableId,processId,recordId,""+nextUser[18]);
		         range="";
				for(int i=0;i<candidate.size();i++){
					Object[] tmp = (Object[])candidate.get(i); 
					range += "$"+tmp[0]+"$";
					show = "userorg";
				}
			}
		 
	}
 

// 是否 是从我的收文转发 
String todeaprat=request.getParameter("todeaprat")==null?"0":request.getParameter("todeaprat").toString();
String myscope="*0*";
if(todeaprat.equals("0")){
   myscope="*0*";
}else{
   myscope="*"+session.getAttribute("orgId")+"*";
}


boolean  gggg=false;
boolean  gggg1=false;
boolean  gggg2=false;

if(!nowSend.equals("0")){
 gggg1=true;
}
gggg2=new com.whir.ezoffice.message.action.ModelSendMsg().judgePurviewMessage("发文管理",session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString());
 if(gggg1||gggg2){
   gggg=true;
 }
boolean smsright = true;
		com.whir.org.manager.bd.ManagerBD managerBD = new com.whir.org.manager.bd.ManagerBD();
		if(!managerBD.hasRight(String.valueOf(session.getAttribute("userId")), "09*01*01")){
			smsright = false;
		}
boolean showorgassistant = false;
java.util.List alist = new  com.whir.govezoffice.documentmanager.bd.DocAssistantBD().getDocAssistantList("","");
if(alist.size() > 0){
	showorgassistant = true;
}
//System.out.println("===============tranType==============="+tranType);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>编号</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body scroll="no" onload="initPage()">
  <div class="1BodyMargin_10">  
        <div class="docBoxNoPanel" style="padding:10;border:0">  
		  <table class="Table_bottomline" border="0" cellpadding="0" cellspacing="0" width="600" height="180">  
		     <tr>  
                    <td class="td_lefttitle" valign="top">发送到 <font style="color:red">*</font>：</td>  
                    <td  valign="top" align="left">  
                                
							
						
						<textarea  class="inputTextarea"  readonly=true name=candidate id=candidate><%=allContent%></textarea><a href="javascript:void(0);" class="selectIco textareaIco" <% if("0".equals(tranType) || tranType == null || "".equals(tranType) ){	%>onclick="openSelect({parent:frameElement.api,allowId:'candidateId', allowName:'candidate', select:'userorggroup', single:'no', show:showType.value, range:rangeType.value,iscontrolRange:iscontrolRange.value,winModalDialog:0});" <%}else{%> onclick="openSelect({parent:window,allowId:'candidateId', allowName:'candidate', select:'userorggroup', single:'no', show:showType.value, range:rangeType.value,winModalDialog:1});" <%}%>></a>
								
								<input type=hidden name=candidateId id=candidateId  value="<%=allId%>">
								<input type="hidden" name="showType" id="showType" value="<%=show%>">
								<input type="hidden" name="rangeType"  id="rangeType"  value="<%=range%>">
								<input type="hidden" name="iscontrolRange" id="iscontrolRange" value="<%=iscontrolRange%>">
									
                    </td>  
                </tr>
				<tr ><td class="td_lefttitle">分发用户：</td><td align="left"><input type="radio" checked name="useOrgUsers" value="0">组织用户<%if(showorgassistant){%><input type="radio" name="useOrgUsers" value="1" a="useOrgAssistants">组织公文员<%}%></td></tr>
				<tr ><td class="td_lefttitle">提醒方式：</td><td align="left"><%if(gggg1){%><input type="checkbox" name="sendFileNeedRTX" value="1" checked='true'>即时通讯提醒&nbsp;<%}%> <%if(gggg2&&smsright){%><input type="checkbox" name="sendFileNeedSendMsg2" value="1">短信提醒&nbsp;<%}%><input type="checkbox" name="sendFileNeedMail" value="1">邮件提醒<input type="checkbox" name="sendFileCanDownload" value="1"  checked='true'>允许下载正文</td></tr>
				<tr class="toolbarBottomLine">  
				<td></td>
                <td align="left" >   
				    <input type="button" name="Submit" value="发送" class="btnButton4font" onclick="include_save();"/>
					<input type="button" name="Cancel" value="取消" class="btnButton4font" onclick="api.close()" />
                </td>  
              
				</tr>  
		 
		</table>
     </div>  
    </div>  
</body>

</html>

<SCRIPT LANGUAGE="JavaScript">
var api = frameElement.api, W = api.opener; 
function initPage(){
	var candidateIdStr = '';
	var candidateStr ='';
	var toIds = '';
	//if(W.document.all.toPerson1Id && W.document.all.toPerson1Id.value && W.document.all.toPerson1Id.value !=''){//主送
		//toIds += W.document.all.toPerson1Id.value;
		
	//}
	//alert(W.document.getElementById("toPerson2").value);
	if(W.document.getElementsByName("toPerson1Id").length > 0  ){//主送
		toIds += W.document.getElementsByName("toPerson1Id")[0].value;//W.document.all.toPerson1Id.value;
	}
	if(W.document.getElementsByName("toPerson2Id").length > 0   ){//主送
		toIds += W.document.getElementsByName("toPerson2Id")[0].value;//W.document.all.toPerson1Id.value;
	}
	if(W.document.getElementsByName("toPersonBaoId").length > 0   ){//主送
		toIds += W.document.getElementsByName("toPersonBaoId")[0].value;//W.document.all.toPerson1Id.value;
	}
	




	//if(W.document.all.toPerson2Id && W.document.all.toPerson2Id.value && W.document.all.toPerson2Id.value !=''){//抄送
		//toIds += W.document.all.toPerson2Id.value;
		
	//}		

	//if(W.document.all.toPersonBaoId && W.document.all.toPersonBaoId.value && W.document.all.toPersonBaoId.value !=''){//抄报
		//toIds += W.document.all.toPersonBaoId.value;		
	//}
	//if($("*[name='toPerson2Id']",W.document).length > 0  && $("*[name='toPerson2Id']",W.document).val()!=null && $("*[name='toPerson2Id']",W.document).val() !=''){//主送
	//	toIds += $("*[name='toPerson2Id']",W.document).val();//W.document.all.toPerson1Id.value;
	//}
	//if($("*[name='toPersonBaoId']",W.document).length > 0  && $("*[name='toPersonBaoId']",W.document).val()!=null && $("*[name='toPersonBaoId']",W.document).val() !=''){//主送
	//	toIds += $("*[name='toPersonBaoId']",W.document).val();//W.document.all.toPerson1Id.value;
	//}
	//alert(toIds);
	if(toIds !=''){
		$.post( '/defaultroot/modules/govoffice/gov_documentmanager/services/getData.jsp',{tag:'sendtomy',toIds:toIds},function(data){
			//alert(data);
			var str = data.replace(/(^\s*)|(\s*$)/g,'').split(';');
			$("*[name='candidateId']").val(str[0]);
			//alert(str[1]);
			$("*[name='candidate']").val(str[1]);
			//document.frm1.candidateId.value = str[0];
			//document.frm1.candidate.value = str[1];
		});
	}

	// 其它模块的工作流程
	// if($("*[name='<%=participantUserField%>Id']",window.parent.opener.document).length > 0){
	 
	// }
	 //if(eval("window.parent.opener.document.all.<%=participantUserField%>Id")){
		//var selectUser = eval("window.parent.opener.document.all.<%=participantUserField%>Id.value");
		//var selectUserName = eval("window.parent.opener.document.all.<%=participantUserField%>Name.value");
		//dealUsers(selectUser,selectUserName);
	//}

}


//处理从某个字段选中
function  dealUsers(selectUser,selectUserName){
	var  participantUserFieldType="<%=participantUserFieldType%>";
	/*
	if(selectUserName.indexOf(",")!=-1){
		selectUserName = selectUserName.substring(0,selectUserName.length-1);
	} else{
		selectUser = "$"+selectUser +"$";
	}*/
  /*
	//新活动
	String.prototype.replaceAll=function(s1,s2)
	{var demo=this;
	 while(demo.indexOf("$$")!=-1)
	 demo=demo.replace(s1,s2);
	 return demo;
	}
  */	 
 
    if(participantUserFieldType=="0"){//本人
		 document.all.showType.value="user";
		 document.all.rangeType.value=selectUser;
		 document.all.iscontrolRange.value="1";
	}else if(participantUserFieldType=="1"){//上级领导
		   workflowSync.getLeaderList(selectUser,loadXMLTool);
	}else if(participantUserFieldType=="2"){//部门领导
	       workflowSync.getUserDeptLeaderListByUserId(selectUser,loadXMLTool);
	}else if(participantUserFieldType=="3"){//分管领导
	       workflowSync.getUserChargeLeaderListByUserId(selectUser,loadXMLTool);
	}
}

//ajax后处理数据
function  loadXMLTool(userList){ 
	var selectUser="";
	var selectUserName="";
	if(userList.length>0){
	  for(var i=0;i<userList.length;i++){
	     selectUser+="$"+userList[i][0]+"$";
		//selectUserName+=userList[i][1]+",";
	  } 
	  document.all.showType.value="user";
	  document.all.rangeType.value=selectUser;
	  document.all.iscontrolRange.value="1";
	}
 
}

//保存
//$:userId
//*:orgId
//@:groupId
function include_save(){
	if( $("*[name='candidateId']").val()==""){
		 alert("请选择接收人！");
	}else{
			if ($.browser.msie ) { 
				W.document.getElementsByName("sendToMyId")[0].value=$("*[name='candidateId']").val();
				W.document.getElementsByName("sendToMyName")[0].value=$("*[name='candidate']").val();
				if( $("*[name='sendFileNeedSendMsg2']").length>0){
					if($("*[name='sendFileNeedSendMsg2']")[0].checked){
						//$("*[name='sendFileNeedSendMsg2']",W.document).val("1");
						W.document.getElementsByName("sendFileNeedSendMsg2")[0].value = "1";
					}else{
						W.document.getElementsByName("sendFileNeedSendMsg2")[0].value = "0";
					}
				}

				if( $("*[name='sendFileNeedRTX']").length>0){
					if($("*[name='sendFileNeedRTX']")[0].checked){
						//$("*[name='sendFileNeedRTX']",W.document).val("1");
						W.document.getElementsByName("sendFileNeedRTX")[0].value = "1";
					}else{
						W.document.getElementsByName("sendFileNeedRTX")[0].value = "0";
					}
				}
				
					
				if( $("*[name='sendFileNeedMail']").length>0){
					if($("*[name='sendFileNeedMail']")[0].checked){
						if(W.document.getElementsByName("sendFileNeedMail").length>0){
							//$("*[name='sendFileNeedMail']",W.document).val("1");
							W.document.getElementsByName("sendFileNeedMail")[0].value = "1";

						}
					}else{
						W.document.getElementsByName("sendFileNeedMail")[0].value = "0";
					}
				}

				if( $("*[name='sendFileCanDownload']").length>0){
					if($("*[name='sendFileCanDownload']")[0].checked){
						if(W.document.getElementsByName("sendFileCanDownload").length>0){
							//$("*[name='sendFileNeedMail']",W.document).val("1");
							W.document.getElementsByName("sendFileCanDownload")[0].value = "1";

						}
					}else{
						W.document.getElementsByName("sendFileCanDownload")[0].value = "0";
					}
				}

				var useOrgUsers = $("input[name='useOrgUsers']:checked")[0].value;//组织用户

				W.cmdSendToMy(useOrgUsers);

				W.document.getElementsByName("sendToMyName")[0].value="";
				W.document.getElementsByName("sendToMyId")[0].value="";
				api.close();

			}else{
				 // if(document.frm1.candidateId.value==""){
	 //alert("请选择接收人！");
	// }else{
	/* var oo = new Object();
     oo.candidateId=document.frm1.candidateId.value;
	 oo.candidate=document.frm1.candidate.value;
		window.returnValue =oo;
		W=null;
		window.close();*/
		//alert(document.frm1.candidateId.value);
		//return ;
		 $("*[name='sendToMyId']",W.document).val($("*[name='candidateId']").val());
		 $("*[name='sendToMyName']",W.document).val($("*[name='candidate']").val());
		//W.document.all.sendToMyId.value=document.frm1.candidateId.value;
		//W.document.all.sendToMyName.value=document.frm1.candidate.value;

	if( $("*[name='sendFileNeedSendMsg2']").length>0){
		if($("*[name='sendFileNeedSendMsg2']")[0].checked){
			$("*[name='sendFileNeedSendMsg2']",W.document).val("1");
		}else{
			$("*[name='sendFileNeedSendMsg2']",W.document).val("0");
		}
	}else{
		$("*[name='sendFileNeedSendMsg2']",W.document).val("0");
	}
      //  if(document.all.frm1.sendFileNeedSendMsg2){
		//   if(document.all.frm1.sendFileNeedSendMsg2.checked){
		 //   W.document.all.sendFileNeedSendMsg2.value="1";		
		 // }
		//}
	if( $("*[name='sendFileNeedRTX']").length>0){
		if($("*[name='sendFileNeedRTX']")[0].checked){
			$("*[name='sendFileNeedRTX']",W.document).val("1");
		}else{
			$("*[name='sendFileNeedRTX']",W.document).val("0");
		}
	}else{
		$("*[name='sendFileNeedRTX']",W.document).val("0");
	}

		//if(document.all.frm1.sendFileNeedRTX){
		   //if(document.all.frm1.sendFileNeedRTX.checked){
		     //W.document.all.sendFileNeedRTX.value="1";		
		  //}
		//}

	if( $("*[name='sendFileNeedMail']").length>0){
		if($("*[name='sendFileNeedMail']")[0].checked){
			if( $("*[name='sendFileNeedMail']",W.document).length>0){
				$("*[name='sendFileNeedMail']",W.document).val("1");
		
			}
		}else{
			$("*[name='sendFileNeedMail']",W.document).val("0");
		}
	}else{
		$("*[name='sendFileNeedMail']",W.document).val("0");
	}

	if( $("*[name='sendFileCanDownload']").length>0){
		if($("*[name='sendFileCanDownload']")[0].checked){
			if( $("*[name='sendFileCanDownload']",W.document).length>0){
				$("*[name='sendFileCanDownload']",W.document).val("1");
			}
		}else{
			$("*[name='sendFileCanDownload']",W.document).val("0");
		}
	}else{
		$("*[name='sendFileCanDownload']",W.document).val("0");
	}

		//if(document.all.frm1.sendFileNeedMail){
		   //if(document.all.frm1.sendFileNeedMail.checked){
			  //if(W.document.all.sendFileNeedMail){
				//	W.document.all.sendFileNeedMail.value="1";	
			  // }
		  //}
		//}
	   	var useOrgUsers = $("input[name='useOrgUsers']:checked")[0].value;//组织用户
		W.cmdSendToMy(useOrgUsers);
			$("*[name='sendToMyName']",W.document).val("");
				$("*[name='sendToMyId']",W.document).val("");
					api.close();
		//W.document.all.sendToMyName.value="";
		//W.document.all.sendToMyId.value="";
			
			}
   
	
		}
	
}
//-->
</SCRIPT>
