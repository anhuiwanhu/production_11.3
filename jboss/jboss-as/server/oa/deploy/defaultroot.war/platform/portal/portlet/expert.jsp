<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%
response.setContentType("text/html; charset=UTF-8");

String portletSettingId = request.getParameter("portletSettingId");

boolean _outter_1 = session.getAttribute("userId")==null;//"1".equals(request.getParameter("outter"));

PortletBD pbd = new PortletBD();

ConfMap confMap = pbd.getConfMap(portletSettingId);
String expertId = confMap.get("expertId");
//String limitNum = confMap.get("limitNum");
//limitNum = limitNum.replace(",","");
//int num = Integer.parseInt(limitNum);
String title = confMap.get("title");
String hasTitle = confMap.get("hasTitle");

String _title = "";
for(int i0=0; i0<title.length(); i0++){
    _title += title.charAt(i0)+"<br>";
}

String[][] experts = pbd.getExpertInfo(expertId)!=null?pbd.getExpertInfo(expertId):new String[0][0];
%>
<div class="wh-expert-consult">
		<div class="wh-slide-sim-consult">
	        <div id="expertDataBase_<%=portletSettingId %>" class="wh-slide-sim-consult-slide flexslider">
	            <ul class="wh-slide-sim-consult-ul clearfix" id="wh-slide-sim-consult-ul_<%=portletSettingId %>">
	    <%
          if(experts!=null){
              int size = experts.length;
              for(int i0=0; i0<size; i0++){
              	  String leftlink = rootPath+"/modules/personal/personal_menu.jsp?portletSettingId=expertView";
              	  String rightlink = rootPath+"/InfoList!retrievalList.action?userDefine=0&type=all&channelType=0&userChannelName=信息管理&retrievalAction=1&retrievalKey="+experts[i0][1];
                  String _link = "javascript:jumpnew('"+leftlink+"','"+rightlink+"')"; 
                  //String _link = rootPath+"/platform/portal/more.jsp?left="+rootPath+"/modules/personal/personal_menu.jsp&right="+rootPath+"/InfoList!retrievalList.action?userDefine=0%26type=all%26channelType=0%26userChannelName="+java.net.URLEncoder.encode("信息管理", "utf-8")+"%26retrievalAction=1%26retrievalKey="+java.net.URLEncoder.encode(experts[i0][1], "utf-8");
                  if(_outter_1)_link="javascript:void(0);";
                  String _photo_path = preUrl+"/upload/peopleinfo/"+experts[i0][2];
                  if(experts[i0][2]==null||"".equals(experts[i0][2])||"null".equals(experts[i0][2])){
                      _photo_path = preUrl+"/images/noliving.gif";
                  }
        %>
	      <li>
  			  <div class="wh-slide-sim-consult-box">
                  <div class="wh-slide-sim-look">
                       <div class="wh-p-person-header">
                       		<img src="<%=_photo_path%>" width="160" height="160" alt=""/>
                       </div>
                  </div>
                  <a href="javascript:void(0)" title="<%=experts[i0][1]%>" onclick="<%=_link%>" class="wh-slide-sim-name"><b><%=experts[i0][1]%></b></a>
              </div>
	       </li>
	     <%}}%>
		 </ul>
	   </div>
	</div>
</div>
<script language="javascript">
    //专家咨询
 $(function () {
        //专家咨询
        $("#expertDataBase_<%=portletSettingId %>").flexslider({
            selector: "#wh-slide-sim-consult-ul_<%=portletSettingId %> > li",
            animation: "slide",
            controlNav:false,
            animationLoop: false,
            itemWidth: 160,
            itemMargin: 4,
            minItems: 2,
            maxItems: 4,
            directionNav: true
            // pausePlay: true
        });
    })
</script>
