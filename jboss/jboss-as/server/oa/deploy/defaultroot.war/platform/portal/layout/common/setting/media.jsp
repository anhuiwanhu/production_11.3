<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%
ConfMap confMap = (ConfMap)request.getAttribute("confMap");
String portletSettingId = request.getParameter("portletSettingId");
String mWidth = confMap.get("mWidth");
String mHeight = confMap.get("mHeight");
String portletImgName = confMap.get("portletImgName");
String portletImgSaveName = confMap.get("portletImgSaveName");
%>
<tr>
    <th><em>媒体管理：</em></th>
    <td colspan="3">
        <input type="hidden" name="portletImgName" value="<%=portletImgName %>" id="portletImgName"/>
        <input type="hidden" name="portletImgSaveName" value="<%=portletImgSaveName %>" id="portletImgSaveName"/>
        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
            <jsp:param name="isShowBatchDownButton" value="no" />
            <jsp:param name="accessType" value="include" />
            <jsp:param name="makeYMdir" value="yes" />
            <jsp:param name="dir" value="portal" />
            <jsp:param name="uniqueId" value="uniqueId_portlet" />
            <jsp:param name="realFileNameInputId" value="portletImgName" />
            <jsp:param name="saveFileNameInputId" value="portletImgSaveName" />
            <jsp:param name="canModify" value="yes" />
            <jsp:param name="width" value="90" />
            <jsp:param name="height" value="20" />
            <jsp:param name="multi" value="false" />
            <jsp:param name="buttonClass" value="upload_btn" />
            <jsp:param name="buttonText" value="上传媒体" />
            <jsp:param name="fileSizeLimit" value="50MB" />
            <jsp:param name="fileTypeExts" value="*.avi;*.wav;*.swf;*.mp3;*.rmvb;" />
            <jsp:param name="uploadLimit" value="0" />
            <jsp:param name="portletSettingId" value="<%=portletSettingId%>" />
            <jsp:param name="buttonDesc" value="支持媒体格式：.avi,.wav,.swf,.mp3,.rmvb" />
        </jsp:include>
    </td>
</tr>
<tr>
    <th><em>媒体宽度：</em></th>
    <td>
    	<div>
         	 <input type="text" id="mWidth" name="mWidth" class="wh-fileup-input" value="<%="".equals(mWidth)?"200":mWidth%>"/>
             <span>px</span>
        </div>
    </td>
    <th><em>媒体高度：</em></th>
    <td>
        <div>
          	 <input type="text" id="mHeight" name="mHeight" class="wh-fileup-input" value="<%="".equals(mHeight)?"180":mHeight%>"/>
             <span>px</span>
         </div>
    </td>
</tr>