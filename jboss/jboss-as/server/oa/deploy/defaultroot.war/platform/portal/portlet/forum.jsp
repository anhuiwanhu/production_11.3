<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");
boolean _outter_ = "1".equals(request.getParameter("outter"));

ModuleVO mvo = (ModuleVO)request.getAttribute("mvo");
if(mvo!=null){

PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String classId = confMap.get("classId");
String scrolling = confMap.get("scrolling");
String topPreview = confMap.get("topPreview");
String infoType = confMap.get("infoType");
String title = confMap.get("title");
String limitNum = confMap.get("limitNum");

%>
<%
    Map itemMapName = mvo.getItemMapName();
    Map itemMap = mvo.getItemMap();
    int mapSize = itemMapName.size();
    String[] cid = classId.split(",");
    int len = cid.length;
%>

<script>
var jsonData = [
	{
		ulCss:"wh-portal-title-slide04-<%=portletSettingId%>",
		data:[
		<%
        if(!"0".equals(classId)){
        for(int i0=0; i0<len; i0++){
            String className = (String)itemMapName.get(cid[i0]);
        %>
			{title:"<%=className%>", url:"", onclick:"", defaultSelected:"<%=i0==0?"on":""%>",liCss:"wh-portal-overflow", morelink:"<%if(!_outter_){%>jumpnew('<%=rootPath%>/ForumClassAction!getForumClassMenu.action?expNodeCode=<%=className%>','<%=rootPath%>/ForumAction!forumTopicList.action?menuLinkFlag=allTopic&queryForumClassId=<%=cid[i0]%>')<%}else{%>jumpnew('<%=rootPath%>/PortletForumAction!forumTopicList.action?forumClassId=<%=cid[i0]%>','')<%}%>"},
		<%}%>
        <%}else{%>
            {title:"<%=title%>", url:"", onclick:"", defaultSelected:"on",liCss:"wh-portal-overflow", morelink:"<%if(!_outter_){%>jumpnew('<%=rootPath%>/ForumClassAction!getForumClassMenu.action','<%=rootPath%>/ForumAction!forumTopicList.action?menuLinkFlag=allTopic')<%}else{%>jumpnew('<%=rootPath%>/PortletForumAction!forumTopicList.action','')<%}%>"},
        <%}%>
		]
	}
];
Portlet.setPortletDataTitle('<%=portletSettingId%>',jsonData);
Portlet.setMoreLink('<%=portletSettingId%>',{});
</script>

<div class="wh-portal-info-content">
    <div class="wh-portal-slide04-<%=portletSettingId%>">
        <ul class="clearfix">
        <%
    	for(int i0=0; i0<len; i0++){
		%>
		<%if(i0 == 0){%>
			<li>
		<%}else{%>
			<li class="wh-portal-hidden">
		<%}%>
		<%
        List list = (List)itemMap.get(cid[i0]);
        if(list != null && list.size() > 0){
		%>
		<%
            if("1".equals(topPreview)){
            ItemVO ivo = (ItemVO)list.get(0);
            String content = PortletUtil.HtmlToText(ivo.getContent());
        %>
			<div class="wh-portal-info-title">
                <div class="wh-portal-infotitle">
				<a href="javascript:void(0)" style="cursor:pointer" onclick="openWin({url:'<%=_outter_?(rootPath+"/PortletForumAction!forumDisplay.action?ForumClassTitle="+ivo.getName()+"&forumTopicId="+ivo.getId()):ivo.getLink()%>',isFull:true});"><strong><%=ivo.getName()%></strong></a>
				<p><span><%=ivo.getTime()%></span></p>
				</div>
                <div class="wh-portal-infocon">
                    <p><%=content.length()>100?content.substring(0,100)+"…":content%>
                      <span><%=ivo.getTime()%></span>
                      <a href="javascript:void(0)" style="cursor:pointer" onclick="openWin({url:'<%=_outter_?(rootPath+"/PortletForumAction!forumDisplay.action?ForumClassTitle="+ivo.getName()+"&forumTopicId="+ivo.getId()):ivo.getLink()%>',isFull:true});">[详细]</a>
                    </p>
                </div>
                    </div>
					<%}%>
					<div class="wh-portal-iclist<%=portletSettingId%><%=i0%> wh-protal-overflow">
					<%
            		int j0 = "1".equals(topPreview)?1:0;
            		for (; j0 < list.size(); j0++) {
                	ItemVO ivo = (ItemVO)list.get(j0);
        			%>
					<div class="wh-portal-i-item clearfix">
                    <a href="javascript:void(0)" >
                    <i class="fa fa-file-o"></i>
                    <span class="wh-portal-a-cursor"  onclick="openWin({url:'<%=_outter_?(rootPath+"/PortletForumAction!forumDisplay.action?ForumClassTitle="+ivo.getName()+"&forumTopicId="+ivo.getId()):ivo.getLink()%>',isFull:true});" title="<%=ivo.getPoptitle()%>"><%=ivo.getName()%></span>
                    <em><%=ivo.getTime()%></em>
                    </a>
                    </div>
                    <%}%>
        		</div>
				<%}%> 
				</li>
				<%}%> 
        	</ul>
        </div>
	</div>

<script language="JavaScript">
slideTab('slide04-<%=portletSettingId%>');
<%if("1".equals(scrolling)){%>
	<%
    for(int a0=0; a0<len; a0++){
	%>
    <%
    List list = (List)itemMap.get(cid[a0]);
    if(list != null && list.size() > 0){
    %>
	//列表滚动
    var _wrap=$('.wh-portal-iclist<%=portletSettingId%><%=a0%>');
	<%if(!"1".equals(topPreview) || ("1".equals(topPreview) && list.size() > 1)){%>
    scrolling(_wrap);
    <%}%>
    <%}%>
    <%}%>
<%}%>

function scrolling(obj){
    //列表滚动
    var _wrap = obj;
    var _interval=3000;
    var _moving;
    var infonum = <%=limitNum%>;
    var info_line_height = 26;
    var counth = info_line_height*(infonum);
    _wrap.css('height',counth);
    _wrap.hover(function(){
        clearInterval(_moving);
    },function(){
        _moving=setInterval(function(){
            var _field=_wrap.find('.wh-portal-i-item:first');
            var _h=_field.height();
            $('<div class="wh-portal-i-item clearfix">'+_field.html()+'</div>').appendTo(_wrap);
            _field.animate({marginTop:-_h+'px'},600,function(){
                _field.css('marginTop',0).remove();
            })

        },_interval)
    }).trigger('mouseleave');
}
</script>
<%}%>
