<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
     List nianOptions= (List) request.getAttribute("nianOptions");
     java.util.Map map = new java.util.HashMap();
    if(request.getAttribute("subjectCostMap") !=null){
        map = (java.util.Map)request.getAttribute("subjectCostMap");
    }
    java.text.DecimalFormat decimalFormat = new java.text.DecimalFormat("0.00");//格式化数字
    java.util.List subjectCostList = new java.util.ArrayList();
    if(request.getAttribute("subjectCostList") !=null){
	    subjectCostList = (java.util.List)request.getAttribute("subjectCostList");
    }
    String listClass1="";
    String sectionid = request.getAttribute("sectionid")==null?"":request.getAttribute("sectionid").toString();
    String costyear = request.getAttribute("costyear")==null?"":request.getAttribute("costyear").toString();
    String sectionname = request.getParameter("sectionname")==null?"":request.getParameter("sectionname").trim();
    String viewType = request.getParameter("viewType")==null?"":request.getParameter("viewType").trim();
    String isHave = request.getAttribute("isHave")==null?"no":request.getAttribute("isHave").toString();
    if(isHave.equals("no") && request.getParameter("isHave") !=null){
        isHave = request.getParameter("isHave")==null?"no":request.getParameter("isHave").trim();
    }
    String bcwfId = request.getParameter("bcwfId")==null?"":request.getParameter("bcwfId").trim();
    String action = request.getAttribute("action")==null?"":request.getAttribute("action").toString();
    String flag = request.getAttribute("flag")==null?"":request.getAttribute("flag").toString();

	costyear=EncryptUtil.htmlcode(costyear);
	sectionid=EncryptUtil.htmlcode(sectionid);
	//sectionname=EncryptUtil.htmlcode(sectionname);
	viewType=EncryptUtil.htmlcode(viewType);
	isHave=EncryptUtil.htmlcode(isHave);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test='#request.action == "add"'>新增预算费用</s:if> <s:else> <%if(viewType.equals("view")){%>查看预算费用<%}else{%>修改预算费用<%}%></s:else> 
</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="Pupwin">
	<div class="BodyMargin_10" >  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="${ctx}/budgetCost!save.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>  
                <td for="预算部门" width="80" class="td_lefttitle">  
                    预算部门<span class="MustFillColor">*</span>：  
                </td>  
                <td>  
                     <s:textfield id="sectionname" name="sectionname" size="16" cssClass="inputText" cssStyle="width:50%;" whir-options="vtype:['notempty',{'maxLength':60}]" onkeydown="return false;" maxlength="60" readonly="true"/><s:if test='#request.action == "add"'><a href="javascript:void(0);" class="selectIco" onClick="openEndowBM();"></a></s:if>
                    <s:hidden name="sectionid" id="sectionid"/>
                </td>  
            </tr>  
            <tr>  
                <td for="年度" class="td_lefttitle">  
                    年&nbsp;&nbsp;&nbsp; 度：  
                </td>  
                <td> 
                 <s:if test='#request.action == "add"'>
                    <select name="budgetCostPO.costyear" id="costyear" style="width:20%" class="selectlist" whir-options="vtype:['notempty']">
                  <%
                    if(nianOptions != null && nianOptions.size() >0){
                        for(int i = 0; i < nianOptions.size(); i++){
                            Object[] obj = (Object[])nianOptions.get(i);
                            String result="";
                            if(costyear.equals(obj[1].toString())){
                                result="true";
                            }
                   %>
                        <option value="<%=obj[1]%>" <%=result.equals("true")?"selected":""%>><%=obj[0]%></option>
                   <%
                        }
                    }
                  %>
                 </s:if>
                 <s:else>
                 <s:hidden name="budgetCostPO.costyear" />
                 <select name="budgetCostPO.costyear" id="costyear" style="width:20%" class="selectlist" disabled="true">
                  <%
                    if(nianOptions != null && nianOptions.size() >0){
                        for(int i = 0; i < nianOptions.size(); i++){
                            Object[] obj = (Object[])nianOptions.get(i);
                            String result="";
                            if(costyear.equals(obj[1].toString())){
                                result="true";
                            }
                   %>
                        <option value="<%=obj[1]%>" <%=result.equals("true")?"selected":""%>><%=obj[0]%></option>
                   <%
                        }
                    }
                  %>
                 </s:else>
                   
                </td>  
            </tr>
            <tr>  
                <td for="制 定 人" class="td_lefttitle" >  
                    制 定 人：  
                </td>  
                <td> 
                     <s:hidden name="budgetCostPO.costcreatorid" id="costcreatorid"/>
                     <s:textfield name="budgetCostPO.costcreator" id="costcreator" cssClass="inputText" readonly="true" onkeydown="return false;" cssStyle="width:50%;" />
                </td>  
            </tr>
            <tr>  
                <td for="控制方式" class="td_lefttitle" >  
                   控制方式：  
                </td>  
                <td>  
                    <s:if test='#request.action == "add"'>
                    <s:radio name="budgetCostPO.costcontrol" list="%{#{'0':'预警提醒','1':'不允许提交'}}" value="1" theme="simple"></s:radio>
                     </s:if>
                    <s:else>
                    <s:radio name="budgetCostPO.costcontrol" list="%{#{'0':'预警提醒','1':'不允许提交'}}"  theme="simple"></s:radio>
                    </s:else>
                </td>  
            </tr>

            </table>
                    <!--页签-->
                    <div class="whir_public_movebg">
                        <div class="Public_tag">
                            <ul id="whir_tab_ul">
                                <li id="li0" onClick="list2();" class="<%if("reload".equals(flag) || "edit".equals(flag)){%>tag_aon<%}%>"  whir-options="{target:'tab0'}"><span class="tag_center">费用预算</span><span class="tag_right"></span></li>
                                <%if(action !=null && "edit".equals(action)){%>
	                            <%if(isHave.equals("yes")){%>
                                <li id="li1" onClick="list4();"class="<%if("idTotalBudget".equals(request.getParameter("idTotalBudget"))){%>tag_aon<%}%>"  whir-options="{target:'tab1'}"><span class="tag_center">累计预算</span><span class="tag_right"></span></li>
                               <%}%>
                                <li id="li2" onClick="list();" class="<%if(!"reload".equals(flag) && !"edit".equals(flag)){%>tag_aon<%}%>" whir-options="{target:'tab2'}"><span class="tag_center">实际发生费用</span><span class="tag_right"></span></li>
                                <li id="li3" onClick="list3();" class="<%if("duibi".equals(request.getParameter("duibi"))){%>tag_aon<%}%>" whir-options="{target:'tab3'}"><span class="tag_center">费用对比</span><span class="tag_right"></span></li>
                                <%}%>
                                
                            </ul>
                        </div>
                    </div>

                    <div class="whir_clear"></div>
                    <div id="tab0" class="grayline">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable outTopline">
                            <tr class="listTableHead">
                                <td nowrap width="9%">科 目</td>
                                <!--月份start-->
                                <%
                                for(int k=0;k<12;k++){
                                %>
                                <td width="7%"><%=k+1%>月</td>
                                <%}%>
                                <!--月份end-->
                                <td width="7%">合计</td>
                            </tr>
                            <%
                                java.util.Iterator it  = map.entrySet().iterator();
                                int index = 0;
                                String listClass;
                                String checkFormStr = "";//验证和保存数据标识字符串，非常重要
                                for(int i=0;i<subjectCostList.size();i++){
                                    Object[] data= (Object[])subjectCostList.get(i);
                                    String key = data[16].toString();

                                    index ++;
                                    listClass = index%2!=0?"listTableLine2":"listTableLine1";
                                    if(i==(subjectCostList.size()-1)){
                                        if(listClass.equals("listTableLine2")){
                                            listClass1="listTableLine1";
                                        }
                                        if(listClass.equals("listTableLine1")){
                                            listClass1="listTableLine2";
                                        }
                                    }
                                    String d15 = data[15]==null?"":data[15].toString();
                                    d15 = (("".equals(d15) || Double.parseDouble(d15)==0)?"":decimalFormat.format(Double.parseDouble(d15)));
                            %>
                            <tr class="<%=listClass%>">
                                <td  width="9%"><%=data[0]%></td>
                                <!--月份start-->
                                <%if(data[1]!=null && "0".equals(data[1].toString())){//按月
                                    for(int k=0;k<12;k++){
                                        checkFormStr += key + "_" + k + ",";
                                        String d3 = data[k+3]==null?"":data[k+3].toString();
                                        d3 = ("".equals(d3)?"":decimalFormat.format(Double.parseDouble(d3)));
                                %>
                                <td width="7%"><input type="text" onKeyUp="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'');sumJE('<%=key%>',0);sumTotalJE('total_<%=k%>','<%=k%>',0);" name="<%=key + "_" + k %>" id="<%=key + "_" + k %>" size="5" maxlength="15" class="INPUTTEXT total_<%=k%>" value="<%=d3%>" /></td>
                                <%}%>
                                <%}else{//按年
                                    checkFormStr += key + "_year" + ",";
                                %>
                                <td class="bnm1" colspan="12"><input name="<%=key + "_year"%>" id="<%=key + "_year"%>" onKeyUp="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'');sumJE('<%=key%>',1);sumTotalJE('','',1);" type="text" style="width:100%" maxlength="15" class="INPUTTEXT" value="<%=d15%>" /></td>
                                <%}%> 
                                <td  width="9%"><input type="text" name="<%=key + "_sum"%>" id="<%=key + "_sum"%>" size="5" maxlength="15" class="INPUTTEXT total_total" value="<%=d15%>" readonly="true" /></td>
                            </tr>
                            <%}%>
                            <% if(subjectCostList!=null && subjectCostList.size() >0){%>
                            <tr class="<%=listClass1%>">
                                <td width="7%">
                                合计
                                </td>
                                <%
                                    for(int m=0;m<12;m++){
                                    
                                %>
                                <td width="7%"><input type="text" name="ttotal_<%=m%>" id="ttotal_<%=m%>" size="5" maxlength="15" class="INPUTTEXT" value="" readonly="true" />
                                </td>
                                <%
                                }
                                %>
                                <td width="7%"><input type="text" name="ttotal_total" id="ttotal_total" size="5" maxlength="15" class="INPUTTEXT" value="" readonly="true" />
                                </td>
                            </tr>
                            <%
                            }
                            %>
                        </table>
                    </div>
                    <%if(flag !=null && "edit".equals(flag)){%>
	                 <%if(isHave.equals("yes")){%>
                   <!--  <div id="tab1" class="grayline">7</div> -->
                    <%}%>
                    <!-- <div id="tab2" class="grayline">8</div>
                    <div id="tab3" class="grayline">9</div> -->
                    <%}%>

                    <!--页签-->
             <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr class="Table_nobttomline"> 
                <td  width="80" class="td_lefttitle"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td nowrap colspan=1> 
                    <%if(!viewType.equals("view")){%>
                    <s:if test='#request.action=="add"'>
                    <input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' /> 
                    <input type="button" class="btnButton4font" onClick="save(1,this);" value='<s:text name="comm.savecontinue"/>' /> 
                    </s:if>
                    <s:else>
                    <input type="button" class="btnButton4font" onClick="update(0,this);" value='<s:text name="comm.saveclose"/> ' />  
                    </s:else>
                    <input type="button" class="btnButton4font" onClick="resetMe();"     value='<s:text name="comm.reset"/>' /> 
                    <%}%>
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                </td>
            </tr>  
        </table> 
        <s:hidden name="budgetCostPO.costid" id="costid"/>
		<input type="hidden" name="viewType" id="viewType" value="<%=viewType%>" />
		<input type="hidden" name="isHave" id="isHave" value="<%=isHave%>" />
	  <!--subjectIdsKey将作为表单验证保存的标识字段-->
	  <input type="hidden" name="subjectIdsKey" id="subjectIdsKey" value="<%if(!"".equals(checkFormStr)){%><%=checkFormStr.substring(0,checkFormStr.lastIndexOf(","))%><%}%>" />
	</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});


	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
    $(document).ready(function(){
        initTab("whir_tab_ul");
        init();
        changeSection('<%=sectionid==null?"":sectionid%>','<%=costyear==null?"":costyear%>');
    });
   
    function update(n,obj){ 
       var formId = $(obj).parents("form").attr("id");
       var validation = validateForm(formId);
       $(obj).parents("form").find("#saveType").val(n);
       if(validation){
           if(checkForm()){
               dataForm.action = "<%=rootPath%>/budgetCost!update.action";
               $('#'+formId).submit();
           }
       }
    }
    function save(n,obj){ 
       var formId = $(obj).parents("form").attr("id");
       var validation = validateForm(formId);
       $(obj).parents("form").find("#saveType").val(n);
       if(validation){
           if(checkForm()){
               $('#'+formId).submit();
           }
       }
    }
    function resetDataFormById(formId){
        var url='<%=rootPath%>/budgetCost!add.action?addType=add';
       // window.location.href=url;
       location_href(url);
        //reloadEvent();
    }

    function checkForm() {
	var objName = $("#subjectIdsKey").val();
	if(objName !=''){
		var ids = objName.split(",");
		for(var k=0;k<ids.length;k++){
			if(document.getElementById(ids[k]).value !=''){
				if(isNaN(document.getElementById(ids[k]).value)){
					whir_alert("必须输入数字!",null,null);
					document.getElementById(ids[k]).select();
					document.getElementById(ids[k]).focus();
					return false;
				}
			}
		}
	}else{
		whir_alert('科目为空,不能保存',null,null);
		return false;
	}
  return true;
}
    function list2(){
		 if($("#sectionname").val()==""){
		 	whir_alert("请先选择预算部门!",null,null);
		 }else{
		 	//window.location.href="<%=rootPath%>/budgetCost!edit.action?viewType=<%=viewType%>&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>";
            var url="<%=rootPath%>/budgetCost!edit.action?viewType=<%=viewType%>&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>";
            location_href(url);
		 }
	}
	function list(){
		 if($("#sectionname").val()==""){
		 	whir_alert("请先选择预算部门!",null,null);
		 }else{
		 	//window.location.href="<%=rootPath%>/budgetCost!viewMonth.action?viewType=<%=viewType%>&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
            var url="<%=rootPath%>/budgetCost!viewMonth.action?viewType=<%=viewType%>&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
            location_href(url);
		 }
	}
	function list3(){
		 if($("#sectionname").val()==""){
		 	whir_alert("请先选择预算部门!",null,null);
		 }else{
		 	//window.location.href="<%=rootPath%>/budgetCost!viewMonth.action?viewType=<%=viewType%>&duibi=duibi&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
            var url="<%=rootPath%>/budgetCost!viewMonth.action?viewType=<%=viewType%>&duibi=duibi&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
            location_href(url);
		 }
	}
	function list4(){
		 if($("#sectionname").val()==""){
		 	whir_alert("请先选择预算部门!",null,null);
		 }else{
		 	//window.location.href="<%=rootPath%>/budgetCost!viewMonth.action?viewType=<%=viewType%>&idTotalBudget=idTotalBudget&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
            var url="<%=rootPath%>/budgetCost!viewMonth.action?viewType=<%=viewType%>&idTotalBudget=idTotalBudget&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
            location_href(url);
		 }
	}
    function changeSection(sectionid,costyear){
	if(sectionid !=''){
		$.ajax({
		url: '<%=rootPath%>/modules/subsidiary/budget/getServices.jsp?tag=changeSection&sectionid=' + sectionid + "&" + Math.round(Math.random()*1000),
		type: 'GET',
		data: null,
		timeout: 1000,
		async: true,      //true异，false,ajax同步
		error: function(){
			//alert('Error loading XML document');
		},
		success: function(data){
			data = data.replace(/(^\s*)|(\s*$)/g,"");
			var arr = data.split(",");
			<s:if test='#request.action == "add"'>
			if(arr[0]=="1"){
				//window.location.href='<%=rootPath%>/modules/subsidiary/budget/cost_process_choose.jsp?sectionid=' +sectionid + "&costyear=" + costyear+"&sectionname=<%=sectionname%>&from=add&bcwfId=<%=request.getParameter("bcwfId")==null?"":request.getParameter("bcwfId").trim()%>";
                var url='<%=rootPath%>/modules/subsidiary/budget/cost_process_choose.jsp?sectionid=' +sectionid + "&costyear=" + costyear+"&sectionname=<%=sectionname%>&from=add&bcwfId=<%=request.getParameter("bcwfId")==null?"":request.getParameter("bcwfId").trim()%>";
               openWin({url:url,width:560,height:300,winName:'selCostFlow'});
               self.close();
			}
			</s:if>
             <s:else>
			if(arr[1]=="1"){
				//window.location.href='<%=rootPath%>/budget/cost_process_choose.jsp?sectionid=' +sectionid + "&costyear=" + costyear+"&from=update&sectionname="+BudgetCostActionForm.sectionname.value
					//+"&bcwfId=<%=request.getParameter("bcwfId")==null?"":request.getParameter("bcwfId").trim()%>";
			}
			</s:else>
		}
		});
	}
}


function openEndowBM(){
        var myids=$("#sectionid").val();
        var mynames=$("#sectionname").val();
        var url="${ctx}/budgetSection!sectionChooseList.action?forward=sectionChoose&reload=1&wait=1&type=radio&opt=1&ids="+myids+"&id=sectionid&name=sectionname"
   // popup({id:'sectionid',content: 'url:'+url,title:'预算部门',width: '600px',height: '400px',lock: true,resize: false}); 
   openWin({url:url,width:600,height:400,winName:'selSection'});
    }
function reloadEvent(){//重新加载页面
	 dataForm.action="${ctx}/budgetCost!reload.action";
	 dataForm.submit();
}
function init(){
	for(var n=0;n<12;n++){
		var total_y=0;
		var obj=$(".total_"+n);
		for(var i=0;i<obj.length;i++){
		var val=obj[i].value;
		if(typeof obj[i] !== 'undefined' && typeof obj[i].value !== 'undefined' &&	obj[i].value !=''){
		total_y+=parseFloat(val);
		}
	}
	if(document.getElementById("ttotal_total")){ 
		document.getElementById("ttotal_" + n).value = parseFloat(total_y).toFixed(2);
	}
	}
	var total_t=0;
	var obj1=$(".total_total");
	for(var j=0;j<obj1.length;j++){
		var val1=obj1[j].value;
		if(typeof obj1[j] !== 'undefined' && typeof obj1[j].value !== 'undefined' && obj1[j].value !=''){
		total_t+=parseFloat(val1);
		}
	}
	if(document.getElementById("ttotal_total")){ 
	document.getElementById("ttotal_total").value = parseFloat(total_t).toFixed(2);
	}
}	
function sumJE(key,flag){
	if(flag==0){//按月
		var moneyJe = 0;
		for(var i=0;i<12;i++){
			if(typeof document.getElementById(key + "_" + i) !== 'undefined' && typeof document.getElementById(key + "_" + i).value !== 'undefined' &&	document.getElementById(key + "_" + i).value !=''){
				moneyJe += Number(document.getElementById(key + "_" + i).value);
			}
		}
		if(moneyJe!=0){
			document.getElementById(key + "_sum").value = Number(moneyJe).toFixed(2);
		}else{
			document.getElementById(key + "_sum").value ='';
		}
		
	}else{
		
		if(document.getElementById(key + "_year").value !=''){
			document.getElementById(key + "_sum").value = Number(document.getElementById(key + "_year").value).toFixed(2);
		}else{
			document.getElementById(key + "_sum").value ='';
		}
		
	}
	//setTimeout(sumTotalJE(key1,k,flag),5000);

	
}
function sumTotalJE(key,k,flag){
	if(flag==0){//按月
	var total_y=0;
	var obj=$("."+key);
	for(var i=0;i<obj.length;i++){
		var val=obj[i].value;
		//alert("val:"+val);
		if(typeof obj[i] !== 'undefined' && typeof obj[i].value !== 'undefined' &&	obj[i].value !=''){
		total_y+=parseFloat(val);
		}
	}
	document.getElementById("ttotal_" + k).value = parseFloat(total_y).toFixed(2);
	}
	var total_t=0;
	var obj1=$(".total_total");
	for(var j=0;j<obj1.length;j++){
		var val1=obj1[j].value;
		//alert("val111:"+val);
		if(typeof obj1[j] !== 'undefined' && typeof obj1[j].value !== 'undefined' && obj1[j].value !=''){
		total_t+=parseFloat(val1);
		}
	}
	document.getElementById("ttotal_total").value = parseFloat(total_t).toFixed(2);
}
function resetMe(){
    dataForm.reset();
    <%if(request.getAttribute("action") !=null && "add".equals(request.getAttribute("action").toString())){%>
       
     var url="${ctx}/budgetCost!add.action";
     location_href(url);
    <%}else{%>
    var url = "${ctx}/budgetCost!edit.action?sectionid=<%=sectionid%>&costyear=<%=costyear%>"
	+"&SearchSectionname=<%=sectionname%>"
	+"&SearchCostyear=<%=costyear%>";
     //window.location.href=url;
     location_href(url);
    <%}%>
}
</script>

</html>

