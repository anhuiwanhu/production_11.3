<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<%  
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();  
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
    <title>采购审批</title>  
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
    <%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>  
    <%@ include file="/public/include/meta_detail.jsp"%>  
    <!--工作流包含页 js文件-->  
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
							  <li id="Panle2" ><a href="#" onClick="changePanle(2);">流程记录</a></li>  
							  <li id="Panle3" ><a href="#" onClick="changePanle(3);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							  <s:if test="#request.p_wf_pool_processType == 0">
							  		<li id="Panle4" ><a href="#" onClick="changePanle(4);">相关附件</a></li> 
							  </s:if>  
						 </ul>  
				    </div>    
					<div class="clearboth"></div>    
					<div id="docinfo0" class="doc_Content" >  
                    	<!--表单包含页--> 
                    	<!-- readType:标识新增或修改；0：新增或审批，1：修改，2：查看，3：审批 -->
						<s:set name="readType" value="3"/>   
                    	<div>
                    		<%@ include file="asset_apply_form.jsp"%>  
                    	</div>      
                    	<!--工作流包含页-->  
                    	<div>    
							<%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>  
                    	</div>  
                    	<!--批示意见包含页-->  
                        <div>  
                              <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>  
                        </div> 
					</div>  
					<div id="docinfo1" class="doc_Content"  style="display:none;"></div>  
					<div id="docinfo2" class="doc_Content"  style="display:none;"></div>  
					<div id="docinfo3" class="doc_Content"  style="display:none;"></div>  
					<div id="docinfo4" class="doc_Content"  style="display:none;"></div>  
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
  
/**  
切换页面  
*/  
function  changePanle(flag){  
	for(var i=0;i<5;i++){  
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
	   showWorkFlowLog("docinfo2");  
	}  
	//显示关联流程  
	if(flag=="3"){  
	   showWorkFlowRelation("docinfo3");  
	}  
 
	//显示相关附件  
	if(flag=="4"){  
	   showWorkFlowAcc("docinfo4");  
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