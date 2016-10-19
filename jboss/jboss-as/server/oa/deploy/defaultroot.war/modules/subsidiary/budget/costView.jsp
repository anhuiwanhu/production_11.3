<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.budget.po.BudgetSubjectPO"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
     List nianOptions= (List) request.getAttribute("nianOptions");
    java.util.Map map = new java.util.HashMap();
    java.util.Map applyMap = new java.util.HashMap();
    java.util.Map costMap = new java.util.HashMap();
    java.util.Map idTotalBudgetMap = new java.util.HashMap();
    java.util.List subjectList = new java.util.ArrayList();
    String isHave = request.getParameter("isHave")==null?"no":request.getParameter("isHave").trim();
    if(isHave.equals("no") && request.getAttribute("isHave") !=null){
        isHave = request.getAttribute("isHave")==null?"no":request.getAttribute("isHave").toString();
    }

    if(request.getAttribute("idTotalBudgetMap") !=null){
        idTotalBudgetMap = (java.util.Map)request.getAttribute("idTotalBudgetMap");
    }
    if(idTotalBudgetMap.get("subjectList") !=null){
        subjectList = (java.util.List) idTotalBudgetMap.get("subjectList");
    }

    java.util.List subjectCostList = new java.util.ArrayList();

    if(request.getAttribute("subjectCostList") !=null){
        subjectCostList = (java.util.List)request.getAttribute("subjectCostList");
    }

    if(request.getAttribute("subjectCostMap") !=null){
        map = (java.util.Map)request.getAttribute("subjectCostMap");
    }

    if(request.getAttribute("apply") !=null){
        applyMap = (java.util.Map)request.getAttribute("apply");
    }

    if(request.getAttribute("cost") !=null){
        costMap = (java.util.Map)request.getAttribute("cost");
    }
    java.text.DecimalFormat decimalFormat = new java.text.DecimalFormat("0.00");//格式化数字

    String listClass1="";
    String sectionid = request.getAttribute("sectionid")==null?"":request.getAttribute("sectionid").toString();
    String costyear = request.getAttribute("costyear")==null?"":request.getAttribute("costyear").toString();
    String sectionname = request.getParameter("sectionname")==null?"":request.getParameter("sectionname").trim();
    String viewType = request.getParameter("viewType")==null?"":request.getParameter("viewType").toString();
  
    String bcwfId = request.getParameter("bcwfId")==null?"":request.getParameter("bcwfId").toString();
    String action = request.getAttribute("action")==null?"":request.getAttribute("action").toString();
    java.util.Map totalMap = new java.util.HashMap();
    Double hjd = new Double(0);
    for(int i=1;i<14;i++){
    totalMap.put("total_"+i,hjd);
    }
    String idTotalBudget = request.getParameter("idTotalBudget")==null?"":request.getParameter("idTotalBudget").toString();
    String duibi = request.getParameter("duibi")==null?"":request.getParameter("duibi").toString();
    String flag = request.getAttribute("flag")==null?"":request.getAttribute("flag").toString();

	costyear=EncryptUtil.htmlcode(costyear);
	sectionid=EncryptUtil.htmlcode(sectionid);
	sectionname=EncryptUtil.htmlcode(sectionname);
	viewType=EncryptUtil.htmlcode(viewType);
	isHave=EncryptUtil.htmlcode(isHave);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>查看预算费用
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
                <td for="预算部门" width="130" class="td_lefttitle">  
                    预算部门<span class="MustFillColor">*</span>：  
                </td>  
                <td>  
                      <s:textfield id="sectionname" name="sectionname" size="16" cssClass="inputText" cssStyle="width:50%;" whir-options="vtype:['notempty',{'maxLength':60}]" onkeydown="return false;" readonly="true"/><s:if test='#request.action == "add"'><a href="javascript:void(0);" class="selectIco" onClick="openEndowBM();"></a></s:if>
                    <s:hidden name="sectionid" id="sectionid"/>
                </td>  
            </tr>  
            <tr>  
                <td for="年度" class="td_lefttitle">  
                    年&nbsp;&nbsp;&nbsp; 度：  
                </td>  
                <td> 
                  <%if((action !=null && "edit".equals(action))){%>
                   <select name="budgetCostPO.costyear" id="costyear" style="width:20%" class="selectlist" whir-options="vtype:['notempty']" disabled="true">
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
                    </select>
                  <%}else{%>
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
                  </select>
                  <%}%>
                 
                   
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
            <tr>
                <td colspan=2>
                    <!--页签-->
                    <div class="whir_public_movebg">
                        <div class="Public_tag">
                            <ul id="whir_tab_ul">
                                <li id="li0" onClick="list2();" class="<%if("edit".equals(flag)){%>tag_aon<%}%>"  whir-options="{target:'tab0'}"><span class="tag_center">费用预算</span><span class="tag_right"></span></li>
	                            <%if(isHave.equals("yes")){%>
                                <li id="li1" class="<%if("idTotalBudget".equals(request.getParameter("idTotalBudget"))){%>tag_aon<%}%>"   whir-options="{target:'tab1'}"><span class="tag_center">累计预算</span><span class="tag_right"></span></li>
                               <%}%>
                                <li id="li2" onClick="list();" class="<%if("viewMonth".equals(flag) && !"idTotalBudget".equals(request.getParameter("idTotalBudget")) && !"duibi".equals(request.getParameter("duibi"))){%>tag_aon<%}%>"   whir-options="{target:'tab2'}"><span class="tag_center">实际发生费用</span><span class="tag_right"></span></li>
                                <li id="li3"  class="<%if("duibi".equals(request.getParameter("duibi"))){%>tag_aon<%}%>"  whir-options="{target:'tab3'}"><span class="tag_center">费用对比</span><span class="tag_right"></span></li>
                                
                            </ul>
                        </div>
                    </div>
                    <div class="whir_clear"></div>
                    <div id="tab2" class="grayline" style="display:<%=("viewMonth".equals(flag) && !"idTotalBudget".equals(request.getParameter("idTotalBudget")) && !"duibi".equals(request.getParameter("duibi")))?"":"none"%>">
                       <table id="viewMonth_table" width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable outTopline" >
                            <tr class="listTableHead">
                                <td  nowrap width="9%">科 目</td>
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
                                    //合计字段值
                                    double hj_d = 0;
                                %>
                            <tr class="<%=listClass%>">
                                <td  width="9%"><a href="javascript:void(0);" onclick="viewDetail(<%=key%>)" title="查看明细"><%=data[0]%></a></td>
                                <!--月份start-->
                                <%if(data[1]!=null && "0".equals(data[1].toString())){//按月%>
                                <%
                                for(int k=1;k<13;k++){
                                    String my_key = sectionid + "_" + key + "_" + costyear + "_" + (k<10?("0" + k):(k+""));					
                                    double dd = 0;
                                    if(applyMap.get(my_key) !=null){
                                        dd = ((Double)(applyMap.get(my_key))).doubleValue();
                                    }
                                    double dd1 = 0;
                                    if(totalMap.get("total_"+k) !=null){
                                        dd1 = ((Double)(totalMap.get("total_"+k))).doubleValue();
                                        dd1=dd1+dd;
                                        totalMap.put("total_"+k,new Double(dd1));
                                    }	
                                    hj_d += dd;
                                %>
                                <td width="7%">&nbsp;<%=decimalFormat.format(dd)%></td>
                                <%}%>
                                <%}else{//按年
                                for(int k=1;k<13;k++){
                                    String my_key = sectionid + "_" + key + "_" + costyear + "_" + (k<10?("0" + k):(k+""));
                                    double dd = 0;
                                    if(applyMap.get(my_key) !=null){
                                        dd = ((Double)(applyMap.get(my_key))).doubleValue();
                                    }
                                    hj_d += dd;
                                }
                                String my_key = sectionid + "_" + key + "_" + costyear;
                                if(applyMap.get(my_key) !=null){
                                    hj_d= ((Double)(applyMap.get(my_key))).doubleValue();
                                }
                                %>
                                <td  colspan="12">&nbsp;<%=decimalFormat.format(hj_d)%></td>
                                <%}
                                double dd2 = 0;
                                if(totalMap.get("total_13") !=null){
                                    dd2 = ((Double)(totalMap.get("total_13"))).doubleValue();
                                    dd2=dd2+hj_d;
                                    totalMap.put("total_13",new Double(dd2));
                                }	
                                %> 
                                <td width="9%">&nbsp;<%=decimalFormat.format(hj_d)%></td>
                            </tr>
                            <%}%>
                            <tr class="<%=listClass1%>">
                                <td width="7%">
                                合计
                                </td>
                                <%
                                for(int m=1;m<14;m++){
                                    String wd="7%";
                                    if(m==13){
                                        wd="7%";
                                    }
                                    double dd2 = 0;
                                    if(totalMap.get("total_"+m) !=null){
                                        dd2 = ((Double)(totalMap.get("total_"+m))).doubleValue();
                                    }
                                %>
                                <td width="<%=wd%>">
                                <%=dd2%>&nbsp;
                                </td>
                                <%
                                }
                                %>
                            </tr>
                        </table>
                    </div>
                    <div id="tab1" class="grayline" style="display:<%="idTotalBudget".equals(idTotalBudget)?"":"none"%>">
                        <!-- 累计预算begin -->
                        <table id="isTotal_table" width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable outTopline" >
                            <tr class="listTableHead">
                                <td  nowrap width="16%">科 目</td>
                                <!--月份start-->
                                <%
                                for(int k=0;k<12;k++){
                                %>
                                <td width="7%"><%=k+1%>月</td>
                                <%}%>
                                <!--月份end-->
                            </tr>
                            <%
                            int index1 = 0;
                            String listClassa;
                            String checkFormStr1 = "";//验证和保存数据标识字符串，非常重要
                            if(subjectList !=null && subjectList.size() >0){
                            for(int i=0;i<subjectList.size();i++){
                            BudgetSubjectPO data= (BudgetSubjectPO)subjectList.get(i);
                            String key = data.getSubjectid().toString();
                            index1 ++;
                            listClassa = index%2!=0?"listTableLine2":"listTableLine1";

                            Map map1=new HashMap();
                            if(idTotalBudgetMap.get(key) !=null){
                            map1 = (Map)idTotalBudgetMap.get(key);
                            }
                            %>
                            <tr class="<%=listClassa%>">
                                <td  width="16%"><a href="javascript:void(0);" onclick="viewDetail(<%=key%>)" title="查看明细"><%=data.getSubjectname()%></a></td>
                                <!--月份start-->
                                <%if(data.getSubjectperiod()!=null && "0".equals(data.getSubjectperiod().toString())){//按月%>
                                <%
                                for(int k=1;k<13;k++){
                                String my_key = sectionid + "_" + key + "_" + costyear + "_" + (k<10?("0" + k):(k+""));	
                                double dd = 0;
                                if(map1.get(k+"") !=null){
                                dd = ((Double)(map1.get(k+""))).doubleValue();
                                }
                                %>
                                <td width="7%">&nbsp;<%=decimalFormat.format(dd)%></td>
                                <%}}%>
                            </tr>
                            <%}}%>
                        </table>
                        <!-- 累计预算end -->
                    </div>
                   
                    <div id="tab3" class="grayline" style="display:<%="duibi".equals(duibi)?"":"none"%>">
                        <table  id="duibi_table"  width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable outTopline">
                            <tr class="listTableHead">
                                <td nowrap colspan="2" width="9%">科 目</td>
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
                            int index2 = 0;
                            String listClass2;
                            String checkFormStr2 = "";

                            for(int i=0;i<subjectCostList.size();i++){
                            Object[] data= (Object[])subjectCostList.get(i);
                            String key = data[16].toString();
                            index2 ++;
                            listClass2 = index2%2!=0?"listTableLine2":"listTableLine1";

                            String d15 = data[15]==null?"":data[15].toString();
                            d15 = (("".equals(d15) || Double.parseDouble(d15)==0)?"":decimalFormat.format(Double.parseDouble(d15)));

                            //合计字段值
                            double hj_d = 0;
                            %>
                            <tr class="<%=listClass2%>">
                                <td rowspan="2" width="9%"><a href="javascript:void(0);" onclick="viewDetail(<%=key%>)" title="查看明细"><%=data[0]%></a></td>
                                <!--月份start-->
                                <td nowrap width="2%">预算</td>
                                <%if(data[1]!=null && "0".equals(data[1].toString())){//按月%>
                                <%
                                for(int k=0;k<12;k++){
                                checkFormStr += key + "_" + k + ",";
                                String d3 = data[k+3]==null?"":data[k+3].toString();
                                d3 = ("".equals(d3)?"":decimalFormat.format(Double.parseDouble(d3)));
                                %>
                                <td width="7%"><%=d3.equals("")?"&nbsp;":d3%></td>
                                <%}%>
                                <%}else{//按年
                                checkFormStr += key + "_year" + ",";
                                %>
                                <td  colspan="12"><%=d15.equals("")?"&nbsp;":d15%></td>
                                <%}%> 
                                <td  width="7%"><%=d15.equals("")?"&nbsp;":d15%></td>
                            </tr>
                            <tr class="<%=listClass2%>">
                                <td nowrap width="2%">实际</td>
                                <!--月份start-->
                                <%if(data[1]!=null && "0".equals(data[1].toString())){//按月%>
                                <%
                                for(int k=1;k<13;k++){
                                String my_key = sectionid + "_" + key + "_" + costyear + "_" + (k<10?("0" + k):(k+""));					
                                double dd = 0;
                                if(applyMap.get(my_key) !=null){
                                dd = ((Double)(applyMap.get(my_key))).doubleValue();
                                }
                                hj_d += dd;
                                %>
                                <td width="7%"><%=decimalFormat.format(dd)%></td>
                                <%}%>
                                <%}else{//按年
                                for(int k=1;k<13;k++){
                                String my_key = sectionid + "_" + key + "_" + costyear + "_" + (k<10?("0" + k):(k+""));
                                double dd = 0;
                                if(applyMap.get(my_key) !=null){
                                dd = ((Double)(applyMap.get(my_key))).doubleValue();
                                }
                                hj_d += dd;
                                }
                                %>
                                <td colspan="12"><%=decimalFormat.format(hj_d)%></td>
                                <%}%> 
                                <td width="7%"><%=decimalFormat.format(hj_d)%></td>
                            </tr>
                            <%}%>
                        </table>
                    </div>

                    <!--页签-->
                </td>
            </tr>
        </table> 
        <s:hidden name="budgetCostPO.costid" id="costid"/>
		
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
         windowWidth = window.screen.availWidth;
       
    });
    function list2(){
		 var url="<%=rootPath%>/budgetCost!edit.action?viewType=<%=viewType%>&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
         location_href(url);
	}
	function list(){
		 var url="<%=rootPath%>/budgetCost!viewMonth.action?viewType=&sectionid=<%=sectionid%>&costyear=<%=costyear%>&SearchSectionname=<%=sectionname%>&SearchCostyear=<%=costyear%>&isHave=<%=isHave%>";
         location_href(url);
	}


function openEndowBM(){
        var myids=$("#sectionid").val();
        var mynames=$("#sectionname").val();
        var url="${ctx}/budgetSection!sectionChooseList.action?forward=sectionChoose&reload=1&wait=1&type=radio&opt=1&ids="+myids+"&id=sectionid&name=sectionname"
    popup({id:'sectionid',content: 'url:'+url,title:'预算部门',width: '600px',height: '400px',lock: true,resize: false}); 	
    }
function reloadEvent(){//重新加载页面
	 dataForm.action="${ctx}/budgetCost!reload.action";
	 dataForm.submit();
}
function viewDetail(subjectid){
    var val="<%=rootPath%>/budgetCost!viewDetail.action?subjectid="+subjectid+"&sectionid=<%=sectionid%>&costyear=<%=costyear%>";
    openWin({url:val,width:750,height:570,winName:'viewDetail'});
}
	
</script>

</html>

