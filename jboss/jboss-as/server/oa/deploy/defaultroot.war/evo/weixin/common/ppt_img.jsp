<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
<%--    ,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui--%>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>文档预览</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<section class="wh-section">
	<article class="wh-article wh-article-pic" id="img_article">
	</article>
</section> 
<input type="hidden" id="startIndex" value="0"/>
<input type="hidden" id="endIndex"/>
<input type="hidden" id="hasMore"/>
</body>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
$(function(){
	//执行转换图片并在页面上显示 
	loadPPTContent();
});

var dialog = null;
//数据加载提示
function showLoding(){
     dialog = $.dialog({
     content:"数据加载中...",
     title: 'load'
   });
}

var loadFlag = 0;
// 加载指定数量的PPT数据
function loadPPTContent(){
	if(loadFlag == 1){
		return false;
	}
	loadFlag = 1;
	var $startIndex = $('#startIndex');
	var $endIndex = $('#endIndex');
	var startIndex = $startIndex.val();
	var endIndex = $endIndex.val();
	showLoding();
	$.ajax({
		url : '/defaultroot/convertFile/pptPdf2Img.controller',
		type : 'post',
		data : {'saveFileName': '${param.saveFileName}', 'moduleName' : '${param.moduleName}', 'startIndex' : startIndex,'endIndex' : endIndex},
		success : function(data){
			if(!data){
				return false;
			}
			var jsonData = eval('('+data+')');
			if(!jsonData){
				return false;
			}
			var dataArray = jsonData.data0;
			if(!dataArray){
				return false;
			}
			var length = dataArray.length;
			var imgHtml = '';
			var directoryName = '';
			var imgSrc;
			var moduleName = jsonData.data2
			for(var index = 0;index < length-2;index ++){
				directoryName = dataArray[index].split('_')[0];
				imgSrc = "/defaultroot/evo/weixin/file/convert/" + moduleName + "/"+directoryName + "/" + dataArray[index];
				imgHtml += '<img src="'+imgSrc+'"/><hr/>';
			}
			$startIndex.val(dataArray[length-2]);
			$endIndex.val(dataArray[length-1]);
			// 是否还有更多标识 赋值
			$('#hasMore').val(jsonData.data1);
			$('#img_article').append(imgHtml);
			if(dialog){
           		dialog.close();
            }
			loadFlag = 0;
		},
		error : function(){
			if(dialog){
         		dialog.close();
            }
			alert('打开文件失败！');
			loadFlag = 0;
		},
	　　complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(dialog){
              		dialog.close();
               }
	　　　　if(status=='timeout'){//超时,status还有success,error等值的情况
	　　　　　  alert("超时");
	　　　　}
	　　}
	});
}

//滚动条至底部加载更多内容
$(window).scroll(function(){
   var scrollTop = $(this).scrollTop();
   var scrollHeight = $(document).height();
   var windowHeight = $(this).height();
   if(scrollTop + windowHeight == scrollHeight){
		var hasMore = $('#hasMore').val();
		if(hasMore == 'true'){
	  	 	loadPPTContent();
		}
   }
});
</script>
</html>
