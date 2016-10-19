<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import=" java.util.Date" %>
<%@ page import= "java.text.SimpleDateFormat" %>
<%
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);

String limitChar = confMap.get("limitChar");
int limitCharNum = 0;
if(limitChar!=null && !"".equals(limitChar)){
	limitCharNum = Integer.parseInt(limitChar);
}

 String view = confMap.get("view");
  if(view==null||"".equals(view)){
        	view ="2";
        }
String limitNum = confMap.get("limitNum");

String scrolling = confMap.get("scrolling");
String topPreview = confMap.get("topPreview");
String  currentDate="";
String  currentDateday="";
String strdata3="";
ModuleVO mvo = (ModuleVO)request.getAttribute("mvo");
if(mvo!=null){
    List list = mvo.getItemList();
    //按时间排序
    Collections.sort(list,new Comparator<ItemVO>(){  
				public int compare(ItemVO v1, ItemVO v2) {
					return v1.getTime().compareTo(v2.getTime());
				}  
	        });  
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");//设置日期格式
String month = df.format(new Date());// new Date()为获取当前系统时间

 //HttpSession session = request.getSession(true);
 String userId = session.getAttribute("userId")!=null?session.getAttribute("userId").toString():"";
   String domainId = com.whir.common.util.CommonUtils.getSessionDomainId(request).toString();       
%>
<%if("2".equals(view)) {
currentDate = (String)request.getAttribute("currentDate");
currentDateday = (String)request.getAttribute("currentDateday");


%>
    <div class="wh-my-schedule">
        <div class="wh-schedule-time-box" id="wh-schedule-time-box-<%=portletSettingId%>">
         <ul class="wh-schedule-time-slide clearfix" id="wh-schedule-time-slide-<%=portletSettingId%>">
                <li><%=currentDateday.substring(0,7)%></li>
                
         </ul>
        </div>
        
        <div class="wh-my-s-date-list" id="wh-my-s-date-list-<%=portletSettingId%>">
            <ul class="wh-my-s-date-li clearfix" id="wh-my-s-date-li-<%=portletSettingId%>">
			<%
			String day = currentDateday.substring(8,10);
			int monthnum = Integer.parseInt(currentDateday.substring(5,7));
			int daynum = Integer.parseInt(day);
			%>
			<%
				Calendar cal =   Calendar.getInstance();//下周数据
  	  			
  		  		SimpleDateFormat sft = new SimpleDateFormat("yyyy-MM-dd");
  		  		
  					cal.setTime(sft.parse(currentDateday));
  					
  	 		 	
			%>
			<%
				for(int i=0;i<7;i++){
				
				Date date2 = new Date();
				date2 = cal.getTime();
				SimpleDateFormat sft2 = new SimpleDateFormat("yyyy-MM-dd");
		    	String strdata = sft2.format(date2);
				String day2 = strdata.substring(8,10);
				int monthnum2 = Integer.parseInt(strdata.substring(5,7));
				int daynum2 = Integer.parseInt(day2);
				//===查询该天有没有数据
				 Date time = null;
				 time = sft2.parse(strdata);
				 Long newDate = new Long(time.getTime());
				com.whir.ezoffice.workmanager.event.bd.EventBD eventBD = new com.whir.ezoffice.workmanager.event.bd.EventBD();
				List listInfo = eventBD.getDeskEvent(Long.valueOf(session.getAttribute("userId").toString()), newDate, new Long(domainId));
				if(listInfo.size()==0){
				
			%>
			 	<li  onclick="changeday1(this)" data="<%=daynum2%>"><%=daynum2%></li>
			<%} else if(listInfo.size()>0){%>
				  <li   onclick="changeday1(this)" data="<%=daynum2%>"><%=daynum2%><i class="wh-portal-schedule-red" >日程</i></li>
			<%} %>
			<% 	
				cal.add(Calendar.DATE, 1);
			%>
			<%	}%>
			<%
				cal.add(Calendar.DATE,-7);
				Date date3 = new Date();
				date3 = cal.getTime();
				SimpleDateFormat sft3 = new SimpleDateFormat("yyyy-MM-dd");
		    	strdata3 = sft3.format(date3);
			%>
            </ul>
        </div>
        
        <div class="wh-my-s-meeting" id="wh-my-s-meeting-<%=portletSettingId%>">
            <ul class="wh-my-s-meeting-ul clearfix" id="wh-my-s-meeting-ul-<%=portletSettingId%>">
                <li>
                    <div class="wh-my-s-meeting-day clearfix">
                        <div class="wh-my-meeting-day-slide" id="wh-my-meeting-day-slide-<%=portletSettingId%>">
                            <ul class="slides wh-my-meeting-day-ul">
							<%
								if(list != null && list.size() > 0){
									for (int i = 0; i < list.size(); i++) {
										ItemVO ivo = (ItemVO)list.get(i);
										String eventaddress = "";
										if(ivo.getPoptitle()!=null&&!"".equals(ivo.getPoptitle())){
											eventaddress = ivo.getPoptitle();
										}
										String title =ivo.getTitle().toString().length()>limitCharNum && limitCharNum>0 ? ivo.getTitle().toString().substring(0,limitCharNum)+"..." : ivo.getTitle().toString();
										String ivotime = "";
										if("1".equals(ivo.getIsConf())){
											ivotime=ivo.getTime()+"全天";
											
										}else{
											ivotime=ivo.getTime();
										}
								%>
                                <li>
                                <a href="javascript:void(0)" title="<%=ivo.getTitle()%>" onclick="gotoPortletURL(this, {lefturl:'<%=ivo.getLink()%>&fromdesktop=1&portletSettingId=<%=portletSettingId%>&cunnUserId=<%=session.getAttribute("userId")%>', righturl:'', winname:'', wintype:'1'});">
                                    <div class="wh-my-meeting-content">
                                        <div class="wh-my-meeting-address-time" >
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <th>地点：</th>
                                                    <td title="<%=eventaddress.replaceAll("\"","&quot;")%>">
                                                   <%  if(eventaddress.length()>9){%>
                                                   			<P ><%=eventaddress.substring(0,7)%></P>
                                                   		<%  if(eventaddress.length()>13){%>
                                                   			<P ><%=eventaddress.substring(7,13)+"..."%></P>
                                                   		<% }else{%>
                                                   			<P><%=eventaddress.substring(7,eventaddress.length())%></P>
                                                   		<% }%>
                                                   	
                                                   <% }else{%>
                                                    <%=eventaddress%>
                                                    <%} %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>时间：</th>
                                                    <td><%=ivotime%></td>
                                                </tr>
                                            </table>
                                        </div>
                                        
                                        <div class="wh-my-meeting-theme"><%=title%></div>
                                    </div>
                                    </a>
                                </li>
								<%}}%>
                                
                            </ul>
                        </div>
                    </div>
                </li>
                
            </ul>
        </div>
     </div>
<%} else{%>
	
           
	<%
	if(list != null && list.size() > 0){
	    for (int i = 0; i < list.size(); i++) {
	        ItemVO ivo = (ItemVO)list.get(i);
	        String title =ivo.getTitle().toString().length()>limitCharNum && limitCharNum>0 ? ivo.getTitle().toString().substring(0,limitCharNum)+"..." : ivo.getTitle().toString();
	%>
	<div class="wh-portal-i-item clearfix">
                    <a href="javascript:void(0)" onclick="gotoPortletURL(this, {lefturl:'<%=ivo.getLink()%>&fromdesktop=1&portletSettingId=<%=portletSettingId%>&cunnUserId=<%=session.getAttribute("userId")%>', righturl:'', winname:'', wintype:'1'});">
                        <i class="fa fa-file-o"></i>
                        <span title="<%=ivo.getTitle()%>"><%=title%></span>
                    </a>
                    <em class="wh-pending-em"><%=ivo.getTime()%></em>
      </div>
	<%}}%>
	
<% }%>
<%}%>

<script>
    $(function () {
        //我的日程
        /*----------我的日程 年月滚动----------*/
        $("#wh-schedule-time-box-<%=portletSettingId%>").flexslider({
            selector:"#wh-schedule-time-slide-<%=portletSettingId%> > li",
            animation: "slide",
            animationLoop: false,
            itemMargin: 7,
            directionNav: true,
            controlNav:false,
            slideshow: false
            // pausePlay: true
        });
        /*----------我的日程 日滚动----------*/
        $("#wh-my-s-date-list-<%=portletSettingId%>").flexslider({
            selector:"#wh-my-s-date-li-<%=portletSettingId%> > li",
            animation: "slide",
            animationLoop: false,
            itemWidth: 85,
            itemMargin: 0,
            minItems: 2,
            maxItems: 7,
            directionNav: true,
            controlNav:false,
            asNavFor: '#wh-my-s-meeting-<%=portletSettingId%>'
            // pausePlay: true
        });
        /*----------我的日程 点击某一日关联事务滚动----------*/
        $("#wh-my-s-meeting-<%=portletSettingId%>").flexslider({
	
            selector:"#wh-my-s-meeting-ul-<%=portletSettingId%> > li",
            animation: "slide",
            controlNav: false,
            directionNav: false,
            animationLoop: false,
            slideshow: false,
            sync: "#wh-my-s-date-list-<%=portletSettingId%>"
            // pausePlay: true
        });
        /*----------我的日程 具体事务滚动----------*/
        $('#wh-my-meeting-day-slide-<%=portletSettingId%>').flexslider({
		
            animation: "slide",
            animationSpeed: 400,
            animationLoop: false,
            itemWidth: 172,
            itemMargin: 20,
            controlNav: false,
            slideshow: false,
			
        });
    
	 $(".sche-no").click(function(){
            $(this).removeClass("flex-active-slide");
        })    
	
	
	  var portletSettingId = '<%=portletSettingId%>';
	  var currentDate = '<%=currentDate%>';
	    var currentDateday = '<%=currentDateday%>';
	 
  //绑定的点击事件，需要传入时间 和上月，下月。
	  $("#wh-schedule-time-box-<%=portletSettingId%> .flex-next").click(function(){
			mycanlendar.refresh($('#content_portletSettingId_'+portletSettingId), {portletSettingId:portletSettingId, type:'mycanlendar', isNext:"truemonth", currentDateday : currentDateday});
		
			
		});
	
	 $("#wh-schedule-time-box-<%=portletSettingId%> .flex-prev ").click(function(){
		  mycanlendar.refresh($('#content_portletSettingId_'+portletSettingId), {portletSettingId:portletSettingId, type:'mycanlendar', isPrev:"truemonth" ,currentDateday : currentDateday});
		  });
	  
	  //绑定的点击事件，需要传入时间 和上周，下周。
	  
	  $("#wh-my-s-date-list-<%=portletSettingId%> .flex-next").click(function(){
		
		  mycanlendar.refresh($('#content_portletSettingId_'+portletSettingId), {portletSettingId:portletSettingId, type:'mycanlendar', isNext:'trueday', currentDateday : currentDateday});
	});
	 $("#wh-my-s-date-list-<%=portletSettingId%> .flex-prev ").click(function(){
	
		  mycanlendar.refresh($('#content_portletSettingId_'+portletSettingId), {portletSettingId:portletSettingId, type:'mycanlendar', isPrev:'trueday' ,currentDateday : currentDateday});
	});
});
 
 

function changeday1(obj){
  	var portletSettingId = '<%=portletSettingId%>';
	var day = $(obj).attr("data");
	
	if(day<10){day ="0"+day;}
	var currentDateday = '<%=currentDateday%>';
	var strdata3 = '<%=strdata3%>';
	
	if(strdata3!=null&&""!=strdata3){
		var dataStr = strdata3.substring(0,7)+"-"+day;
		//alert(strdata3);
		//alert(dataStr);
		if(strdata3>dataStr){
			var monthstr=Number(strdata3.substring(5,7));
			monthstr = monthstr+1;//月份+1
			var yearstr=Number(strdata3.substring(0,4));
			if(monthstr<10){
				dataStr = yearstr+'-0'+monthstr+"-"+day;
			}
			if(monthstr>9&&monthstr<13){
				dataStr = yearstr+'-'+monthstr+"-"+day;
			}
			 if(monthstr>12){
			 	yearstr = yearstr+1;
				monthstr = monthstr-12;
				dataStr = yearstr+'-0'+monthstr+"-"+day;
			}
		}
		//alert(dataStr);
		   mycanlendar.refresh($('#content_portletSettingId_'+portletSettingId), {portletSettingId:portletSettingId, type:'mycanlendar' ,dataStr : dataStr,currentDateday : dataStr});
	}
}
</script>
