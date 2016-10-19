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
                                <a href="javascript:void(0);">知道专家库</a>
                            </li>
                        </ul>
                    </div>
                    <div class="wh-portal-i-content">
                        <s:form name="queryForm" id="queryForm" action="Expert!thumbList.action" method="post" theme="simple">
                            <div id="content" class="moduleContent clearfix">
                               
                            </div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
								<tr>
									<td>
										<%@ include file="/public/page/pagerExpert.jsp"%>
									</td>
								</tr>
							</table>
                        </s:form>
                    </div>
                </div>
            </div>
        </td>
        <td width="35%" class="portal-column-td" zone="B">
            <!--知道专家信息-->

                <div class="wh-portal-info-box">
                    <div class="wh-portal-info">
                    <div class="wh-portal-tools">
                    </div>
                    <div class="wh-portal-i-title clearfix">
                        <ul class="wh-portal-i-title-left clearfix">
                            <li class="wh-portal-title-li on">
                                <a href="javascript:void(0);">知道专家信息</a></li>
                        </ul>
                    </div>
                    <div class="wh-portal-i-content">
                        <div class="wh-personal-info">
                            <ul>
                                <li>专家总人数：<span><s:property value="%{#request.expertCount}"/></span></li>
                                <li>贡献回答总数：<span><s:property value="%{#request.expertAnswerCount}"/></span></li>
                                <li>回答被采纳总数：<span><s:property value="%{#request.expertAnswerAcceptCount}"/></span></li>
                            </ul>
                        </div>
                        <div class="wh-portal-info-content" id="wh-portal-iclist1">
						   <%
							List classList = (List) request.getAttribute("classList");
							if(classList !=null && classList.size()>0){
								for(int j=0;j<classList.size();j++){
									Object[] classObj =(Object[])classList.get(j);
							%>
                            <div class="wh-portal-i-item clearfix">
                                <a href="javascript:void(0);" onclick="javascript:openQuestionList('<%=classObj[0]%>');">
                                    <i class="fa fa-circle"></i>
                                    <span> <%=classObj[1]%></span>
                                </a>
                                <em>（<%=classObj[2]%>）</em>
                            </div>
							<%
								}
							}
							%>
                        </div>
                    </div>
                    </div>
                </div>
            <!--回答问题排行-->
            <div class="wh-portal-info-box">
                <div class="wh-portal-info">
                <div class="wh-portal-i-title clearfix">
                    <ul class="wh-portal-i-title-left wh-portal-title-slide04 clearfix" data-linum="2">
                        <li class="wh-portal-title-li wh-portal-overflow on"><a href="javascript:void(0)" title="周回答问题排行">周回答问题排行</a></li>
                        <li class="wh-portal-title-li wh-portal-overflow"><a href="javascript:void(0)" title="回答问题总排行">回答问题总排行</a></li>
                    </ul>
                 </div>
                <div class="wh-portal-i-content">
                    <div class="wh-portal-info-content">
                        <div class="wh-portal-slide04">
                            <ul class="clearfix">
                                <li>
								    <%
									List weekList = (List) request.getAttribute("weekList");
									if(weekList !=null && weekList.size()>0){
										for(int i=0;i<weekList.size();i++){
											Object[] weekObj =(Object[])weekList.get(i);
									%>
                                    <div class="wh-portal-i-item clearfix">
										<a href="javascript:void(0);"> <span><%=i+1%></span><span onclick="javascript:addQuestion('<%=weekObj[0]%>','<%=weekObj[1]%>');"><%=weekObj[1]%></span><span class="wh-doc-items-tips"><%=weekObj[2]%></span></a>
                                    </div>
									<%}
									
									}%>
                                </li>
                                <li class="wh-portal-hidden">
									<%
									List allList = (List) request.getAttribute("allList");
									if(allList !=null && allList.size()>0){
										for(int i=0;i<allList.size();i++){
											Object[] allObj =(Object[])allList.get(i);
									%>
                                    <div class="wh-portal-i-item">
										<a href="javascript:void(0);"><span><%=i+1%></span><span onclick="javascript:addQuestion('<%=allObj[0]%>','<%=allObj[1]%>');"><%=allObj[1]%></span><span class="wh-doc-items-tips"><%=allObj[2]%></span></a>
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

		var tabLiDom = $('.wh-portal-title-slide04 li.wh-portal-overflow');
		var tabLiNum = parseInt($('.wh-portal-title-slide04').data('linum'));
		var tabLiWidth = 100 / tabLiNum +"%"; //计算页签个数取整;
		tabLiDom.css({width:tabLiWidth});
		if(tabLiNum == 2){
			tabLiDom.css({width:"96px"});
		}
		if(tabLiNum == 1){
			tabLiDom.css({width:"auto"});
		}
    })

	$(document).ready(function(){
		initThumbListFormToAjax({formId:"queryForm"});
		$("#pagerSize").hide();
		$('#pagebtn').css("padding","0 5px 5px 5px");
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
				var photo = '/images/noliving_middle.gif';
				if(po.empLivingPhoto!=null && po.empLivingPhoto!=''){
					photo = "/upload/peopleinfo/"+po.empLivingPhoto.substring(0,po.empLivingPhoto.indexOf("."))+"_middle"+po.empLivingPhoto.substring(po.empLivingPhoto.indexOf("."));
				}
                var orgclass = "";
                if(po.orgNameString.length>20){
                    orgclass = 'class="orgli"';
                }
				var expertclass = "";
                if(po.zhidaoClassNames.length>20){
                    expertclass = 'class="expertli"';
                }
                comment += '<div class="wh-zd-thumbDiv"> <div class="wh-zd-thumbDivLeft"><div class="wh-zd-thumbDivLeftImg"><img src="<%=preUrl%>'+photo+'"></div><div class="wh-zd-thumbDivLeftButton"> <input type="button" class="wh-zh-zixun" value="咨询专家" onClick="javascript:addQuestion(\''+po.expertUserId+'\',\''+po.expertName+'\');"></div></div><div class="wh-zd-thumbDivRight"><ul><li class="nameli"><p>'+po.expertName+'</p></li><li class="expertli"><p>专业领域：<span title="'+po.zhidaoClassNames+'">'+po.zhidaoClassNames+'</span></p></li><li><p>部门：<span title="'+po.orgNameString+'">'+po.orgNameString+'</span></li><li><p>职务：<span>'+po.empDuty+'</span></li><li><p>帮助了：<span>'+po.acceptCount+'</span>人&nbsp;&nbsp;采纳率：<span>'+po.acceptPoint+'</span></li></ul></div></div>';

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

function addQuestion(userId,userName){
	openWin({url:'question!addQuestion.action?helpEmpId='+userId+'&helpEmpName='+userName,isFull:true,winName:'新增问题'+userId});
}

function openQuestionList(classId){
	openWin({url:'question!list.action?classId='+classId,isFull:true,winName:'问题列表'+classId});
}

</script>

</body>
</html>