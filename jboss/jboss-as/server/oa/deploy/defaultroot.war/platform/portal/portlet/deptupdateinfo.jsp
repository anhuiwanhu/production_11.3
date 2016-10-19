<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/<%=whir_skin%>/portal/style.css">
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%> 
<%
//模块页面
/*response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);*/
response.setContentType("text/html; charset=UTF-8");
String _skin = PortletUtil.getSkin(request);
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
String limitNum = confMap.get("limitNum");

String windowHeight = confMap.get("windowHeight");

String hasTitle = confMap.get("hasTitle");
String hasToolbar = confMap.get("hasToolbar");
String hasBorder = confMap.get("hasBorder");

Double height=120.0;
if(!"auto".equals(windowHeight)&&!"".equals(windowHeight)){
	height=Double.parseDouble(windowHeight)-50;
}
%>
<% 
if(classId!=null&&!"".equals(classId)){
    Map itemMapName = mvo.getItemMapName();
    Map itemMap = mvo.getItemMap(); 
    Map linkMap = mvo.getLinkMap();
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
    	if(len>0){
		%>	
			<%
            for(int i0=0; i0<mapSize; i0++){
                String className = (String)itemMapName.get(cid[i0]);
                String[] moreType = (String[])linkMap.get(cid[i0]);
                String linkUrl = "";
                if("noorgweb".equals(moreType[0])){
                    linkUrl = "javascritp:alert('该部门未设置部门主页！')";
                }else{
                    linkUrl = "javascript:openWin({url:'"+moreType[1]+"', isFull:true});";
                }
                if(_outter_)linkUrl="";
        	%>
			{title:"<%=className%>", url:"", onclick:"<%=linkUrl%>", defaultSelected:"<%=i0==0?"on":""%>",liCss:"wh-portal-overflow", morelink:"<%=linkUrl%>"},
			<%}%>
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
    for(int i0=0; i0<mapSize; i0++){
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
                String _link = "";
                if("true".equals(ivo.getIsConf())){
                    _link = "openWin({url:'"+ivo.getLink()+"', isFull:true});";
                    if(_outter_)_link="openWin({url:'"+rootPath+"/PortalInformation!getInformation.action?title="+ivo.getPoptitle()+"&id="+ivo.getId()+"', isFull:true});";
                }else{
                    _link = "javascript:alert('这是一份加密文件,您无权查看!');";
                }
        %>
        <div class="wh-portal-info-title">
            <div class="wh-portal-infotitle">
				<a href="javascript:void(0)" style="cursor:pointer" onclick="<%=_link%>"><strong><%=ivo.getPoptitle()%></strong></a>
				<p><span><%=ivo.getTime()%></span></p>
			</div>
            <div class="wh-portal-infocon">
                <p><%=content.length()>100?content.substring(0,100)+"…":content%>
                <span><%=ivo.getTime()%></span>
                <a href="#_notarget" style="cursor:pointer" onclick="<%=_link%>">[详细]</a>
                </p>
            </div>
        </div>
		<%}%>
		<div class="wh-portal-iclist<%=portletSettingId%><%=i0%> wh-protal-overflow">
		<%
            int j0 = "1".equals(topPreview)?1:0;
            for (; j0 < list.size(); j0++) {
                ItemVO ivo = (ItemVO)list.get(j0);
                String _link = "";
                if("true".equals(ivo.getIsConf())){
                    _link = "openWin({url:'"+ivo.getLink()+"', isFull:true});";
                    if(_outter_)_link="openWin({url:'"+rootPath+"/PortalInformation!getInformation.action?title="+ivo.getPoptitle()+"&id="+ivo.getId()+"', isFull:true});";
                }else{
                    _link = "javascript:alert('这是一份加密文件,您无权查看!');";
                }
        %>
		<div class="wh-portal-i-item clearfix">
            <a href="javascript:void(0)">
            <i class="fa fa-file-o"></i>
            <%=ivo.getChannelTitle()%><span class="wh-portal-a-cursor" onclick="<%=_link%>" title="<%=ivo.getPoptitle()%>"><%=ivo.getName()%></span>
            <em><%=ivo.getTime()%></em><%=ivo.getTitle()%>
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
<!--
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
//-->
</script>

<%}%>
<%}%>