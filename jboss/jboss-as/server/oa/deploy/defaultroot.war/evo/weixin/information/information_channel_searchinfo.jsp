<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
	<head lang="en">
	    <meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="format-detection" content="telephone=no">
	    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
		<title>${channelName}</title>
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.swiper.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
	</head>
	<body>
		<section class="wh-section wh-section" id="list_content">
		    <header class="wh-search">
		        <div class="wh-container">
		            <form id="searchForm" action="/defaultroot/channel/searchInfoList.controller" method="post" id="searchForm">
		            	<input type="text" name="channelId" value="${channelId}" id="channelId" style="display: none;"/>
						<input type="text" name="channelName" value="${channelName}" id="channelName" style="display: none;"/>
		                <input type="search" placeholder="搜索信息标题" id="search_title" name="title" value="${title}" />
		                <i class="fa fa-search"></i>
		            </form>
		        </div>
		    </header>
		    <article class="wh-article-info">
		        <div class="wh-container">
		            <div class="wh-article-lists">
		                <ul id="content_ul">
			               	<c:choose>
							  	<c:when test="${not empty docXml}">
									<x:parse xml="${docXml}" var="doc"/>
									<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
									<c:if test="${recordCount==0}">
										<li>
					                        <a>系统没有查询到信息记录！</a>
					                    </li>
									</c:if>
									<x:forEach select="$doc//infoList" var="n" varStatus="status">
										<c:set var="currTitle" ><x:out select="$n/informationTitle/text()"/></c:set>   
										<c:set var="time" ><x:out select="$n/informationIssueTime/text()"/></c:set>
										<c:set var="infoId" ><x:out select="$n/informationId/text()"/></c:set>
										<c:set var="informationType" ><x:out select="$n/informationType/text()"/></c:set>
										<c:set var="informationKits" ><x:out select="$n/informationKits/text()"/></c:set>
										<c:set var="currChannelId" ><x:out select="$n/channelId/text()"/></c:set>
										<li onclick="openInfo('${infoId}','${informationType}','${currChannelId}')" name="content_li">
					                        <p>
						                        <a>${currTitle}</a>
						                        <span>${fn:substring(time,0,16)}</span>
					                        </p>
											<c:if test="${informationKits==0}">
					                        <em style="background-color:grey"><x:out select="$n/informationKits/text()"/></em>
											</c:if>
											<c:if test="${informationKits>0}">
					                        <em ><x:out select="$n/informationKits/text()"/></em>
											</c:if>
					                    </li>
									</x:forEach>
								</c:when>
								<c:otherwise>
									<li>
			                        	<a>数据查询异常！</a>
				                    </li>
								</c:otherwise>
							</c:choose>
		                </ul>
		            </div>
		        </div>
		    </article>
		    <aside class="wh-load-box" style="display: none">
		        <div class="wh-load-tap">上滑加载更多</div>
		        <div class="wh-load-md" style="display: none">
		            <span></span>
		            <span></span>
		            <span></span>
		            <span></span>
		            <span></span>
		        </div>
		    </aside>
		</section>
	</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper.min.js"></script>
<script type="text/javascript">
var nomore = "";
var pagerOffset = "0";
var channelId = "";
var title = "";
var channelType = "";
var userDefine = "";

$(function(){
	nomore = "${nomore}";
	pagerOffset = "${pagerOffset}";
	channelId = "${channelId}";
	title = $("#search_title").val();
 	if(nomore){
		$(".wh-load-box").show();
	}else{
		$(".wh-load-box").css("display","none");
	}
});

//使用ajax方式加载当前栏目下的信息
var loadFlag = '0';
function loadInfoList(){
	if(loadFlag == '1'){
		return false;
	}
	loadFlag = '1';
	if(nomore){
	    $(".wh-load-md").css("display","block");
		$(".wh-load-tap").html("正在加载...");
		$.ajax({
			url : "/defaultroot/channel/infoList.controller",
			type : "post",
			data : {"channelId" : channelId, "title" : title, "channelType" : channelType,"userDefine" : userDefine,"pagerOffset" : pagerOffset},
			success : function(data){
				nomore = $($(data)[32]).val();
				pagerOffset = $($(data)[30]).val();
				if(nomore){
					$(".wh-load-tap").html("上滑加载更多");
					$(".wh-load-box").css("display","block");
					$(".wh-load-md").css("display","none");
				}else{
					$(".wh-load-box").css("display","none");
				}
				$("#content_ul").append($("li[name='content_li']",data));
				loadFlag = '0';
			},
			error:function(data){
				$(".wh-load-tap").html("加载失败！");
			}
		});
	}
}

/**
 *打开详情页
 */
function openInfo(infoId,informationType,channelId){
	window.location="/defaultroot/channel/infoDetail.controller?infoId="+infoId+"&informationType="+informationType+"&channelId="+channelId;
}

/**
 * 滚动条至底部事触发事件
 * @memberOf {TypeName} 
 */
$(window).scroll(function(){
   var scrollTop = $(this).scrollTop();
   var scrollHeight = $(document).height();
   var windowHeight = $(this).height();
   if(scrollTop + windowHeight == scrollHeight){
	 if(nomore){
		loadInfoList();
	 }
  }
});


  //绑定查询框回车事件
$('#search_title').keydown(function(event){
  	var searchTitle = $('#search_title').val();
	if(event.keyCode == 13){ //绑定回车 
		if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
			alert('请正确填写搜索信息标题！');
			return false;
		}
		$('#searchForm').submit();
	} 
});
</script>