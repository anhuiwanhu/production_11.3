<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.common.util.UploadFile"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>

<%
String rootPath = com.whir.component.config.PropertiesUtil.getInstance().getRootPath();

	String local = session.getAttribute("org.apache.struts.action.LOCALE")!=null?session.getAttribute("org.apache.struts.action.LOCALE").toString():"zh_CN";
	request.setCharacterEncoding("UTF-8");
   	String FileName =request.getParameter("fileName");;
	UploadFile upFile = new UploadFile();
	String encrypt = upFile.getFileEncrypt(FileName);	
	String path="/defaultroot";
	
	response.setContentType("application/x-download");
	
	response.addHeader("Content-Disposition", "attachment;filename=\"" +FileName+"\"");
	try {
	    if("1".equals(encrypt)){
	        out.clearBuffer();
	        upFile.decryptFile(request.getRealPath(path + "/" + FileName), response.getOutputStream(), true);
	    }else{
	        out.clearBuffer();
	        upFile.decryptFile(request.getRealPath(path + "/" + FileName), response.getOutputStream(), false);
	    }
	} catch(Throwable e) {
	  	e.printStackTrace();
	} finally {
	  	response.flushBuffer();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>  
     
  
</head>
</html>