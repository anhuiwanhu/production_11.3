<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.fa.css" />
<link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.style.css" />
<%if(isPad){%>
<link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.ios.css" />
<%}%>
<script src="<%=rootPath%>/scripts/jquery-1.8.0.min.js" type="text/javascript"></script> 
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.ztree.css" type="text/css"> 
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/zTree_v3/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>"; 
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(whir_agent)%>"; 
	var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
</script> 
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>  
<script LANGUAGE="JavaScript" src="<%=rootPath%>/scripts/main/cookie.js"></script>
<script LANGUAGE="JavaScript" src="<%=rootPath%>/scripts/desktop/desktop_2016.js"></script> 
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/superslide/jquery.SuperSlide.2.1.1.js" ></script>   
<script type="text/javascript">  
  var setting = {
		view: {
			selectedMulti: false,
			dblClickExpand: false
		},
		check: {
			enable: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		edit: {
			enable: false
		},
		callback: {
		  onClick: onClick
		} 
	}; 
	function onClick(e,treeId, treeNode) {
		 var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		 zTree.expandNode(treeNode);
    };  
</script>
<script type="text/javascript">
<!--
	var g_whir_skin = "<%=whir_skin%>";
//-->
</script>
<!--[if lt IE 9]>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.style.ie8.css" />
<![endif]-->
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/themes/2015/color_<%=whir_new_skin%>/template.keyframe.<%=whir_new_skin%>.css" />
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/themes/2015/color_<%=whir_new_skin%>/template.color.<%=whir_new_skin%>.css" />
<%
//×ÖÌå´óÐ¡ 
if(whir_pageFontSize.equals("12")){%>
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.frame.small.css" />
<%}else{%>
<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.frame.big.css" />
<%}
%> 