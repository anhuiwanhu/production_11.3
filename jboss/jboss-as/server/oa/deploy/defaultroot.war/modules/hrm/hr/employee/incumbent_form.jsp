<%@ page import="com.whir.org.manager.bd.*"%>
<%
//中进汽贸项目-true
//产品-false
boolean zjqmFlag = false;

response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

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

//人事管理-奖惩记录 维护
boolean hr_right7 = managerBD.hasRight(userId, "07*33*02");
//人事管理-培训记录 维护
boolean hr_right8 = managerBD.hasRight(userId, "07*32*02");
//人事管理-社保 维护
boolean hr_right9 = managerBD.hasRight(userId, "07*55*04");
//人事管理-工伤 维护
boolean hr_right10 = managerBD.hasRight(userId, "07*55*02");


String range = request.getAttribute("managerScope")==null?"":request.getAttribute("managerScope").toString();
String orgId = request.getAttribute("orgId")==null?"":request.getAttribute("orgId").toString();
String orgName = request.getAttribute("orgName")==null?"":request.getAttribute("orgName").toString();
String empId = request.getParameter("empId")!=null?request.getParameter("empId"):"";
String oldEmpPosition = request.getAttribute("oldEmpPosition")==null?"":request.getAttribute("oldEmpPosition").toString();
String pastOrgId = request.getAttribute("pastOrgId")==null?"":request.getAttribute("pastOrgId").toString();
String pastSidelineOrg = request.getAttribute("pastSidelineOrg")==null?"":request.getAttribute("pastSidelineOrg").toString();
%>
<script language="javascript">

function changePanle(flag){
	$(".tag_aon").removeClass("tag_aon");
	$("#Panle"+flag).addClass("tag_aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();
    var empId = $("#empId").val();
	if(flag == 1){
		$("#edusty").attr("src","<%=rootPath%>/empedusty!edusty_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#familymember").attr("src","<%=rootPath%>/familymember!member_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#emergencycontact").attr("src","<%=rootPath%>/emergencycontact!contact_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		
		//alert($("#docinfo1 iframe").length);
		$("#docinfo1 iframe").each(function(){
			$(this).attr("src",$(this).attr("src"));
		});
		
	}else if(flag == 2){
		$("#contract").attr("src","<%=rootPath%>/empcontract!contract_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#work").attr("src","<%=rootPath%>/empwork!work_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#rzxx").attr("src","<%=rootPath%>/rzxx!rzxx_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#trainhistory").attr("src","<%=rootPath%>/trainhistory!history_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#competence").attr("src","<%=rootPath%>/empcompetence!competence_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#rzzg").attr("src","<%=rootPath%>/jobqualification!jobq_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#zyzg").attr("src","<%=rootPath%>/vocationqulification!vocationq_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		
	}else if(flag == 3){
     	$("#trainRecord").attr("src","<%=rootPath%>/train!card_record_list.action?empID="+empId+"&canAdd=1&date="+new Date());
	}else if(flag == 4){
     	$("#hpRecord").attr("src","<%=rootPath%>/hortationpunish!card_record_list.action?empID="+empId+"&canAdd=1&date="+new Date());
	}else if(flag == 5){
		$("#PerformanceCheck").attr("src","<%=rootPath%>/performancecheck!card_record_list.action?empID="+empId+"&canAdd=1&date="+new Date());
	}else if(flag == 6){
		$("#EmpInhabitancy").attr("src","<%=rootPath%>/inhabitancy!card_record_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#EmpSocialinsurance").attr("src","<%=rootPath%>/socialinsurance!card_record_list.action?empID="+empId+"&canAdd=1&date="+new Date());
		$("#EmpCompo").attr("src","<%=rootPath%>/empcompo!card_record_list.action?empID="+empId+"&canAdd=1&date="+new Date());
	}else if(flag == 7){
	}else if(flag == 8){
	}else{
		//whir_uploader_reset(up_uniqueId1);
		whir_uploader_reset("uniqueId1");
	}
}

function MyImage(Img){
	var image=new Image();
	image.src=Img.src;
	width=document.body.clientWidth/2-120;//预先设置的所期望的宽的值
	height=330;//预先设置的所期望的高的值
	if(image.width>width||image.height>height){//现有图片只有宽或高超了预设值就进行js控制
		w=image.width/width;
		h=image.height/height;
		if(w>h){//比值比较大==>宽比高大
			//定下宽度为width的宽度
			Img.width=width;
			//以下为计算高度
			Img.height=image.height/w;
		}else{//高比宽大
			//定下宽度为height高度
			Img.height=height;
			//以下为计算高度
			Img.width=image.width/h;
		}
	}else{
 		Img.height = image.height;
 		Img.width = image.width;
	}
}

function showGzgwinfo(obj){
	var val = obj.value;
	var r = ajaxForSync("<%=rootPath%>/modules/hrm/salary/gzbz/getGzgwinfo_httprequest.jsp?gzxs="+val,"");
	eval(r);
	getBtbz(null);
	
}

function getBtbz(obj){
	var orgId = $("#orgId").val();
	var salary_gz_gwjb_id = $("#salary_gz_gwjb_id").val();
	var response = ajaxForSync("<%=rootPath%>/modules/hrm/salary/gzbz/getBtbzNew_httprequest.jsp?orgId="+orgId+"&gwjbId="+salary_gz_gwjb_id,"");
	var s = response.replace(/\r|\n/igm,'');
	var arr = s.split('$');
	var bonusStandardId = document.getElementsByName("bonusStandardId");
	for(var i=0; i<bonusStandardId.length; i++){
		document.getElementsByName("bonusStandard")[i].value="";
	}
	for(var i=0; i<bonusStandardId.length; i++){
		var val = bonusStandardId[i].value;
		for(var j=0; j<arr.length; j++){
			var mm = arr[j].split('|');
			if(mm[0]==val){
				document.getElementsByName("bonusStandard")[i].value=mm[1];
				computeYearZj(i);
				break;
			}
		}
	}
}

function computeYearZj(i){
	var bonusStandard = document.getElementsByName("bonusStandard")[i].value;
	if(bonusStandard.replace(/ /gm,'')=='')bonusStandard=0;
	var ffMonths = document.getElementsByName("ffMonths")[i].value;
	if(ffMonths.replace(/ /gm,'')=='')ffMonths=0;
	var yearZj = parseFloat(bonusStandard)*parseFloat(ffMonths);
	document.getElementsByName("yearZj")[i].value = yearZj.toFixed(2);
}

function selectWorkAddress(){
	var addressId = $("#addressId").val();
	var workAddressName = $("#workAddressName").val();
	popup({content:"url:<%=rootPath%>/workaddress!workAddress_list_select.action",width:800,height:500,title:"选择办公地点"});
}
function selectWorkAddress1(){
	var workAddress = $("#workAddress").val();
	var workAddressName = $("#workAddressName").val();
	popup({content:"url:<%=rootPath%>/workaddress!workAddress_list_selectSingle.action",width:800,height:500,title:"选择办公地点"});
}

var _______chargeLeaderIds="";
var _______chargeLeaderNames="";
var _______deptLeaderIds="";
var _______deptLeaderNames="";
var _______empLeaderId="";
var _______empLeaderName="";
var _______orgIds="<%=orgId%>";

function setOrgId(orgId){
	_______orgIds = orgId;
}

function fillLeader(){
	var tmp_orgIds = $("#orgId").val();
	if(tmp_orgIds==''){
		$("#chargeLeaderIds").val("");
		$("#chargeLeaderNames").val("");
		$("#deptLeaderIds").val("");
		$("#deptLeaderNames").val("");
	}else{
		var chargeLeaderIds__= $("#chargeLeaderIds").val();
		var deptLeaderIds__= $("#deptLeaderIds").val();
		var response = ajaxForSync("<%=rootPath%>/platform/system/system_manager/getLeaders.jsp?orgId="+tmp_orgIds,"");
		var newData = response;
		eval(newData);
		if(_______orgIds!=tmp_orgIds){
			$("#chargeLeaderIds").val(_______chargeLeaderIds);
			$("#chargeLeaderNames").val(_______chargeLeaderNames);
			$("#deptLeaderIds").val(_______deptLeaderIds);
			$("#deptLeaderNames").val(_______deptLeaderNames);
			$("#empLeaderId").val(_______empLeaderId);
			$("#empLeaderName").val(_______empLeaderName);
		}else {
			if($("#chargeLeaderNames").val()==''){
				$("#chargeLeaderIds").val(_______chargeLeaderIds);
				$("#chargeLeaderNames").val(_______chargeLeaderNames);
			}
			if($("#deptLeaderNames").val()==''){
				$("#deptLeaderIds").val(_______deptLeaderIds);
				$("#deptLeaderNames").val(_______deptLeaderNames);
			}
			if($("#empLeaderName").val()==''){
				$("#empLeaderId").val(_______empLeaderId);
				$("#empLeaderName").val(_______empLeaderName);
			}
		}
	}
}


function changeJobStatus(obj){
	if(obj==undefined || obj==null){
		return ;
	}
	if(obj.value=='离职'||obj.value=='内退'||obj.value=='退休'){
		$("#lizhidatespan").show();
	}else{
		$("#lizhidatespan").hide();
		$("#lizhiDate").val("");
	}
}


function getDetpKind(){
	var orgId = $("#orgId").val();
	if(orgId!=''){
		$("#__deptKindId").val(ajaxForSync("<%=rootPath%>/modules/hrm/hr/deptkind/getDeptKind_httprequest.jsp","orgId="+orgId));
	}
}

function getDetpKindAndFillLeader(){
	var orgId = $("#orgId").val();
	if(orgId!=''){
		$("#__deptKindId").val(ajaxForSync("<%=rootPath%>/modules/hrm/hr/deptkind/getDeptKind_httprequest.jsp","orgId="+orgId));
		fillLeader();
	}
	// 
	linkage_changeOrg();
}

// 联动：改变组织
function linkage_changeOrg(){
	var oldOrgId = $("#_orgId").val();
	var newOrgId = $("#orgId").val();
	if(oldOrgId != newOrgId){
		var vUrl = whirRootPath + '/employee!getLinkageData_changeOrg.action';
		vUrl += '?oldOrgId=' + oldOrgId;
		vUrl += '&newOrgId=' + newOrgId;
		ajaxForAsync(vUrl, '', callback_changeOrg)
	}
}
function callback_changeOrg(msg){
	var msg_json = eval("(" + msg + ")");
	// 工作地点
	var waIds = ',' + $('#workAddress').val();
	var waNames = ',' + $('#workAddressName').val();
	
	var oData = msg_json.oldData;
	if(oData){
		var waArr = oData.workAddress;
		if(waArr != undefined) {
			for(var i=0; i<waArr.length; i++){
				waIds = replaceAll(waIds, ','+waArr[i].id+',', ',');
				waNames = replaceAll(waNames, ','+waArr[i].name+',', ',');
			}
		}
	}
	var nData = msg_json.newData;
	if(nData){
		var waArr = nData.workAddress;
		if(waArr != undefined) {
			for(var i=0; i<waArr.length; i++){
				if(waIds.indexOf(',' + waArr[i].id + ',')<0){
					waIds += waArr[i].id + ',';
					waNames += waArr[i].name + ',';
				}
			}
		}
	}
	waIds = waIds.substring(1, waIds.length);
	waNames = waNames.substring(1, waNames.length);
	$('#workAddress').val(waIds);
	$('#workAddressName').val(waNames);
	
	// 
	$("#_orgId").val($("#orgId").val());
}
</script>

<s:hidden name="user.empId" id="empId"/>
<s:hidden name="user.userIsActive" id="userIsActive" />
<s:hidden name="user.userAccounts" id="userAccounts" />
<input type="hidden" value="<s:property value="user.isApplyAccount"/>" id="isApplyAccount"  name="isFirstApplay" />

<input type="hidden" id="sysdate" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date())%>" />

<div class="BodyMargin_10" style="margin-bottom:50px;">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine tablewidth">
    <tr>
        <td>
            <div class="Public_tag">
                <ul>
                	<%if(hr_right1){%>
                    <li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center">基本信息</span><span class="tag_right"></span></li>
                    <li id="Panle1" onClick="changePanle(1);"><span class="tag_center">详细信息</span><span class="tag_right"></span></li>  
                    <%}%>
                    <s:if test="user.empId!=null">
					<%if(hr_right2||hr_right3){%>     
                    <li id="Panle2" onClick="changePanle(2);"><span class="tag_center">工作信息</span><span class="tag_right"></span></li>
                    <%}%>
					<%if(hr_right8){%>
                    <li id="Panle3" onClick="changePanle(3);"><span class="tag_center">培训记录</span><span class="tag_right"></span></li>
                    <%}%>
					<%if(hr_right7){%>
                    <li id="Panle4" onClick="changePanle(4);"><span class="tag_center">奖惩记录</span><span class="tag_right"></span></li>
                    <%}%>
					<%if(hr_right6){%>
                    <li id="Panle5" onClick="changePanle(5);"><span class="tag_center">绩效考核</span><span class="tag_right"></span></li>
                    <%}%>
					<%if(hr_right9||hr_right10){%>
                    <li id="Panle6" onClick="changePanle(6);"><span class="tag_center">居住证办理、社保、工伤</span><span class="tag_right"></span></li>
                    <%}%>
					<%if(hr_right4){%>
                    <li id="Panle7" onClick="changePanle(7);"><span class="tag_center">工资福利标准</span><span class="tag_right"></span></li>
                    <%}%>
					<%if(hr_right5){%>
                    <li id="Panle8" onClick="changePanle(8);"><span class="tag_center">社保标准</span><span class="tag_right"></span></li>   
                    <%}%>     
                    </s:if> 
                </ul>
            </div>
        </td>
    </tr>
</table>
<%
String agent = request.getHeader("user-agent");
%>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="TableLine tablewidth">
    <tr>
        <td valign="top">
            <div id="docinfo0" style="display:none;">
                <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="72" class="td_lefttitle"><strong>基本信息</strong>
                        </td>
                        <td >&nbsp;</td>
                        <td colspan="2" class="td_lefttitle">
                            <s:hidden name="user.empLivingPhoto" id="empLivingPhoto"  />
                            <input type="hidden" name="realFileName"        id="realFileName"    />
                            <div style="width:214px;" id="empLivingPhoto_div">
                            <%if(agent.indexOf("MSIE 6")>=0  ){ %>
                            <div style="float:left;width:120px;margin-top:10px;margin-bottom:-4px;margin-left:0px;">
                            <%}else{ %>
                            <div style="float:left;width:120px;margin-top:5px;margin-bottom:0px;margin-left:5px;">
                            <%} %>
                            <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
							    <jsp:param name="onInit"		 value="init_hrm" />
							    <jsp:param name="onSelect"		 value="" />
							    <jsp:param name="onUploadProgress"		 value="onUploadProgress_hrm" />
							    <jsp:param name="onUploadSuccess"		 value="onUploadSuccess_hrm" />
							    <jsp:param name="accessType"		 value="include" />
							    <jsp:param name="makeYMdir"		 value="no" />
							   
							    <jsp:param name="thumbnail"      value="150x150_small;256x256_detail;420x410_middle" />  
							   
							    <jsp:param name="dir"		 value="peopleinfo" />
							    <jsp:param name="uniqueId"    value="uniqueId1" />
							    <jsp:param name="realFileNameInputId"    value="realFileName" /> 
							    <jsp:param name="saveFileNameInputId"    value="empLivingPhoto" /> 
							    <jsp:param name="canModify"       value="yes" />
							    
							    <jsp:param name="width"		 value="90" />
							    <jsp:param name="height"		 value="20" />
							    <jsp:param name="multi"		 value="false" />
							    <jsp:param name="buttonClass" value="upload_btn" />
							    <jsp:param name="buttonText"		 value="上传照片" />
							    <jsp:param name="fileSizeLimit"		 value="0" />
							    <jsp:param name="fileTypeExts"		 value="*.jpg;*.jpeg;*.gif;*.png" />
							    <jsp:param name="uploadLimit"		 value="0" />
							</jsp:include>
							</div>
                          	<div style="margin-top:-25px;padding-top:3px;float:right;height:19px;width:94px;background:#fff;border:1px solid #808080;text-align:center;cursor:pointer;" onclick="deleteUploadedFile_hrm();">删除照片</div>
                          	</div>
                        </td>
                    </tr>
                    <tr>
                        <td width="80" class="td_lefttitle">员工编号：</td>
                        <td width="58%">
                             <s:textfield name="user.empNumber" id="empNumber" cssClass="inputText" whir-options="vtype:[{'maxLength':10},'spechar3']"  />
                        </td>
                        <td width="45%" height="370" colspan="2" rowspan="18" valign="top" >
                            <div style="height:370px;margin:5px; width:95%;">
                                <div style="border:1px solid #dddddd; padding:14px;">
                                    <div style="height:420px;overflow:hidden;">
                                        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="center" value="middle">
													  <span class="progressbar111" id="uploadprogressbar">
													  	<img  src="<%=rootPath%>/images/loading20.gif" /> 正在上传...
													  </span>
													  <span  id="icon" >
                                                      <img id="ImgShow" name="ImgShow"  src="<%=rootPath%>/images/blank.gif" onload="$('#uploadprogressbar').hide();$(this).parent().show();" />
                                                	  </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="中文名">中文名<span class="MustFillColor">*</span>：</td>
                        <td>
                        	<s:textfield name="user.empName" id="empName" cssClass="inputText"  maxlength="10" whir-options="vtype:['notempty',{'maxLength':10},'spechar3']"  />
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">英文名：</td>
                        <td>
                            <s:textfield name="user.empEnglishName" id="empEnglishName" cssClass="inputText" whir-options="vtype:[{'maxLength':100},'spechar3']"  />
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">曾用名：</td>
                        <td>
                            <s:textfield name="user.formerName" id="formerName" cssClass="inputText" whir-options="vtype:[{'maxLength':20},'spechar3']"  />
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">性别：</td>
                        <td >
                            <div class="radiolist">
                                <s:radio name="user.empSex" list="%{#{'0':'男','1':'女','-1':'空'}}" ></s:radio>                   
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">单位：</td>
                        <td>
                             <s:select cssClass="selectlist" name="user.unitId" list="#request.unitMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   cssStyle="width:150px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="部门">部门<span class="MustFillColor">*</span>：</td>
                        <td>
							<input type="hidden" name="pastOrgId" id="pastOrgId" value="<%=pastOrgId%>"/>
							<input type="hidden" id="_orgId" value="<%=orgId%>"/>
                            <input type="hidden" name="orgId" id="orgId" value="<%=orgId%>"/>
                            <input type="text" name="orgName" id="orgName" class="inputText" readonly="readonly" whir-options="vtype:['notempty']" value="<%=orgName%>" /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onclick="openSelect({allowId:'orgId', allowName:'orgName', select:'org', single:'yes', show:'org', range:'*0*',callbackOK:'getDetpKindAndFillLeader'});" ></a>							
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">部门性质：</td>
                        <td>
                            <input type="text" name="__deptKindId" id="__deptKindId" class="inputText" maxlength="40" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">人员性质：</td>
                        <td>
                            <s:select  cssClass="selectlist" name="user.personalKind" list="#request.kindMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   cssStyle="width:150px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">岗位：</td>
                        <td>
                            <s:select  cssClass="selectlist" name="user.empPosition" list="#request.stationMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   cssStyle="width:150px;"/>
							<input type="hidden" name="oldEmpPosition" id="oldEmpPosition" value="<%=oldEmpPosition%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">职务：</td>
                        <td>
                            <s:select  cssClass="selectlist" id="empDuty" name="user.empDuty" list="#request.dutyMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   cssStyle="width:150px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">职称：</td>
                        <td>
                            <s:select  cssClass="selectlist" name="user.zhicheng" list="#request.positionMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   cssStyle="width:150px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="兼职部门">兼职部门：</td>
                        <td>
                            <s:hidden name="user.sidelineOrg" id="sidelineOrg" />
                            <s:textfield name="user.sidelineOrgName" id="sidelineOrgName" whir-options="vtype:[{'maxLength':50}]" cssClass="inputText" readonly="true"  /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onclick="openSelect({allowId:'sidelineOrg', allowName:'sidelineOrgName', select:'org', single:'no', show:'org', range:'*0*'});"  ></a>
							<input type="hidden" name="pastSidelineOrg" id="pastSidelineOrg" value="<%=pastSidelineOrg%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle">兼任职务：</td>
                        <td>
                            <s:textfield name="user.partjobDuty" id="partjobDuty" cssClass="inputText" whir-options="vtype:[{'maxLength':100},'spechar3']"  /> 
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="分管领导">分管领导：</td>
                        <td>
                            <s:hidden name="user.chargeLeaderIds" id="chargeLeaderIds" />
                            <s:textfield name="user.chargeLeaderNames" id="chargeLeaderNames" whir-options="vtype:[{'maxLength':100}]"  cssClass="inputText" readonly="true"  /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onclick="openSelect({allowId:'chargeLeaderIds', allowName:'chargeLeaderNames', select:'user', single:'no', show:'userorggroup', range:'*0*'});"  ></a>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="部门领导">部门领导：</td>
                        <td>
                            <s:hidden name="user.deptLeaderIds" id="deptLeaderIds" />
                            <s:textfield name="user.deptLeaderNames" id="deptLeaderNames" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]"  readonly="true"  /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onclick="openSelect({allowId:'deptLeaderIds', allowName:'deptLeaderNames', select:'user', single:'no', show:'userorggroup', range:'*0*'});"  ></a>
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="上级领导">上级领导：</td>
                        <td>
                            <s:hidden name="user.empLeaderId" id="empLeaderId" />
                            <s:textfield name="user.empLeaderName" id="empLeaderName" cssClass="inputText"  whir-options="vtype:[{'maxLength':100}]" readonly="true"  /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onclick="openSelect({allowId:'empLeaderId', allowName:'empLeaderName', select:'user', single:'no', show:'userorggroup', range:'*0*'});"  ></a>
                        </td>
                    </tr>
                    
                    <tr>
                        <td width="72" class="td_lefttitle" for="办公地点">办公地点：</td>
                        <td>
                            <s:hidden name="user.workAddress" id="workAddress" />
                            <%
								String addressName = request.getAttribute("addressName")!=null?request.getAttribute("addressName").toString():"";
							%>
                            <input type="text"  id="workAddressName" value="<%=addressName%>" class="inputText" readonly="readonly"  /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onClick="javascript:selectWorkAddress();" ></a>							
                        </td>
                    </tr>
					  <tr>
                        <td width="72" class="td_lefttitle" for="地址">地址：</td>
                        <td>
                            <s:hidden name="user.addressId" id="addressId" />
                            <%
								String addressName1 = request.getAttribute("addressName1")!=null?request.getAttribute("addressName1").toString():"";
								String addressName2 = request.getAttribute("addressName2")!=null?request.getAttribute("addressName2").toString():"";
							%>
                            <input type="text"  id="address" value="<%=addressName1%>" class="inputText" readonly="readonly"  /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onClick="javascript:selectWorkAddress1();" ></a>
							<input type="hidden" id="addresses" value="<%=addressName2%>" />
                        </td>
                        <td width="84" class="td_lefttitle" for="电子邮件">电子邮件：</td>
                        <td width="419">
                            <s:textfield name="user.empEmail" id="empEmail" cssClass="inputText" whir-options="vtype:['email',{'maxLength':100}]"  /> 
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="商务电话">商务电话：</td>
                        <td>
                            <s:textfield name="user.empBusinessPhone" id="empBusinessPhone" cssClass="inputText" whir-options="vtype:['tel',{'maxLength':20}]"  /> 
                        </td>
                        <td width="84" class="td_lefttitle" for="传真">传真：</td>
                        <td width="419">
                            <s:textfield name="user.empBusinessFax" id="empBusinessFax" cssClass="inputText" whir-options="vtype:['tel',{'maxLength':20}]"  /> 
							<%
								String fax = request.getAttribute("fax")!=null?request.getAttribute("fax").toString():"";
							%>
							<input type="hidden" id="fax" value="<%=fax%>" />
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="分机号">分机号：</td>
                        <td>
                            <s:textfield name="user.serial" id="serial" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':20}]"  /> 
                        </td>
                        <td width="84" class="td_lefttitle" for="密码">密码：</td>
                        <td width="419">
                            <s:password name="user.serialPwd" id="serialPwd" cssClass="inputText" whir-options="vtype:[{'maxLength':20}]"  /> 
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="移动电话">移动电话：</td>
                        <td>
                            <s:textfield name="user.empMobilePhone" id="empMobilePhone" cssClass="inputText" whir-options="vtype:['mobile',{'maxLength':20}]"  /> 
                        </td>
                        <td width="84" class="td_lefttitle" for="住宅电话">住宅电话：</td>
                        <td width="419">
                            <s:textfield name="user.empPhone" id="empPhone" cssClass="inputText" whir-options="vtype:['tel',{'maxLength':20}]"  /> 
                        </td>
                    </tr>
                    <tr>
                        <td width="72" class="td_lefttitle" for="个人简介">个人简介：</td>
                        <td colspan="3">
                            <s:textarea name="user.empDescribe"  id="empDescribe" whir-options="vtype:[{'maxLength':1000},'spechar3']"  rows="3" style=" width:99.5%" cssClass="inputTextarea" ></s:textarea>
                        </td>
                    </tr>
                </table>
            </div>
           
            <div id="docinfo1" style="display:none;">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Table_bottomline">
                    <tr>
                        <td width="140" class="td_lefttitle">人员类别：</td>
                        <td width="42%">
                             <s:select  cssClass="selectlist" name="user.personTypeId" list="#request.personTypeMap" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   />
                        </td>
                        <td width="80" class="td_lefttitle">在职状态：</td>
                        <td width="42%">
                             <s:select  cssClass="selectlist" style="width:50%;" name="user.jobStatus" id="jobStatus" list="#{'在岗':'在岗','正式':'正式','内退':'内退','退休':'退休','试用':'试用','临时':'临时','离职':'离职','待岗':'待岗','其他':'其他'}" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"    onchange="changeJobStatus(this);" />
                        	 <span id="lizhidatespan">
                        		<s:textfield name="user.lizhiDate" id="lizhiDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" >
                        	 		<s:param name="value"><s:date name="user.lizhiDate" format="yyyy-MM-dd"/></s:param>
                        	 	</s:textfield>
                        	 </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle" for="出生日期" >出生日期：</td>
                        <td>
                        	 <s:textfield  name="user.empBirth" id="empBirth" cssClass="Wdate whir_datebox" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" >
                        	 <s:param name="value"><s:date name="user.empBirth" format="yyyy-MM-dd"/></s:param>
                        	 </s:textfield>
                        </td>
                        <td class="td_lefttitle">婚姻状况：</td>
                        <td>
                            <s:select  cssClass="selectlist" name="user.marriageStatus" list="#{'已婚':'已婚','未婚':'未婚','离异':'离异','丧偶':'丧偶','未知':'未知'}" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"  />
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">民族：</td>
                        <td>
                            <s:select  cssClass="selectlist"  name="user.empNation" list="#{'汉族':'汉族','蒙古族':'蒙古族','回族':'回族','藏族':'藏族','维吾尔族':'维吾尔族','苗族':'苗族','彝族':'彝族','壮族':'壮族','布依族':'布依族','朝鲜族':'朝鲜族','满族':'满族','侗族':'侗族','瑶族':'瑶族','白族':'白族','土家族':'土家族','哈尼族':'哈尼族','哈萨克族':'哈萨克族','傣族':'傣族','黎族':'黎族','僳僳族':'僳僳族','佤族':'佤族','畲族':'畲族','高山族':'高山族','拉祜族':'拉祜族','水族':'水族','东乡族':'东乡族','纳西族':'纳西族','景颇族':'景颇族','柯尔克孜族':'柯尔克孜族','土族':'土族','达斡尔族':'达斡尔族','仫佬族':'仫佬族','羌族':'羌族','布朗族':'布朗族','撒拉族':'撒拉族','毛南族':'毛南族','仡佬族':'仡佬族','锡伯族':'锡伯族','阿昌族':'阿昌族','普米族':'普米族','塔吉克族':'塔吉克族','怒族':'怒族','乌孜别克族':'乌孜别克族','俄罗斯族':'俄罗斯族','鄂温克族':'鄂温克族','德昂族':'德昂族','保安族':'保安族','裕固族':'裕固族','京族':'京族','塔塔尔族':'塔塔尔族','独龙族':'独龙族','鄂伦春族':'鄂伦春族','赫哲族':'赫哲族','门巴族':'门巴族','珞巴族':'珞巴族','基诺族':'基诺族'}" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   />
                        </td>
                        <td class="td_lefttitle">籍贯：</td>
                        <td>
                             <s:textfield name="user.empNativePlace" id="empNativePlace" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" maxLength="10" /> 
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">第一学历：</td>
                        <td>                            
                            <s:select cssClass="selectlist" name="user.empStudyExperience" list="#{'博士':'博士','硕士':'硕士','双学历':'双学历','大学本科':'大学本科','大学专科':'大学专科','中专':'中专','中技':'中技','高职':'高职','高中':'高中','初中及以下':'初中及以下'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--" />
                        </td>
                        <td class="td_lefttitle">第一学位：</td>
                        <td>                            
                            <s:select cssClass="selectlist" name="user.empDegree" list="#{'博士':'博士','硕士':'硕士','学士':'学士','无':'无'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--" />
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">参加工作日期：</td>
                        <td>
                            <s:textfield name="user.empFireDate" id="empFireDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true, onpicked:calcSeniority_all})" >
                            <s:param name="value"><s:date name="user.empFireDate" format="yyyy-MM-dd"/></s:param>
                        	 </s:textfield>
                        </td>
                        <td class="td_lefttitle">入职日期：</td>
                        <td>
                            <s:textfield name="user.intoCompanyDate" id="intoCompanyDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true, onpicked:calcSeniority_cur})" >
                            <s:param name="value"><s:date name="user.intoCompanyDate" format="yyyy-MM-dd"/></s:param>
                        	 </s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">工龄：</td>
                        <td>
							<span id="seniority_all"><s:property value="%{#request.seniority_all}" /></span>
                        </td>
                        <td class="td_lefttitle">工龄（本单位）：</td>
                        <td>
							<span id="seniority_cur"><s:property value="%{#request.seniority_cur}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">有无离职证明：</td>
                        <td>
                            <div class="radiolist">
                                <s:radio name="user.isdimissionprove" list="%{#{'1':'有','0':'无'}}" ></s:radio>
                            </div>
                        </td>
                        <td class="td_lefttitle">工段：</td>
                        <td>
                            <s:textfield name="user.section" id="section" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" />  
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">用工性质：</td>
                        <td>
                            <s:textfield name="user.empResumeNum" id="empResumeNum" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" />  
                        </td>
                        <td class="td_lefttitle">身份：</td>
                        <td>
                            <s:textfield name="user.dignity" id="dignity" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" />  
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">政治面貌：</td>
                        <td>
                             <s:select  cssClass="selectlist"  name="user.empPolity" list="#{'中共党员':'中共党员','共青团员':'共青团员','群众':'群众','民主党派':'民主党派'}" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   />
                        </td>
                        <td class="td_lefttitle" for="入党团时间">入党团时间：</td>
                        <td>
                             <s:textfield name="user.partyDate"  id="partyDate"  whir-options="vtype:[{'maxLength':50}]"  style="width:98%" cssClass="inputText" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">户口性质：</td>
                        <td>
                            <s:select  cssClass="selectlist"  name="user.hkxz" list="#{'外埠城镇':'外埠城镇','本市城镇':'本市城镇','外埠农村劳动力':'外埠农村劳动力','本市农村劳动力':'本市农村劳动力','其他':'其他'}" listKey="key"  listValue="value" headerKey="" headerValue="--请选择--"   />
                        </td>
                        <td class="td_lefttitle">户口所在地：</td>
                        <td>
                            <s:textfield name="user.hujiAddress" id="hujiAddress" cssClass="inputText" whir-options="vtype:[{'maxLength':200}]" />  
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle" for="身份证号">身份证号：</td>
                        <td>
                             <s:textfield name="user.empIdCard" id="empIdCard" cssClass="inputText" whir-options="vtype:['idcard',{'maxLength':18}]" />  
                        </td>
                        <td class="td_lefttitle" for="身份证签发机关" >身份证签发机关：</td>
                        <td>
                            <s:textfield name="user.sfzQfjg"  id="sfzQfjg"  whir-options="vtype:[{'maxLength':50}]" rows="2" style="width:98%" cssClass="inputText" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">因私护照号码：</td>
                        <td>
                            <s:textfield name="user.passportNo" id="passportNo" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" />  
                        </td>
                        <td class="td_lefttitle">因公护照号码：</td>
                        <td>
                            <s:textfield name="user.passportNo2" id="passportNo2" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" />  
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle" for="身份证住址" >身份证住址：</td>
                        <td>
                            <s:textfield name="user.sfzAddress"  id="sfzAddress" whir-options="vtype:[{'maxLength':50}]"  rows="2" style="width:98%" cssClass="inputText" ></s:textfield>
                        </td>
                        <td class="td_lefttitle" for="身份证住址邮编" >身份证住址邮编：</td>
                        <td>
                            <s:textfield name="user.sfzPostcode" id="sfzPostcode" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" />  
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle" for="家庭住址"  >家庭住址：</td>
                        <td>
                             <s:textfield name="user.empAddress"  id="empAddress" whir-options="vtype:[{'maxLength':50}]" rows="2" style="width:98%" cssClass="inputText" ></s:textfield>
                        </td>
                        <td class="td_lefttitle"  for="家庭住址邮编" >家庭住址邮编：</td>
                        <td>
                            <s:textfield name="user.familyPostcode" id="familyPostcode" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" />  
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle" for="现居住地址"  >现居住地址：</td>
                        <td>
                             <s:textfield name="user.livingAddress"  id="livingAddress"  whir-options="vtype:[{'maxLength':50}]" rows="2" style="width:98%" cssClass="inputText" ></s:textfield>
                        </td>
                        <td class="td_lefttitle" for="现居住地址邮编"  >现居住地址邮编：</td>
                        <td>
                            <s:textfield name="user.nowLivingPostcode" id="nowLivingPostcode" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" />  
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">暂住证号码：</td>
                        <td>
                            <s:textfield name="user.zzzNo" id="zzzNo" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" />
                        </td>
                        <td class="td_lefttitle">暂住证有效期：</td>
                        <td>
                            <s:textfield name="user.zzzDate" id="zzzDate" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" />
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">保险卡号：</td>
                        <td>
                            <s:textfield name="user.insuranceCardNo" id="insuranceCardNo" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" />
                        </td>
                        <td class="td_lefttitle">工资卡号：</td>
                        <td>
                            <s:textfield name="user.payCardNo" id="payCardNo" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" />
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle">发放工资：</td>
                        <td>
                            <div class="radiolist">
                                <s:if test="user!=null">
                                	<s:radio name="user.gzFf" list="%{#{'1':'是','0':'否'}}" ></s:radio>
                                </s:if>
                                <s:else>
                                	<s:radio name="user.gzFf" list="%{#{'1':'是','0':'否'}}" value="0"  ></s:radio>
                                </s:else>
                            </div>
                        </td>
                        <td class="td_lefttitle">申请本系统账号：</td>
                        <td>
                            <div class="radiolist">
                            	<s:if test="user!=null">
                                	<s:radio name="user.isApplyAccount" list="%{#{'1':'是','0':'否'}}" ></s:radio>
                                </s:if>
                                <s:else>
                                	<s:radio name="user.isApplyAccount" list="%{#{'1':'是','0':'否'}}" value="0" ></s:radio>
                                </s:else>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_lefttitle" for="个人特长和爱好"  >个人特长和爱好：</td>
                        <td>
                            <s:textarea name="user.empInterest"  id="empInterest"  whir-options="vtype:[{'maxLength':50}]" rows="2" style="width:98%" cssClass="inputTextarea" ></s:textarea>
                        </td>
                        
                    </tr>
                    
                   <%
						// 参数说明：
						//     extTableId      - 扩展表名称（大写），必须
						//     extInfoId       - 扩展信息主键ID，必须
						//     extCssStyle     - css style样式
						//     extTextareaRows - 行数（适用于文本框），只能为整数。
						//     isAdd           - 是否是新增 true-是 其他值-否
						//     canModify       - 是否可以修改（适用于上传类型）， true-是 其他值-否
						//     showCols            - 显示列数，必须
				
						String extInfoId_para = (request.getParameter("empId")!=null && (!request.getParameter("empId").equals("")) )?request.getParameter("empId"):"-1";
					%>
					<jsp:include page="/platform/custom/extension/extension_include.jsp" flush="true">
						<jsp:param name="extTableId" value="ORG_EMPLOYEE"/>
						<jsp:param name="extInfoId" value="<%=extInfoId_para%>"/>
						<jsp:param name="extCssStyle" value="width:98%"/>
						<jsp:param name="extTextareaRows" value="3"/>
						<jsp:param name="isAdd" value="false"/>
						<jsp:param name="canModify" value="true"/>
						<jsp:param name="showCols" value="2"/>
						<jsp:param name="isDetail" value=""/>
					</jsp:include>
                    
                <s:if test="user!=null">
                    <tr>
                        <td colspan="4" class="td_lefttitle"><strong>教育经历：</strong></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <iframe allowTransparency="true" id="edusty" name="edusty" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="td_lefttitle"><strong>家庭成员：</strong> </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <iframe allowTransparency="true" id="familymember" name="familymember" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="td_lefttitle"><strong>紧急联络人：</strong></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <iframe allowTransparency="true" id="emergencycontact" name="emergencycontact" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                 	</s:if>
               </table>
            </div>
         	<s:if test="user!=null">
            <div id="docinfo2" style="display:none;">
                <table width="100%" border="0">
                    <tr>
                        <td><strong>合同信息：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="contract" name="contract" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>工作经历：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="work" name="work" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>入职信息：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="rzxx" name="rzxx" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>入职前培训经历：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="trainhistory" name="trainhistory" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>资格证书：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="competence" name="competence" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>任职资格：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="rzzg" name="rzzg" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>职业资格：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="zyzg" name="zyzg" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td colspan="2"><strong>简历：</strong>
                        </td>
                    </tr>
                    <tr>
						<td for="简历" style="display:none;"></td>
                        <td align="left"> 
                            <s:textarea name="user.empWorkExperience" id="empWorkExperience" rows="4" whir-options="vtype:[{'maxLength':300}]" style="width:99.5%;word-break:break-all;" cssClass="inputTextarea"></s:textarea>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div id="docinfo3" style="display:none;">
                <table width="100%" border="0">
                    <tr>
                        <td><strong>&nbsp;</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="trainRecord" name="trainRecord" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="docinfo4" style="display:none;">
                <table width="100%" border="0">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="hpRecord" name="hpRecord" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="docinfo5" style="display:none;">
                <table width="100%" border="0">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="PerformanceCheck" name="PerformanceCheck" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="docinfo6" style="display:none;">
                <table width="100%" border="0">
                    <tr>
                        <td><strong>居住证办理：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="EmpInhabitancy" name="EmpInhabitancy" src="" frameborder="0" style="width:100%"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>社保：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="EmpSocialinsurance" name="EmpSocialinsurance" src="" frameborder="0" style="width:100%;height:260px;"></iframe>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td><strong>工伤：</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <iframe allowTransparency="true" id="EmpCompo" name="EmpCompo" src="" frameborder="0" style="width:100%;height:500px;"></iframe>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="docinfo7" style="display:none;">
                <table width="100%" border="0">
                    <tr>
                        <td><strong>岗位信息：</strong></td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
                                <tr align="center" class="listTableHead">
                                    <td width="20%" nowrap>岗位级别</td>
                                    <td width="20%" nowrap>岗位工资档级</td>
                                    <td width="20%">岗位固定工资（元/月）</td>
                                    <td width="20%">绩效考核工资（元/月）</td>
                                    <td width="20%" nowrap>工资系数</td>
                                </tr>
                                 <%
						        	com.whir.ezoffice.hrm.salary.bd.GzbzBD gzbzBD = new com.whir.ezoffice.hrm.salary.bd.GzbzBD();
						            //Map gzbzMap = gzbzBD.getGzbzByUserId(empId);
									Map gz_gzbzMap = request.getAttribute("gz_gzbzMap")!=null?(Map)request.getAttribute("gz_gzbzMap"):new HashMap();
									String gz_gzxs = (String)request.getAttribute("gz_gzxs");
									List gzbzGzxsList = gzbzBD.getGzxsList(session.getAttribute("domainId").toString());
        						%>
                                <tr>
									  <td>
									  <input type="hidden" name="salary_gz_gwjb_id"  id="salary_gz_gwjb_id" value="<%=gz_gzbzMap.get("GZ_GWJBID")!=null?(String)gz_gzbzMap.get("GZ_GWJBID"):""%>" />
									  <input type="text" name="salary_gz_gwjb" id="salary_gz_gwjb" value="<%=gz_gzbzMap.get("GZ_GWJB")!=null?(String)gz_gzbzMap.get("GZ_GWJB"):""%>" style="width:100%;border:0" readonly class="inputText" />
									  </td>
							          <td><input type="text" name="salary_gz_gwgzdj" id="salary_gz_gwgzdj"  value="<%=gz_gzbzMap.get("GZ_GWGZDJ")!=null?(String)gz_gzbzMap.get("GZ_GWGZDJ"):""%>" style="width:100%;border:0" readonly class="inputText" /></td>
							          <td><input type="text" name="salary_gz_gwgdgz" id="salary_gz_gwgdgz"  value="<%=gz_gzbzMap.get("GZ_GWGDGZ")!=null?(String)gz_gzbzMap.get("GZ_GWGDGZ"):""%>" style="width:100%;border:0" readonly class="inputText" /></td>
							          <td><input type="text" name="salary_gz_jxkhgz" id="salary_gz_jxkhgz"  value="<%=gz_gzbzMap.get("GZ_JXKHGZ")!=null?(String)gz_gzbzMap.get("GZ_JXKHGZ"):""%>" style="width:100%;border:0" readonly class="inputText" /></td>
							          <td class="listTableLine1 listTableLineLastTD">
									  <select name="salary_gz_gzxs" style="width:100%;" onchange="showGzgwinfo(this)">
										<option value=""></option>
									  <%
										if(gzbzGzxsList!=null&&gzbzGzxsList.size()>0){
											for(int i0=0; i0<gzbzGzxsList.size(); i0++){
												Object oo = (Object)gzbzGzxsList.get(i0);
									  %>
										<option value="<%=oo!=null?oo+"":""%>" <%=oo!=null&&oo.toString().equals(gz_gzxs)?"selected":""%>><%=oo!=null?oo+"":""%></option>
									  <%}}%>
									  </select>
									  </td>
						        </tr>
                            </table>
                        </td>
                    </tr>
                    <!-- -->
                </table>
            </div>
            <div id="docinfo8" style="display:none;">
             <%if(hr_right5){%>
			 <table width="100%"  border="0" >
			   <tr>
			    <td>&nbsp;</td>
			   </tr>
			   <tr>
			   <td align="center">
			       <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
			       	<tr align="center" class="listTableHead" >
					    <td width="30%">缴纳项目</td>
						<td width="25%">缴纳情况</td>
						<td width="25%">变更日期</td>
						<td width="20%">缴纳基数</td>
					</tr>
			        <%
						Date now = new Date();
			            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			            //当前年月
			            String yyyyMM = sdf.format(now);
			        	com.whir.ezoffice.hrm.welfare.bd.RatioSettingBD ratioBD = new com.whir.ezoffice.hrm.welfare.bd.RatioSettingBD();
			        	com.whir.ezoffice.hrm.welfare.bd.SbbzBD sbbzBD = new com.whir.ezoffice.hrm.welfare.bd.SbbzBD();
			            List ratioSettingList = ratioBD.getRatioSettingList(new Long(session.getAttribute("domainId").toString()));
						if(ratioSettingList!=null&&ratioSettingList.size()>0){
							SimpleDateFormat sdf_ = new SimpleDateFormat("yyyy-MM-dd");
							for(int i0=0; i0<ratioSettingList.size(); i0++){
								Object[] rObj = (Object[])ratioSettingList.get(i0);
								com.whir.ezoffice.hrm.welfare.po.SbbzPO sbbzPO = sbbzBD.getMySbbzPO(empId, rObj[0].toString());
								String payBase = sbbzPO!=null?sbbzPO.getPayBase()+"":"";
								Date changeDate = sbbzPO!=null?sbbzPO.getChangeDate():new Date();
								String tr_class = i0%2==0?"listTableLine1":"listTableLine2";
			        %>
			        <tr class="<%=tr_class%>">
					  <td><%=rObj[1]%>缴纳情况<input type="hidden" name="payBaseItem_Id" value="<%=rObj[0]%>"/></td>
			          <td align="center">
			              <select name="payBaseItem_qk" style="width:98%">
			                  <option value=""></option>
			                  <option value="1" <%=sbbzPO!=null&&"1".equals(sbbzPO.getPayStatus())?"selected":""%>>正常缴纳</option>
			                  <option value="0" <%=sbbzPO!=null&&"0".equals(sbbzPO.getPayStatus())?"selected":""%>>停止缴纳</option>
			              </select>
			          </td>
			          <td align="center">
						<input type="text" name="payBaseItem_changeDate" id="payBaseItem_changeDate" readonly  value="<%=sdf_.format(changeDate)%>"  class="Wdate whir_datebox"   onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
			          </td>
			          <td class="listTableLine1 listTableLineLastTD">
			            <input class="inputText" type="text" name="payBaseItem_js" value="<%=payBase%>" id="payBaseItem_js<%=i0%>" whir-options="vtype:['p_decimal_e']" />
			          </td>
			        </tr>
					<%}}%>
			       </table>
			    </td>
			   </tr>
			  </table>
			  <%}%>
            </div>
            </s:if>
        </td>
    </tr>
    
    <%
    	String styleStr ="";
        if(hr_right1==false && "".equals(empId)){
            styleStr ="disabled='true'";
        }
    	//if(!hr_right1 && !hr_right2 && !hr_right3 && !hr_right4 && !hr_right5 && !hr_right6 && !hr_right7 && !hr_right8 && !hr_right9 && !hr_right10){
    	//	styleStr ="disabled='true'";
    	//}
    %>
	<tr>
    <td>
	    <div style="margin:10px;">
			    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
			       <tr>
			           <td class="td_lefttitle" style="width:65px;">&nbsp;</td>
			           <td colspan="4">
							<s:if test="user!=null">
							<%if(hr_right1 || ( hr_right_wh && hr_right4 ) || ( hr_right_wh&&hr_right5 )){%>
							<input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.save"/>' name="option"/>  
			                <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' name="option"/>  
			                 <%}%>
			                <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' id="exsit_button" />  
							</s:if>
							<s:else>
							<input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.saveclose"/>' name="option" <%=styleStr%>/>  
			                <input type="button" class="btnButton4font" onClick="ok(1,this);" value='<s:text name="comm.savecontinue"/>' name="option" <%=styleStr%>/> 
			                <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' name="option" <%=styleStr%>/>  
			                <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>'  id="exsit_button"/>  
			                </s:else>
			           </td>
			       </tr>
			       </table>
	       </div>
        </td>
       </tr>
</table>
</div>
<script type="text/javascript">
<!--
$(document).ready(function(){
	var empIdCard = $("#empIdCard").val();
	if(empIdCard=="NULL" || empIdCard=="null"){
		$("#empIdCard").val("");
	}
	changeJobStatus($("#jobStatus")[0]);
	
	if($("#isApplyAccount").val()!="0" && $("#isApplyAccount").val()!="" ){
		$("input[name='user.isApplyAccount']").eq(1).prop("disabled",true);
		$("input[name='user.isApplyAccount']").eq(0).prop("checked",true);
		//$("input[name='user.isApplyAccount']").eq(0).uniform(); 
	}
});

$(document).ready(function(){
	getDetpKind();
	changeJobStatus($("#jobStatus")[0]);
	
	var liid = $(".Public_tag ul li").eq(0).attr("id");
	var divid = "docinfo"+liid.substring(liid.length-1);
	$("#"+divid).show();
	changePanle(liid.substring(liid.length-1));
});


//-->
</script>
<!-- end -->