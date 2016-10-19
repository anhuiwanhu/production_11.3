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
  	java.util.List classList  = request.getAttribute("classList")!=null?(List)request.getAttribute("classList"):null;
	java.util.List classListTwo  = request.getAttribute("classList_two")!=null?(List)request.getAttribute("classList_two"):null;
	java.util.List classListThree  = request.getAttribute("classList_three")!=null?(List)request.getAttribute("classList_three"):null;
	
	String classId =request.getAttribute("classId")==null?"":request.getAttribute("classId").toString();
	String classId_one =request.getAttribute("classId_one")==null?"":request.getAttribute("classId_one").toString();
	String classId_two =request.getAttribute("classId_two")==null?"":request.getAttribute("classId_two").toString();
	String classId_three =request.getAttribute("classId_three")==null?"":request.getAttribute("classId_three").toString();
	
	String helpEmpId =request.getAttribute("helpEmpId")==null?"":request.getAttribute("helpEmpId").toString();
	String helpEmpName =request.getAttribute("helpEmpName")==null?"":request.getAttribute("helpEmpName").toString();
%>
<body>
<div class="wh-wrapper">
<s:form name="dataForm" id="dataForm" action="/question!updateQuestion.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
	<s:hidden name="questionPO.questionId" />
	<s:hidden name="parentId" id="parentId"/>
	<s:hidden name="parentIdPre" id="parentIdPre"/>
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
                                        <s:textfield name="questionPO.questionTitle" id="questionTitle" cssClass="q_title" readonly="true"/>
                                    </td>
                                </tr>
                                <tr class="anstr2">
                                    <td class="anstrl">问题描述：</td>
                                    <td class="anstrr" colspan="2">
                                        <s:textarea name="questionPO.questionContent" id="questionContent" cssClass="question_content"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
									<%
									  String realFileArray="";
									  String saveFileArray="";
									  realFileArray = request.getAttribute("realFileArray")==null?"":request.getAttribute("realFileArray").toString();
									  saveFileArray = request.getAttribute("saveFileArray")==null?"":request.getAttribute("saveFileArray").toString();
									%>
                                    <td class="answertd1">
                                       <input type="hidden" name="realFileName" id="realFileName" value="<%=realFileArray%>"/>
										<input type="hidden" name="saveFileName" id="saveFileName" value="<%=saveFileArray%>"/>
										<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
											<jsp:param name="accessType"  value="include" />
											<jsp:param name="makeYMdir"   value="yes" />
											<jsp:param name="onInit"      value="init" />
											<jsp:param name="onSelect"    value="onSelect" />
											<jsp:param name="onUploadProgress"  value="onUploadProgress" />
											<jsp:param name="onUploadSuccess"   value="onUploadSuccess" />
											<jsp:param name="dir"  value="zhidao" />
											<jsp:param name="uniqueId"  value="zhidao_question" />
											<jsp:param name="realFileNameInputId"  value="realFileName" />
											<jsp:param name="saveFileNameInputId"  value="saveFileName" />
											<jsp:param name="canModify"  value="yes" />
											<jsp:param name="multi"      value="false" />
											<jsp:param name="buttonText" value="上传图片" />
											<jsp:param name="fileSizeLimit" value="0" />
											<jsp:param name="fileTypeExts"  value="*.jpg;*.jpeg;*.gif;*.png;*.bmp" />
											<jsp:param name="uploadLimit"   value="1" />
										</jsp:include>
                                    </td>
                                    <td class="answertd2"><span>关键词</span><s:textfield name="questionPO.questionKeyWord" id="questionKeyWord" cssClass="pickfiles_zhidao_keywords" /></td>
                                </tr>
                            </table>
                            <div class="forminfo">
								<s:checkboxlist name="questionPO.questionAnonymous" id="questionAnonymous" list="#{'1':'匿名提问'}" />
								<%if(!"".equals(helpEmpId)){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="hidden" name="helpEmpId" id="helpEmpId" value="<%=helpEmpId%>">
								<span class="left34">求助对象：<span class="fontorange"><%=helpEmpName%></span></span>
								<%}%>
							</div>
                            <div class="changetitle">
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
                                                <select multiple="multiple" onchange="selectClass1(this);" name="select1" id="select1" class="selectstyle" defaultvalue="2">

                                                    <%
													if(classList !=null && classList.size() >0){
													   for(int i1=0;i1<classList.size();i1++){
														   Object[] classObj = (Object[]) classList.get(i1);
														   String isSelect ="";
														   if(classId_one.equals(classObj[0].toString())){
															   isSelect ="selected";
														   }
													%>
													<option value="<%=classObj[0]%>" <%=isSelect%>><%=classObj[1]%></option>
													<%}}%>

                                                </select>
                                            </div>
                                        </td>
                                        <td width="210">
                                            <div class="select-bar">
                                                <select multiple="multiple" onchange="selectClass2(this);" name="select2" id="select2" class="selectstyle" defaultvalue="34">
												<%
												if(classListTwo !=null && classListTwo.size() >0){
													for(int i2=0;i2<classListTwo.size();i2++){
														Object[] classObj = (Object[]) classListTwo.get(i2);
														String isSelect ="";
														if(classId_two.equals(classObj[0].toString())){
															isSelect ="selected";
														}
												%>
												<option value="<%=classObj[0]%>" <%=isSelect%>><%=classObj[1]%></option>
												<%}}%>
                                                </select>
                                            </div>
                                        </td>
                                        <td width="210">
                                            <div class="select-bar">
                                                <select multiple="multiple" onchange="selectClass3(this);" name="select3" id="select3" class="selectstyle">
                                                 <%
												if(classListThree !=null && classListThree.size() >0){
													for(int i3=0;i3<classListThree.size();i3++){
														Object[] classObj = (Object[]) classListThree.get(i3);
														String isSelect ="";
														if(classId_three.equals(classObj[0].toString())){
															isSelect ="selected";
														}
												%>
												<option value="<%=classObj[0]%>" <%=isSelect%>><%=classObj[1]%></option>
												<%}}%>
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
                            <div class="sub-answer">
                                <input type="button" name="" class="sub-answer-btn" onClick="saveAndExit(this);" value="提交问题"/>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</s:form>
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
//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'提交问题'});
	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
    
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
    	$("#parentId").val("<%=classId%>");
    	$("#parentIdPre").val("<%=classId%>");
    	
		var $length1 =$("#questionTitle").val().length;
		var $length2 =$("#questionContent").val().length;
		//$("#wordCount1").text(50 - $length1);
		//$("#wordCount2").text(1500 - $length2);

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
    }
    
    function selectClass3(obj){
    	$('#parentId').val(obj.value);
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