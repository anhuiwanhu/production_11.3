<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.zhidao.bd.KnowIndexBD"%>
<%@ page import="com.whir.ezoffice.knowledge.bd.ExpertBD"%>
<%@ page import="com.whir.ezoffice.knowledge.po.ExpertPO"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.personalwork.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%@ page import="com.whir.component.util.*"%>
<%@ include file="/public/desktop/include_desktop_menubaseInfo.jsp"%> 
<%@ page import=" java.util.Date" %>
<%@ page import= "java.text.SimpleDateFormat" %>
<%@ page import="com.whir.i18n.Resource" %>
<%
//String whir_locale = session.getAttribute("org.apache.struts.action.LOCALE").toString();
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");
String userId2 = session.getAttribute("userId").toString();

com.whir.ezoffice.personalwork.setup.po.MyInfoPO myinfo = new com.whir.ezoffice.personalwork.setup.bd.MyInfoBD().load(userId2);
String empGnome = myinfo.getEmpGnome();
//String empGnome="";
//if(empGnome1!=null&&!"".equals(empGnome1)){ 
//	empGnome  = new String(empGnome1.getBytes("UTF-8"));
//}

//com.whir.component.util.StringUtils su = new com.whir.component.util.StringUtils();
if(empGnome!=null&&!"".equals(empGnome)){empGnome = com.whir.component.util.StringUtils.HtmlToText(empGnome);}
else {empGnome="";}

//List<com.whir.ezoffice.personalwork.setup.po.OaEmployeeStatusPO>  statusPoList = new com.whir.ezoffice.personalwork.setup.bd.MyInfoBD().getStatusListByUserId(session.getAttribute("userId").toString());
 

//= sObj==null||sObj[0]==null?"0":sObj[0].toString();//上班状态 0|正常;101|请假;102|调休;103|出差;104|外出
   
com.whir.org.bd.usermanager.UserBD _ubd2 = new com.whir.org.bd.usermanager.UserBD();
String _userphoto2 = _ubd2.getUserPhoto(userId2);
List userInfos = _ubd2.getUserInfo(Long.parseLong(userId2));
Object[] obj = null;
obj = (Object[])userInfos.get(0);
String orgName = obj[9].toString();//组织机构
String empDuty = "";//部门
if(obj[15]!=null&&!"".equals(obj[15])){empDuty = obj[15].toString();}

String _userImage2 = "/defaultroot/images/p1.jpg";
String _userphoto_f2 ="p1";
if(_userphoto2!=null&&!"".equals(_userphoto2)&&!"null".equals(_userphoto2)){
    _userphoto_f2 = _userphoto2.substring(0, _userphoto2.lastIndexOf("."));
    String __userphoto_ext2 = _userphoto2.substring(_userphoto2.lastIndexOf("."));
    _userImage2 = preUrl + "/upload/peopleinfo/" + _userphoto_f2 + "_middle" + __userphoto_ext2;
}
String userName = session.getAttribute("userName").toString();
/*Map map = new KnowIndexBD().getMyCount(userId2);
ExpertPO po = new ExpertBD().loadByUserId(userId2,null);
boolean isExpert = false;
if(po!=null){
	isExpert = true;
}*/

PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String fileserver = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
String portletImgName = confMap.get("portletImgName");
String portletImgSaveName = confMap.get("portletImgSaveName");

String imgSrc="/defaultroot/images/ver113/personal-card-bg.png";
if(portletImgSaveName!=null&&!"".equals(portletImgSaveName)){
	if(portletImgSaveName.indexOf("|")!=-1){
	 String[] portletImgSaveNameS = portletImgSaveName.split("\\|");
	 int num = portletImgSaveNameS.length;
	 portletImgSaveName = portletImgSaveNameS[num-1];
	}
	String folder = portletImgSaveName.substring(0,6);
	imgSrc =fileserver+ "/upload/portal/"+folder+"/"+portletImgSaveName;
}
String classId = confMap.get("classId");
String view ="1";
if(confMap.get("view")!=null&&!"".equals(confMap.get("view"))){view = confMap.get("view");}
//---------获取当前日期
Date date = new Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy年MM月dd日 EEEE");
String dateString = formatter1.format(date);


%>
<input type="hidden" value="<%=myinfo%>" id="myinfoid">
<input type="hidden" value="<%=userId2%>" id="userId2id">
	<%if("1".equals(view)){%>
	<div class="wh-personal-card">
    	<div class="wh-personal-card-content clearfix">
		 <img src="<%=imgSrc%>" class="wh-personal-card-bg" alt=""/>
		  <div class="wh-personal-card-con clearfix">
		  <p class="wh-personal-date"><span><%=dateString%></span></p>
			<a title="<%=Resource.getValue(whir_locale, "personalwork", "personalwork.personalHomepage")%>" onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?portletSettingId=userinfo', '/defaultroot/PortalLayout!homePage.action?type=personal')" href="javascript:void(0)" class="fa fa-th-large wh-personal-card-setting-click"></a>
			<span class="wh-personal-card-pos">
				<p><a title="<%=userName%>" style="cursor:default"><%=userName%></a></p>
				<span title="<%=empDuty%>" style="cursor:default"><%=empDuty%></span>
			</span>
				<a  style="cursor:default" class="wh-personal-card-look" href="javascript:void(0)"><img  class="wh-card-look" src="<%=_userImage2%>" width="106"  height="106" alt="<%=_userphoto_f2%>"/></a>
			<span class="wh-personal-card-state" id="wh-personal-card-state-<%=portletSettingId%>">
                <a title="<%=orgSimpleName%>" href="javascript:void(0)" class="wh-card-department clearfix" id="wh-card-department-<%=portletSettingId%>"><span><%=orgSimpleName%></span><i class="fa fa-angle-down  org-setting-click" id="org-setting-click-<%=portletSettingId%>"></i></a>
				<div  class="per-wh-hd-depart-state" id="per-wh-hd-user-org-<%=portletSettingId%>">
					<%
						for(int m=0; m<allOrgList.size(); m++){
							Object[] objSideOrg = (Object[])allOrgList.get(m);
							String _objSideOrg_name = (String)objSideOrg[3];
							if(_objSideOrg_name.length()>10){
								_objSideOrg_name = _objSideOrg_name.substring(0, 9) + "...";
							}
							String org_class="";
							if(orgId.equals(objSideOrg[0]+"")){
								org_class="class=\"current\"";
							}
						%> 
						
						 <a title="<%=_objSideOrg_name%>" style="cursor:default"  href="javascript:void(0)" <%=org_class%> onClick="changeCurOrg('<%=objSideOrg[0]%>','<%=objSideOrg[1]%>','<%=objSideOrg[2]%>','<%=objSideOrg[3]%>','<%=objSideOrg[4]%>');userinfo.refresh($('#content_portletSettingId_'+<%=portletSettingId%>),{portletSettingId:<%=portletSettingId%>,type:'userinfo'});"   title="<%=objSideOrg[3].toString().replaceAll("\"","&quot;")%>" > <%=_objSideOrg_name%><i class="fa"></i></a>
							 
						<%}%> 
						
				</div>
				
						<a title="上班" href="javascript:void(0)" class="wh-card-state clearfix" ><span id="desktop_userstatus_em-<%=portletSettingId%>">上班</span><i class="fa fa-angle-down state-setting-click" id="state-setting-click-<%=portletSettingId%>"></i></a>
						<div class="per-wh-hd-user-state" id="per-wh-hd-user-state-<%=portletSettingId%>">
						<!--	<a href="javascript:void(0)" class="current" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=0',width:545,height:220,winName:'addStatus'});return false;" ><span>上班</span></a>
							<a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=101',width:545,height:220,winName:'addStatus'});return false;">请假</a>
							<a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=102',width:545,height:220,winName:'addStatus'});return false;">调休</a>
							<a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=103',width:545,height:220,winName:'addStatus'});return false;">外出</a>
							<a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=104',width:545,height:220,winName:'addStatus'});return false;">出差</a>
							<a href="javascript:void(0)" class="state-self" onclick="openWin({url:'/defaultroot/StatusSetupAction!addStatusClass.action',width:545,height:220,winName:'addStatus'});return false;">自定义</a>-->
						</div>
				
                		
            </span>         
		 </div>
	   </div>
		
		<div class="wh-personal-card-btn clearfix">
			<a href="javascript:void(0)" class="wh-personal-card-btn-a fl" onclick="jumpnew('/modules/personal/personal_menu.jsp?statusType=personalInfo&expNodeCode=myInfo','MyInfoAction!modiMyInfo.action');" title="个人设置">个人设置</a>
			<a href="javascript:void(0)" class="wh-personal-card-btn-a fr" onclick="jumpnew('/modules/personal/personal_menu.jsp?statusType=personalPwd&expNodeCode=personalPwd','MyInfoAction!modiMyPassword.action');" title="修改密码">修改密码</a>
		</div>
	</div>
	<%} else {%>
	
	<!--<div class="wh-personal-card-setting-content">-->
	<div class="wh-personal-card">
    <div class="wh-personal-card-setting-content">
        <div class="wh-personal-card-setting clearfix">
		
            <img src="<%=imgSrc%>" class="wh-personal-card-bg" alt=""/>
         	<div class="wh-personal-card-setting-divtop">
			<a title="<%=Resource.getValue(whir_locale, "personalwork", "personalwork.personalHomepage")%>"  
		onclick="javascript:jumpnew('/defaultroot/modules/personal/personal_menu.jsp?portletSettingId=userinfo', '/defaultroot/PortalLayout!homePage.action?type=personal')" href="javascript:void(0)" class="fa fa-th-large wh-personal-card-setting-click"></a>
				<span class="wh-personal-card-look">
					<a style="cursor:default" href="javascript:void(0)"><img  class="wh-card-look" src="<%=_userImage2%>" width="106"  height="106" alt="<%=_userphoto_f2%>"/></a>
				</span>
				<div class="wh-personal-card-namesign">
					<p class="wh-personal-date"><span style="cursor:default"><%=dateString%></span></p>
					<p><span style="cursor:default">欢迎您，</span><a href="javascript:void(0)" style="cursor:default" title="<%=userName.replaceAll("\"","&quot;")%>"><%=userName%></a></p>
					 <form>
						 <input disabled="disabled"  title="<%=empGnome.replaceAll("\"","&quot;")%>" type="text" name="empGnome" id="empGnome-<%=portletSettingId%>" class="sign" value="<%=empGnome.replaceAll("\"","&quot;")%>" onblur="javascritp:saveEmpGome();" />
						 <span><a href="javascript:void(0)" onclick="changeEdit();"><i class="fa fa-pencil" id="fa-pencil-<%=portletSettingId%>"></i></a></span>
					 </form>
				</div>
			</div>
        </div>
        <div class="wh-personal-card-setting-show clearfix" id="wh-personal-card-setting-show-<%=portletSettingId%>">
            <dl class="fl">
				<dt style="cursor:default">状态：</dt>
                <dt style="cursor:default" class="card-state" id="desktop_userstatus_em-<%=portletSettingId%>" title="上班">上班</dt>
               	<dd class="card-right"><i class="fa fa-angle-down wh-pcard-state-down" id="wh-pcard-state-down-<%=portletSettingId%>"></i></dd>
				 <div class="per-wh-hd-guser-state" id="per-wh-hd-user-state-<%=portletSettingId%>">
                  <!--  <a href="javascript:void(0)" class="current" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=0',width:545,height:220,winName:'addStatus'});return false;" ><span>上班</span></a>
                    <a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=101',width:545,height:220,winName:'addStatus'});return false;">请假</a>
                    <a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=102',width:545,height:220,winName:'addStatus'});return false;">调休</a>
                    <a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=103',width:545,height:220,winName:'addStatus'});return false;">外出</a>
					<a href="javascript:void(0)" onclick="openWin({url:'/defaultroot/StatusAction!addStatus.action?statusClassId=104',width:545,height:220,winName:'addStatus'});return false;">出差</a>
					<a href="javascript:void(0)" class="state-self" onclick="openWin({url:'/defaultroot/StatusSetupAction!addStatusClass.action',width:545,height:220,winName:'addStatus'});return false;">自定义</a>-->
                </div>
             </dl>
            <dl class="fr">
                <dt style="cursor:default">组织：</dt>
                <dd style="cursor:default" class="card-state"  title="<%=orgSimpleName%>"><%=orgSimpleName%></dd>
                <dd class="card-right"><i class="fa fa-angle-down wh-pcard-group-down" id="wh-pcard-group-down-<%=portletSettingId%>"></i></dd>
                 <ul class="wh-pcard-down-list clearfix" id="wh-pcard-down-list-<%=portletSettingId%>">
                 
				 <%
						for(int m=0; m<allOrgList.size(); m++){
							Object[] objSideOrg = (Object[])allOrgList.get(m);
							String _objSideOrg_name = (String)objSideOrg[3];
							if(_objSideOrg_name.length()>10){
								_objSideOrg_name = _objSideOrg_name.substring(0, 9) + "...";
							}
							String org_class="";
							if(orgId.equals(objSideOrg[0]+"")){
								org_class="class=\"current\"";
							}
						%> 
						
							<li <%if(orgSimpleName.equals(_objSideOrg_name)){ %> class="current" <%}%> style="cursor:default"  <%=org_class%> onClick="changeCurOrg('<%=objSideOrg[0]%>','<%=objSideOrg[1]%>','<%=objSideOrg[2]%>','<%=objSideOrg[3]%>','<%=objSideOrg[4]%>');userinfo.refresh($('#content_portletSettingId_'+<%=portletSettingId%>),{portletSettingId:<%=portletSettingId%>,type:'userinfo'});"   title="<%=objSideOrg[3].toString().replaceAll("\"","&quot;")%>" ><span><%=_objSideOrg_name%></span><i class="fa"></i></li> 
							 
						<%}%> 
						
                   
                   
                </ul>
            </dl>
        </div>
        <div class="wh-personal-card-setting-btn clearfix">
           <a href="javascript:void(0)" class="wh-personal-card-btn-a" onclick="jumpnew('/modules/personal/personal_menu.jsp?statusType=personalInfo&expNodeCode=myInfo','MyInfoAction!modiMyInfo.action');" title="个人设置">个人设置</a>
			<a href="javascript:void(0)" class="wh-personal-card-btn-a" onclick="jumpnew('/modules/personal/personal_menu.jsp?statusType=personalPwd&expNodeCode=personalPwd','MyInfoAction!modiMyPassword.action');" title="修改密码">修改密码</a>
        </div>
        <!--<i class="fa fa-angle-left wh-personal-card-set-back"></i>-->
    <!--</div>-->
	</div>
</div>
<%}%>
<script>

  	 $('#per-wh-hd-user-state-<%=portletSettingId%> a').click(function () {
        $(this).addClass('current').siblings().removeClass('current');
    });
    $("#state-setting-click-<%=portletSettingId%>").click(function(){
        $('#per-wh-hd-user-state-<%=portletSettingId%>').slideToggle();
		
		
    })
    
     $("#wh-pcard-state-down-<%=portletSettingId%>").click(function(){
        $('#per-wh-hd-user-state-<%=portletSettingId%>').slideToggle();
		
		
    })
    
    
     $("#wh-card-department-<%=portletSettingId%>").click(function(){
        $('#per-wh-hd-depart-state-<%=portletSettingId%>').slideToggle();
		
		
    })
	 $("#org-setting-click-<%=portletSettingId%>").click(function(){
        $('#per-wh-hd-user-org-<%=portletSettingId%>').slideToggle();
    })
	
    $(function(){
        var pcard_list = $('#wh-pcard-down-list-<%=portletSettingId%>');
        $("#wh-pcard-group-down-<%=portletSettingId%>").click(function(){
            pcard_list.slideToggle(300);
        });
        
       
        
        $("#wh-pcard-down-list-<%=portletSettingId%> li").click(function(){
            pcard_list.hide();
        });
        
         $("#wh-pcard-down-list-<%=portletSettingId%> li").click(function(){
            pcard_list.hide();
        });
        
        $("#fa-pencil-<%=portletSettingId%>").click(function () {
            $(".sign").removeAttr('readonly');
        });
        $('#per-wh-hd-user-state-<%=portletSettingId%> a').click(function () {
            $(this).addClass('current').siblings().removeClass('current');
        });
    })
    
    $("#wh-personal-card-state-<%=portletSettingId%>>div").hover(function(){},function(){ $(this).hide(); })
	
	$("#wh-personal-card-setting-show-<%=portletSettingId%> dl>div,#wh-personal-card-setting-show-<%=portletSettingId%> dl>ul").hover(function(){

        },function(){
            $(this).hide();
        })
	
setStateHtm(); 
var currentStatusName = "";
function setStateHtm(){

	//先清空per-wh-hd-user-state
	$("#per-wh-hd-user-state-<%=portletSettingId%>").html("");

    var str0 = getStates(); //0,0|正常;101|请假;102|调休;103|出差;104|外出;
 
    var str1;
    var str2="";//存放statusName
    var str3="";//存放StatusId
    //str1[0] 选中状态;str2自定义状态组
    if(str0 != ""){
        str1 = str0.split(",");//str1[0]为当前状态id；str1[1]为所有状态id和name组成的串
    }
	var state = str1[0].replace(/\n|\r/g,"");//当前状态id


    var str1Temp = new Array();
    str1Temp = str1[1].split(";");
    for(var ss=0;ss<str1Temp.length-1;ss++){
        var str1Temp2 = new Array();
        str1Temp2 = str1Temp[ss].split("|");
        //str2 += str1Temp2[1]+",";//存放所有状态name组成的串
        //str3 += str1Temp2[0]+",";//存放所有状态id组成的串 
		var statusName = str1Temp2[1];
        if(str1Temp2[1]=='正常'){
            statusName = '<%=Resource.getValue(local,"personalwork","status.normal")%>';
        }else if(str1Temp2[1]=='请假'){
            statusName = '<%=Resource.getValue(local,"personalwork","status.leave")%>';
        }else if(str1Temp2[1]=='调休'){
            statusName = '<%=Resource.getValue(local,"personalwork","status.timeoff")%>';
        }else if(str1Temp2[1]=='外出'){
            statusName = '<%=Resource.getValue(local,"personalwork","status.outside")%>';
        }else if(str1Temp2[1]=='出差'){
            statusName = '<%=Resource.getValue(local,"personalwork","status.outgoing")%>';
        } 

        var statusClass="";
		if(str1Temp2[0]==state){ 
			currentStatusName = statusName;
			statusClass="class=\"current\"";
		}
		$("#per-wh-hd-user-state-<%=portletSettingId%>").append("<a  title=\""+statusName+"\" style=\"cursor:default\" href=\"javascript:void(0)\" id=\"destop_a_"+str1Temp2[0]+"\"  onclick=\"setDefineStatesByStatusId('"+str1Temp2[0]+"',this);return false;\"        "+statusClass+" ><span>"+statusName+"</span><i  style=\"cursor:default\" class=\"fa\"></i></a>"); 
    }
  
    //显示自定义
    $("#per-wh-hd-user-state-<%=portletSettingId%>").append("<a  href=\"\" onClick=\"openWin({url:'StatusSetupAction!addStatusClass.action',width:445,height:120,winName:'addStatus'});return false;\"><%=Resource.getValue(local,"personalwork","status.custom")%></a>"); 

    showDestopStatuName(currentStatusName);
}
/**
更新已经选择的状态名
*/
function showDestopStatuName(name){
	//
    name=name.replace(/\</g,'&lt;').replace(/\>/g,'&gt;');
	$("#desktop_userstatus_em-<%=portletSettingId%>").html(name);
	
	$("#desktop_userstatus_em-<%=portletSettingId%>").attr("title",name);
};

	
	//获取数据库里状态
function getStates(){
	var result = "";
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/modules/personal/setup/getDefineStates.jsp",
		cache: true,
        async: false,
		dataType: 'text',
		success: function(data) {
			result = data;
		}
	});
	return result;
}
//设置个人状态
function setDefineStatesByStatusId(statusId,obj){
	var vstatusId = statusId;
    var vherf = whirRootPath+"/StatusAction!addStatus.action?statusClassId="+statusId;
    openWin({url:vherf,width:600,height:300,winName:'changeStatus'});
};
//切换当前组织信息
function changeCurOrg(orgId,orgName,orgIdString,orgSelfName,orgEnglishName){
    var curOrgId = $("#curOrgId").val();//document.getElementById("curOrgId").value;
    //var msg = "您确认要进入 "+orgSelfName+" 吗？";
    var msg = comm.confirm_tip1 + orgSelfName + comm.whir_confirmlast;
    if(orgId!=curOrgId){
    	if(confirm(msg)){
			var returnValue = changeCurOrgInfo(orgId).replace(/\n|\r/g,"");
			if(returnValue=="1"){
				$("#curOrgId").val(orgId);
				if(orgSelfName.length>10)orgSelfName=orgSelfName.substring(0, 7) + "...";
				$("#currentOrgName").html("("+orgSelfName+")");

				$("span[id^='span_orgid_']").each(function(){
					if(('span_orgid_'+orgId)==this.id){
						this.innerHTML="<img src=images/cxtj.gif hspace=5 border=0>";
					}else{
						this.innerHTML="";
					}
				});
			}
    	}
    }
}

function changeCurOrgInfo(orgId){
	var result = "";
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/change_current_org.jsp?orgId="+orgId,
        async: false,
		dataType: 'text',
		success: function(data){
			result = data;
		}
	});	
	return result;
}
//签名
function checkForm(){
    // 
    $('#empGnome-<%=portletSettingId%>').val(getWebeditorHTML(ewebeditorIFrame));
    
    if(!myInfoValidate()){
        return false;
    }
    
    return true;
}

//保存签名
function saveEmpGome(){
	var empGnome = encodeURIComponent(document.getElementById("empGnome-<%=portletSettingId%>").value);

	//var myinfo = document.getElementById("myinfoid").value;
	var userId2id = document.getElementById("userId2id").value;
	//var myinfojson = JSON.stringify(myinfo);
	//alert(userId2id);
 	$.ajax({
							type:"POST",
							url:whirRootPath + '/PortletData!updateMyInfo.action?empGnome=' + empGnome+'&userId='+userId2id,
										success : function(response, opts) {
												userinfo.refresh($('#content_portletSettingId_'+<%=portletSettingId%>),{portletSettingId:<%=portletSettingId%>,type:'userinfo'});
										}
							
						 });
 	
}

function changeEdit(){
	var emp = $("#empGnome-<%=portletSettingId%>");
	emp.removeAttr("disabled");;
}
</script>
