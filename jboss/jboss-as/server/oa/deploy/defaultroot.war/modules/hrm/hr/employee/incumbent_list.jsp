<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.org.manager.bd.ManagerBD" %>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>标准列表页面结构</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
String userId = session.getAttribute("userId").toString();
ManagerBD managerBD = new ManagerBD();
//人事信息-人事信息 维护
boolean hr_right_wh = managerBD.hasRight(userId, "07*01*03");
//人事信息-人事信息 查看
boolean hr_right_ck = managerBD.hasRight(userId, "07*01*01");
//人事信息-基本信息 维护
boolean hr_right1 = managerBD.hasRight(userId, "HR*07*01");
//人事信息-工作信息 查看
boolean hr_right2 = managerBD.hasRight(userId, "HR*07*04");
//人事信息-工作信息 维护
boolean hr_right3 = managerBD.hasRight(userId, "HR*07*05");
//人事信息-工资福利标准 查看
boolean hr_right4 = managerBD.hasRight(userId, "HR*07*07");
//人事信息-社保标准 查看
boolean hr_right5 = managerBD.hasRight(userId, "HR*07*08");
//人事信息-绩效考核 查看
boolean hr_right6 = managerBD.hasRight(userId, "HR*07*06");

EncryptUtil util = new EncryptUtil();
String dlcode = util.getSysEncoderKeyVlaue("FileName","hrm_import_template.xls","dir");
%>
<body class="MainFrameBox">
    <s:form name="queryForm" id="queryForm" action="${ctx}/employee!incumbent_list_data.action" method="post" >
    
    <!-- SEARCH PART START -->
    <%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar" id="searchTable">  
        <input type="hidden" name="exportType" id="exportType" value="0" />
        <tr>
            <td class="whir_td_searchtitle">组织：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="orgName"  cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">姓名：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="empName"  cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">性别：</td>
            <td class="whir_td_searchinput"  >
                <s:radio name="empSex" list="%{#{'0':'男','1':'女','-1':'空'}}" ></s:radio>
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle">岗位：</td>
            <td class="whir_td_searchinput">
               <s:select name="empPosition" list="#request.stationMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--" cssClass="selectlist" />
            </td>
             <td class="whir_td_searchtitle">学历：</td>
            <td class="whir_td_searchinput">
                <s:select name="empStudyExperience" list="#{'博士':'博士','硕士':'硕士','双学历':'双学历','大学本科':'大学本科','大学专科':'大学专科','中专':'中专','中技':'中技','高职':'高职','高中':'高中','初中及以下':'初中及以下'}" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--" cssClass="selectlist" />
            </td>
            <td class="whir_td_searchtitle">年龄：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="age"  cssClass="inputText" cssStyle="width:50px;" whir-options="vtype:['p_integer']"/> 至 <s:textfield  whir-options="vtype:['p_integer']"  name="age2" cssStyle="width:50px;" cssClass="inputText" />
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle">职务：</td>
            <td class="whir_td_searchinput">
                <s:select name="empDuty" list="#request.dutyMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--" cssClass="selectlist" />
            </td>
            <td class="whir_td_searchtitle">生日：</td>
            <td class="whir_td_searchinput" colspan="3" >
                 <s:textfield name="empBirth" id="empBirth"  cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'empBirth2\\',{d:0});}'})" /> 至 
                 <s:textfield name="empBirth2" id="empBirth2"  cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'empBirth\\',{d:0});}'})" />
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle">人员性质：</td>
            <td class="whir_td_searchinput">
                 <s:select name="personalKind" list="#request.kindMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--" cssClass="selectlist" />
            </td>
            <td class="whir_td_searchtitle">入职日期：</td>
            <td class="whir_td_searchinput" colspan="2" >
                 <s:textfield name="intoCompanyDate"  id="intoCompanyDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'intoCompanyDate2\\',{d:0});}'})" /> 至 
                 <s:textfield name="intoCompanyDate2"  id="intoCompanyDate2" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'intoCompanyDate\\',{d:0});}'})" />
            </td>
            <td  class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow" />' />
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear" />' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
    <!-- SEARCH PART END -->
    

    <!-- MIDDLE    BUTTONS    START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >             
            <td align="right">
                <%
                    String agent = request.getHeader("user-agent");
                    boolean ie6 = agent.indexOf("MSIE 6")>=0 ;
                    boolean ie7 = agent.indexOf("MSIE 7")>=0 ;
                    if( hr_right_wh ){
                %>
                    <a style="cursor:pointer" href="javascript:void(0);downloadTemplate();">下载导入模板</a>&nbsp;
                    <input type="button" class="btnButton4font" onclick="openWin({url:'<%=rootPath%>/employee!incumbent_add.action',isFull:true,width:620,height:350,winName:'incumbent_add'});" value='<s:text name="comm.add" />' />
                    <input type="button" class="btnButton4font" onclick="excelImport2();" value='<s:text name="comm.import" />' />
                <%}%>
                <%
                    if (hr_right_wh) {
                %>
                    <input type="button" class="btnButton6font" onClick="batchDel();" value="加入历史库" />
                    <input type="button" class="btnButton4font" onClick="batchResume();" value="批量恢复" />
                    <select name="exportType_" id="exportType_"  style="padding:2px 0px 2px 0px;width:100px;height:24px;margin-top:-2px;<%if(ie6){%>height:30px;margin-top:-25px;<%}%><%if(ie7){%>margin-bottom:-2px;margin-top:4px;<%}%>" onchange="javascript:$('#exportType').val(this.value);">
                        <option value="0" selected>员工信息</option>
                        <option value="1">合同信息</option>
                        <option value="2">教育经历</option>
                        <option value="3">工作经历</option>
                        <option value="4">入职前培训经历</option>
                        <option value="5">资格证书</option>
                    </select>
                    <input type="button" class="btnButton4font" onClick="excelExport();" value='<s:text name="comm.export" />' />
                    <input type="button" class="btnButton4font" onClick="excelExport_checked();" value='选中导出' />
                <%}%>
            </td>
        </tr>
    </table>
    <!-- MIDDLE    BUTTONS    END -->

    <!-- LIST TITLE PART START -->    
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable" id="listTable">
        <thead id="headerContainer" whir-options="renderer:trStyle">
        <tr class="listTableHead">
            <td whir-options="field:'empId',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('empId',this.checked);" ></td>
            <td whir-options="field:'orgNameString',width:'35%',allowSort:true">组织</td> 
            <td whir-options="field:'empName',width:'10%',allowSort:true,renderer:show">姓名</td> 
            <td whir-options="field:'empSex', width:'5%',renderer:sex">性别</td> 
            <td whir-options="field:'empBirth', width:'12%',renderer:common_DateFormat">出生日期</td> 
            <td whir-options="field:'empDuty',width:'10%'">职务</td> 
            <td whir-options="field:'empLeaderName',width:'17%'">直接上级</td> 
            <td whir-options="field:'',width:'8%',renderer:myOperate">操作</td> 
        </tr>
        </thead>
        <tbody  id="itemContainer" >
        
        </tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->
    <br>
    <font size="2">&nbsp;&nbsp;注：黑色代表有系统帐号的在职员工；绿色代表没有系统帐号的在职员工；灰色代表有系统帐号但被禁用。</font>
    </s:form>
</body>


    <script type="text/javascript">
    
    //*************************************下面的函数属于公共的或半自定义的*************************************************//

    //初始化列表页form表单,"queryForm"是表单id，可修改。
    $(document).ready(function(){        
        initListFormToAjax({formId:"queryForm"});
    });
    
    function myccc(){
        mergeCells("listTable",1,1,1);
    }
    
    //自定义操作栏内容
    function myOperate(po,i){
        var html = "&nbsp;";
        <%
        if(hr_right1||hr_right2||hr_right3||hr_right4||hr_right5||hr_right6 ||hr_right_wh ){
        %>
            html =  '<img border="0"  style="cursor:pointer" src="<%=rootPath%>/images/modi.gif" title="修改" onclick="openWin({url:\'<%=rootPath%>/employee!incumbent_modify.action?empId='+po.empId+'&verifyCode='+po.verifyCode+'\',isFull:true,winName:\'modifyUser\'});" >';
            <%
            if (hr_right_wh){
            %>
                html +=  '<img width="13" height="13" src="<%=rootPath%>/images/del.gif" title="删除" onclick="ajaxDelete(\'${ctx}/employee!incumbent_set_history.action?empId='+po.empId+'\',this);" style="cursor:pointer"/>';
                if(po.userAccounts!="" && po.userIsActive == "1" ) {
                    html += '<img width="12" height="13" src="<%=rootPath%>/images/stop.gif" title="禁用" onClick="javascript:forbid(\''+po.empId+'\');" style="cursor:pointer"/>';    
                }else if(po.userAccounts!="" && po.userIsActive == "0") {
                    html += '<img  src="<%=rootPath%>/images/finsh.gif" title="恢复" onClick="javascript:regain(\''+po.empId+'\');" style="cursor:pointer"/>';
                }
            <%
            }
            %>
        <%
        }
        %>
        return html;
    }

    //自定义查看栏内容
    function show(po,i){
        //alert("empLeaderId:"+po.empLeaderId);
        var curcolor = "black" ;
        //有OA帐号
        if (po.userAccounts!='')  {
            curcolor = "black" ;
            //有OA帐号但被禁用的用户以灰色显示
            if (po.userIsActive=='0')  {
                curcolor = "gray";
            }
        }else {
            //没有OA帐号
            curcolor = "green";
        }
        var html =  '<a   href="javascript:void(0)" onclick="openWin({url:\'${ctx}/employee!incumbent_view.action?hasRight=true&empId='+po.empId+'&verifyCode='+po.verifyCode+'&empLeaderId='+po.empLeaderId+'\',isFull:true,winName:\'showUser\'});">'+po.empName+'</a>';
        return html;
    }


    //*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

    function sex(po,i){
        var html ;
        if(po.empSex=='0'){
            html = "男";
        }else if(po.empSex=='1'){
            html = "女";
        }else{
            html = "&nbsp;";
        }
        return html;
    }
    
    function downloadTemplate(){
        location.href="<%=rootPath%>/public/download/download.jsp?verifyCode=<%=dlcode%>&FileName=hrm_import_template.xls&name=人事管理_在职员工_导入模板.xls&path=peopleinfo";
    }
    
    function excelImport2(){
        // excelImport({importer:"<%=rootPath%>/modules/hrm/hr/employee/hrm_import_save.jsp"});
        excelImport({importer:"<%=rootPath%>/hrImport!excelImport.action"});
    }
    
    //批量加入历史库
    function batchDel(){
        ajaxBatchOperate({url:"employee!incumbent_set_history.action",checkbox_name:"empId",attr_name:"empId",tip:"批量加入历史库",formId:"queryForm"});
    }
    
    //批量恢复
    function batchResume(){
        ajaxBatchOperate({url:"employee!incumbent_set_resume.action",checkbox_name:"empId",attr_name:"empId",tip:"批量恢复",formId:"queryForm"});
    }
    
    //禁用
    function forbid(id){
        ajaxOperate({urlWithData:"employee!incumbent_set_forbid.action?empId="+id,tip:"禁用",formId:"queryForm"});
    }
    
    //恢复
    function regain(id){
        ajaxOperate({urlWithData:"employee!incumbent_set_regain.action?empId="+id,tip:"恢复",formId:"queryForm"});
    }
    
    // 导出
    function excelExport() {
        commonExportExcel({formId:'queryForm', action:'employee!incumbent_list_export.action'});
    }
    
    // 选中导出
    function excelExport_checked() {
		var ids = getCheckBoxData4J({rangeId:'itemContainer',checkbox_name:'empId',attr_name:'empId'});
		if(ids == ''){
			$.dialog.alert(comm.whir_notselect,function(){});
		} else {
			commonExportExcel({formId:'queryForm', action:'employee!incumbent_list_export.action?checkedIds=' + ids});
		}
    }

    function trStyle(po,i){
        var curcolor = "black" ;
        //有OA帐号
        if (po.userAccounts!='')  {
            curcolor = "black" ;
            //有OA帐号但被禁用的用户以灰色显示
            if (po.userIsActive=='0')  {
                curcolor = "gray";
            }
        }else {
            //没有OA帐号
            curcolor = "green";
        }
        return 'style="color:'+curcolor+'"';
    }
    
   </script>

</html>

