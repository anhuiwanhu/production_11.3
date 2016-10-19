<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%> 
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.i18n.Resource" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String local       = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><s:text name="personalwork.skinmodify" /></title> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
	<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>"; 
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(whir_agent)%>"; 
	var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
    </script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>  
	<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>  
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.style.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.fa.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/themes/2015/color_default/template.keyframe.default.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/themes/2015/color_default/template.color.default.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.frame.big.css" /> 
    <!--这里可以追加导入模块内私有的js文件或css文件--> 
</head>
<style type="text/css">
</style>

<body >
    <s:form name="dataFormSkin" id="dataFormSkin"  action="/defaultroot/MyInfoAction!updateMySkin.action" method="post" theme="simple" >
        <%@ include file="/public/include/form_detail.jsp"%>
        <%@ include file="personal_mySkinSC_form.jsp"%>
    </s:form>
</body>

<script type="text/javascript">
var api = frameElement==undefined?null:frameElement.api, W = api==null?null:api.opener; 
function updateMySkinSuccess(){
    if(api == undefined) {
    } else {
        // W.refreshDisplayList();
        var url = whirRootPath + "/desktop.jsp" +'?date='+Math.random();
        //alert(url);
        api.hide();
        W.top.location_href(url);
        //window.top.location.reload();
        
        // 关闭当前弹出层
        //api.close();
    }
}

function closePopup(){
    if(api == undefined) {
    } else {
        // 关闭当前弹出层
        api.close();
    }
}
 
 
/** 修改页 [BEGIN] */
function initModiForm(){   
   $(".wh-sys-setting-skinlist p").click(function () {
	   var $this = $(this);
	   var skin = $(this).attr("skinValue");
	   if(skin == ''){
	   } else {
		  $('#mySkin').val(skin);
	   } 
	   var skinColor = $this.data("color");
       $this.addClass('current').siblings().removeClass('current');           
       $("#whSkinImg").removeClass().addClass("wh-skin-model-img wh-skin-"+skinColor);
	}); 

	//初始化 选择当前的样式
    var curSkin = $('#mySkin').val();  
	/*var index=curSkin.substr(curSkin.length-1,1);  
	$("#personal_skinchoose_div p[skinValue='"+curSkin+"']").addClass('current').siblings().removeClass('current');
	$(".skin_model").hide().eq(index-1).show(); */  
	var  pobj=$("#personal_skinchoose_div p[skinValue='"+curSkin+"']"); 
	pobj.addClass('current').siblings().removeClass('current'); 
	$("#whSkinImg").removeClass().addClass("wh-skin-model-img wh-skin-"+pobj.data("color"));  
    return true;
}

 
$(document).ready(function(){    
    if(initModiForm()){ 
        //设置表单为异步提交
        initDataFormToAjax({"dataForm":'dataFormSkin', "tip":'<s:text name="personalwork.save" />', "callbackfunction":updateMySkinSuccess});
    }
});

 


</script>

</html>

