<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%
response.setContentType("text/html; charset=UTF-8");

String portletSettingId = request.getParameter("portletSettingId");

ModuleVO mvo = (ModuleVO)request.getAttribute("mvo");
List list  = new ArrayList();
if(mvo!=null){
     list = mvo.getItemList();
%>
<!--网上投票-->
         	<div class="wh-portal-vote-box" id = "surver">
                <ul class="wh-portal-vote-slide clearfix">
				<%
				if(list != null && list.size() > 0){
				    for (int i = 0; i < list.size(); i++) {
				        ItemVO ivo = (ItemVO)list.get(i);
				%>  
	           	 	<%=ivo.getTitle()%>
				<%}}%>
				</ul>
        	</div>
<%}%>
<script language="JavaScript">

function flexslid(){
	$(".wh-portal-vote-box").flexslider({
	    selector:".wh-portal-vote-slide > li",
	    animation: "slide",
	    animationLoop: false,
	    directionNav: true,
	    controlNav:false,
	    slideshow:false
	    // pausePlay: true
	});
	var listSize = '<%=list.size()%>';
	if(listSize == "1"){
		$("#surver .flex-direction-nav").hide();
	}
}
//执行resize方法。
setTimeout(flexslid(), 200) ;

function checkType(ele,type,lilength,livalue,formlength){
	//如果是单选，
	if(type == 2){
		//改变样式
		$("#li_"+formlength+"_"+lilength).siblings().find('i').removeClass('fa-check-circle fa-color').addClass('fa-check-circle-o');
		$("#li_"+formlength+"_"+lilength).find('i').removeClass('fa-check-circle-o').addClass('fa-check-circle fa-color');
		//把值赋给对应的input
		$("input[name='surveyItem"+formlength+"']").attr("checked",false);
		document.getElementById(livalue+"_"+lilength).checked = "checked";
	}
	//如果是多选
	else{
		var oldValue = document.getElementById(livalue+"_"+lilength).checked;
		if(oldValue == false){
			//把值赋给对应的input
			//改变样式
			document.getElementById(livalue+"_"+lilength).checked = true;
			$("#li_"+formlength+"_"+lilength).find('i').removeClass('fa-check-circle-o').addClass('fa-check-circle fa-color');
		}else{
			document.getElementById(livalue+"_"+lilength).checked = false;
			var newValue = document.getElementById(livalue+"_"+lilength).checked;
			$("#li_"+formlength+"_"+lilength).find('i').removeClass('fa-check-circle fa-color').addClass('fa-check-circle-o');
		 }
	}
}
	
function getSubmitValue(_id){
    var obj=eval("document.getElementsByName('surveyItem"+_id+"')");
    var ids="";
    if(obj){
        if(obj.length){
            var i=0;
            while(obj[i]){
                if(obj[i].checked){
                    ids+=obj[i].value+",";
                }
                i++;
            }
            if(i>0) ids=ids.substring(0,ids.length-1);
        }else{
            if(obj.checked){
                ids=obj.value;
            }
        }
    }
    return ids;
}

function getAllValues(_id){
    var obj=eval("document.getElementsByName('surveyItem"+_id+"')");
    var ids="";
    if(obj){
        if(obj.length){
            var i=0;
            while(obj[i]){
                ids+=obj[i].value+",";
                i++;
            }
            if(i>0) ids=ids.substring(0,ids.length-1);
        }else{
            ids=obj.value;
        }
    }
    return ids;
}

function surveySubmit(nb){
    var ids=getSubmitValue(nb);
    if(ids==""){
        whir_alert('您还没有选择投票项,请选择！');
    }else{
        if(confirm("您确定提交投票吗？")){
        	document.getElementById("surveySubmit_"+nb).disabled=true;
			var surveyId=$("#netSurveyId"+nb).val();
			var returnInfo = ajaxForSync(whirRootPath+"/lookInto!voteAdd.action", "surveyId=" + surveyId + "&itemsIds=" + ids);
			whir_alert(returnInfo);
            }
    }
}

function surveryView(nb){
    var ids=getAllValues(nb);
    var surveyId=$("#netSurveyId"+nb).val();//var surveyId=eval("document.getElementById('netSurveyId"+nb+"').value");
    openWin({url:whirRootPath+"/lookInto!voteList.action?id="+surveyId+"&itemsIds="+ids,width:660,height:480});
}



</script>