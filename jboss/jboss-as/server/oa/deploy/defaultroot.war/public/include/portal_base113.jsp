    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/jquery/jquery.min.js" ></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/superslide/jquery.SuperSlide.2.1.1.js" ></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/flexslide/jquery.flexslider.js" ></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/foucs/jquery.foucs.js" ></script>
    <!--
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/html5/html5.js" ></script>    
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/html5/excanvas.js" ></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/radialindicator/radialIndicator.js" ></script>
    -->
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/highcharts/jquery.highcharts.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/highcharts/jquery.highcharts-more.js"></script>
    <script type="text/javascript">
        var whirRootPath = "<%=rootPath%>";
        var preUrl = "<%=preUrl%>";
        var whir_browser = "<%=whir_browser%>";
        var whir_agent = "<%=whir_agent%>";
        var whir_skin = "<%=whir_skin%>";
    </script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/platform/portal/js/common.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/platform/portal/js/jquery.jfeed.pack.js"></script>

    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.fa.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.portal.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/themes/2015/color_<%=whir_new_skin%>/template.keyframe.<%=whir_new_skin%>.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/themes/2015/color_<%=whir_new_skin%>/template.color.<%=whir_new_skin%>.css" />
    <%
    //×ÖÌå´óÐ¡ 
    if(whir_pageFontSize.equals("12")){%>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.portal.small.css" />
    <%}else{%>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.portal.big.css" />
    <%}%>
    <%if(isPad){%>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.ios.css" />
    <%}%>
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.portal.ie8.css" />
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/respond/respond.js" ></script>
    <![endif]-->