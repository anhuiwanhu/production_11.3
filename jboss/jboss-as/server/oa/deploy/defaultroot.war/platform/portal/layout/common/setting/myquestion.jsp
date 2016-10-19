<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%
ConfMap confMap = (ConfMap)request.getAttribute("confMap");

String limitNum = confMap.get("limitNum");
String limitChar = confMap.get("limitChar");
String personInfomationValue = confMap.get("personInfomationValue");
String myKnowValue = confMap.get("myKnowValue");
String myAnswerValue = confMap.get("myAnswerValue");
String otherQuestinValue = confMap.get("otherQuestinValue");

//初始化默认值
if(limitNum==null||"".equals(limitNum)||"null".equals(limitNum)||"undefined".equals(limitNum)){
    limitNum = "10";//默认记录数
}
%>
<script>
function chkbox(elm,flag){
	  var obj=document.getElementsByName("myknow");
	  var num=0;
	  for (i=0;i<obj.length ;i++ ){
		  if (obj[i].checked ){
		      num+=1;  
			  }
		  }
	 if (num>3)
	 {
	  //并且把多选择的去除
	  alert("最多可以选择三个！");
	  elm.status=false;
	 // var flag = elm.flag ;
	  //alert(flag);
	  obj[flag].checked =false;
	 }
	 if(elm.checked){
		  elm.value = 1;
	  }else{
		  elm.value = 0;
	 }
 }
</script>
<tr>
    <th><em>显示项：</em></th>
    <td colspan="3">
	<div class="wh-choose-check">
		<input name="myknow" type="checkbox" value="<%=personInfomationValue %>" onclick="chkbox(this,0);" id = "personInfomationValue"  flag ="0" 
		<%if("1".equals(confMap.get("personInfomationValue"))){%>
			checked="checked"
		<%}%>
		>
		  <label for="personInfomation">个人信息</label>
		<input name="myknow" type="checkbox" value="<%=myKnowValue %>" onclick="chkbox(this,1);" id = "myKnowValue" flag ="1" 
		<%if("1".equals(confMap.get("myKnowValue"))){%>
			checked="checked"
		<%}%>
		>
		  <label for="myKnow">我的提问</label>
		  <input name="myknow" type="checkbox" value="<%=myAnswerValue %>" onclick="chkbox(this,2);" id = "myAnswerValue" flag ="2" 
		<%if("1".equals(confMap.get("myAnswerValue"))){%>
			checked="checked"
		<%}%>
		>
		  <label for="myAnswer">我的回答</label>
		  <input name="myknow" type="checkbox" value="<%=otherQuestinValue %>" onclick="chkbox(this,3);" id = "otherQuestinValue"  flag ="3" 
		<%if("1".equals(confMap.get("otherQuestinValue"))){%>
			checked="checked"
		<%}%>
		>
		  <label for="otherQuestion">他人求助</label>
    </div>
</tr>
<tr>
    <th><em>列表字数限制：</em></th>
    <td>
        <div class="wh-choose-input">
            <input type="text" name="limitChar" id="limitChar" class="wh-choose-input-wid" value="<%=limitChar %>" maxlength="2"/>
        </div>
    </td>
    <th><em>信息条数：</em></th>
    <td>
        <div class="wh-choose-input-w-box">
            <i class="fa fa-plus wh-pic-num-plus" onclick="setAmount.add('.wh-backstage-pic-num')"></i>
            <input type="text" name="limitNum" id="limitNum" class="wh-choose-input-num wh-backstage-pic-num" value="<%=limitNum %>" data-maxval="20" data-minval="1" maxlength="2"/>
            <i class="fa fa-minus wh-pic-num-minus" onclick="setAmount.reduce('.wh-backstage-pic-num')"></i>
        </div>
    </td>
</tr>