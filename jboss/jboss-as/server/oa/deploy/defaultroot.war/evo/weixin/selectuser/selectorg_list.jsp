<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
	//System.out.println("----->selectorg_list.jsp");
	String contextPath = request.getContextPath() + "/evo/weixin";
	
	String selectUserName = request.getParameter("selectUserName");
	String selectUserId   = request.getParameter("selectUserId");
	
	//0:表示文件办理选人字段
	String type =request.getParameter("type")==null?"":request.getParameter("type");

	//选择类型
	String selectType =request.getParameter("selectType")==null?"checkbox":request.getParameter("selectType");

	//已选中的赋值
	String selectedUserId =request.getParameter("selectedUserId")==null?"":request.getParameter("selectedUserId");
	selectedUserId =selectedUserId.replaceAll("\\$",",");//处理办理中可写的选人字段
	
	int G_PAGE_SIZE = 15;
	int recordCount1 =request.getAttribute("recordCount1")==null?Integer.parseInt("0"):Integer.parseInt(request.getAttribute("recordCount1").toString());
	String offset1 =request.getAttribute("offset1")==null?"0":request.getAttribute("offset1").toString();
%>
<section id="sectionScroll" class="wh-section wh-section-bottomfixed">
    <header class="wh-search" id="search_header">
        <div class="wh-container">
            <form method="post" id="searchForm">
                <input type="search" placeholder="输入部门查询" name="queryTitle" value="${queryTitle}" id="queryCondition"/>
				 <input type="text" style="display: none;"/>
                <i class="fa fa-search"></i>
            </form>
        </div>
    </header>
    <aside class="wh-category wh-category-text">
        <div class="wh-container">
            <div class="wh-cate-lists" name="cateListChek">
                <ul id="org_ul" name="org_ul" data-loadorgflag='0'>
               	 	<c:if test="${not empty docXml1}">
	                	<x:parse xml="${docXml1}" var="doc1" />
	                	<c:set var="recordCount"><x:out select="$doc1//recordCount/text()" /></c:set>
						<c:if test="${recordCount==0}">
							<li>
		                        <p><strong>系统没有查询到组织记录！</strong></p>
		                    </li>
						</c:if>
	                	<x:forEach select="$doc1//list" var="n1" varStatus="status">
	                		<c:set var="orgHasJunior"><x:out select="$n1//orgHasJunior/text()" /></c:set>
							<c:set var="orgName"><x:out select="$n1//orgName/text()" /></c:set>
							<c:set var="orgId"><x:out select='$n1//orgId/text()' /></c:set>
		                    <li>
								<c:choose>
									<c:when test="${orgHasJunior eq '1'}">
										<div class="wh-cate-libox">
										<i class="fa fa-check-circle" data-orgid="${orgId}," data-orgname="${orgName},"></i>
					                        <a onclick="selectChildOrg(this,'<x:out select='$n1//orgLevel/text()' />','${orgId}','<%=selectType%>');" data-click="0">
									</c:when>
									<c:when test="${orgHasJunior eq '0'}">
										<div class="wh-cate-libox wh-cate-libox-empty">
										<i class="fa fa-check-circle" data-orgid="${orgId}," data-orgname="${orgName},"></i>
											<a>
									</c:when>
								</c:choose>
<%--								selectOrg(this,'<x:out select='$n1//orgId/text()' />','<x:out select='$n1//orgName/text()' />');--%>
			                            <i class="icon"><c:out value="${fn:substring(orgName, 0, 1)}" /></i>
			                            <p>
			                                <strong>${orgName}</strong>
			                                <c:if test="${orgHasJunior eq '1'}">
				                                <span>人数<x:out select="$n1/orgUserNum/text()"/> 下级组织<x:out select="$n1/childOrgNum/text()"/></span>
			                                </c:if>
			                            </p>
			                        </a>
		                        </div>
		                    </li>
		                </x:forEach>
                	</c:if>
            	</ul>
            </div>
        </div>
    </aside>
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
<footer class="wh-footer wh-footer-text">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
            	<a href="javascript:clearSelect();" class="fbtn-cancel col-xs-6"><i class="fa fa-bitbucket"></i>清空</a>
                <a href="javascript:confirmSelect();" class="fbtn-matter col-xs-6"><i class="fa fa-check-square"></i>确定</a>
            </div>
        </div>
    </div>
</footer>
<input type="hidden" value="${nomore1}" id="nomore1"/>
<input type="hidden" value="${offset1}" id="offset1"/>
<input type="hidden" value="${param.selectType}" id="selectType"/>
<input type="hidden" value="${param.selectName}" id="selectName"/>
<input type="hidden" value="${param.selectId}" id="selectId"/>
<input type="hidden" value="${param.selectNameVal}" id="selectNameVal"/>
<input type="hidden" value="${fn:replace(param.selectIdVal,'*',',')}" id="selectIdVal"/>
<input type="hidden" value="${param.range}" id="range"/>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<script type="text/javascript">
	//选择表单id值的id
	var selectId = $('#selectId').val();
	//选择表单name值的id
	var selectName = $('#selectName').val();
	//单选/多选标识 0：单选，1：多选
	var selectType = $('#selectType').val();
	//已选择的用户名
	var selectNameVal = $("#selectNameVal").val();
	//已选择的用户id
	var selectIdVal = $("#selectIdVal").val();
	//组织
	var pager_offset1 ='<%=offset1%>';
	var selectOrgMore = '${nomore1}';
	var idValArray = selectIdVal.split(',');
	var nomore = $('#nomore1').val();
	var range = $("#range").val();
	$(function(){
		bindOrgSelect();
		//判断是否显示下拉加载区域
	    if(selectOrgMore){
			$(".wh-load-box").show();
		}else{
			$(".wh-load-box").hide();
		}
		//设置icon样式类
		setIconClass($('.icon'));
	});
	
	//绑定用户选择点击事件
	function bindOrgSelect(){
		var orgId = '';
		var empName = '';
	    $("i.fa-check-circle").each(function(){
	    	$(this).unbind('click');
	    	$(this).bind('click',function(){
	    		orgId = $(this).data('orgid');
	    		orgName = $(this).data('orgname');
		    	//单选时选择方式
		    	if(selectType == '0'){//单选
		        	$(this).addClass('fa-check-circle-active');
		        	$('i.fa-check-circle').not(this).removeClass('fa-check-circle-active');
		        	selectIdVal = orgId;
		        	selectNameVal = orgName;
		    	}else if(selectType == '1'){//多选 
		    		if($(this).hasClass('fa-check-circle-active')){
		    			$(this).removeClass('fa-check-circle-active');
		    			selectIdVal = selectIdVal.replace(orgId,'');
		    			selectNameVal = selectNameVal.replace(orgName,'');
		    		}else{
				        $(this).addClass('fa-check-circle-active');
		    			selectIdVal += orgId;
		    			selectNameVal += orgName;
		    		}
		    	}
	    	});
	    	//回显已勾选的数据
			//setSelectVal(this,$(this).data('orgid'));
	    });
	}
	
	$(window).scroll(function(){ 
		totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop()); 
		if($(document).height() <= totalheight){
			if(selectOrgMore=='true'){
				loadmore1();
			}
		}
	});

	//加载更多 
	function loadmore1(){
		if($('#org_ul').data('loadorgflag') == '1'){
			return;
		}
		$('#org_ul').data('loadorgflag','1');
		$(".wh-load-md").show();
		$(".wh-load-tap").html("正在加载...");
		$.ajax({
			url : '/defaultroot/person/searchOrg.controller',
			data : {'pageSize' : pager_offset1,'nomore' : selectOrgMore,'flag' : 'org','range' : range},
			type : 'post',
			success : function(data){
				var $data = $(data);
				pager_offset1 = $($data[6]).val();//orgOffset
				selectOrgMore = $($data[4]).val();
				$('#org_ul').append($("ul[name='org_ul'] li",data));
				if(selectOrgMore){
					$(".wh-load-tap").html("上滑加载更多");
					$(".wh-load-box").show();
					$(".wh-load-md").hide();
				}else{
					$(".wh-load-box").hide();
				}
				$('#org_ul').data('loadorgflag','0');
				//设置icon样式类
				setIconClass($("i[class=icon]"));
			}
		});
		/*
		$("#footer1").html("正在加载...");
		var url ='/defaultroot/person/searchOrg.controller?range=*0*&flag=org&pageSize='+pager_offset1;
		$.get(url, function(data,status){
			if(status != "success"){
				alert("加载失败！");
				$("#footer1") .html("更多数据");
				stop1 = true;
				return;
			}
			var $data = $(data);
			var len =$data.find('#page_row1').length;
			if(len>0){
				pager_offset1 = parseInt(pager_offset1) + <%=G_PAGE_SIZE%>;
				$('#content1').append($data.find('#page_row1'));
			}
			if(len < <%=G_PAGE_SIZE%>){
				$("#footer1").detach();
				stop1 =false;
			}else{
				if('<%=recordCount1%>' == pager_offset1){
					$("#footer1").detach();
					stop1 =false;
				}else{
					$("#footer1").html("更多数据");
					stop1 =true;
				}
			}
		});*/
	}

	//加载下级组织
	function selectChildOrg(obj, orgLevel, orgId, selectType){
		getHtml(obj, orgLevel, orgId, selectType);
	}

	// 拼接下级组织html
	function getHtml(obj, orgLevel, orgId, selectType){
		var $parentDiv = $(obj).parent();
		var $divNext = $parentDiv.next();
		var clickFlag = $(obj).data("click");
		$(obj).data("click","1");
		//判断下级是否已经加载，若已加载则显示/隐藏 
		if($divNext.length > 0){
			if($divNext.css("display") != "none"){
				$divNext.hide();
				$parentDiv.removeClass("wh-cate-libox-active");
			}else{
				$divNext.show();
				$parentDiv.addClass("wh-cate-libox-active");
			}
			return;
		}
		if(clickFlag == "0"){
			//拼接的dom元素
			var html ='<ul>';
			var spanDom = '';
			var aDom = '';
			var divClass = '';
			var iconClass = '';
			//查询数据加载下一级版块
			$.ajax({
				url : '/defaultroot/person/getOrg.controller',
				type : 'post',
				data : {'orgId' : orgId,'range' : range},
				success : function(data){
					if(data){
						var jsonData = eval('('+data+')');
						if(!jsonData){
							return;
						}
						var orgVar;
						for(var i=0,length=jsonData.length;i<length;i++){
							orgVar = jsonData[i];
							if(orgVar.orgHasJunior == '1'){
								spanDom = '<span>人数'+ orgVar.orgUserNum +' 下级组织'+ orgVar.childOrgNum +'</span>';
								aDom = '<a onclick="selectChildOrg(this,'+orgVar.orgLevel+','+orgVar.orgId+',\'1\');" data-click="0">';
								divClass = 'wh-cate-libox';
							}else if(orgVar.orgHasJunior == '0'){
								spanDom = '<span>人数'+ orgVar.orgUserNum +'</span>';
								divClass = 'wh-cate-libox wh-cate-libox-empty';
								aDom = '<a>';
							}
							iconClass = getIconClass();
							html += 
			                    '<li>'+
									'<div class="'+divClass+'">'+
										'<i class="fa fa-check-circle" data-orgid="'+orgVar.orgId+'," data-orgname="'+orgVar.orgName+',"></i>'+aDom+
				                        '<i class="icon '+iconClass+'">'+ orgVar.orgName.substring(0,1) +'</i>'+
				                            '<p>'+
				                                '<strong>'+ orgVar.orgName +'</strong>'+spanDom+
				                            '</p>'+
				                        '</a>'+
			                        '</div>'+
			                    '</li>';
						}
						html += '</ul>';
					}
					$(obj).parent().parent().append(html);
					bindOrgSelect();
				},
				error:function(data){
					alert("加载下级栏目异常！");
				}
			});
		}
	}

	//确定
	function confirmSelect(){
		nomore1 = '';
		var $select = $("i.fa-check-circle-active");

		$("input[id='"+selectId+"']").val(selectIdVal);
		$("input[id='"+selectName+"']").val(selectNameVal);
		if(typeof ( selectCallBack ) == "function" ){
			selectCallBack( $("input[id='"+selectName+"']"),$("input[id='"+selectId+"']") );
		}

		hiddenContent(1);
	}
	
	//清空
	function clearSelect(){
		$("i.fa-check-circle-active").removeClass("fa-check-circle-active");
		selectNameVal = '';
	    selectIdVal = '';
	}

</script>
<script>
	var selectIndex = 0;
	$(function() {
		var headerBtn = $("#headerBtn a");
		headerBtn.click(function(){
			selectIndex = $(this).index();
			headerBtn.eq(selectIndex).addClass("active").siblings().removeClass("active");
			if(selectIndex==0){
				//改变占位文字为用户搜索
				$('#search_header').show();
				$('article.wh-article').show();
				$('aside.wh-category').hide();
				$("#org_list i.fa-check-circle").removeClass('fa-check-circle-active');
				selectNameVal = '';
				selectIdVal = '';
				pageFlag = 'emp';
				//判断是否显示下拉加载区域
				if(nomore){
					$(".wh-load-box").show();
				}else{
					$(".wh-load-box").hide();
				}
			}else if(selectIndex==1){
				//改变占位文字为组织搜索
				$('#search_header').hide();
				$('aside.wh-category').show();
				$('article.wh-article').hide();
				$("#all_user_list i.fa-check-circle").removeClass('fa-check-circle-active');
				selectNameVal = '';
				selectIdVal = '';
				pageFlag = 'org';
				//判断是否显示下拉加载区域
				if(orgNomore){
					$(".wh-load-box").show();
					$(".wh-load-tap").html("上滑加载更多");
					$(".wh-load-md").hide();
				}else{
					$(".wh-load-box").hide();
				}
			}
		});
		//绑定用户选择点击事件
		bindEmpSelect();
		//判断是否显示下拉加载区域
		if(nomore){
			$(".wh-load-box").show();
		}else{
			$(".wh-load-box").hide();
		}
		//设置icon样式类
		setIconClass($('.icon'));
	});


//绑定用户选择点击事件
function bindEmpSelect(){
    //$("#all_user_list i.fa-check-circle").each(function(){
	var empId = '';
	var empName = '';
    $("i.fa-check-circle").each(function(){
    	$(this).unbind('click');
    	$(this).bind('click',function(){
	    		orgId = $(this).data('orgid');
	    		orgName = $(this).data('orgname');
		    	//单选时选择方式
		    	if(selectType == '0'){//单选
		        	$(this).addClass('fa-check-circle-active');
		        	$('i.fa-check-circle').not(this).removeClass('fa-check-circle-active');
		        	selectIdVal = orgId;
		        	selectNameVal = orgName;
		    	}else if(selectType == '1'){//多选 
		    		if($(this).hasClass('fa-check-circle-active')){
		    			$(this).removeClass('fa-check-circle-active');
		    			selectIdVal = selectIdVal.replace(orgId,'');
		    			selectNameVal = selectNameVal.replace(orgName,'');
		    		}else{
				        $(this).addClass('fa-check-circle-active');
		    			selectIdVal += orgId;
		    			selectNameVal += orgName;
		    		}
		    	}
	    	});
    	//回显已勾选的数据
		setSelectVal(this,$(this).data('orgid'));
    });
}

//回显已勾选的数据
function setSelectVal(obj,curEmpId){
	if(idValArray){
		for(var i=0,length=idValArray.length; i<length; i++){
			if(idValArray[i]+',' == curEmpId){
				$(obj).addClass('fa-check-circle-active');
			}
		}
	}
}


 $(function(){
		$(document).scrollTop(0);
		 //绑定查询框回车事件
		$('#queryCondition').keydown(function(event){
			var searchTitle = $('#queryCondition').val();
			if(event.keyCode == 13){ //绑定回车 
				if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
					alert('请正确填写搜索信息标题！');
					return false;
				}

				$('#org_ul').empty();
				searchOrgData(searchTitle);
			} 
		});
  });

 


	//查询用户数据
	function searchOrgData(searchTitle){
		//if($('#org_ul').data('loaduserflag') == '1'){
			//return;
		//}
		$('#org_ul').data('loaduserflag','1');
		$(".wh-load-md").css("display","block");
		$(".wh-load-tap").html("正在加载...");
		$.ajax({
			url : '/defaultroot/person/searchOrg.controller',
			data : {'pageSize' : '0','title' : searchTitle,'flag' : 'org','range' : range},
			type : 'post',
			success : function(data){
				var $data = $(data);
				//alert($data);
				pager_offset1 = $($data[6]).val();//orgOffset
				selectOrgMore = $($data[4]).val();
				$('#org_ul').append($("ul[name='org_ul'] li",data));
				if(selectOrgMore){
					$(".wh-load-tap").html("上滑加载更多");
					$(".wh-load-box").show();
					$(".wh-load-md").hide();
				}else{
					$(".wh-load-box").hide();
				}
				//$('#org_ul').data('loadorgflag','0');
				//设置icon样式类
				setIconClass($("i[class=icon]"));
			}
		});
		
	
	}
</script>