<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>发送流程</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" /> 
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<section class="wh-section wh-section-bottomfixed" id="mainContent">
	<article class="wh-edit wh-edit-document">
		<div class="wh-container">
			<form id="sendForm" action="/defaultroot/workflow/sendezflowprocess.controller" method="post">
				<input type="hidden" id="userId" name="userId" value=""/>
		     	<input type="hidden" id="scopeId" name="scopeId" value=""/>
			 	<input type="hidden" id="activityName" name="activityName" value=""/>
			 	<input type="hidden" id="activityType" name="activityType" value=""/>
		     	<input type="hidden" id="businessId" name="businessId" value="${businessId}"/>
			 	<input type="hidden" id="processId" name="processId" value="${param.processId}"/>
			 	<c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
					<input type="hidden" id="gateNum" name="gateNum" value="<x:out select="$doc//gateNum/text()"/>"/>
				</c:if>
				<input type="hidden"  name="docTitle" value="${docTitle }"/>
				<c:set var="docTitle" value="${docTitle }"></c:set>
				<table class="wh-table-edit">
					<tr>
	            		<th>下一环节<i class="fa fa-asterisk"></i>：</th>
	            		<td>
	            			<select name="activity"  id="activity" onchange="hiddenEnd();">
								<option value="">--请选择--</option>
								<c:if test="${not empty docXml}">
									<x:parse xml="${docXml}" var="doc"/> 
									<x:forEach select="$doc//activity" var="n" varStatus="statusc"> 
										<c:set var="activitys"><x:out select="$n/activityId/text()"/></c:set>
										<option <x:if select="$n/isDefaultActivity/text() = '1'">selected="true"</x:if> value="<x:out select="$n/activityId/text()"/>"><x:out select="$n/activityName/text()"/></option>
									</x:forEach>
								</c:if>
							</select>
	            		</td>
	            	</tr>
	            	<tr id="person">
	            		<th>办理人：</th>
	            		<td>
<%--	            		<input type="text"   id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>--%>
	            		<input placeholder="请选择" type="text" class="edit-ipt-r" id="userName" name="userName" value="" readonly onclick='selectUser("1","userName","userId",$("#scopeId").val());'/>
	            		</td>
	            	</tr>
				</table>
			</form>
		</div>
	</article>
</section>
<footer class="wh-footer wh-footer-text" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:send();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>发送</a>
            </div>
        </div>
    </div>
</footer>
<section id="selectContent" style="display:none">
</section>
</body>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script language="javascript">
	$(document).ready(function(){
		hiddenEnd();
	});

	function hiddenEnd(){
		if($('#activity').val() =='' || $('#activity').val() =='-2' || $('#activity').val() =='-100'){
			$('#person').hide();
		}else{
			$('#person').show();
		}
		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			<x:forEach select="$doc//activity" var="n" >
				if('<x:out select="$n/activityId/text()"/>' == $('#activity').val()){
					if('<x:out select="$n/scopeType/text()"/>' == 'default_users'){
						$('#userId').val('<x:out select="$n/scopeId/text()"/>');
						$('#userName').val('<x:out select="$n/scopeName/text()"/>');
						$('#activityName').val('<x:out select="$n/activityName/text()"/>');
						$('#activityType').val('<x:out select="$n/activityType/text()"/>');
						$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
						$('#bottonselect').hide();
					}else if( '<x:out select="$n/scopeType/text()"/>' == 'scopes_user' ){
						$('#userId').val('');
          	 			$('#userName').val('');
						$('#activityName').val('<x:out select="$n/activityName/text()"/>');
						$('#activityType').val('<x:out select="$n/activityType/text()"/>');
          	 			$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
						$('#bottonselect').show();
					}else{
						$('#userId').val('');
						$('#userName').val('');
						$('#activityName').val('<x:out select="$n/activityName/text()"/>');
						$('#activityType').val('<x:out select="$n/activityType/text()"/>');
						$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
						$('#bottonselect').show();
					}
				}
			</x:forEach>
		</c:if>
	}
	
	function loadSend(){
	    dialog = $.dialog({
	        content:"正在发送...",
	        title: 'load'
	    });
	}
	
	//发送
	function send(){
		if($('#activity').val() ==''){
			alert("请选择下一节点!");
			return false;
		}
		if($('#userName') != null && $('#userName').val() == ''){
			alert('办理人不能为空');
			return false;
		}
		loadSend();
		//发送流程
		$.ajax({
			url : '/defaultroot/workflow/sendezflowprocess.controller',
			type : 'post',
			data : $('#sendForm').serialize(),
			success : function(data){
				if(dialog){
					dialog.close();
				}
				if(data){
					var jsonData = eval('('+data+')');
					if(jsonData.result = 'success'){
						alert('发送成功！');
						window.location = '/defaultroot/workflow/listflow.controller';
					}
				}else{
					alert('发送失败！');
				}
			},
			error : function(){
				alert('发送异常！');
			}
		});
	}

	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag==0){
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#selectContent").css("display","block");
		}else if(flag==1){
			$("#selectContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#selectContent").empty();
		}
	}
	
	var dialog = null;
	function loadPage(){
	    dialog = $.dialog({
	        content:"正在加载中...",
	        title: 'load'
	    });
	}
		
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		loadPage();
		var selectIdVal = $('#'+selectId).val();
		if(selectIdVal.indexOf('$') != -1){
			var selectIdArray = selectIdVal.split('$');
			if(selectIdArray){
				selectIdVal = '';
				for(var i=0,length=selectIdArray.length;i<length;i++){
					if(selectIdArray[i]){
						selectIdVal += selectIdArray[i] + ',';
					}
				}
			}
		}
		$.ajax({
			url : '/defaultroot/person/newsearch.controller?flag=user',
			type : 'post',
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$('#selectContent').append(data);
				hiddenContent(0);
				if(dialog){
					dialog.close();
				}
			}
		});
	}
</script>
</html>