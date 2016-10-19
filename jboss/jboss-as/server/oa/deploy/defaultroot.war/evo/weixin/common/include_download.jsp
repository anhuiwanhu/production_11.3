<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.math.RoundingMode"%>
<%
request.setCharacterEncoding("UTF-8");
java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(""+session.getAttribute("domainId"));
//上传下载方式：1：http，2：ftp
/*int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}*/
//文件下载服务
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
//session.getAttribute("fileServer") + "" ;
//真实文件名
String realFileNames = request.getParameter("realFileNames") != null ? request.getParameter("realFileNames") : "";
//保存文件名
String saveFileNames = request.getParameter("saveFileNames") != null ? request.getParameter("saveFileNames") : "";
//模块名称
String moduleName = request.getParameter("moduleName") != null ? request.getParameter("moduleName") : "";

String[] realFileNamesArray = realFileNames.split("\\|");
String[] saveFileNamesArray = saveFileNames.split("\\|");
com.whir.evo.weixin.util.UploadFile uploadFile = new com.whir.evo.weixin.util.UploadFile();
File file = null;
String fileUrl = "";
String fileSizeStr = "";
double fileSize = 0;
BigDecimal bd = null;
String downloadFileLink = "";
String moduleRealPath = request.getRealPath("/upload/"+moduleName);
%>
<div class="wh-article-atta">
<%
for(int i = 0,length = realFileNamesArray.length ;i < length ;i ++){
	/*fileUrl = moduleRealPath + "/" + saveFileNamesArray[i].substring(0,6) + "/" + saveFileNamesArray[i];
	file = new File(fileUrl);
	fileSizeStr = "";
	fileSize = file.length();
	if ((fileSize / 1024 / 1024) < 1) {
		if (fileSize / 1024 < 1) {
			fileSizeStr = String.valueOf(fileSize).concat("B");
		} else {
			fileSizeStr = String.valueOf(Math.round(fileSize / 1024 * 10) / 10.0).concat("KB");							
		}
	} else {
		bd = new BigDecimal(fileSize / 1024 / 1024);
		fileSizeStr = String.valueOf(bd.setScale(2, RoundingMode.HALF_UP)).concat("M");
	}*/
	downloadFileLink = uploadFile.getDownloadFileLink(saveFileNamesArray[i], realFileNamesArray[i], moduleName, fileServer).replaceAll("&cd=inline","");
%>
<p style="text-align:left;">
	<i class="fa fa-paperclip"></i>
	<a href='javascript:void(0);' onclick='clickSub("<%=downloadFileLink%>",this);' color='blue'>
		<strong class="atta-name">
			<%=realFileNamesArray[i]%>
		</strong>
	</a>
<%--	<span class="atta-size"><%=fileSizeStr%></span>--%>
</p>
<%
}
%>
</div>