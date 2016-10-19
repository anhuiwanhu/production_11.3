<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.whir.ezoffice.zhidao.bd.KnowIndexBD"%>
<%@ include file="/public/include/init.jsp"%>
<html lang="zh-cn">
<head>
    <title>查看问题</title>	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
	String realFileArray="";
    String saveFileArray="";
    realFileArray = request.getAttribute("realFileName")==null?"":request.getAttribute("realFileName").toString();
    saveFileArray = request.getAttribute("saveFileName")==null?"":request.getAttribute("saveFileName").toString();
	//是否匿名 0：不匿名 1：匿名
	String questionAnonymous =request.getAttribute("questionAnonymous")==null?"":request.getAttribute("questionAnonymous").toString();
	if(questionAnonymous.equals("1")){
		questionCreateUserName ="匿名";
	}
    String askLivingPhoto =request.getAttribute("askLivingPhoto")==null?"":request.getAttribute("askLivingPhoto").toString();
	String askImgUrl =askLivingPhoto != null && !"".equals(askLivingPhoto)?askLivingPhoto.split("\\.")[0]+"_small."+askLivingPhoto.split("\\.")[1]:"noliving.gif";
	//满意回答ID
	String questionGoodAnswerId =request.getAttribute("questionGoodAnswerId")==null?"":request.getAttribute("questionGoodAnswerId").toString();
	String my_questionGoodComment =request.getAttribute("questionGoodComment")==null?"":request.getAttribute("questionGoodComment").toString();
	my_questionGoodComment =my_questionGoodComment.replaceAll("\n", "<br>");
	String my_answerContent =request.getAttribute("answerContent")==null?"":request.getAttribute("answerContent").toString();
	my_answerContent =my_answerContent.replaceAll("\n", "<br>");
	String my_answerTime =request.getAttribute("answerTime")==null?"":request.getAttribute("answerTime").toString();
	String my_answerGood =request.getAttribute("answerGood")==null?"":request.getAttribute("answerGood").toString();
	String my_answerCommentNum =request.getAttribute("answerCommentNum")==null?"":request.getAttribute("answerCommentNum").toString();
	String my_answerUserName =request.getAttribute("answerUserName")==null?"":request.getAttribute("answerUserName").toString();
	String livingPhoto =request.getAttribute("livingPhoto")==null?"":request.getAttribute("livingPhoto").toString();
	String answerImgUrl =livingPhoto != null && !"".equals(livingPhoto)?livingPhoto.split("\\.")[0]+"_small."+livingPhoto.split("\\.")[1]:"noliving.gif";
	List my_commentList =new ArrayList();
	my_commentList= request.getAttribute("commentList")!=null?(List)request.getAttribute("commentList"):null;
	
	List my_askAndAnswerAgainList =new ArrayList();
	my_askAndAnswerAgainList= request.getAttribute("askAndAnswerAgainList")!=null?(List)request.getAttribute("askAndAnswerAgainList"):null;
	
	//相关问题列表
	java.util.List relatedQuestionList  = request.getAttribute("relatedQuestionList")!=null?(List)request.getAttribute("relatedQuestionList"):null;
	
	String goodRealFileName = request.getAttribute("goodRealFileName")==null?"":request.getAttribute("goodRealFileName").toString();
    String goodSaveFileName = request.getAttribute("goodSaveFileName")==null?"":request.getAttribute("goodSaveFileName").toString();
	String answerRealFileName =request.getAttribute("answerRealFileName")==null?"":request.getAttribute("answerRealFileName").toString();
	String answerSaveFileName =request.getAttribute("answerSaveFileName")==null?"":request.getAttribute("answerSaveFileName").toString();
%>
<body>
<div class="wh-wrapper">
  <s:form name="dataForm" id="dataForm" action="" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
	<input type="hidden" name="questionId" id="questionId" value="<%=questionId%>"/>
	<input type="hidden" name="answerId" id="answerId" value=""/>
	<input type="hidden" name="answerCommentContent" id="answerCommentContent" value=""/>
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
                                <div class="wh-q2a-tip">
                                    <div class="wh-q2a-tip-btn">
                                        <a href="##" onclick="setAnswer();"><i class="fa fa-pencil"></i>我来回答</a>
                                    </div>
                                </div>
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
								<%if(!"".equals(realFileArray) && !"".equals(saveFileArray)){%>
                                <div class="wh-q2a-ques-att">
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
                            </div>
                        </li>
						<li id="answerTable" style="display:none">
						<table class="subquestion-table">
							<tr class="subquestion-tableTR1">
								<td colspan="2"><textarea name="answerPo.answerContent" id="answerContent" class="talk-textarea"></textarea></td>
							</tr>
							<tr>
								<td class="answertd1">
								<input type="hidden" name="answerRealFileName" id="answerRealFileName" value=""/>
								<input type="hidden" name="answerSaveFileName" id="answerSaveFileName" value=""/>
								<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
									<jsp:param name="accessType"  value="include" />
									<jsp:param name="makeYMdir"   value="yes" />
									<jsp:param name="onInit"      value="init" />
									<jsp:param name="onSelect"    value="onSelect" />
									<jsp:param name="onUploadProgress"  value="onUploadProgress" />
									<jsp:param name="onUploadSuccess"   value="onUploadSuccess" />
									<jsp:param name="dir"  value="zhidao" />
									<jsp:param name="uniqueId"  value="zhidao" />
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
								<td class="answertd2"><span>参考资料</span><input name="answerPo.answerCkzl" id="answerCkzl" class="pickfiles_zhidao_keywords" /></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="sub-answer">
										<input type="button" name="" class="sub-answer-btn" onClick="saveAnswer(this);" value="提交回答"/>
									</div>
								</td>
							</tr>
						</table>
					    </li>
                        <li>
						<%if(!"".equals(questionGoodAnswerId)){%>
                            <div class="wh-q2a-answer wh-q2a-ans-best">                          
                                <div class="wh-q2a-tip">
                                    <div class="wh-q2a-tip-btn-two">
                                        <span><i class="fa fa-smile-o"></i>满意回答</span>
                                    </div>
                                    <div class="wh-q2a-tip-vote">
                                        <span onclick="clickAnswerGood('<%=questionId%>','<%=questionGoodAnswerId%>');"><em  id="span_<%=questionGoodAnswerId%>"><%=my_answerGood%></em><i class="fa fa-thumbs-o-up"></i></span>
                                        <span onclick="clickAnswerComment('<%=questionGoodAnswerId%>');"><em><%=my_answerCommentNum%></em><i id="commitBtn1" class="fa fa-essence-inf"></i></span>
                                    </div>
                                </div>
                                <div class="wh-q2a-ans-con">
								    <div class="wh-q2a-close">
                                        <p><span><%=answerList.size()+1%></span>个回答</p>
                                    </div>
								    <%if(!"noliving.gif".equals(answerImgUrl)){%>
                                    <a class="wh-q2a-q-avatar"><img src="/defaultroot/upload/peopleinfo/<%=answerImgUrl%>" /></a>
									<%}else{%>
									<a class="wh-q2a-q-avatar"><img src="/defaultroot/images/<%=answerImgUrl%>" /></a>
									<%}%>
                                    <div class="wh-q2a-q-meta">
                                        <span class="q-meta-author"><%=my_answerUserName%></span>
                                        <span class="q-meta-hist">浏览次数：<em><%=questionClicks%></em>次</span>
                                        <span class="q-meta-date"><%=my_answerTime%></span>
                                    </div>
                                    <div class="wh-q2a-q-title">
                                        <p><%=my_answerContent%></p>
                                    </div>
                                </div>
								<%if(my_askAndAnswerAgainList !=null && my_askAndAnswerAgainList.size() >0){%>
                                <div id="askGoon1" class="wh-q2a-ques-add">
									<%
									  for(int a=0;a<my_askAndAnswerAgainList.size();a++){
									  Object[] myAsk =(Object[])my_askAndAnswerAgainList.get(a);
									  String askAgainId =myAsk[0]==null?"":String.valueOf(myAsk[0]);
									  String askAgainContent =myAsk[1]==null?"":String.valueOf(myAsk[1]);
									  askAgainContent =askAgainContent.replaceAll("\n", "<br>");
									  List answerAgainList =new ArrayList();
									  if(myAsk[2] !=null){
										  answerAgainList =(List)myAsk[2];
	          	  	                  }
									%>
                                    <p>
                                        <strong class="q-add-tit">问题追问：</strong>
                                        <span class="q-add-con"><%=askAgainContent%></span>
                                    </p>
									<%if(answerAgainList !=null && answerAgainList.size() >0){
		          					for(int b1=0;b1<answerAgainList.size();b1++){
		          					Object[] myAnswer =(Object[])answerAgainList.get(b1);
		          					String answerAgainContent =myAnswer[1]==null?"":String.valueOf(myAnswer[1]);
									answerAgainContent =answerAgainContent.replaceAll("\n", "<br>");
		          					%>
									<p>
                                        <strong class="q-add-tit">问题回答：</strong>
                                        <span class="q-add-con"><%=answerAgainContent%></span>
                                    </p>
									<%}}}%>
                                </div>
								<%}%>
								<%if(!"".equals(goodRealFileName) && !"".equals(goodSaveFileName)){%>
									<div>
										<input type="hidden" name="goodRealFileName" id="goodRealFileName" value="<%=goodRealFileName%>"/>
										<input type="hidden" name="goodSaveFileName" id="goodSaveFileName" value="<%=goodSaveFileName%>"/>
										<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
											<jsp:param name="accessType"  value="include" />
											<jsp:param name="makeYMdir"   value="yes" />
											<jsp:param name="onInit"      value="init" />
											<jsp:param name="dir"  value="zhidao" />
											<jsp:param name="uniqueId"  value="uniqueId_goodAnswer" />
											<jsp:param name="realFileNameInputId"  value="goodRealFileName" />
											<jsp:param name="saveFileNameInputId"  value="goodSaveFileName" />
											<jsp:param name="canModify"  value="no" />
											<jsp:param name="multi"      value="false" />
											<jsp:param name="buttonText" value="上传图片" />
											<jsp:param name="fileSizeLimit" value="0" />
											<jsp:param name="fileTypeExts"  value="*.jpg;*.jpeg;*.gif;*.png;*.bmp" />
											<jsp:param name="uploadLimit"   value="1" />
										</jsp:include>
									</div>
									<%}%>
								<!--回答评论-->
                                <div id="comment_<%=questionGoodAnswerId%>" class="wh-q2a-ans-commit">
                                    <ul class="wh-q2a-a-comlist clearfix">
									    <%
										if(my_commentList !=null && my_commentList.size() >0){
											for(int mm=0;mm<my_commentList.size();mm++){
												Object[] my_comment =(Object[])my_commentList.get(mm);
										%>
                                        <li><strong><%=my_comment[3]%>：</strong><span><%=my_comment[1]==null?"":my_comment[1].toString().replaceAll("\n", "<br>")%></span></li>
										<%}}%>
                                    </ul>
                                    <div class="wh-q2a-a-comipt">
                                        <input type="text" id="commentContent_<%=questionGoodAnswerId%>" />
                                        <a href="###" class="a-com-btn" onclick="saveComment('<%=questionGoodAnswerId%>',this);">提交评论</a>
                                    </div>
                                </div>
								<div>提问者对回答者的评价：<%=my_questionGoodComment%></div>
                            </div>							
							<%}%>
                            <%
								if(answerList !=null && answerList.size() >0){
									int answer_num =answerList.size();
							%>
							 <%
								for(int jj=0;jj<answer_num;jj++){
									Object[] answerObj =(Object[])answerList.get(jj);
									String answerUserName =answerObj[0]==null?"":answerObj[0].toString();
									String answerContent =answerObj[1]==null?"":answerObj[1].toString();
									answerContent =answerContent.replaceAll("\n", "<br>");
									String answerTime =answerObj[2]==null?"":answerObj[2].toString();
									if(!"".equals(answerTime) && answerTime.length() >19){
										answerTime =answerTime.substring(0,19);
									}
									String answerCkzl =answerObj[3]==null?"":answerObj[3].toString();
									String anonymity =answerObj[4]==null?"0":answerObj[4].toString();
									if("1".equals(anonymity)){
										answerUserName ="匿名";
									}
									String answerId =answerObj[5]==null?"0":answerObj[5].toString();
									String answerGood =answerObj[6]==null?"0":answerObj[6].toString();
									String answerRealFile =answerObj[7]==null?"":answerObj[7].toString();
									String answerSaveFile =answerObj[8]==null?"":answerObj[8].toString();
									String realFile ="RealFile_"+answerId;
									String saveFile ="SaveFile_"+answerId;
									String uniqueId ="uniqueId_"+answerId;
									String commentNum =answerObj[9]==null?"0":answerObj[9].toString();
									String imgUrl =answerObj[12] != null && !"".equals(answerObj[12].toString())?answerObj[12].toString().split("\\.")[0]+"_small."+answerObj[12].toString().split("\\.")[1]:"noliving.gif";
									List commentList =new ArrayList();
									if(answerObj[10] !=null){
										commentList =(List)answerObj[10];
									}
									//取追问和追问回答信息
									List zwList =new ArrayList();
									if(answerObj[11] !=null){
										zwList =(List)answerObj[11];
									}
							%>
                            <div class="wh-q2a-answer wh-q2a-ans-reply">
							   
                                <div class="wh-q2a-tip">
                                    <div class="wh-q2a-tip-vote">
                                        <span onclick="clickAnswerGood('<%=questionId%>','<%=answerId%>');"><em id="span_<%=answerId%>"><%=answerGood%></em><i class="fa fa-thumbs-o-up"></i></span>
                                        <span onclick="clickAnswerComment('<%=answerId%>');"><em><%=commentNum%></em><i id="commitBtn2" class="fa fa-essence-inf"></i></span>
                                    </div>
                                </div>
                                <div class="wh-q2a-ans-con">
								    <%if("".equals(questionGoodAnswerId) && jj==0){%>
								    <div class="wh-q2a-close">
                                        <p><span><%=answerList.size()%></span>个回答</p>
                                    </div>
									<%}%>
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
                                    </div>
                                </div>
									<%if(zwList !=null && zwList.size() >0){%>
                                <div id="askGoon2" class="wh-q2a-ques-add">
									<%
									  for(int b=0;b<zwList.size();b++){
									  Object[] zwObj =(Object[])zwList.get(b);
									  String askAgainId =zwObj[0]==null?"":String.valueOf(zwObj[0]);
									  String askAgainContent =zwObj[1]==null?"":String.valueOf(zwObj[1]);
									  askAgainContent =askAgainContent.replaceAll("\n", "<br>");
									  List answerAgainList =new ArrayList();
									  if(zwObj[2] !=null){
										  answerAgainList =(List)zwObj[2];
									  }
									%>
                                    <p>
                                        <strong class="q-add-tit">问题追问：</strong>
                                        <span class="q-add-con"><%=askAgainContent%></span>
                                    </p>
									<%if(answerAgainList !=null && answerAgainList.size() >0){
		          					for(int b1=0;b1<answerAgainList.size();b1++){
		          					Object[] myAnswer =(Object[])answerAgainList.get(b1);
		          					String answerAgainContent =myAnswer[1]==null?"":String.valueOf(myAnswer[1]);
									answerAgainContent =answerAgainContent.replaceAll("\n", "<br>");
		          					%>
									<p>
                                        <strong class="q-add-tit">问题回答：</strong>
                                        <span class="q-add-con"><%=answerAgainContent%></span>
                                    </p>
									<%}}}%>
                                </div>
								<%}%>
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
                                <div id="comment_<%=answerId%>" class="wh-q2a-ans-commit">
                                    <ul class="wh-q2a-a-comlist clearfix">
										<%
										if(commentList !=null && commentList.size() >0){
											for(int nn=0;nn<commentList.size();nn++){
												Object[] comment =(Object[])commentList.get(nn);
										%>
                                        <li><strong><%=comment[3]%>：</strong><span><%=comment[1]==null?"":comment[1].toString().replaceAll("\n", "<br>")%></span></li>
										<%}}%>
                                    </ul>
                                    <div class="wh-q2a-a-comipt">
                                        <input type="text" id="commentContent_<%=answerId%>"/>
                                        <a href="###" class="a-com-btn" onclick="saveComment('<%=answerId%>',this);">提交评论</a>
                                    </div>
                                </div>
								
                            </div>
							<%}%>
							<%}%>
                        </li>
                    </ul>
                </div>
                <div class="wh-q2a-other clearfix">
					<%
					if(relatedQuestionList !=null && relatedQuestionList.size() >0){
						int relatednum =relatedQuestionList.size();
						if(relatednum >5){
							relatednum =5;
						}
					%>
                    <div class="wh-q2a-relate">
                        <h2><strong>相关问题</strong></h2>
                        <ul>
						    <%
							  for(int kk=0;kk<relatednum;kk++){
								  Object[] relatedObj =(Object[])relatedQuestionList.get(kk);
								  String related_questionId    =relatedObj[0]==null?"":String.valueOf(relatedObj[0]);
								  String related_questionTitle =relatedObj[1]==null?"":String.valueOf(relatedObj[1]);
								  String related_questionAnswerCount =relatedObj[2]==null?"":String.valueOf(relatedObj[2]);
							%>
                            <li>
                                <a href="javascript:void(0)" onclick="openWin({url:'<%=rootPath%>/question!viewQuestion.action?id=<%=related_questionId%>',isFull:true,winName:'查看问题'});">
                                    <i class="fa fa-file-o"></i>
                                    <span><%=related_questionTitle%></span>
                                </a>
                                <em><%=related_questionAnswerCount%>回答</em>
                            </li>
							<%}%>
                        </ul>
                    </div>
					<%}%>
					<%
					//热点问题
					List hotlist = new KnowIndexBD().getHotQuestionList("5");
                    if(hotlist != null && hotlist.size() > 0){
					%>
                    <div class="wh-q2a-hot">
                        <h2><strong>热点问题</strong></h2>
                        <ul>
						    <%
								for (int i = 0; i < hotlist.size(); i++) {
									Object[] obj = (Object[]) hotlist.get(i);
									String qname=obj[1].toString();
									if(obj[1].toString().length()>20){
								     	 qname = obj[1].toString().substring(0,20);
									}
							%>
                            <li>
                                <a href="javascript:void(0)" onClick="openWin({url:'<%=rootPath%>/question!viewQuestion.action?id=<%=obj[0]%>',isFull:true,winName:'查看问题<%=obj[0]%>'});">
                                    <i class="fa fa-file-o"></i>
                                    <span title="<%=obj[1]%>"> <%=qname%>...</span>
                                </a>
                                <em><%=obj[3]%>回答</em>
                            </li>
							<%}%>
                        </ul>
                    </div>
					<%}%>
                </div>
            </div>
        </div>
    </div>
	</s:form>
</div>
</body>
<script type="text/javascript">
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'',"callbackfunction":null});
	/*var tB= $(".wh-q2a-list ul li");
	tB.each(function(i){
		$("#commitBtn"+i).click(function(){
			$("#commit"+i).toggle();
		})
		$("#askGoonBtn"+i).click(function(){
			$("#askGoon"+i+" .wh-q2a-a-comipt").toggle();
		})
	});*/
	//点赞
	function clickAnswerGood(questionId,answerId){ //给力操作glType=0
		ajaxOperate({urlWithData:'<%=rootPath%>/answer!answerGood.action?glType=0&questionId='+questionId+'&answerId='+answerId,tip:'点赞',isconfirm:false,callbackfunction:function(){
			var answerGoodNum =$("#span_"+answerId).text();
			$("#span_"+answerId).text(parseInt(answerGoodNum)+1);
		}});
	}

    
	//保存评论
	function saveComment(answerId,obj){
		var commentContent =$("#commentContent_"+answerId).val();
		if(commentContent ==''){
			whir_alert('请输入评论内容！',function(){
				$("#commentContent_"+answerId).focus();
			});
		}else{
			if(commentContent.length >500){
				whir_alert('评论内容已超过500字，请重新输入！',function(){
					$("#commentContent_"+answerId).focus();
				});
			}else{
				if(checkIllegalCharacter(commentContent,"评论内容")){
					return false;
				}
				$("#answerId").val(answerId);
				$("#answerCommentContent").val(commentContent);
				$('#dataForm').attr("action","/defaultroot/answer!saveAnswerComment.action");
				ok(1,obj);
			}
		}
	}

	//评论
	function clickAnswerComment(answerId){
		if($("#comment_"+answerId).is(":hidden")){
			$("#comment_"+answerId).show();
		}else{
			$("#comment_"+answerId).hide();
		}
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
	
	function setAnswer(){
		if($("#answerTable").is(":hidden")){
			$("#answerTable").show();
		}else{
			$("#answerTable").hide();
		}
	}
  
   //保存回答
  function saveAnswer(obj){
		var answerContent =$("#answerContent").val();
		if(answerContent ==''){
			whir_alert('请输入回答内容！',function(){
				$("#answerContent").focus();
			});
		}else{
			if(answerContent.length >500){
				whir_alert('回答内容已超过500字，请重新输入！',function(){
					$("#answerContent").focus();
				});
			}else{
				if(checkIllegalCharacter(answerContent,"回答内容")){
					return false;
				}
				$('#dataForm').attr("action","/defaultroot/answer!saveAnswer.action");
				ok(1,obj);
			}
		}
	}

</script>
</html>