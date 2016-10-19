<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%
ConfMap confMap = (ConfMap)request.getAttribute("confMap");
String stockCode = confMap.get("stockCode");
%>
<tr>
    <th><em>我的股票：</em></th>
    <td colspan="3">
       <div class="wh-choose-info-text">
           <input type="text" name="stockCode" class="wh-choose-info-input" value="<%=stockCode %>" placeholder="请输入股票代码，多只股请使用,分割"/>
       </div>
       <span>例:sh600006,sh000001</span>
    </td>
</tr>
