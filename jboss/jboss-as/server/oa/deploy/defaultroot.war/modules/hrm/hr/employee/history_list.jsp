<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.org.manager.bd.ManagerBD" %>
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
%>
<body class="MainFrameBox">
    <s:form name="queryForm" id="queryForm" action="${ctx}/employee!history_list_data.action" method="post" >

    <!-- SEARCH PART START -->
    <%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar" id="searchTable">  
        <tr>
            <td class="whir_td_searchtitle">组织：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="queryOrgName" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">姓名：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="queryEmpName" size="14" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">身份：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="queryDignity" size="16" cssClass="inputText" />
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle">年龄：</td>
            <td class="whir_td_searchinput">
                <s:textfield  name="queryAgeFrom" cssClass="inputText" cssStyle="width:50px;" whir-options="vtype:['p_integer']"/> 至 <s:textfield  whir-options="vtype:['p_integer']" name="queryAgeTo" cssStyle="width:50px;" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">入职日期：</td>
            <td class="whir_td_searchinput">
                <s:textfield name="queryEntryDateB" id="queryEntryDateB" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd', readOnly:true, maxDate:'#F{$dp.$D(\\'queryEntryDateE\\')}'})" >  
                    <s:param name="value"><s:date name="queryEntryDateB" format="yyyy-MM-dd"/></s:param>  
                </s:textfield>
                至 
                <s:textfield name="queryEntryDateE" id="queryEntryDateE" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd', readOnly:true, minDate:'#F{$dp.$D(\\'queryEntryDateB\\')}'})" >  
                    <s:param name="value"><s:date name="queryEntryDateE" format="yyyy-MM-dd"/></s:param>  
                </s:textfield>
            </td>
            <td class="whir_td_searchtitle">离职日期：</td>
            <td class="whir_td_searchinput">
                <s:textfield name="queryLeaveDateB" id="queryLeaveDateB" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd', readOnly:true, maxDate:'#F{$dp.$D(\\'queryLeaveDateE\\')}'})" >  
                    <s:param name="value"><s:date name="queryLeaveDateB" format="yyyy-MM-dd"/></s:param>  
                </s:textfield>
                至 
                <s:textfield name="queryLeaveDateE" id="queryLeaveDateE" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd', readOnly:true, minDate:'#F{$dp.$D(\\'queryLeaveDateB\\')}'})" >  
                    <s:param name="value"><s:date name="queryLeaveDateE" format="yyyy-MM-dd"/></s:param>  
                </s:textfield>
            </td>
        </tr>
        <tr>
            <td colspan="6" class="SearchBar_toolbar">
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
                    if (hr_right_wh) {
                %>
                    <input type="button" class="btnButton4font" onClick="batchResume();" value="批量恢复" />
                <%}%>
                    <input type="button" class="btnButton4font" onClick="excelExport();" value='<s:text name="comm.export" />' />
            </td>
        </tr>
    </table>
    <!-- MIDDLE    BUTTONS    END -->

    <!-- LIST TITLE PART START -->    
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
        <thead id="headerContainer">
        <tr class="listTableHead">
            <td whir-options="field:'empId',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('empId',this.checked);" ></td>
            <td whir-options="field:'orgNameString',width:'30%'">组织</td> 
            <td whir-options="field:'empName',width:'10%',allowSort:true,renderer:show">姓名</td> 
            <td whir-options="field:'empSex', width:'5%',renderer:sex">性别</td> 
            <td whir-options="field:'empBirth', width:'10%',renderer:common_DateFormat">出生日期</td> 
            <td whir-options="field:'empNation',width:'5%'">民族</td> 
            <td whir-options="field:'empStudyExperience',width:'10%'">学历</td> 
            <td whir-options="field:'intoCompanyDate',width:'10%',renderer:common_DateFormat">入职日期</td> 
            <td whir-options="field:'lizhiDate',width:'10%',renderer:common_DateFormat">离职日期</td> 
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

    </s:form>
</body>


    <script type="text/javascript">
    
    //*************************************下面的函数属于公共的或半自定义的*************************************************//

    //初始化列表页form表单,"queryForm"是表单id，可修改。
    $(document).ready(function(){        
        initListFormToAjax({formId:"queryForm"});    
    });
    
    //自定义操作栏内容
    function myOperate(po,i){
         var html = "&nbsp;";
         <%    if (hr_right_wh){%>
                    html = '<img  src="<%=rootPath%>/images/quash.gif" title="恢复" onClick="javascript:rehis(\''+po.empId+'\');" style="cursor:pointer"/>';
         <%}%>
         return html;
    }

    //自定义查看栏内容
    function show(po,i){
        var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/employee!incumbent_view.action?hasRight=true&empId='+po.empId+'&verifyCode='+po.verifyCode+'\',isFull:true,winName:\'showUser\'});">'+po.empName+'</a>';
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
    
    //批量恢复
    function batchResume(){
        ajaxBatchOperate({url:"employee!history_set_incumbent_batch.action",checkbox_name:"empId",attr_name:"empId",tip:"批量恢复",formId:"queryForm"});
    }
    
    //恢复
    function rehis(id){
        //var r = ajaxForSync("<%=rootPath%>/modules/hrm/hr/employee/ajax_checkUserNum.jsp?add=0&empId="+id,"");
        //alert(r);
        //if(r.indexOf('授权用户数')!=-1){
        //    $.dialog.alert(r,function(){});
        //}else{
            ajaxOperate({urlWithData:"employee!history_set_incumbent.action?empId="+id,tip:"恢复",formId:"queryForm"});
        //}
    }
    
    function excelExport(){
        commonExportExcel({formId:'queryForm', action:'employee!export_history.action'});
    }
    
   </script>

</html>

