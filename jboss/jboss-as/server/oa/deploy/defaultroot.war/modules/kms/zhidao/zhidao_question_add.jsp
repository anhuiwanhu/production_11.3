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
	<link rel="stylesheet" href="<%=rootPath%>/templates/template_default/common/css/template.page.css" />
	<!--[if lt IE 9]>
    <link rel="stylesheet" href="../../templates/template_default/common/css/template.portal.ie8.css" />
    <![endif]-->
	<%@ include file="/public/include/meta_list.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
</head>
<%
	com.whir.ezoffice.zhidao.bd.QuestionBD qbd =new com.whir.ezoffice.zhidao.bd.QuestionBD();
	
  	java.util.List classList  = request.getAttribute("classList")!=null?(List)request.getAttribute("classList"):null;
	//String helpEmpId =request.getParameter("helpEmpId")==null?"":request.getParameter("helpEmpId");
	String helpEmpId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"helpEmpId");
    //String helpEmpName =request.getParameter("helpEmpName")==null?"":request.getParameter("helpEmpName");
	String helpEmpName = com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"helpEmpName");
	//String questionTitle =request.getParameter("questionTitle")==null?"":request.getParameter("questionTitle");
	String questionTitle = com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"questionTitle");
%>
<body>
<div class="wh-wrapper">
<s:form name="dataForm" id="dataForm" action="/question!saveQuestion.action" method="post" theme="simple" >
    <div class="wh-content">
        <div class="wh-container">            
            <div class="wh-sigpage wh-sigpage-q2a">
                <div class="wh-q2a-list">
                    <h2>
                        <strong>请将您的疑问告诉我们</strong>
                    </h2>
                    <ul>
                        <li class="clearfix">
                            <table class="answer-table">
                                <tr class="anstr1">
                                    <td class="anstrl">问题标题： </td>
                                    <td class="anstrr" colspan="2" >
                                        <input name="questionPO.questionTitle" id="questionTitle" class="q_title" />
                                    </td>
                                </tr>
                                <tr class="anstr2">
                                    <td class="anstrl">问题描述：</td>
                                    <td class="anstrr" colspan="2">
                                        <textarea name="questionPO.questionContent" id="questionContent" class="question_content"></textarea>
                                    </td>
                                </tr>
								<s:hidden name="questionPO.questionId" />
	                            <s:hidden name="parentId" id="parentId"/>
                                <tr>
                                    <td></td>
                                    <td class="answertd1">
                                        <input type="hidden" name="answerRealFileName" id="answerRealFileName" value=""/>
										<input type="hidden" name="answerSaveFileName" id="answerSaveFileName" value=""/>
										<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
											<jsp:param name="accessType"  value="include" />
											<jsp:param name="makeYMdir"   value="yes" />
											<jsp:param name="onInit"      value="init" />
											<jsp:param name="dir"  value="zhidao" />
											<jsp:param name="uniqueId"  value="zhidao_answer" />
											<jsp:param name="realFileNameInputId"  value="answerRealFileName" />
											<jsp:param name="saveFileNameInputId"  value="answerSaveFileName" />
											<jsp:param name="canModify"  value="yes" />
											<jsp:param name="multi"      value="false" />
											<jsp:param name="buttonText" value="上传图片" />
											<jsp:param name="fileSizeLimit" value="0" />
											<jsp:param name="fileTypeExts"  value="*.jpg;*.jpeg;*.gif;*.png;*.bmp" />
											<jsp:param name="uploadLimit"   value="1" />
										</jsp:include>
                                    </td>
                                    <td class="answertd2"><span>关键词</span>
									<input name="questionPO.questionKeyWord" id="questionKeyWord" class="pickfiles_zhidao_keywords" />
									</td>
                                </tr>
                            </table>                           
                            <div class="changetitle">
							    <div class="unname-ask">
								<s:checkboxlist name="questionPO.questionAnonymous" id="questionAnonymous" list="#{'1':'匿名提问'}" />
								<%if(!"".equals(helpEmpId)){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="hidden" name="helpEmpId" id="helpEmpId" value="<%=helpEmpId%>">
								<span>求助对象：<span><%=helpEmpName%></span></span>
								<%}%>
							    </div>
                                <div onclick="getClassList();" class="setclass" >
                                    <span>设置分类</span>
                                    <i class="fa fa-angle-down"></i>
                                </div>
                                <div class="bold">如果没有合适的推荐分类，建议您更改分类，有助于获得准确解答</div>
                            </div>
								<div id="classList" style="display:none">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tbody><tr valign="top">
                                        <td width="210">
                                            <div class="select-bar">
                                                <select multiple="multiple" onchange="selectClass1(this);" name="select1" id="select1" class="selectstyle" >
												<%
												if(classList !=null && classList.size() >0){
												   for(int ii=0;ii<classList.size();ii++){
													   Object[] classObj = (Object[]) classList.get(ii);
												%>
												<option value="<%=classObj[0]%>" ><%=classObj[1]%></option>
												<%}}%>
                                                </select>
                                            </div>
                                        </td>
                                        <td width="210">
                                            <div class="select-bar">
                                                <select multiple="multiple" onchange="selectClass2(this);" name="select2" id="select2" class="selectstyle" >

                                                </select>
                                            </div>
                                        </td>
                                        <td width="210">
                                            <div class="select-bar">
                                                <select multiple="multiple" onchange="selectClass3(this);" name="select3" id="select3" class="selectstyle">

                                                </select>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td colspan="3">
                                            <div class="remark-1">如果您的问题无法归入任何子分类，您可以只选择一级分类</div>
                                            <div class="txtright">&nbsp;</div>
                                        </td>
                                    </tr>
                                    </tbody></table>
                            </div>
							<%
							if(!"".equals(questionTitle)){
								List<Map> maplist =request.getAttribute("maplist")!=null?(List)request.getAttribute("maplist"):null;
								if(maplist !=null && maplist.size() >0){
							%>
							<div class="askbox">
								<h1>看看以下回答是否解决了您的疑问</h1>
								<ul class="asklist">
									<%
									int num =5;
									if(num > maplist.size()){
										num =maplist.size();
									}
									for(int i=0;i<num;i++){
										Map qmap =(Map)maplist.get(i);
										String _questionId =qmap.get("id")==null?"":String.valueOf(qmap.get("id"));
										String _questionTitle =qmap.get("title")==null?"":String.valueOf(qmap.get("title"));
										String answerContent =qbd.getAnswerContentByQuestionId(_questionId);
										if("".equals(answerContent)){
											answerContent ="暂无回答！";
										}
										if(answerContent !=null && !"".equals(answerContent) && answerContent.length() >150){
											answerContent =answerContent.substring(0,150)+"...";
										}
									%>
									<li>
										<div class="ask"><a href="javascript:void(0);" onclick="view('<%=_questionId%>')"><%=_questionTitle%></a></div>
										<div class="answer"><%=answerContent%></div>
									</li>
									<%}%>
								</ul>
							</div>
							<%}}%>
							
							<div class="userarea" id="userarea" style="display:none">
								<div class="userarea-top"><input name="userIds" id="userIds" type="checkbox" value=""/><span id="description"></span></div>
								<ul class="userlist" id="userlist">
									
								</ul>
							</div>
							<div class="sub-answer">
                                <input type="button" name="" class="sub-answer-btn" onClick="saveAndExit(this);" value="提交问题"/>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
	</s:form>
</div>
</body>
<script type="text/javascript">
var tB= $(".wh-q2a-list ul li");
tB.each(function(i){
    $("#commitBtn"+i).click(function(){
        $("#commit"+i).toggle();
    })
    $("#askGoonBtn"+i).click(function(){
        $("#askGoon"+i+" .wh-q2a-a-comipt").toggle();
    })
});

function getClassList(){
    var temp = $("#classList").is(":hidden");
    if(temp){
        $("#classList").attr('style','display:');
    }else{
        $("#classList").attr('style','display:none');
    }
}
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'提交问题'});
 function saveAndExit(obj){
    	var questionTitle =$("#questionTitle").val();
    	if(questionTitle ==null || questionTitle ==""){
    		whir_alert("请输入问题标题！", function(){
    			$("#questionTitle").focus();
    		});
    	    return false;
    	}else{
			if(checkIllegalCharacter(questionTitle,"问题标题")){
				return false;
			}
		}

		var questionContent =$("#questionContent").val();
		if(questionContent !=null && questionContent !=""){
			if(checkIllegalCharacter(questionContent,"问题补充")){
				return false;
			}
		}
    	
		var questionKeyWord =$("#questionKeyWord").val();
		if(questionKeyWord.length >100){
			whir_alert("关键词已超过100字，请重新输入！", null);
    	    return false;
		}else{
			if(checkIllegalCharacter(questionKeyWord,"关键词")){
				return false;
			}
		}

    	var parentId =$("#parentId").val();
    	if(parentId ==null || parentId =="" || parentId=="-1"){
    		whir_alert("请选择知识分类！", function(){});
    	    return false;
    	}
    	
        ok(0,obj);
    }
    
    function getClassList(){
    	var temp = $("#classList").is(":hidden");
    	if(temp){
    		$("#classList").attr('style','display:');
    	}else{
    		$("#classList").attr('style','display:none');
    	}
    }
    
    $(document).ready(function(){
    	var questionTitle =$('#question_title').val();
    	if(questionTitle !=""){
    		$("#questionTitle").val(questionTitle);
    	}
    	
		var $length1 =$("#questionTitle").val().length;
		//$("#wordCount1").text(50 - $length1);

    	$("#questionTitle").keyup(function(){
    		var $max =50;
    		var $length =$("#questionTitle").val().length;
    		if($length > $max){
				//$("#wordCount1").text("0");
    			whir_alert("问题标题不能超过50个字！", function(){
    				$("#questionTitle").val($("#questionTitle").val().substring(0,50));
    			});
    		}else{
    			//$("#wordCount1").text($max - $length);
    		}
    	});
    	
    	$("#questionContent").keyup(function(){
    		var $max =1500;
    		var $length =$("#questionContent").val().length;
    		if($length > $max){
				//$("#wordCount2").text("0");
    			whir_alert("问题补充不能超过1500个字！", function(){
    				$("#questionContent").val($("#questionContent").val().substring(0,1500));
    			});
    		}else{
    			//$("#wordCount2").text($max - $length);
    		}
    	});
    	
    	
    	<%if("".equals(helpEmpId)){%>
    	$("#questionKeyWord").change(function(){
    		var kw =$("#questionKeyWord").val();
    		if(kw !=""){
				var classId =$('#parentId').val();
    			var address = whirRootPath + "/question!getExpert.action?keyWord="+encodeURIComponent(kw)+"&classId="+classId;
				var description ="同时向擅长'"+kw+"'的专家求助，他们会更快的解决你的问题。";
    			$.ajax({
    				type: 'POST',
    				url: address,
    				async: true,
    				dataType: 'json',
    				success: function(json){
    					if(json.expertString !=''){
	    					$("#userarea").show();
	    					$("#userlist").html(json.expertString);
	    					$("#userIds").val(json.expertIds);
							$("#description").html(description);
    					}else{
    						$("#userarea").hide();
    						$("#userlist").html('');
    						$("#userIds").val('');
							$("#description").html(description);
    					}
    				},
    				error: function(XMLHttpRequest, textStatus, errorThrown) {
                		alert(XMLHttpRequest.status);
                		alert(XMLHttpRequest.readyState);
                		alert(textStatus);
            		}
    			});
    		}
    	});
    	<%}%>
    	
    });
    
    function selectClass1(obj){
    	var address = whirRootPath + "/classSet!getClassListByClassId.action?classId="+obj.value+"";
    	$('#parentId').val(obj.value);
    	$.ajax({
    	 	type: 'POST',
    	 	url: address,
    	 	async: true,
    	 	dataType: 'json',
    	 	success: function(json){
    	 	 	$('#select2').html(json.classJosn);
    	 	 	$('#select3').html("");
    	 	},
    	 	error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
    	});
		//【知道】->点击直接提问，在关键词处输入关键词，需要按照分类检索专家，若未选择分类，则检索全部专家--需求文档[检索此问题分类中所有专家的"擅长关键词"，将匹配的专家显示在最下方]
		var kw =$("#questionKeyWord").val();
		if(kw !=""){
			var url_address = whirRootPath + "/question!getExpert.action?keyWord="+encodeURIComponent(kw)+"&classId="+obj.value;
			var description ="同时向擅长'"+kw+"'的专家求助，他们会更快的解决你的问题。";
			$.ajax({
				type: 'POST',
				url: url_address,
				async: true,
				dataType: 'json',
				success: function(json){
					//alert(json.expertString);
					if(json.expertString !=''){
						$("#userarea").show();
						$("#userlist").html(json.expertString);
						$("#userIds").val(json.expertIds);
						$("#description").html(description);
					}else{
						$("#userarea").hide();
						$("#userlist").html('');
						$("#userIds").val('');
						$("#description").html(description);
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.status);
					alert(XMLHttpRequest.readyState);
					alert(textStatus);
				}
			});
		}
    }
    
    function selectClass2(obj){
    	var address = whirRootPath + "/classSet!getClassListByClassId.action?classId="+obj.value+"";
    	$('#parentId').val(obj.value);
    	$.ajax({
    	 	type: 'POST',
    	 	url: address,
    	 	async: true,
    	 	dataType: 'json',
    	 	success: function(json){
    	 	 	$('#select3').html(json.classJosn);
    	 	},
    	 	error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
    	});
		//【知道】->点击直接提问，在关键词处输入关键词，需要按照分类检索专家，若未选择分类，则检索全部专家--需求文档[检索此问题分类中所有专家的"擅长关键词"，将匹配的专家显示在最下方]
		var kw =$("#questionKeyWord").val();
		if(kw !=""){
			var url_address = whirRootPath + "/question!getExpert.action?keyWord="+encodeURIComponent(kw)+"&classId="+obj.value;
			var description ="同时向擅长'"+kw+"'的专家求助，他们会更快的解决你的问题。";
			$.ajax({
				type: 'POST',
				url: url_address,
				async: true,
				dataType: 'json',
				success: function(json){
					//alert(json.expertString);
					if(json.expertString !=''){
						$("#userarea").show();
						$("#userlist").html(json.expertString);
						$("#userIds").val(json.expertIds);
						$("#description").html(description);
					}else{
						$("#userarea").hide();
						$("#userlist").html('');
						$("#userIds").val('');
						$("#description").html(description);
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.status);
					alert(XMLHttpRequest.readyState);
					alert(textStatus);
				}
			});
		}
    }
    
    function selectClass3(obj){
    	$('#parentId').val(obj.value);
		//【知道】->点击直接提问，在关键词处输入关键词，需要按照分类检索专家，若未选择分类，则检索全部专家--需求文档[检索此问题分类中所有专家的"擅长关键词"，将匹配的专家显示在最下方]
		var kw =$("#questionKeyWord").val();
		if(kw !=""){
			var url_address = whirRootPath + "/question!getExpert.action?keyWord="+encodeURIComponent(kw)+"&classId="+obj.value;
			var description ="同时向擅长'"+kw+"'的专家求助，他们会更快的解决你的问题。";
			$.ajax({
				type: 'POST',
				url: url_address,
				async: true,
				dataType: 'json',
				success: function(json){
					//alert(json.expertString);
					if(json.expertString !=''){
						$("#userarea").show();
						$("#userlist").html(json.expertString);
						$("#userIds").val(json.expertIds);
						$("#description").html(description);
					}else{
						$("#userarea").hide();
						$("#userlist").html('');
						$("#userIds").val('');
						$("#description").html(description);
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.status);
					alert(XMLHttpRequest.readyState);
					alert(textStatus);
				}
			});
		}
    }
    
    function view(questionId){
		openWin({url:'<%=rootPath%>/question!viewQuestion.action?id='+questionId+'',isFull:true,winName:'查看问题'});
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