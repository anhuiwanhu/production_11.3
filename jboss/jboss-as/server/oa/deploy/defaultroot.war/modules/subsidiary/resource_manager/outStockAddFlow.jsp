<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.text.DateFormat"%>
<%
  String PstockName = com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"stockName");
  //String PstockName =request.getParameter("stockName")==null?"":request.getParameter("stockName");
  String AstockName =request.getAttribute("stockName")==null?"":request.getAttribute("stockName").toString();
  AstockName =com.whir.component.security.crypto.EncryptUtil.htmlcode(AstockName);
  
  String local     = session.getAttribute("org.apache.struts.action.LOCALE").toString();
  //String mode      = request.getParameter("mode")==null?"outStock":request.getParameter("mode");
  String mode = com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"mode");
  if("".equals(mode)){
	  mode ="outStock";
  }
  String flowTitle = PstockName+"领用"+(mode.equals("outStock")?"出库":"退库");
  Calendar now  = Calendar.getInstance();
  DateFormat df = DateFormat.getDateInstance(DateFormat.LONG, Locale.CHINESE);

  String stockId =com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"stockId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>领用<%=mode.equals("outStock")?"出库":"退库"%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<%@ include file="/public/include/meta_base_workflow.jsp"%>
	<style>
	.TBStyle{
	    BACKGROUND-COLOR: #ffffff;
	    BORDER-BOTTOM: #000000 0px solid;
	    BORDER-LEFT: #000000 0px solid;
	    BORDER-RIGHT: #000000 1px solid;
	    BORDER-TOP: #000000 1px solid;
	    TEXT-DECORATION: none;
	    COLOR: #000000;
	}
	
	.TDStyle{}
	.TDStyle td{
	    BACKGROUND-COLOR: #ffffff;
	    BORDER-BOTTOM: #000000 1px solid;
	    BORDER-LEFT: #000000 1px solid;
	    BORDER-RIGHT: #000000 0px solid;
	    BORDER-TOP: #000000 0px solid;
	    TEXT-DECORATION: none;
	    COLOR: #000000;
	}
	
	.TDTitleStyle{}
	.TDTitleStyle td{
	    BACKGROUND-COLOR: menu;
	    BORDER-BOTTOM: #000000 1px solid;
	    BORDER-LEFT: #000000 1px solid;
	    BORDER-RIGHT: #000000 0px solid;
	    BORDER-TOP: #000000 0px solid;
	    TEXT-DECORATION: none;
	    COLOR: #000000;
	}
	</style>
</head>
<body  class="docBodyStyle" scroll="no" onload="initBody();">
	<!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
	<div class="doc_Scroll">
	   <s:form name="dataForm" id="dataForm" action="" method="post" theme="simple" >
	      <%@ include file="/public/include/form_detail.jsp"%>
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
	                  <div id="docinfo0" class="doc_Content">
	                  <!--表单包含页-->
	                  <div>
	                  <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                      <s:hidden name="ssMasterPO.id" />
                      <tr>
                          <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>仓库：</td>
                          <td width="89%" colspan="3">
                              <%=AstockName%>
                              <s:hidden name="ssMasterPO.ssMoney" id="ssMoney" value="" />
                              <s:hidden name="ssMasterPO.ssMan"   id="ssMan"   value="%{#request.userName}" /><!--出货人（又称：制单人）姓名-->
                              <s:hidden name="ssMasterPO.ssDept"  id="ssDept"  value="%{#request.orgId}" />   <!--出货人（又称：制单人）所在部门-->
                              <s:hidden name="ssMasterPO.ssStock" id="ssStock" value="%{#request.stockId}" />
                              <input type="hidden" name="stockId"   value="<%=stockId%>">
                              <input type="hidden" name="stockName" value="<%=PstockName%>">
                              <input type="hidden" name="flowTitle" value="<%=flowTitle%>" >
                              <input type="hidden" name="mode"      value="<%=mode%>">
                          </td>
                      </tr>
                      
                      <tr>
                          <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>部门<span class="MustFillColor">*</span>：</td>
                          <td width="40%">
                              <s:hidden name="ssMasterPO.ssOrg" id="ssOrg" value="%{#request.orgId}"/><s:textfield name="ssMasterPO.ssOrgName" id="ssOrgName" cssClass="inputText" cssStyle="width:98%;" readonly="true" value="%{#request.orgName}"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'ssOrg', allowName:'ssOrgName', select:'org', single:'yes', show:'org', range:'*0*'});"></a>
                          </td>
                          <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"领用":"退库"%>人<span class="MustFillColor">*</span>：</td>
                          <td width="40%">
                              <s:hidden name="ssMasterPO.ssUseManID" id="ssUseManID" value="%{#request.userId}"/><s:textfield name="ssMasterPO.ssUseMan" id="ssUseMan" cssClass="inputText" cssStyle="width:98%;" readonly="true" value="%{#request.userName}"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'ssUseManID', allowName:'ssUseMan', select:'user', single:'yes', show:'user', range:'*0*'});"></a>
                          </td>
                      </tr>
                      
                      <tr>
                          <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>日期<span class="MustFillColor">*</span>：</td>
                          <td width="40%">
                              <s:textfield name="ssMasterPO.ssDate" id="ssDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({el:'ssDate',dateFmt:'yyyy-MM-dd',readOnly:true})" >
                                  <s:param name="value"><s:date name="ssMasterPO.ssDate" format="yyyy-MM-dd"/></s:param>
                              </s:textfield>
                          </td>
                          <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"出库":"退库"%>类别：</td>
                          <td width="40%">
                              <select name="ssTypeDefine" id="ssTypeDefine" class="easyui-combobox" data-options="width:202,panelHeight:'150'" editable="false">
							  <option value="-1"><s:text name='comm.select2'/></option>
                              <%
                                List typeDefineList = (List)request.getAttribute("typeDefineList");
                                if(typeDefineList !=null && typeDefineList.size() >0){
                                	for(int i = 0 ;i<typeDefineList.size();i++){
                                		Object []obj = (Object[])typeDefineList.get(i);
                              %>
                              <option value="<%=obj[0]%>"><%=obj[1]%></option>
                              <%}}%>
                              </select>
                          </td>
                      </tr>
                      
                      <%if(mode.equals("outStock")){%>
                      <tr>
                          <td width="9%" class="td_lefttitle" nowrap>领料部门：</td>
                          <td width="40%">
                              <select name="lyDept" id="lyDept" class="easyui-combobox" data-options="width:202,panelHeight:'150'" editable="false">
                              <option value=""><s:text name='comm.select2'/></option>
                              <%
                                List deptList = (List)request.getAttribute("deptList");
                                if(deptList !=null && deptList.size() >0){
                                	for(int i = 0;i<deptList.size();i++){
                                		Object []obj = (Object[])deptList.get(i);
                              %>
                              <option value="<%=obj[0]%>"><%=obj[1]%></option>
                              <%}}%>
                              </select>
                          </td>
                          <td width="9%" class="td_lefttitle" nowrap>&nbsp;</td>
                          <td width="40%">&nbsp;</td>
                      </tr>
                      <%}%>
                      
                      <tr>
			              <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"用途":"退库原因"%><span class="MustFillColor">*</span>：</td>
			              <td width="89%" colspan="3">
			             	  <s:textarea name="ssMasterPO.uses" id="uses" cssClass="inputTextarea" cols="112" rows="3" maxLength="400" cssStyle="width:99%;"></s:textarea>
			              </td>
			          </tr>
                      
                      <tr>
			              <td width="9%" class="td_lefttitle" nowrap>备注：</td>
			              <td width="89%" colspan="3">
			             	  <s:textarea name="ssMasterPO.remark" id="remark" cssClass="inputTextarea" cols="112" rows="3" maxLength="100" cssStyle="width:99%;"></s:textarea>
			              </td>
			          </tr>
                      
                      <tr>
			              <td class="td_lefttitle" colspan="4" nowrap>
			             	  <input type="button" class="btnButton4font" style="margin-bottom:5px;" onclick="addGoods('<%=mode%>','<%=stockId%>');" value="<s:text name="comm.add"/>" /><span class="MustFillColor">*</span>
			              </td>
			          </tr>
                      
                      <tr>
                      	  <td class="td_lefttitle" colspan="4" nowrap>
                      	      <table width="99.5%" border="0" cellpadding="0" cellspacing="0" id="detailTable" class="TBStyle">
                      	          <tr id="startTr" class="TDTitleStyle">
                      	              <td align="center" width="10%">存货编号</td>
                      	              <td align="center" width="22%">存货名称</td>
                      	              <td align="center" width="10%">规格型号</td>
                      	              <td align="center" width="10%">计量单位</td>
                      	              <td align="center" width="10%">数量</td>
                      	              <td align="center" width="10%">单价</td>
                      	              <td align="center" width="10%">金额</td>
                      	              <td align="center" width="10%"><%=mode.equals("outStock")?"使用":"退库"%>人</td>
                      	              <td align="center" width="8%">操作</td>
                      	          </tr>
                      	  		  <tr id="endTr" class="TDStyle">
	                  		  	      <td align="center" height="25">合计</td>
	                  			      <td>&nbsp;</td>
	                                  <td>&nbsp;</td>
	                                  <td>&nbsp;</td>
	                                  <td><input type="text" name="sum_num" id="sum_num" class="inputText" size="10" readonly="readonly"></td>
	                                  <td>&nbsp;</td>
	                                  <td><input type="text" name="sum_money" id="sum_money" class="inputText" size="10" readonly="readonly"></td>
	                                  <td>&nbsp;</td>
	                                  <td>&nbsp;</td>
	                  		      </tr>
                      	      </table>
                      	  </td>
                      </tr>
                      
                      <tr>
                      	  <td class="td_lefttitle" colspan="4" nowrap>
			              	  <table width="100%" border="0" cellpadding="1" cellspacing="1">
			              	  	 <tr>
			              	  	     <td width="9%" class="td_lefttitle" nowrap>制单人：</td>
			              	  	     <td width="21%"><s:property value="%{#request.userName}"/></td>
			              	  	     <td width="9%" class="td_lefttitle" nowrap>审核人：</td>
			             	  	     <td width="21%">&nbsp;</td>
			             	  	     <td width="9%" class="td_lefttitle" nowrap>保管员：</td>
			             	  	     <td width="31%"><s:textfield name="ssMasterPO.ssStoreMan" id="ssStoreMan" maxLength="20" cssClass="inputText" cssStyle="width:96.5%;" /></td>
			             	  	 </tr>
			             	  	 <tr>
			              	  	     <td width="9%" class="td_lefttitle" nowrap>制单日期：</td>
			              	  	     <td width="21%"><%=df.format(now.getTime())%></td>
			              	  	     <td width="9%" class="td_lefttitle" nowrap>审核时间：</td>
			             	  	     <td width="21%">&nbsp;</td>
			             	  	     <td width="9%" class="td_lefttitle" nowrap><%=mode.equals("outStock")?"提料员":"经办人"%>：</td>
			             	  	     <td width="31%"><s:textfield name="ssMasterPO.ssPicker" id="ssPicker" maxLength="20" cssClass="inputText" cssStyle="width:96.5%;" /></td>
			             	  	 </tr>
			             	  	 <tr>
			              	  	     <td width="9%" class="td_lefttitle" nowrap>审核状态：</td>
			              	  	     <td width="21%">未审核</td>
			              	  	     <td width="9%" class="td_lefttitle" nowrap>&nbsp;</td>
			             	  	     <td width="21%">&nbsp;</td>
			             	  	     <td width="9%" class="td_lefttitle" nowrap>&nbsp;</td>
			             	  	     <td width="31%">&nbsp;</td>
			             	  	 </tr>
			                  </table>
			              </td>
			          </tr>
	                  </table>
	                  </div>
	                  <!--工作流包含页-->
	                  <div><%@ include file="/platform/bpm/work_flow/operate/wf_include_form.jsp"%></div>
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
	//2013-08-06-----禁止Backspace-----start
	$(document).keydown(function(e){
        var doPrevent;
        var varkey =(e.keyCode) || (e.which) || (e.charCode);
        if(varkey ==8){
        	 var d = e.srcElement || e.target;
        	 if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
        	 	doPrevent = d.readOnly || d.disabled;
        	 	if(d.type.toUpperCase() == 'SUBMIT' || d.type.toUpperCase() == 'RADIO' || d.type.toUpperCase() == 'CHECKBOX' || d.type.toUpperCase() == 'BUTTON'){
        	 		doPrevent = true;
        	 	}
        	 }else{
        	 	doPrevent = true;
        	 }
        }
        if(doPrevent){
        	e.preventDefault();
        }
    });
    //2013-08-06-----禁止Backspace-----end
    
    /**切换页面*/
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
    
    /**初始话信息*/
    function initBody(){
        //初始话信息
        ezFlowinit();
    }
	
	//检查页面参数有效性
	function initPara(){
		
		if($('#ssOrg').val() == ''){
			$.dialog.alert('请选择部门！', function(){});
    		return false;
		}
		
		var alertHtml ='退库人不能为空！';
		<%if(mode.equals("outStock")){%>
		    alertHtml ='领用人不能为空！';
		<%}%>
		
		if($('#ssUseManID').val() ==''){
			$.dialog.alert(alertHtml, function(){});
    		return false;
		}
		
		var alertHtml1 = "退库日期";
		<%if(mode.equals("outStock")){%>
		alertHtml1 = "出库日期";
		<%}%>
		if($('#ssDate').val() == ''){
			$.dialog.alert(alertHtml1+'不能为空！', function(){});
    		return false;
		}
		
		if($.trim($('#uses').val()) == ''){
			$.dialog.alert('请填写用途！', function(){});
    		return false;
		}else if($('#uses').val() != '' && $('#uses').val().length > 400){
			$.dialog.alert('用途不能超过400个汉字！', function(){});
    		return false;
		}
		
		if($('#remark').val() != '' && $('#remark').val().length > 100){
			$.dialog.alert('备注不能超过100个汉字！', function(){});
    		return false;
		}
		
	    if((document.getElementById('detailTable').rows.length - 2) == 0){
    		$.dialog.alert('您还没有增加物品信息，请增加物品信息！', function(){});
    		return false;
    	}else{
    		var flag =true;
    		<%if(mode.equals("returnStock")){%>
	    		$('#detailTable').find('tr:not(#startTr,#endTr)').each(function(){
	    			var goodsName=$(this).find('#goodsName').val();
	    			var kc       =$(this).find('#kc').val();
	    			var amount   =$(this).find('#amount').val();
	    			if(parseFloat(amount) > parseFloat(kc)){
	    				whir_alert('物品'+goodsName+'退库数量不能大于已领用数量:'+eval(kc).toFixed(2), null, null);
	    				flag =false;
	    				return false;
	    			}
	    		});
    		<%}%>
    		if(!flag){
    			return flag;
    		}
    	}
		
		$('#ssDept').val($('#ssOrg').val());
		
	    return true;
	}
	
	function addGoods(mode,stockId){
	    if(mode == 'outStock'){
	       popup({id:'intoStockForm',content:'url:<%=rootPath%>/goodsAction!list.action?addGoods=1&stockIds='+stockId+'&addcolumn=8&chuku=1&mode=outStock',title:'选择物品信息',lock:false,width:950,height:450});
	    }else{
	       popup({id:'intoStockForm',content:'url:<%=rootPath%>/goodsAction!list.action?addGoods=2&stockIds='+stockId+'&addcolumn=8&mode=returnStock',title:'选择物品信息',lock:false,width:950,height:450});
	    }
	}
	
	function CheckAndCount(obj){
	    var mode ="<%=mode%>";
		//处理空格
	    $(obj).val($.trim($(obj).val()));

	    if($(obj).attr('name') == 'amount'){
	       if(isNaN($(obj).val()) || $(obj).val()<=0){
	       	   $.dialog.alert('请输入正确的数值！', function(){
	       	   	   $(obj).val('1');
	       	   	   $(obj).focus();
	       	   });
	       	   return false;
	       }else if($(obj).val() > 99999){
	       	   $.dialog.alert('数值不能大于99999！', function(){
	       	   	   $(obj).val('1');
	       	   	   $(obj).focus();
	       	   });
	       	   return false;
	       }
	    }
	    
	    if(isNaN($(obj).val()) || $(obj).val()<=0){
	        $.dialog.alert('请输入正确的数值！', function(){
	       	    $(obj).focus();
	        });
	        return false;
	    }else{
			//2014-05-27 处理小数点问题
			if($(obj).val().indexOf('.') != -1){
				var len =$(obj).val().substring($(obj).val().indexOf('.')+1,$(obj).val().length);
				if(len !=null && len !='' && len.length >2){
					$(obj).val(eval($(obj).val()).toFixed(2));
					if(isNaN($(obj).val()) || $(obj).val()<=0){
						$.dialog.alert('请输入正确的数值！', function(){
	       					$(obj).focus();
						});
						return false;
					}
				}
			}

	    	var amount = $(obj).parent().parent().find('#amount').val();
	    	var price  = $(obj).parent().parent().find('#price').val();
	    	var money  = $(obj).parent().parent().find('#money').val();
	    	var kc     = $(obj).parent().parent().find('#kc').val();
	        if($(obj).attr('name') == 'amount'){
	        	//if(mode=="outStock" && parseFloat($(obj).val()) > parseFloat(kc)){
	        	//	$.dialog.alert('出库数量不能大于库存:'+eval(kc).toFixed(2), function(){
	        	//		$(obj).val('1');
	        	//		$(obj).focus();
	        	//	});
	        	//	return false;
	        	//}
	        	if(mode=="returnStock" && parseFloat($(obj).val()) > parseFloat(kc)){
	        		$.dialog.alert('退库数量不能大于已领用数量:'+eval(kc).toFixed(2), function(){
	        			$(obj).val('1');
	        			$(obj).focus();
	        		});
	        		return false;
	            }else{
	        		var sumMoney =eval(amount*price).toFixed(2);
	        		$(obj).parent().parent().find('#money').val(sumMoney);
	        	}
	        }else{
	            var sumMoney =eval(amount*price).toFixed(2);
	            $(obj).parent().parent().find('#money').val(sumMoney);
	        }
	    }
	}
	
	function total_money(){
	    var goods_num=document.getElementById('detailTable').rows.length - 2;
	    var total_money = 0.00;
	    var cutNumber = Math.pow(10,2);
	    var total_amount = 0;
	    var total_mon = 0.00;
	    if(goods_num == 0){
	    	document.getElementById('ssMoney').value = 0;
	    }else if(goods_num==1){
	    	document.getElementById('ssMoney').value = document.getElementById('money').value;
	    	total_amount += parseFloat(document.getElementById('amount').value);
			total_mon    += eval(document.getElementById('money').value);
	    }else{
	    	$('#detailTable').find('tr:not(#startTr,#endTr)').each(function(){
	    		total_money   = total_money * 1 + $(this).find('input[name=money]').val() * 1;
	    		total_amount += parseFloat($(this).find('input[name=amount]').val());
	    		total_mon    += eval($(this).find('input[name=money]').val());
	        });
	        document.getElementById('ssMoney').value = Math.round(total_money * cutNumber)/cutNumber;
	    }
	    document.getElementById('sum_num').value  =total_amount.toFixed(2);
	    document.getElementById('sum_money').value=total_mon.toFixed(2);
	}
</script>
</html>