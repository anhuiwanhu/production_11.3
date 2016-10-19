<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.component.security.crypto.EncryptUtil" %>
<%
String rootPath = com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
String whir_locale = com.whir.component.util.LocaleUtils.getLocale(request);
String whir_skin = "themes/" + (session!=null&&session.getAttribute("skin")!=null?session.getAttribute("skin").toString():"2015/color1");//"themes/2012/2012skin_blue";
String whir_new_skin="default";
String whir_pageFontSize="14";
if(session!=null&&session.getAttribute("pageFontsize")!=null){
	whir_pageFontSize=session.getAttribute("pageFontsize").toString();
}
if(session!=null&&session.getAttribute("skin")!=null){
	if(session.getAttribute("skin").toString().equals("2015/color1")){
		whir_new_skin="default";
	}else if(session.getAttribute("skin").toString().equals("2015/color2")){
		whir_new_skin="orange";
	}else if(session.getAttribute("skin").toString().equals("2015/color3")){
		whir_new_skin="green";
	}else if(session.getAttribute("skin").toString().equals("2015/color4")){
		whir_new_skin="linered";
	}else if(",2015/color_default,2015/color_green,2015/color_lineorange,2015/color_linepurple,2015/color_linered,2015/color_orange,2015/color_pureblue,2015/color_puregreen,2015/color_seablue,".indexOf(","+session.getAttribute("skin")+",")>=0){
		whir_new_skin=session.getAttribute("skin")+"";
        whir_new_skin=whir_new_skin.substring(whir_new_skin.indexOf("_")+1);
	}
}
boolean isPad = com.whir.common.util.CommonUtils.isPad(request);
boolean isForbiddenPad = !isPad;
boolean isSurface = com.whir.common.util.CommonUtils.isSurface(request);
   
String preUrl = rootPath;
//是否为FTP上传
java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session!=null&&session.getAttribute("domainId")!=null?session.getAttribute("domainId").toString():"0");
if (sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")) {
    String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
    preUrl = fileServer;
}

//浏览器类型
String whir_agent = request.getHeader("user-agent")!=null?request.getHeader("user-agent"):"";
whir_agent=com.whir.component.security.crypto.EncryptUtil.htmlcode(whir_agent);
String whir_browser = "";
if(whir_agent.indexOf("Firefox")>=0){
	whir_browser = "firefox";
}else if(whir_agent.indexOf("MSIE")>=0){
	whir_browser = "msie";//或者是360兼容模式
}else if(whir_agent.indexOf("Chrome")>=0 && whir_agent.indexOf("Safari")>=0 && whir_agent.indexOf("OPR")>=0){
	whir_browser = "opera";
}else if(whir_agent.indexOf("Chrome")>=0 && whir_agent.indexOf("Safari")>=0){
	whir_browser = "chrome";//或者是360急速模式
}else if(whir_agent.indexOf("Safari")>=0){
	whir_browser = "safari";
}

String whir_custom_str = "";
%>