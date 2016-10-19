<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <%@ include file="/public/include/meta_new_base.jsp"%>
	<!--[if lt IE 9]>
    <link rel="stylesheet" href="../../templates/template_default/common/css/template.portal.ie8.css" />
    <![endif]-->
	<%@ include file="/public/include/meta_list.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
</head>
<body>
<div class="wh-container wh-portaler">
    <div class="wh-portal-zd-search">
        <form name="queryForm" action="" method="post" theme="simple" >
            <div class="wh-zd-toolbarBottomLine" >
                <input type="text" name="retrievalKey" id="retrievalKey" class="wh-zd-search-text" >
                <input type="button" class="wh-zd-search" onclick="retrieval();" value="搜索答案">
                <input type="button" class="wh-zd-ask" onclick="addQuestionForIndex();" value="直接提问">
                <input type="button" class="wh-zd-ans" onclick="openWin({url:'/defaultroot/question!answerQuestionList.action',isFull:true,winName:'我要回答'});" value="我要回答">
            </div>
         </form>
    </div>
</div>
</body>
<script>
    // 捕捉回车键
	$("body").unbind();
	$("input").bind('keydown',function(event){
		if(event!=undefined && event.keyCode==13){
			retrieval();
            event.preventDefault();
            event.stopPropagation();
		}
	});

	function retrieval(){
		var key = $("#retrievalKey").val();
		if(key==''){
			whir_alert("请输入关键字");
			return false;
		}else{
			if(checkIllegalCharacter(key,"关键字")){
				return false;
			}
			if(key.length >50){
				key =key.substring(0,50);
			}
			openWin({url:'<%=rootPath%>/question!selectQuestion.action?key='+key,isFull:true,winName:'搜索答案'});
		}
	}
	
	function addQuestionForIndex(){
		var questionTitle =$("#retrievalKey").val();
		if(questionTitle !=null && questionTitle !=""){
			if(checkIllegalCharacter(questionTitle,"关键字")){
				return false;
			}
		}
		if(questionTitle.length >50){
			questionTitle =questionTitle.substring(0,50);
		}
		openWin({url:'<%=rootPath%>/question!addQuestion.action?questionTitle='+questionTitle,isFull:true,winName:'新增问题'});
	}
	
	//检查是否包含非法字符
	function checkIllegalCharacter(val, name){
        var regu = /['<>^/\\\#&]/g;
        var re   = new RegExp(regu);
        if(val.search(re) != -1){
           whir_alert(name + "不能含有特殊字符:\n ' < > ^ / \\\ # &");
           return true ;
        }
        return false ;
    }
</script>
</html>