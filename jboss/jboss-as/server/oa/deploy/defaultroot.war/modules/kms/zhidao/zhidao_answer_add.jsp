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
  	java.util.List answerList  = request.getAttribute("answerList")!=null?(List)request.getAttribute("answerList"):null;
	
	String questionId =request.getAttribute("questionId")==null?"":request.getAttribute("questionId").toString();
	String questionTitle =request.getAttribute("questionTitle")==null?"":request.getAttribute("questionTitle").toString();
	questionTitle =questionTitle.replaceAll("\n", "<br>");
	String questionContent =request.getAttribute("questionContent")==null?"":request.getAttribute("questionContent").toString();
	questionContent =questionContent.replaceAll("\n", "<br>");
	String questionClicks =request.getAttribute("questionClicks")==null?"":request.getAttribute("questionClicks").toString();
	String questionCreateTime =request.getAttribute("questionCreateTime")==null?"":request.getAttribute("questionCreateTime").toString();
	String questionCreateUserName =request.getAttribute("questionCreateUserName")==null?"":request.getAttribute("questionCreateUserName").toString();
	//是否匿名 0：不匿名 1：匿名
	String questionAnonymous =request.getAttribute("questionAnonymous")==null?"":request.getAttribute("questionAnonymous").toString();
	if(questionAnonymous.equals("1")){
		questionCreateUserName ="匿名";
	}
	
	if(!"".equals(questionCreateTime) && questionCreateTime.length() >19){
		questionCreateTime =questionCreateTime.substring(0,19);
	}
	//问题图片
	String realFileArray =request.getAttribute("realFileName")==null?"":request.getAttribute("realFileName").toString();
    String saveFileArray =request.getAttribute("saveFileName")==null?"":request.getAttribute("saveFileName").toString();
	//回答图片
	String answerRealFileName =request.getAttribute("answerRealFileName")==null?"":request.getAttribute("answerRealFileName").toString();
	String answerSaveFileName =request.getAttribute("answerSaveFileName")==null?"":request.getAttribute("answerSaveFileName").toString();
	String askLivingPhoto =request.getAttribute("askLivingPhoto")==null?"":request.getAttribute("askLivingPhoto").toString();
	String askImgUrl =askLivingPhoto != null && !"".equals(askLivingPhoto)?askLivingPhoto.split("\\.")[0]+"_small."+askLivingPhoto.split("\\.")[1]:"noliving.gif";
%>
<body>
<div class="wh-wrapper">
    <s:form name="dataForm" id="dataForm" action="/answer!saveAnswer.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
	<s:hidden name="answerPo.answerId" />
	<input type="hidden" name="questionId" id="questionId" value="<%=questionId%>"/>
    <div class="wh-content">
        <div class="wh-container">            
            <div class="wh-sigpage wh-sigpage-q2a">
                <div class="wh-q2a-list">
                    <h2>
                        <strong>本问题详情页</strong>
                    </h2>
                    <ul>
                        <li>
                            <div class="wh-q2a-question">
                                <div class="wh-q2a-ques-con">
                                   <%if(!"noliving.gif".equals(askImgUrl)){%>
                                    <a class="wh-q2a-q-avatar"><img src="/defaultroot/upload/peopleinfo/<%=askImgUrl%>" /></a>
									<%}else{%>
									<a class="wh-q2a-q-avatar"><img src="/defaultroot/images/<%=askImgUrl%>" /></a>
									<%}%>
                                    <div class="wh-q2a-q-meta">
                                        <span class="q-meta-author"><%=questionCreateUserName%></span>
                                        <span class="q-meta-hist">浏览次数：<em><%=questionClicks%></em>次</span>
                                        <span class="q-meta-date"><%=questionCreateTime%></span>
                                    </div>
                                    <div class="wh-q2a-q-title">
                                        <p><%=questionTitle%></p>
                                    </div>
                                </div>
								<%if(!"".equals(questionContent)){%>
                                <div class="wh-q2a-ques-add">
                                    <p>
                                        <strong class="q-add-tit">问题补充：</strong>
                                        <span class="q-add-con"><%=questionContent%></span>
                                    </p>
                                </div>
								<%}%>
                                <div class="wh-q2a-ques-att">
                                    <ul>
                                        <%if(!"".equals(realFileArray) && !"".equals(saveFileArray)){%>
										<div class="txtright topbot10" style="padding:1px 0">
											<input type="hidden" name="realFileName" id="realFileName" value="<%=realFileArray%>"/>
											<input type="hidden" name="saveFileName" id="saveFileName" value="<%=saveFileArray%>"/>
											<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
												<jsp:param name="accessType"  value="include" />
												<jsp:param name="makeYMdir"   value="yes" />
												<jsp:param name="onInit"      value="init" />
												<jsp:param name="dir"  value="zhidao" />
												<jsp:param name="uniqueId"  value="zhidao_question" />
												<jsp:param name="realFileNameInputId"  value="realFileName" />
												<jsp:param name="saveFileNameInputId"  value="saveFileName" />
												<jsp:param name="canModify"  value="no" />
												<jsp:param name="multi"      value="false" />
												<jsp:param name="buttonText" value="上传图片" />
												<jsp:param name="fileSizeLimit" value="0" />
												<jsp:param name="fileTypeExts"  value="*.jpg;*.jpeg;*.gif;*.png;*.bmp" />
												<jsp:param name="uploadLimit"   value="1" />
											</jsp:include>
										</div>
										<%}%>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li>
                            <!--<textarea name="questionPO.questionTitle" cols="" rows="" readonly="readonly" id="questionTitle" class="talk-textarea">ff</textarea>
                            <p class="pickfiles_zhidao_question" style="position: relative; z-index: 0;">上传图片</p>-->
                            <table class="subquestion-table">
                                <tr class="subquestion-tableTR1">
                                    <td colspan="2"><textarea name="answerPo.answerContent" id="answerContent" class="talk-textarea"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="answertd1">
                                        <div class="txtright topbot10" style="padding:1px 0">
											<input type="hidden" name="answerRealFileName" id="answerRealFileName" value="<%=answerRealFileName%>"/>
											<input type="hidden" name="answerSaveFileName" id="answerSaveFileName" value="<%=answerSaveFileName%>"/>
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
									    </div>
                                    </td>
                                    <td class="answertd2"><span>参考资料</span><input name="answerPo.answerCkzl" id="answerCkzl" class="pickfiles_zhidao_keywords" /></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="sub-answer">
                                            <input type="button" name="" class="sub-answer-btn" onClick="saveAndExit(this);" value="提交问题"/>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </li>
						<%
						if(answerList !=null && answerList.size() >0){
							int answer_num =answerList.size();
								if(answerList.size() >5){
									answer_num =5;
								}
						%>
                        <li>
					   <%
						for(int jj=0;jj<answer_num;jj++){
							Object[] answerObj =(Object[])answerList.get(jj);
							String answerUserName =answerObj[0]==null?"":answerObj[0].toString();
							String answerContent =answerObj[1]==null?"":answerObj[1].toString();
							answerContent =answerContent.replaceAll("\n", "<br>");
							String answerTime =answerObj[2]==null?"":answerObj[2].toString();
							String answerCkzl =answerObj[3]==null?"":answerObj[3].toString();
							String anonymity =answerObj[4]==null?"0":answerObj[4].toString();
							if(!"".equals(answerTime) && answerTime.length() >19){
								answerTime =answerTime.substring(0,19);
							}
							if("1".equals(anonymity)){
								answerUserName ="匿名";
							}
							String answerId =answerObj[5]==null?"":answerObj[5].toString();
							String answerRealFile =answerObj[7]==null?"":answerObj[7].toString();
							String answerSaveFile =answerObj[8]==null?"":answerObj[8].toString();
							String imgUrl =answerObj[9] != null && !"".equals(answerObj[9].toString())?answerObj[9].toString().split("\\.")[0]+"_small."+answerObj[9].toString().split("\\.")[1]:"noliving.gif";
							String realFile ="RealFile_"+answerId;
							String saveFile ="SaveFile_"+answerId;
							String uniqueId ="uniqueId_"+answerId;
						%>
                            <div class="wh-q2a-answer wh-q2a-ans-reply">
                                <div class="wh-q2a-ans-con">
                                    <%if(!"noliving.gif".equals(imgUrl)){%>
                                    <a class="wh-q2a-q-avatar"><img src="/defaultroot/upload/peopleinfo/<%=imgUrl%>" /></a>
									<%}else{%>
									<a class="wh-q2a-q-avatar"><img src="/defaultroot/images/<%=imgUrl%>" /></a>
									<%}%>
                                    <div class="wh-q2a-q-meta">
                                        <span class="q-meta-author"><%=answerUserName%></span>
                                        <span class="q-meta-hist">浏览次数：<em><%=questionClicks%></em>次</span>
                                        <span class="q-meta-date"><%=answerTime%></span>
                                    </div>
                                    <div class="wh-q2a-q-title">
                                        <p><%=answerContent%></p>
										<%if(!"".equals(answerRealFile) && !"".equals(answerSaveFile)){%>
										<div>
											<input type="hidden" name="<%=realFile%>" id="<%=realFile%>" value="<%=answerRealFile%>"/>
											<input type="hidden" name="<%=saveFile%>" id="<%=saveFile%>" value="<%=answerSaveFile%>"/>
											<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
												<jsp:param name="accessType"  value="include" />
												<jsp:param name="makeYMdir"   value="yes" />
												<jsp:param name="onInit"      value="init" />
												<jsp:param name="dir"  value="zhidao" />
												<jsp:param name="uniqueId"  value="<%=uniqueId%>" />
												<jsp:param name="realFileNameInputId"  value="<%=realFile%>" />
												<jsp:param name="saveFileNameInputId"  value="<%=saveFile%>" />
												<jsp:param name="canModify"  value="no" />
												<jsp:param name="multi"      value="false" />
												<jsp:param name="buttonText" value="上传图片" />
												<jsp:param name="fileSizeLimit" value="0" />
												<jsp:param name="fileTypeExts"  value="*.jpg;*.jpeg;*.gif;*.png;*.bmp" />
												<jsp:param name="uploadLimit"   value="1" />
											</jsp:include>
										</div>
										<%}%>
                                        <%if(!"".equals(answerCkzl)){%>
                                        <p>参考资料：<%=answerCkzl%></p>
										<%}%>
                                    </div>
                                </div>
                            </div>
							<%}%>
                        </li>
						<%}%>
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
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'提交回答'});
function saveAndExit(obj){
    	var answerContent =$("#answerContent").val();
    	if(answerContent ==null || answerContent ==""){
    		whir_alert("请输入回答内容！", function(){
    			$("#answerContent").focus();
    		});
    	    return false;
    	}
    	
        ok(0,obj);
    }
    
    $(document).ready(function(){
		var $length2 =$("#answerContent").val().length;
		//$("#wordCount1").text(9999 - $length2);
    	$("#answerContent").keyup(function(){
    		var $max =9999;
    		var $length =$("#answerContent").val().length;
    		if($length > $max){
    			whir_alert("回答内容不能超过9999个字！", function(){
    				$("#answerContent").val($("#answerContent").val().substring(0,9999));
    			});
    		}else{
    			//$("#wordCount1").text($max - $length);
    		}
    	});
    });
</script>
</html>