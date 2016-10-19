<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>  
<%  
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();  
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
    <title>新采购</title>  
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
    <%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>  
    <%@ include file="/public/include/meta_detail.jsp"%>  
    <!--工作流包含页 js文件--> 
    <%-- <%@ include file="/public/include/meta_base_workflow.jsp"%> --%>
    <%@ include file="/public/include/meta_base_bpm.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
	<script src="<%=rootPath%>/modules/subsidiary/assetmanager/asset_apply_js.js" type="text/javascript"></script>
	<script type="text/javascript">
	    function cmdPrint(){
	    	window.print();
			setTimeout(function(){window.close();},2000);
		}
    </script>
</head> 
 
<body  class="docBodyStyle" scroll=no onload="initBody();">  
    <!--包含头部--->  
    <jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>  
    <div class="doc_Scroll">  
    <s:form name="dataForm" id="dataForm" action="wfoperate!showSend.action" method="post" theme="simple" >  
    <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">  
        <tr valign="top">  
			<td height="100%">  
                <div class="docbox_noline">  
					<div class="doc_Movetitle">  
						<ul>  
							<li class="aon"  id="Panle0"><a href="#" onClick="changePanle(0);" >基本信息</a></li>  
							<li id="Panle1"><a href="#" onClick="changePanle(1);">流程图</a></li>   
							<li id="Panle2" ><a href="#" onClick="changePanle(2);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>  
						</ul>  
					</div>    
					<div class="clearboth"></div>    
					<div id="docinfo0" class="doc_Content" >  
                    	<!--表单包含页-->
                    	<!-- readType:标识新增或修改；0：新增，1：修改，2：查看 -->
						<s:set name="readType" value="0"/>  
                    	<div>
                    		<%@ include file="asset_apply_form.jsp"%>  
                    	</div>      
                    	<!--工作流包含页-->  
                    	<div>   
							 <%--<%@ include file="/platform/bpm/work_flow/operate/wf_include_form.jsp"%>   --%>
							 <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
                    	</div> 
					</div>  
					<div id="docinfo1" class="doc_Content"  style="display:none;"></div>  
					<div id="docinfo2" class="doc_Content"  style="display:none;"></div>  
				</div>  
			</td>  
		</tr>  
	</table>  
	</s:form> 
	</div>  
    <div class="docbody_margin"></div>  
    <%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
</body>  
<script type="text/javascript">  
  	
  	$(document).ready(function(){ 
  		hasCodeState() ;
    });
    
    function hasCodeState() {
    	var codeState = "${codeState}";
    	if(codeState == '0') {
    		whir_alert("没有适合的采购单编号，请联系管理员设置合适的采购单编号", function() { window.close();},null);
    	} else if(codeState == '2') {
    		whir_alert("有多个适合的采购单编号，请联系管理员设置合适的采购单编号", function() { window.close();},null);
    	}
    }
    
	/**  
	 切换页面  
	 */  
	function  changePanle(flag){  
	    for(var i=0;i<3;i++){  
	        $("#Panle"+i).removeClass("aon");  
	    }  
	    $("#Panle"+flag).addClass("aon");  
	    $("div[id^='docinfo']").hide();  
	    $("#docinfo"+flag).show();  
	      
	    //显示流程图  
	    if(flag=="1"){  
	        //传流程图的div的id  
	       showWorkFLowGraph("docinfo1");  
	    }  
	    //显示关联流程  
	    if(flag=="2"){  
	       showWorkFlowRelation("docinfo2");  
	    }  
	}  
	  
	/**  
	初始话信息  
	*/  
	function initBody(){ 
	    //初始话信息  
	    ezFlowinit();
	    changeApplyClass();  
	}  
	
	function initPara(){
		var validation = validateForm("dataForm");
		if(!validation) { 
			return false;
		}
		return true;
	}  
	 
</script>  
</html>  