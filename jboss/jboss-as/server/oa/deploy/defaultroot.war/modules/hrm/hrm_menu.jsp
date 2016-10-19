<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.booksmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.workflow.vo.*" %>
<%@ page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD" %>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD" %>
<%@ page import="com.whir.ezoffice.officemanager.bd.EmployeeBD" %>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader ("Expires", 0);   

String userId = session.getAttribute("userId").toString();
String domainId = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
CustomerMenuDB cmdb=new CustomerMenuDB();
String codes=",personnelManagement_humanresouce,personnelManagement_cardmanager,personnelManagement_examination,personnelManagement_wageManager,personnelManagement_sbgjj,personnelManagement_performanceManager,personnelManagement_kqgl,";
String canShowMenus=cmdb.getShowMenu(codes,domainId);

ManagerBD managerBD = new ManagerBD();
//人事信息-人事信息 维护
boolean hr_right_wh = managerBD.hasRight(userId, "07*01*03");
//人事信息-人事信息 查看
boolean hr_right_ck = managerBD.hasRight(userId, "07*01*01");
int menuIndex=0;   
//此处公共业务逻辑   
%>  
<%if(canShowMenus.indexOf("personnelManagement_humanresouce")>=0){
	int cardManagerId = 0;
	//判断当前用户有无人事信息--职称职务的维护权限
	String standupfor = "";
	if(managerBD.hasRightTypeName(userId, "人事管理-设置", "维护")){
		standupfor="1";
	}
	//判断当前用户有无人事信息--人事信息查看、新增或维护中的任一权限
	String  peopleinfo ="";
	if(managerBD.hasRightType(userId, "人事管理-人事信息")){
		peopleinfo="1";
	}
%>
            <SCRIPT type="text/javascript">     
                var zNodes =[   
                	{ id:1, pId:-1, name:"人事管理",open:true,iconSkin:"fa fa-cog fa"}   
                	<% 
						if(!session.getAttribute("userAccount").toString().toLowerCase().equals("admin")&&!session.getAttribute("userAccount").toString().toLowerCase().equals("security")){
					%>
	                    ,{ id:1000000000, pId:1, name:"我的卡片", url:"<%=rootPath%>/employee!incumbent_view.action?access=incumbent_mycard&hasRight=true", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:2000000000, pId:1, name:"我的资产", url:"<%=rootPath%>/assetInfo!assetInfoMyList.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:3000000000, pId:1, name:"我的考勤", url:"<%=rootPath%>/kqrecord!kqrecord_list.action?empId=<%=userId%>", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:4000000000, pId:1, name:"我的自助", url:"", target:'mainFrame',iconSkin:"fa fa"} 
	                       ,{ id:4100000000, pId:4000000000, name:"我的假期情况", url:"<%=rootPath%>/kqworkflow!myleavestatus_list.action", target:'mainFrame',iconSkin:"fa fa"}     
	                       ,{ id:4200000000, pId:4000000000, name:"我的请假", url:"<%=rootPath%>/kqworkflow!myleave_list.action?empId=<%=userId%>", target:'mainFrame',iconSkin:"fa fa"}     
	                       ,{ id:4300000000, pId:4000000000, name:"我的销假", url:"<%=rootPath%>/kqworkflow!mycancelleave_list.action?empId=<%=userId%>", target:'mainFrame',iconSkin:"fa fa"}     
	                       ,{ id:4400000000, pId:4000000000, name:"我的出差", url:"<%=rootPath%>/kqworkflow!mytravel_list.action?empId=<%=userId%>", target:'mainFrame',iconSkin:"fa fa"}     
	                       ,{ id:4500000000, pId:4000000000, name:"我的加班", url:"<%=rootPath%>/kqworkflow!myovertime_list.action?empId=<%=userId%>", target:'mainFrame',iconSkin:"fa fa"}     
	                       ,{ id:4600000000, pId:4000000000, name:"我的调休", url:"<%=rootPath%>/kqworkflow!mypaidleave_list.action?empId=<%=userId%>", target:'mainFrame',iconSkin:"fa fa"}     
	                    <%
							}
						%>
	                    ,{ id:5000000000, pId:1, name:"我的工资", url:"<%=rootPath%>/hrmgzjl!hrmgzjl_list_my.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:6000000000, pId:1, name:"我的下属", url:"<%=rootPath%>/employee!underling_emp_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%if (peopleinfo.equals("1")) {%>
	                    ,{ id:7000000000, pId:1, name:"组织结构", url:"<%=rootPath%>/hrmorgstructure!orgstructure.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%}%>
	                    <%if (hr_right_wh || hr_right_ck) {%>
	                    ,{ id:8000000000, pId:1, name:"人事信息",iconSkin:"fa fa"}   
	                    	,{ id:8100000000, pId:8000000000, name:"在职员工", url:"<%=rootPath%>/employee!incumbent_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    <%}%>
	                    	<%if (peopleinfo.equals("1")) {%>
	                    	,{ id:8200000000, pId:8000000000, name:"历史员工", url:"<%=rootPath%>/employee!history_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	<%if(managerBD.hasRight(userId, "HR*07*09")||managerBD.hasRight(userId, "HR*07*10")){ %>
	                    	,{ id:8300000000, pId:8000000000, name:"党员信息", url:"<%=rootPath%>/partyinfo!partymember_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:8400000000, pId:8000000000, name:"转出党员", url:"<%=rootPath%>/partyinfo!partymember_turnout_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	<%}%>
	                    	,{ id:8500000000, pId:8000000000, name:"人事调整", url:"<%=rootPath%>/empchange!list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:8600000000, pId:8000000000, name:"合同到期员工", url:"<%=rootPath%>/employee!expirationofcontract_emp_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:8700000000, pId:8000000000, name:"生日到达员工", url:"<%=rootPath%>/employee!birthdaycoming_emp_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:8800000000, pId:8000000000, name:"居住证到期员工", url:"<%=rootPath%>/employee!residencedueto_emp_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:8900000000, pId:8000000000, name:"试用期到达员工", url:"<%=rootPath%>/employee!probationdueto_emp_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                   		<%}%>
	                   	<%if(managerBD.hasRightType(userId, "人事管理-培训记录")){ %>
	                    ,{ id:9000000000, pId:1, name:"培训记录", url:"<%=rootPath%>/train!record_list.action", target:'mainFrame',iconSkin:"fa fa"} 
	                    <%}%>
						<%if(managerBD.hasRightType(userId, "人事管理-奖惩记录")){ %>  
	                    ,{ id:1100000000, pId:1, name:"奖惩记录", url:"<%=rootPath%>/hortationpunish!record_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%}%>
	                    <%if(managerBD.hasRightType(userId, "人事管理-考勤记录")){ %>
	                    ,{ id:1200000000, pId:1, name:"考勤记录", url:"<%=rootPath%>/hrempattend!hrempattend_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%}%>
	                    <%if(managerBD.hasRightType(userId, "人事管理-绩效考核")){ %>
	                    ,{ id:1300000000, pId:1, name:"绩效考核", url:"<%=rootPath%>/performancecheck!pfcheck_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%}%>
	                    <%if(managerBD.hasRightType(userId, "人事管理-工伤")){ %>
	                    ,{ id:1400000000, pId:1, name:"工伤", url:"<%=rootPath%>/empcompo!record_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%}%>
	                    <%if(managerBD.hasRightType(userId, "人事管理-居住证办理")){ %>
	                    ,{ id:1500000000, pId:1, name:"居住证办理", url:"<%=rootPath%>/inhabitancy!record_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%}%>
	                    <%if(managerBD.hasRightType(userId, "人事管理-社保")){ %>
	                    ,{ id:1600000000, pId:1, name:"社保及公积金缴纳", url:"<%=rootPath%>/socialinsurance!record_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    <%}%>
	                    <%if(managerBD.hasRightType(userId, "人事管理-统计报表")){ %>
	                    ,{ id:1700000000, pId:1, name:"统计报表", url:"", target:'mainFrame',iconSkin:"fa fa"} 
	                    	,{ id:1710000000, pId:1700000000, name:"默认格式报表", url:"<%=rootPath%>/hrmempstatistics!empstatistics.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1720000000, pId:1700000000, name:"自定义报表", url:"<%=rootPath%>/hrmcustomizereport!customize_query.action", target:'mainFrame',iconSkin:"fa fa"}  
                    <%}%>
                    <%if (standupfor.equals("1")) {%>
	                    ,{ id:1800000000, pId:1, name:"设置", url:"", target:'mainFrame',iconSkin:"fa fa"}   
	                    	,{ id:1810000000, pId:1800000000, name:"自定义字段", url:"", target:'mainFrame',iconSkin:"fa fa"}  
	                    		,{ id:1811000000, pId:1810000000, name:"详细信息", url:"<%=rootPath%>/hrextension!filed_list.action?module=hrm&type=1", target:'mainFrame',iconSkin:"fa fa"} 
	                    		,{ id:1812000000, pId:1810000000, name:"工作信息", url:"<%=rootPath%>/hrextension!filed_list.action?module=hrm&type=2", target:'mainFrame',iconSkin:"fa fa"} 
	                    	,{ id:1820000000, pId:1800000000, name:"单位设置", url:"<%=rootPath%>/unitsetting!unit_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1830000000, pId:1800000000, name:"部门性质设置", url:"<%=rootPath%>/deptkindsetting!deptkind_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1840000000, pId:1800000000, name:"党组设置", url:"<%=rootPath%>/partysetting!party_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1850000000, pId:1800000000, name:"职务设置", url:"<%=rootPath%>/dutysetting!duty_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1860000000, pId:1800000000, name:"岗位设置", url:"<%=rootPath%>/stationsetting!station_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1870000000, pId:1800000000, name:"职称设置", url:"<%=rootPath%>/personalpositionsetting!position_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1880000000, pId:1800000000, name:"人事调整类型设置", url:"<%=rootPath%>/empchangesetting!empchangetype_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1890000000, pId:1800000000, name:"课程分类设置", url:"<%=rootPath%>/trainclasssetting!trainclass_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1811000000, pId:1800000000, name:"培训数据字典", url:"<%=rootPath%>/sysdictsetting!sysdict_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1812000000, pId:1800000000, name:"奖惩种类设置", url:"<%=rootPath%>/hortationpunishsetting!hortationpunish_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1813000000, pId:1800000000, name:"办公地点设置", url:"<%=rootPath%>/workaddress!workAddress_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1814000000, pId:1800000000, name:"人员性质设置", url:"<%=rootPath%>/personalkindsetting!kind_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1815000000, pId:1800000000, name:"人员类别设置", url:"<%=rootPath%>/persontypesetting!type_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1816000000, pId:1800000000, name:"合同类型设置", url:"<%=rootPath%>/empcontractsetting!type_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1817000000, pId:1800000000, name:"到期提醒设置", url:"<%=rootPath%>/remindsetting!remind_modify.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:1818000000, pId:1800000000, name:"合同模板设置", url:"<%=rootPath%>/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=yes&moduleType=hrm", target:'_blank',iconSkin:"fa fa"}  
	                    	,{ id:1819000000, pId:1800000000, name:"标签设置", url:"<%=rootPath%>/public/iWebOfficeSign/BookMark/BookMarkList.jsp?haveRight=yes&moduleType=hrm", target:'_blank',iconSkin:"fa fa"}
	                    <%}%>
                    <%}%>
                    <%
						//考勤管理-维护
						boolean hr_kq_right1 = managerBD.hasRight(userId, "KQ*01*01");
						//考勤管理-设置
						boolean hr_kq_right2 = managerBD.hasRight(userId, "KQ*01*02");
						if(canShowMenus.indexOf("personnelManagement_kqgl")>=0 && (hr_kq_right1 || hr_kq_right2)){
					%>
						,{ id:2, pId:-1, name:"考勤管理",iconSkin:"fa fa-cog fa"} 
						<%if(hr_kq_right1){%>
	                    ,{ id:1900000000, pId:2, name:"考勤数据导入", url:"<%=rootPath%>/kqrecordimp!kqrecordimp_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:2100000000, pId:2, name:"考勤记录", url:"<%=rootPath%>/kqrecord!kqrecord_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:2200000000, pId:2, name:"考勤统计", url:"", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:2210000000, pId:2200000000, name:"查看", url:"<%=rootPath%>/kqrecord!kqrecord_statistics_query.action", target:'mainFrame',iconSkin:"fa fa"} 
	                    	,{ id:2220000000, pId:2200000000, name:"导入", url:"<%=rootPath%>/kqimp!kqrecordimp_list.action", target:'mainFrame',iconSkin:"fa fa"}  
	                    <%}%>
       					<%if(hr_kq_right2){%>
	                    ,{ id:2300000000, pId:2, name:"设置", url:"", target:'mainFrame',iconSkin:"fa fa"} 
	                    	,{ id:2310000000, pId:2300000000, name:"考勤人员", url:"<%=rootPath%>/kquser!kquser_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:2320000000, pId:2300000000, name:"特殊考勤", url:"<%=rootPath%>/kqspeuser!kqspeuser_list.action", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:4330000000, pId:2300000000, name:"请假类别", url:"<%=rootPath%>/kqleavetype!kqleavetype_list.action", target:'mainFrame',iconSkin:"fa fa"}
							,{ id:2340000000, pId:2300000000, name:"冲销时限", url:"<%=rootPath%>/kqrecordimp!setpaidleave.action", target:'mainFrame',iconSkin:"fa fa"}
	                    <%}%>
                   	<%}%>
                   	<%
						if(canShowMenus.indexOf("personnelManagement_sbgjj")>=0){
						if(managerBD.hasRight(userId,"HR*09*01")){
					%>
						,{ id:3, pId:-1, name:"社保及公积金管理",iconSkin:"fa fa-cog fa"}
						,{ id:2400000000, pId:3, name:"比例设置", url:"<%=rootPath%>/hrmratiosetting!hrmratiosetting_list.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:2500000000, pId:3, name:"变更记录", url:"<%=rootPath%>/hrmchangerecord!hrmchangerecord_query.action", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:2600000000, pId:3, name:"社保、公积金台帐", url:"<%=rootPath%>/hrmsbgjjtz!hrmsbgjjtz_query.action", target:'mainFrame',iconSkin:"fa fa"}
	                    <%}%>
                    <%}%>
                    <%
						if(canShowMenus.indexOf("personnelManagement_wageManager")>=0){
							boolean hrm_salary_1 = managerBD.hasRight(userId,"HR*10*01");//新增
							boolean hrm_salary_2 = managerBD.hasRight(userId,"HR*10*02");//维护
							if(hrm_salary_1||managerBD.hasRight(userId,"HR*10*02")){
					%>
					,{ id:4, pId:-1, name:"薪资管理",iconSkin:"fa fa-cog fa"}
					<%if(hrm_salary_1){%>
                    ,{ id:2700000000, pId:4, name:"工资记录", url:"<%=rootPath%>/hrmgzjl!hrmgzjl_list.action", target:'mainFrame',iconSkin:"fa fa"}   
                    <%}%>
					<%if(hrm_salary_2){%>
                    ,{ id:2800000000, pId:4, name:"工资项目设置", url:"<%=rootPath%>/hrmgzxm!hrmgzxm_list.action", target:'mainFrame',iconSkin:"fa fa"}   
                    ,{ id:2900000000, pId:4, name:"工资设置", url:"", target:'mainFrame',iconSkin:"fa fa"}  
                    	,{ id:2910000000, pId:2900000000, name:"工资档级设置",  url:"<%=rootPath%>/hrmgzdj!hrmgzdj_list.action", target:'mainFrame',iconSkin:"fa fa"} 
                    	,{ id:2920000000, pId:2900000000, name:"工资标准设置",  url:"<%=rootPath%>/hrmgzbz!hrmgzbz_list.action", target:'mainFrame',iconSkin:"fa fa"}  
                    	,{ id:2930000000, pId:2900000000, name:"个人所得税设置", url:"<%=rootPath%>/hrmincometaxratio!hrmincometaxratio_add.action", target:'mainFrame',iconSkin:"fa fa"}  
                    	,{ id:2940000000, pId:2900000000, name:"发放方式设置",  url:"<%=rootPath%>/hrmfffs!hrmfffs_add.action", target:'mainFrame',iconSkin:"fa fa"}  
                    <%}%>
                    <%if(hrm_salary_1){%>
                    ,{ id:3100000000, pId:4, name:"工资台帐", url:"<%=rootPath%>/hrmgzjl!hrmgzjl_tz_query.action", target:'mainFrame',iconSkin:"fa fa"}
                   	<%}%>
                   	<%}%>
					<%}%>
					<%
						if(canShowMenus.indexOf("personnelManagement_cardmanager")>=0){
							String cardManager  = managerBD.hasRightType(userId,"贺卡管理")?"1":"" ;
							if("1".equals(cardManager)) {
				    %>
				    ,{ id:5, pId:-1, name:"贺卡管理",iconSkin:"fa fa-cog fa"}
				    <%
					  String festivalRight = managerBD.hasRightType(userId,"贺卡管理")?"1":"" ;
					  if("1".equals(festivalRight)) {  
					%>
                    ,{ id:3200000000, pId:5, name:"节日贺卡", url:"<%=rootPath%>/hrmfestalcard!festivalcard_list.action", target:'mainFrame',iconSkin:"fa fa"}  
                    <%}
					  String birthdayRight = managerBD.hasRightType(userId,"贺卡管理")?"1":"" ;
					  if("1".equals(birthdayRight)) {
		            %> 
                    ,{ id:3300000000, pId:5, name:"生日贺卡", url:"<%=rootPath%>/hrmbirthcard!birthdaycard_list.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
					<%}%>
					<%}%>
					<%
						if(canShowMenus.indexOf("personnelManagement_examination")>=0){
					%>
					,{ id:6, pId:-1, name:"培训管理",iconSkin:"fa fa-cog fa"}
					,{ id:3400000000, pId:6, name:"员工自测", url:"", target:'mainFrame',iconSkin:"fa fa"}  
                    	,{ id:3410000000, pId:3400000000, name:"员工自测", url:"<%=rootPath%>/hrmexamselftest!hrmexamselftest_add.action", target:'mainFrame',iconSkin:"fa fa"} 
                    	<% if(managerBD.hasRight(session.getAttribute("userId").toString(), "07*40*01")){%>
                    	,{ id:3420000000, pId:3400000000, name:"记录查询", url:"<%=rootPath%>/hrmexamselftest!hrmexamselftest_list.action", target:'mainFrame',iconSkin:"fa fa"} 
                    	<%}%>
                    ,{ id:3500000000, pId:6, name:"我的试卷", url:"<%=rootPath%>/hrmexammy!hrmexammy_list.action", target:'mainFrame',iconSkin:"fa fa"}   
                    <% if(managerBD.hasRight(session.getAttribute("userId").toString(), "07*40*02")){%>
                    ,{ id:3600000000, pId:6, name:"考卷管理", url:"", target:'mainFrame',iconSkin:"fa fa"}  
                    	,{ id:3610000000, pId:3600000000, name:"考卷制作", url:"<%=rootPath%>/hrmexammanage!hrmexammanage_list.action?page=create", target:'mainFrame',iconSkin:"fa fa"} 
                    	,{ id:3620000000, pId:3600000000, name:"答卷管理", url:"<%=rootPath%>/hrmexammanage!hrmexammanage_list.action?page=manage", target:'mainFrame',iconSkin:"fa fa"}  
                    ,{ id:3700000000, pId:6, name:"试题库管理", url:"", target:'mainFrame',iconSkin:"fa fa"} 
                    	,{ id:3710000000, pId:3700000000, name:"考试题库", url:"<%=rootPath%>/hrmexamstock!hrmexamstock_list.action?sign=1", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:3720000000, pId:3700000000, name:"自测题库", url:"<%=rootPath%>/hrmexamstock!hrmexamstock_list.action?sign=0", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:3730000000, pId:3700000000, name:"分类管理", url:"<%=rootPath%>/hrmexamtype!hrmexamtype_list.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
                    <%}%>  
                    <%
			          	String menutype = "personnelManagement";
			        %>
			        <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
                ];   
            
                $(document).ready(function(){     
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);     
                });     
            </SCRIPT>     
<div class="wh-l-msg">
	<a href="javascript:void(0)" class="clearfix" style="cursor:default">
		<i class="fa fa-cog fa-color fa-user"></i>
		<span>
			人事
		</span>
	</a>
</div>
<div class="wh-l-con">
    <ul id="treeDemo" class="ztree"></ul>
</div>

<SCRIPT LANGUAGE="JavaScript">  
<!--   
$(function() {   
   OpenCloseSubMenu(0);   
});   
//-->  
</SCRIPT>  