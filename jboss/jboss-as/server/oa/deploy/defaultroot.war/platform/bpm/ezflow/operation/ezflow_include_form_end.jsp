<%@ page contentType="text/html; charset=UTF-8"%>
<%
   //当前的批示意见  这里取不到  ezflow_include_form.jsp 中定义的 cur_commentField
   String cur_commentField_=request.getAttribute("p_wf_curCommField")==null?"":request.getAttribute("p_wf_curCommField").toString();
   //从哪地方打开
   String openType=request.getAttribute("p_wf_openType")==null?"":request.getAttribute("p_wf_openType")+"";
   String localcom_ = session.getAttribute("org.apache.struts.action.LOCALE").toString();
   //常用语
   java.util.List officelist_w = new com.whir.ezoffice.workflow.newBD.WorkFlowBD().getOffiDict(session.getAttribute("userId").toString(), session.getAttribute("domainId").toString());

%>
<%

 //待办 待阅 才显示输入批示意见
 if(openType.equals("waitingDeal")||openType.equals("waitingRead")){
	 //如果当前是自动追加批示意见
	 if("autoCommentField".equals(cur_commentField_)){
%>
		<div id="noteDiv"  class="noteDiv_auto" value="comment"   >
			<%
			  if(officelist_w!=null&&officelist_w.size()>0){
			   for(int i=0;i<officelist_w.size();i++){
				 String offContent=""+officelist_w.get(i);%>
				  <div class="divOut" onmouseover="lockedNote_w();this.className='divOver'" onmouseout="this.className='divOut'" onclick="include_set_comment(this,'comment')"><%=offContent%></div>
			   <%}
			}
			%>
		  <div class="divOut"><a href="#"  onclick="addOffical();" style="float:left">>><!-- 添加 --><%=Resource.getValue(localcom_,"workflow","workflow.newactivitydefineadd")%></a>&nbsp;&nbsp;<a href="#"  onclick="manangerOffical();" style="float:right"><!-- 管理常用语 -->管理常用语</a></div>
		</div> 
<%  } 
 }
%>
<%  
    //增加批示字段对应意见到指定位置 likun 20070129
    //待办 或者待阅   当前不是自动追加批示意见   并且  不是无批示意见
	if((openType.equals("waitingDeal")||openType.equals("waitingRead"))&&!cur_commentField_.equals("autoCommentField")&&!cur_commentField_.equals("nullCommentField")){
%>
  <div id="noteDiv"  class="noteDiv_field" value="<%=cur_commentField_%>"   >
		<%
		  if(officelist_w!=null&&officelist_w.size()>0){
		   for(int i=0;i<officelist_w.size();i++){
			 String offContent=""+officelist_w.get(i);%>
			  <div class="divOut" onmouseover="lockedNote_w();this.className='divOver'" onmouseout="this.className='divOut'" onclick="include_set_comment(this,'<%=cur_commentField_%>')"><%=offContent%></div>
		   <%}
		}
		%>
	  <div class="divOut"><a href="#"  onclick="addOffical();" style="float:left">>><!-- 添加 --><%=Resource.getValue(localcom_,"workflow","workflow.newactivitydefineadd")%></a>&nbsp;&nbsp;<a href="#"  onclick="manangerOffical();" style="float:right"><!-- 管理常用语 -->管理常用语</a></div>
 </div>  
<%}%>
 