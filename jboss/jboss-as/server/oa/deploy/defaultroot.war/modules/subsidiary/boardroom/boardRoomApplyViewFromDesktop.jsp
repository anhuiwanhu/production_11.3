<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomEquipmentPO" %>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardroomMeetingTimePO" %>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomPO" %>
<%@ page import="com.whir.ezoffice.bpm.bd.BPMInstanceBD" %>
<%
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd日");
    com.whir.ezoffice.boardroom.po.BoardRoomApplyPO boardRoomApplyPO=null;
    if(request.getAttribute("boardRoomApplyPO") !=null){
        boardRoomApplyPO = (com.whir.ezoffice.boardroom.po.BoardRoomApplyPO)request.getAttribute("boardRoomApplyPO");
    }
    String ld = boardRoomApplyPO.getAttendee()!=null?boardRoomApplyPO.getAttendee():"";  
    String emceeName = boardRoomApplyPO.getEmceeName();
    String addr = boardRoomApplyPO.getAddr()!=null&&!"".equals(boardRoomApplyPO.getAddr())?boardRoomApplyPO.getAddr():null;
    java.util.Date applyDate = new java.util.Date();
    if(boardRoomApplyPO.getApplyDate() !=null){
        applyDate=boardRoomApplyPO.getApplyDate();
    }
    String otherAttendeePerson = boardRoomApplyPO.getOtherAttendeePerson()!=null?boardRoomApplyPO.getOtherAttendeePerson():"";
    String boardroomApplyId= boardRoomApplyPO.getBoardroomApplyId()+"";
    
    BPMInstanceBD instanceBD = new BPMInstanceBD();
    //0 自定义  2 固定
	String formType = instanceBD.getFormType("15",boardroomApplyId);
	String fileDir = "boardroom";
	if("0".equals(formType)){
		fileDir = "customform";
	}
    
    String boardroomName=request.getParameter("boardroomName")!=null?request.getParameter("boardroomName"):"";
    String boardroomFileName = "";
	if(request.getAttribute("boardroomFileName") !=null){
	boardroomFileName = request.getAttribute("boardroomFileName").toString();
	}
    String boardroomSaveName = "";
	if(request.getAttribute("boardroomSaveName") !=null){
	boardroomSaveName = request.getAttribute("boardroomSaveName").toString();
	}
    String userId = session.getAttribute("userId").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>会议通知</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
<style type="text/css">
.ft1{
	font-size:24pt;
	color:red;
	FONT-FAMILY:宋体;
}

.ft2{
	font-size:16pt;
	color:black;
	FONT-FAMILY:仿宋_GB2312;
}
@media print {
 .noprint {display:none}
}
</style>
<%
	response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);

	String meetingId = request.getParameter("meetingId");
	String notmessage = (String)request.getAttribute("notmessage");
	String userID = session.getAttribute("userId").toString(); //取当前用户的ID

if("1".equals(notmessage)){
%>
<script language="javascript">
<!--
alert("信息不存在，可能被删除了，请联系管理员！");
window.close();
-->
</script>
<%
return;
 }
%>
</head>
<body class="Pupwin">
    <div class="BodyMargin_10" >  
        <div class="docBoxNoPanel">
            <s:form name="dataForm" id="dataForm" action="${ctx}/boardRoom!changeBoardRoom.action" method="post" theme="simple" >
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td nowrap="nowrap" colspan="2" align=center>
                        <font class=ft1><b>关于<s:property value="boardRoomApplyPO.motif" escape="false"/>的通知</b></font>
                    </td>
                </tr>
                <tr>
                    <td><br></td>
                </tr>
                <%
                    String meet_date = "";
                    String sortNum = request.getParameter("sortNum")!=null?request.getParameter("sortNum"):"";
                    Set meetingTime = (Set) request.getAttribute("meetingTime");
                    Iterator itor = meetingTime.iterator();
                    int kk0=0;
                    while(itor.hasNext()){
                        BoardroomMeetingTimePO tt = (BoardroomMeetingTimePO)itor.next();
                        java.util.Date destineDate = new java.util.Date();
                        destineDate = tt.getMeetingDate();
                        
                        int startTime =Integer.parseInt(tt.getStartTime());
                        int endTime = Integer.parseInt(tt.getEndTime());
                        if(sortNum.equals(tt.getSortNum().toString())){
                            meet_date =formatter.format(destineDate)+ " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                        }
                    }
                    		
                %>
                <%
                
                %>
                <tr>
                    <td   class="td_lefttitle">
                        <font class=ft2>一、时间：</font>
                    </td>
                    <td  colspan=1></td>
                </tr>
                <tr>
                    <td colspan=2 class="td_lefttitle">
                        <font class=ft2>&nbsp;&nbsp;&nbsp;&nbsp;<%=meet_date%></font>
                    </td>
                </tr>
                <tr>
                    <td nowrap class="td_lefttitle">
                        <font class=ft2>二、地点：</font>
                    </td>
                    <td colspan=1></td>
                </tr>
                <tr>
                    <td colspan=2>
                        <font class=ft2>&nbsp;&nbsp;&nbsp;&nbsp;<%=addr!=null?addr:""%></font>
                    </td>
                </tr>
                <tr>
                    <td nowrap class="td_lefttitle">
                        <font class=ft2>三、主持人：</font>
                    </td>
                    <td colspan=1></td>
                </tr>
                <tr>
                    <td colspan=2>
                        <font class=ft2>
                        &nbsp;&nbsp;&nbsp;&nbsp;<%=emceeName!=null?(emceeName.endsWith(",")?emceeName.substring(0,emceeName.length()-1):emceeName):""%></font>
                    </td>
                </tr>
                <tr>
                    <td nowrap class="td_lefttitle">
                        <font class=ft2>四、出席人员：</font>
                    </td>
                    <td colspan=1></td>
                </tr>
                <tr>
                    <td colspan=2>
                        <font class=ft2>&nbsp;&nbsp;&nbsp;&nbsp;<%if(ld!=null&&!"".equals(ld)){%><%=ld.endsWith(",")?ld.substring(0,ld.length()-1).replaceAll(",","、"):ld.replaceAll(",","、")%><%="。"%><%}%><%=otherAttendeePerson.length()>0?otherAttendeePerson:""%></font>
                    </td>
                </tr>
                <%
                if(boardRoomApplyPO.getDepict()!=null&&!"".equals(boardRoomApplyPO.getDepict())){
					String depict=boardRoomApplyPO.getDepict();
					depict=depict.replaceAll("\n","<br/>");
                %>
                <tr>
                    <td nowrap class="td_lefttitle">
                        <font class=ft2>五、会议内容：</font>
                    </td>
                    <td colspan=1></td>
                </tr>
                <tr>
                    <td colspan=2>
                        <font class=ft2><%=depict%></font>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td><br><br></td>
                </tr>
                <tr>
                    <td nowrap></td>
                    <td colspan=1 align=center>
                        <span style="width:30%"></span><font class=ft2>&nbsp;&nbsp;&nbsp;&nbsp;<%=boardRoomApplyPO.getApplyOrgName()!=null?boardRoomApplyPO.getApplyOrgName():"&nbsp;"%></font>
                    </td>
                </tr>
                <tr>
                    <td nowrap></td>
                    <td colspan=1 align=center><span style="width:30%"></span><font class=ft2>&nbsp;&nbsp;&nbsp;&nbsp;<%=formatter.format(applyDate)%></font></td>
                </tr>
                <tr>
                    <td><br></td>
                </tr>
                <%
                if(boardroomFileName != null && !boardroomFileName.equals("") && !boardroomFileName.equals("null")){
                %>
                <tr>
                    <td nowrap class="td_lefttitle">
                        <font class=ft2>相关附件：</font>
                    </td>
                    <td colspan=1></td>
                </tr>
                <tr>
                    <td colspan=2 class="td_lefttitle">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="hidden" name="boardroomFileName" id="boardroomFileName" value="<%=boardroomFileName%>"/>
                        <input type="hidden" name="boardroomSaveName" id="boardroomSaveName" value="<%=boardroomSaveName%>"/>

                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                        <jsp:param name="dir"		 value="<%=fileDir %>" />
                        <jsp:param name="uniqueId"    value="uniqueId" />
                        <jsp:param name="realFileNameInputId"    value="boardroomFileName" />
                        <jsp:param name="saveFileNameInputId"    value="boardroomSaveName" />
                        <jsp:param name="canModify"       value="no" />
                        <jsp:param name="width"		 value="90" />
                        <jsp:param name="height"		 value="16" />
                        <jsp:param name="multi"		 value="true" />
                        <jsp:param name="buttonClass" value="upload_btn" />
                        <jsp:param name="fileSizeLimit"		 value="0" />
                        <jsp:param name="fileTypeExts"		 value="*.jpg;*.jpeg;*.gif;*.png;*.zip;*.doc;*.docx;*.xls;*.xlsm;*.ppt;*.pptx;*.txt" />
                        </jsp:include>                 
                    </td>
                </tr>
                <%}%>
                <tr class=noprint>
                    <td></td>
                    <td colspan=1 align=right>
                        <a href="javascript:void(0);" onclick="openWin({url:'<%=rootPath%>/boardRoom!selectBoardroomApplyView.action?boardroomApplyId=<%=boardroomApplyId%>&boardroomName=<%=boardroomName%>&type=view&p_wf_recordId=<%=boardroomApplyId%>&p_wf_moduleId=15&p_wf_openType=modifyView',width:screen.width,height:screen.height,winName:'viewBoardRoomApply'});">查看详细</a>
                        &nbsp;
                         <input type="button" class="btnButton4font" onClick="printWindow();" value='<s:text name="comm.print"/>'/> 
                    </td>
                </tr>
                <tr height="1">
                    <td></td>
                </tr>
            </table>
            <br />
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="report_table" style="display:" class=noprint>
                <tr>
                    <td align="center" width="100%">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="inlineBottomLine">
                            <tr><td height="10"></td></tr>
                            <tr>
                                <td width="100%" nowrap="nowrap" align="left">
                                    <span id="_Panle1" onClick="changePanle1(1);" style="color:red;cursor:hand">回复信息</span>
                                    | <span id="_Panle5" onClick="changePanle1(5);" style="color:black;cursor:hand">回复信息统计</span>
                                    | <span id="_Panle3" onClick="changePanle1(3);" style="color:black;cursor:hand">查看情况</span>
                                    <%
                                    String notePerson = request.getAttribute("notePerson")+"";
                                    if(("true".equals(request.getParameter("executeStatus")) ||
                                    ("$"+userId+"$").equals(notePerson)) && (request.getParameter("meetingId") !=null && !"".equals(request.getParameter("meetingId"))) ){
                                    %>
                                    | <span id="_Panle4" onClick="changePanle1(4);" style="color:black;cursor:hand">会议执行情况</span>
                                    <%}%>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="docBoxNoPanel">
                            <tr>
                                <td height="100" valign="top">
                                    <div id="div_1" style="display:block">
                                        <iframe  id="reports" name="reports" src="<%=rootPath%>/boardRoom!applyReportList.action?boardroomApplyId=<%=boardroomApplyId%>&isView=<%=request.getParameter("isView")%>" scrolling="no" frameborder="0"  style="width:100%"></iframe>
                                        
                                    </div>
                                    <div id="div_5" style="display:none">
                                        <iframe  id="tj" name="tj" src="<%=rootPath%>/modules/subsidiary/boardroom/boardRoomApply_tj.jsp?boardroomApplyId=<%=boardroomApplyId%>" scrolling="no" frameborder="0"  style="width:100%"></iframe>
                                    </div>
                                    <div id="div_2" style="display:none">
                                    </div>
                                    <div id="div_3" style="display:none">
                                    </div>
                                    <%
                                    if(!"false".equals(request.getParameter("executeStatus"))){
                                    %>
                                    <div id="div_4" style="display:none">
                                    </div>
                                    <%}%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </s:form>
        </div>
    </div>
</body>

<script language="JavaScript">
<!--
function changePanle1(id){
	for(i=0;i<=5;i++){
 	 	if(document.getElementById("_Panle"+i)){
	 		document.getElementById("_Panle"+i).style.color = "black";
	 	}
 	 	if(document.getElementById("div_"+i)){
	 		document.getElementById("div_"+i).style.display = "none";
	 	}
  	}
	if(document.getElementById("_Panle"+id)){
		document.getElementById("_Panle"+id).style.color = "red";
	}
	if(document.getElementById("div_"+id)){
		document.getElementById("div_"+id).style.display = "";
	}

	if(id==1){
		//document.all.reports.src="BoardRoomAction.do?action=applyReportList&boardroomApplyId=<%=boardroomApplyId%>&isView=<%=request.getParameter("isView")%>";
	}
	if(id==5){
		document.getElementById("tj").src="<%=rootPath%>/modules/subsidiary/boardroom/boardRoomApply_tj.jsp?boardroomApplyId=<%=boardroomApplyId%>";
	}
    if(id==4){
		var url='${ctx}/boardRoom!executeStatus.action?boardroomApplyId=<%=boardroomApplyId%>&meetingId=<%=meetingId%>';
        openWin({url:url,width:650,height:500,winName:'executeStatus'});
        
	}
     if(id==3){
		//var url='${ctx}/boardRoom!unviewUsers.action?boardroomApplyId=<%=boardroomApplyId%>&fromtype=boardroom';
        //openWin({url:url,isFull:'true',winName: 'viewUsers' });
        openWin({url:'realtimemessage!onlinelist.action?id=<%=boardroomApplyId%>&fromtype=boardroom',isFull:'true',winName: 'viewUsers' });
	}
}
function viewUser(flag){
	if(flag == '1'){
		var win = MM_openBrWindow('BoardRoomAction.do?action=viewUsers&boardroomApplyId=<%=boardroomApplyId%>&yhlx=qb','win1','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=650,height=500');
	} else if(flag == '0'){
		var win = MM_openBrWindow('BoardRoomAction.do?action=unviewUsers&boardroomApplyId=<%=boardroomApplyId%>&yhlx=qb','win2','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=650,height=500');
	}
}

function printWindow(){
	window.print();
}
//-->
</script>
</html>

