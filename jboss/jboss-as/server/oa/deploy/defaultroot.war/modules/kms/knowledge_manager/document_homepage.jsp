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
	<script src="<%=rootPath%>/scripts/plugins/jPages/js/jPages.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
    <link rel="stylesheet" href="../../templates/template_default/common/css/template.portal.ie8.css" />
    <![endif]-->
	<%@ include file="/public/include/meta_detail.jsp"%>
	<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
</head>
<body>
<div class="wh-container wh-portaler">
    <div class="wh-portal-doc-search">
        <div class="doc-search-input">
            <input type="text" class="d-s-input-text" name="docTitle" id="docTitle" />
            <a href="#" class="d-s-input-btn-seh" onclick="queryDoc();">搜索文档</a>
            <a href="#" class="d-s-input-btn-uld" onclick="openWin({url:'<%=rootPath%>/Document!upload.action',width:910,height:600,winName:''});">上传文档</a>
        </div>
        <div class="doc-search-radio">
            <ul class="doc-s-r-list">
                <li class="active" onclick="changeCheck('search0')"><i class="fa fa-check-circle"></i><span>全部</span> <input type="hidden" name="search" id="search0" value="0"></li>
                <li onclick="changeCheck('search1')"><i class="fa fa-check-circle"></i><span>DOC</span><input type="hidden" name="search" id="search1" value="1"></li>
                <li onclick="changeCheck('search2')"><i class="fa fa-check-circle"></i><span>XLS</span><input type="hidden" name="search" id="search2" value="2"></li>
                <li onclick="changeCheck('search3')"><i class="fa fa-check-circle"></i><span>PPT</span><input type="hidden" name="search" id="search3" value="3"></li>
                <li onclick="changeCheck('search4')"><i class="fa fa-check-circle"></i><span>TXT</span><input type="hidden" name="search" id="search4" value="4"></li>
                <li onclick="changeCheck('search5')"><i class="fa fa-check-circle"></i><span>PDF</span><input type="hidden" name="search" id="search5" value="5"></li>
            </ul>
        </div>
    </div>
    <script type="text/javascript">
        $(".doc-s-r-list li").click(function(){
            $(".doc-s-r-list li").eq($(this).index()).addClass("active").siblings().removeClass("active");
        })
    </script>
    <table id="portalMain" cellpadding="0" cellspacing="0" border="0" width="100%" align="center" style="table-layout:fixed;">
    <tr>
        <td width="65%" class="portal-column-td" zone="A">
            <!--单个信息栏目 -->
            <div class="wh-portal-info-box">
                <!--#include file="portal-i-tools.html"-->
                <div class="wh-portal-info">
                    <div class="wh-portal-i-title clearfix">
                        <ul class="wh-portal-i-title-left clearfix">
                            <li class="wh-portal-title-li on">
                                <a href="javascript:void(0)"><i class="fa fa-lock"></i>文库演示</a>
                            </li>
                        </ul>
                    </div>
					<s:form name="queryForm" id="queryForm" action="Document!thumbList.action" method="post" theme="simple">
					<s:hidden id="documentTitle" name="documentTitle"/>
					<s:hidden id="docType" name="docType"/>
                    <div class="wh-portal-i-content">
                        <div class="wh-portal-document">
                            <ul id="content" class="wh-portal-doc-list clearfix">
                                                     
                            </ul>
                        </div>
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
						<tr>
							<td>
								<%@ include file="/public/page/pagerExpert.jsp"%>
							</td>
						</tr>
					</table>
                    </div>
					</s:form>
                </div>
            </div>
        </td>
        <td width="35%" class="portal-column-td" zone="B">
            <!--单标签-->
            <div class="wh-portal-info-box">
                <div class="wh-portal-info">
                    <div class="wh-portal-i-title clearfix">
                        <ul class="wh-portal-i-title-left clearfix">
                            <li class="wh-portal-title-li on">
                               <a href="javascript:void(0)"><i class="fa fa-lock"></i>我的文库</a>
							</li>
                        </ul>
                    </div>
                    <div class="wh-portal-i-content">
                        <div class="wh-portal-info-content" id="wh-portal-iclist1">
						    <%
							List myDoc = (List) request.getAttribute("myDoc");
							if(myDoc !=null && myDoc.size()>0){
								for(int j=0;j<myDoc.size();j++){
									Object[] myDocObj =(Object[])myDoc.get(j);
									EncryptUtil  encryptUtil=new  EncryptUtil(request);
									String verifyCodeValue=encryptUtil.getSysEncoderKeyVlaue("id",myDocObj[0].toString(),"DocumentAction");  

							%>
                            <div class="wh-portal-i-item clearfix">
                                <a href="javascript:void(0);"><span><%=j+1%></span><span onclick="javascript:openDoc('<%=myDocObj[0]%>','<%=verifyCodeValue%>');" class="wh-portal-a-cursor"><%=myDocObj[2]%></span></a>
                            </div>
                            <%}}%>
                        </div>
                    </div>
                </div>
            </div>
			<div class="wh-portal-info-box">
                <div class="wh-portal-info">
                    <div class="wh-portal-i-title clearfix">
                        <ul class="wh-portal-i-title-left clearfix">
                            <li class="wh-portal-title-li on">
                                <a href="javascript:void(0)"><i class="fa fa-lock"></i>文档排行榜</a>
							</li>
                        </ul>
                    </div>
                    <div class="wh-portal-i-content">
                        <div class="wh-portal-info-content" id="wh-portal-iclist1">
					     	<%
							List docList = (List) request.getAttribute("doctop");
							if(docList !=null && docList.size()>0){
								for(int j=0;j<docList.size();j++){
									Object[] docObj =(Object[])docList.get(j);
									EncryptUtil  encryptUtil=new  EncryptUtil(request);
									String verifyCodeValue=encryptUtil.getSysEncoderKeyVlaue("id",docObj[0].toString(),"DocumentAction");
							%>
                            <div class="wh-portal-i-item clearfix">
                                <a href="javascript:void(0);"> <span><%=j+1%></span><span onclick="javascript:openDoc('<%=docObj[0]%>','<%=verifyCodeValue%>');" class="wh-portal-a-cursor"><%=docObj[2]%></span><span class="wh-doc-items-tips"><%=docObj[8]!=null?docObj[8].toString():"0"%></span></a>
                            </div>
							<%
								}
							}
							%>
                        </div>
                    </div>
                </div>
            </div>
            <!--多标签-->
            <div class="wh-portal-info-box">
                <div class="wh-portal-info">
                    <div class="wh-portal-i-title clearfix">
                        <ul class="wh-portal-i-title-left wh-portal-title-slide04 clearfix">
                            <li class="wh-portal-title-li wh-portal-overflow on"><a href="javascript:void(0)">本周上传排行</a></li>
                            <li class="wh-portal-title-li wh-portal-overflow"><a href="javascript:void(0)">总上传排行</a></li>
                        </ul>
                    </div>
                    <div class="wh-portal-i-content">
                        <div class="wh-portal-info-content">
                            <div class="wh-portal-slide04">
                                <ul class="clearfix">
                                    <li>
									    <%
										List weekList = (List) request.getAttribute("week");
										if(weekList !=null && weekList.size()>0){
											for(int i=0;i<weekList.size();i++){
												Object[] weekObj =(Object[])weekList.get(i);
										%>
                                        <div class="wh-portal-i-item clearfix">
											<a href="javascript:void(0);" ><span><%=i+1%></span><span><%=weekObj[0]%></span><span class="wh-doc-items-tips"><%=weekObj[1]%></span></a>
                                        </div>
										<%
											}
										}
										%>
                                    </li>
                                    <li class="wh-portal-hidden">
										<%
										List allList = (List) request.getAttribute("all");
										if(allList !=null && allList.size()>0){
											for(int i=0;i<allList.size();i++){
												Object[] allObj =(Object[])allList.get(i);
										%>
                                        <div class="wh-portal-i-item">
											<a href="javascript:void(0);" ><span><%=i+1%></span><span><%=allObj[0]%></span><span class="wh-doc-items-tips"><%=allObj[1]%></span></a>
                                        </div>
										<%
											}
										}
										%>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </td>
    <tr>
</table>


</div>
<script>
    $(function(){
        var $tab_li = $('.wh-portal-title-slide04 li');
        $tab_li.hover(function(){
            $(this).addClass('on').siblings().removeClass('on');
            var index = $tab_li.index(this);
            $('.wh-portal-slide04 > ul > li').eq(index).show().siblings().hide();
        });
    })

	$(document).ready(function(){
	initThumbListFormToAjax({formId:"queryForm"});
	$("#pagerSize").hide();
	$('#pagebtn').css("padding","0 5px 5px 5px");
});

function queryDoc(){
	$("#documentTitle").val($("#docTitle").val());
	var obj = document.getElementsByName('search');
	for(var i=0 ;i<obj.length;i++){
		if(obj[i].checked == true){
		$("#docType").val(obj[i].value);
		}
	}
	initThumbListFormToAjax({formId:"queryForm"});
}

$("body").on('keydown', function(event){
	if(event!=undefined && event.keyCode==13){
		queryDoc();
		event.preventDefault();
		event.stopPropagation();
	}
});

function initThumbListFormToAjax(formJson){
	var formJson_ = eval(formJson);
	var formId = formJson_.formId;
	//分页参数等html、公共js事件绑定
	initList(formId);
 	var jq_form = $('#'+formId);
	jq_form.ajaxForm({
		beforeSend:function(){
			//$.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
		},
		success:function(responseText){
			$.dialog({id:"Tips"}).close();
			jq_form.find("#content").html("");
			//解析服务器返回的json字符串
			var json = eval("("+responseText+")").data;
			var data = json.data;
			var pager = json.pager;
			var $start_page = jq_form.find("#start_page");
			var $page_count  = jq_form.find("#page_count");
			var $recordCount = jq_form.find("#recordCount");
			//分页信息
            var _pageCount = parseInt(pager.pageCount, 10);
            var _start_page = parseInt($start_page.val(), 10);
            if(_pageCount != 0 && _pageCount < _start_page){
                $start_page.val(_start_page - 1);
            }

            $page_count.val(_pageCount);
            $recordCount.val(pager.recordCount);
			//设置列表样式部分
            setList(formId);
            jq_form.find(".page").hide();
			//循环数据信息
			var comment = '';			
			for (var i=0; i<data.length; i++) {
				var po = data[i];
				var img = 'myPhoto.jpg';
				if(po.docSaveName!=null){
					img = po.docSaveName.substring(0,6)+"/"+po.docSaveName.substring(0,po.docSaveName.lastIndexOf("."))+".png";
				}

				comment +='<li><a  href="javascript:void(0);" onclick="openDoc(\''+po.id+'\',\''+po.verifyCode+'\');" title="'+po.documentTitle+'"><span class="doc-list-img"><img src="<%=preUrl%>/upload/knowledgedoc/'+img+'" alt="'+po.documentTitle+'" onclick="openDoc(\''+po.id+'\',\''+po.verifyCode+'\');"/></span><strong class="doc-list-name">'+po.documentTitle+'</strong><em class="doc-list-author">'+po.empName+'</em></a></li>';   

			}
			jq_form.find("#content").append(comment);
			jq_form.find(".page").show();
			//调用回调事件
			if(formJson_.onLoadSuccessAfter){
			    formJson_.onLoadSuccessAfter.call(this);
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.dialog({id:"Tips"}).close();
			$.dialog.alert(comm.loadfailure,function(){});
		}
	}); 
	//初次提交表单获得数据
	$("#"+formId).submit();
}

//设置分页
function setPager(formId){
    var jq_form = $("#"+formId);
    jq_form.find(".page").show();

    var page_size = (jq_form.find("#page_size").val())*1+0;
    var start_page = (jq_form.find("#start_page").val())*1+0;

    jq_form.find("#pager").jPages({
      containerID : "content",
      previous : comm.lastpage,
      next : comm.nextpage,
      perPage : page_size,
      startPage: start_page,
      delay : 20,
      formId:formId
    });

    setPagerDesc(formId);

    jq_form.find("#pager a").click(function(event){ 
         event.stopPropagation(); 
         event.preventDefault();
    }) ;
}

function changeCheck(id){
	$("input[name='search']").attr("checked",false);
	document.getElementById(id).checked = "checked";
}
function openDoc(id,verifyCode){
	openWin({url:'<%=rootPath%>/Document!record_view.action?id='+id+'&verifyCode='+verifyCode,isFull:true,winName:'doc'+id});
}
</script>

</body>
</html>