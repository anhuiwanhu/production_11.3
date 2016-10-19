<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script language="JavaScript" src="scripts/i18n/<%=whir_locale%>/MailResource.js" type="text/javascript"></script>

<script language="JavaScript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/MailResource.js" type="text/javascript"></script>

<%
    String cert = "";
	if(session.getAttribute("cert") !=null){
		cert = session.getAttribute("cert").toString();
	}
	String searchtype = request.getParameter("searchtype");
	if(searchtype==null){
	  searchtype = "allbox";
	}

	String userId = session.getAttribute("userId").toString();
%>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="innerMail!getSearchList.action" method="post" >

    <!-- SEARCH PART START -->  
    <%@ include file="/public/include/form_list.jsp"%>  
  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
        <tr>  
		    <input name="hassearch" id="hassearch" type="hidden">
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%>：&nbsp;</td>  
            <td class="whir_td_searchinput">  
				<input type="text" id="searchsubject" name="searchsubject" size="14" class="inputText" />  
            </td>  
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"mail","mail.scope")%>：</td>  
            <td class="whir_td_searchinput">  
			   <select name="searchtype" id="searchtype" style="margin:0px;" class="selectlist" onchange="chgsearchtype();">
			      <option value="allbox" <%if("allbox".equals(searchtype)){out.print("selected");}%> ><%=Resource.getValue(whir_locale,"mail","mail.allmaibox")%></option>
				  <option value="inbox" <%if("inbox".equals(searchtype)){out.print("selected");}%> ><%=Resource.getValue(whir_locale,"mail","mail.inbox")%></option>
                  <option value="sendbox" <%if("sendbox".equals(searchtype)){out.print("selected");}%>><%=Resource.getValue(whir_locale,"mail","mail.sendbox")%></option>
                  <option value="trashbox" <%if("trashbox".equals(searchtype)){out.print("selected");}%>><%=Resource.getValue(whir_locale,"mail","mail.trashbox")%></option>
                  <logic:iterate id="folderList" name="folderList" scope="request" >
                  <%Object[] obj = (Object[]) folderList;%>
                    <option  value="<%=obj[0]%>" <%if(searchtype !=null && searchtype.equals(obj[0]+"")){out.print("selected");}%>><%=obj[1]%></option>
                  </logic:iterate> 
				</select> 
            </td>  
            <td class="whir_td_searchtitle">
              <span id="poster" style="">
			  <%=Resource.getValue(whir_locale,"mail","mail.addresser")%>：
			  </span>
			  <span id="mailto" style="display:none">
			  <%=Resource.getValue(whir_locale,"mail","mail.sendto")%>：
			  </span>
			 </td>  
            <td class="whir_td_searchinput">  
                <input type="text" id="searchuser" name="searchuser" size="14" value="" class="inputText" />  
            </td>  
        </tr>  
        <tr>  
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%>：</td>  
            <td class="whir_td_searchinput" colspan="3">   
				<input type="text" class="Wdate whir_datebox" id="searchsendtime_s" name="searchsendtime_s" onfocus="WdatePicker({el:'searchsendtime_s'})"/>
				<%=Resource.getValue(whir_locale,"mail","mail.to1")%>
				<input type="text" class="Wdate whir_datebox" id="searchsendtime_e" name="searchsendtime_e" onfocus="WdatePicker({el:'searchsendtime_e'})"/>
            </td>  
            <td colspan="2" class="SearchBar_toolbar">  
                <!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->  
                <input type="button" class="btnButton4font"  onclick="searchform();"  value="<%=Resource.getValue(whir_locale,"common","comm.searchnow")%>" />  
                <!--resetForm(obj)为公共方法-->  
                <input type="button" class="btnButton4font" value="<%=Resource.getValue(whir_locale,"common","comm.clear")%>" onclick="chgsearchtype();" />  
            </td>  
        </tr>  
    </table>  
    <!-- SEARCH PART END -->   

	<!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr>
			<td align="left" width="55%">&nbsp;</td>
            <td align="right">
			    <span id="span_boxName" style="display:none">
				<input id="boxName" class="easyui-combobox111" name="boxName" data-options="valueField:'id',textField:'text',panelHeight:200,onSelect: function(record){moveMails(record);}" />  
				</span>
				<input type="button" class="btnButton4font" onclick="delMailToDeserted();" value="<%=Resource.getValue(whir_locale,"mail","mail.delete")%>" />
				<input type="button" class="btnButton4font" onclick="delMails();" value="<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>" />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer" whir-options="renderer:showread">
        <tr class="listTableHead">

             <%if("allbox".equals(searchtype)){%>
				<td whir-options="field:'mailuserid',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('mailuserid',this.checked);" ></td>
				<td whir-options="field:'notRead',width:'5%',renderer:showStat"><%=Resource.getValue(whir_locale,"mail","mail.status")%></td> 
				<td whir-options="field:'maillevel',width:'8%',renderer:showLevel"><%=Resource.getValue(whir_locale,"mail","mail.priority")%></td> 
				<td whir-options="field:'mailpostername', width:'10%',renderer:showPoster"><%=Resource.getValue(whir_locale,"mail","mail.addresser")%></td> 
				<td whir-options="field:'sendto',width:'10%',renderer:showsendto"><%=Resource.getValue(whir_locale,"mail","mail.sendto")%></td> 
				<td whir-options="field:'mailsubject', width:'45%',renderer:showTitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%></td> 
				<td whir-options="field:'accessorySize', width:'10%',renderer:showAcc"><%=Resource.getValue(whir_locale,"mail","mail.filesize")%></td> 
				<td whir-options="field:'mailposttime', width:'10%',renderer:getmailposttime"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%></td> 
             <%}else if("inbox".equals(searchtype)){%>
	    		<td whir-options="field:'mailuserid',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('mailuserid',this.checked);" ></td>
				<td whir-options="field:'notRead',width:'8%',allowSort:true,renderer:showStat"><%=Resource.getValue(whir_locale,"mail","mail.status")%></td> 
				<td whir-options="field:'maillevel',width:'10%',renderer:showLevel"><%=Resource.getValue(whir_locale,"mail","mail.priority")%></td> 
				<td whir-options="field:'mailpostername', width:'10%',allowSort:true,renderer:showPoster"><%=Resource.getValue(whir_locale,"mail","mail.addresser")%></td> 
				<td whir-options="field:'mailsubject', width:'45%',renderer:showTitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%></td> 
				<td whir-options="field:'accessorySize', width:'10%',allowSort:true,renderer:showAcc"><%=Resource.getValue(whir_locale,"mail","mail.filesize")%></td> 
				<td whir-options="field:'mailposttime', width:'15%',allowSort:true,renderer:getmailposttime"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%></td> 
	    	 <%}else if("sendbox".equals(searchtype)){%>
	    		<td whir-options="field:'mailuserid',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('mailuserid',this.checked);" ></td>
				<td whir-options="field:'sendto',width:'25%',renderer:showsendto"><%=Resource.getValue(whir_locale,"mail","mail.sendto")%></td> 
				<td whir-options="field:'title',width:'35%',renderer:showTitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%></td> 
				<td whir-options="field:'accessorySize', width:'10%',allowSort:true,renderer:showAcc"><%=Resource.getValue(whir_locale,"mail","mail.filesize")%></td> 
				<td whir-options="field:'mailposttime', width:'20%',renderer:getmailposttime"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%></td> 
	    	 <%}else if("trashbox".equals(searchtype)){%>
	    		<td whir-options="field:'mailuserid',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('mailuserid',this.checked);" ></td>
				<td whir-options="field:'poster',width:'18%',renderer:showPoster"><%=Resource.getValue(whir_locale,"mail","mail.addresser")%></td> 
				<td whir-options="field:'title',width:'40%',renderer:showTitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%></td> 
				<td whir-options="field:'acc', width:'10%',allowSort:true,renderer:showAcc"><%=Resource.getValue(whir_locale,"mail","mail.filesize")%></td> 
				<td whir-options="field:'mailposttime', width:'15%',renderer:getmailposttime"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%></td> 
				<td whir-options="field:'reveivetime', width:'15%',renderer:showreveivetime"><%=Resource.getValue(whir_locale,"mail","mail.reveivetime")%></td> 
	    	 <%}else{%>
	    		<td whir-options="field:'mailuserid',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('mailuserid',this.checked);" ></td>
				<td whir-options="field:'notRead',width:'8%',allowSort:true,renderer:showStat"><%=Resource.getValue(whir_locale,"mail","mail.status")%></td> 
				<td whir-options="field:'maillevel',width:'10%',renderer:showLevel"><%=Resource.getValue(whir_locale,"mail","mail.priority")%></td> 
				<td whir-options="field:'mailpostername', width:'10%',allowSort:true,renderer:showPoster"><%=Resource.getValue(whir_locale,"mail","mail.addresser")%></td> 
				<td whir-options="field:'mailsubject', width:'45%',renderer:showTitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%></td> 
				<td whir-options="field:'accessorySize', width:'10%',allowSort:true,renderer:showAcc"><%=Resource.getValue(whir_locale,"mail","mail.filesize")%></td> 
				<td whir-options="field:'mailposttime', width:'15%',allowSort:true,renderer:getmailposttime"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%></td> 
	    	 <%}%>

        </tr>
		</thead>
		<tbody  id="itemContainer">
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->
   
    <!-- PAGER START -->
    <table id="pagertab" width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
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
        var searchtype = $('#searchtype').val();
	    //initListFormToAjax({formId:"queryForm"});
	    $("#boxName").combobox("reload", 'innerMail!getMovetoBox.action?searchtype='+searchtype);
		if(searchtype=="sendbox"){
		   $('#poster').hide();
		   $('#mailto').show();
		}else{
		   $('#poster').show();
		   $('#mailto').hide();
		}
		if(searchtype=="allbox"){
		  $('#span_boxName').hide();
		}else{
		  $('#span_boxName').show();
		}
    });
    $('#itemContainer').hide();
    $('#pagertab').hide();
      
    //*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  
	
	function showreveivetime(po,i){
		var html = "&nbsp;";
		if(po.mailreceivetime!=null)
		   getFormatDateByLong(po.mailreceivetime, 'yyyy-MM-dd hh:mm');
		return html;
	}
	function showsendto(po,i){
		var html='';
		var rMailUserName = "";
		if(po.mailtosimple!=null){
		   rMailUserName = po.mailtosimple;
		}
		if(po.mailto!=null){
		   rMailUserName = rMailUserName+po.mailto;
		}
		var str = rMailUserName.split(",");
		var resultstr="";
        for(var k=0;k<str.length-1;k++){
		   if(str[k].indexOf(">")>0){
			  resultstr += str[k].substring(str[k].indexOf("<")+1,str[k].indexOf("/"))+",";
		   }else{
			  resultstr += str[k]+",";
		   }
	    }
		html = resultstr;
		return html;
	}
    function showread(po,i){
	   var rt = '';
	   if(po.notRead==1){
	      rt = 'style="color:red;"';
	   }
       return rt;
    }
	function showStat(po,i){
		var html='';

		if(po.notRead==1){
			html = '<img src="<%=rootPath%>/images/new_mail.gif" alt="<%=Resource.getValue(whir_locale,"mail","mail.notread")%>" width="15" height="11">';
		}else if (po.mailreturned==1){
			html = '<img src="<%=rootPath%>/images/reply.gif" alt="<%=Resource.getValue(whir_locale,"mail","mail.havereply")%>" width="17" height="17">';
		}else{
            html = '<img src="<%=rootPath%>/images/readmail.gif" alt="<%=Resource.getValue(whir_locale,"mail","mail.readedmail")%>" width="13" height="12">';
		}
		return html;
	}

    function showLevel(po,i){
		var html='';

		if(po.maillevel==0){
			html = '<%=Resource.getValue(whir_locale,"mail","mail.common")%>';
		}else if (po.maillevel==1){
			html = '<%=Resource.getValue(whir_locale,"mail","mail.important")%>';
		}else if (po.maillevel==2){
            html = '<%=Resource.getValue(whir_locale,"mail","mail.urgency")%>';
		}
		return html;
	}                         

	function showPoster(po,i){
		var html='';

		var sendMailUser = po.mailpostername;
		if(po.mailpostername==null){
		   sendMailUser = "&nbsp;";
		}
		  if(sendMailUser.indexOf(",") > 0){
			  sendMailUser = sendMailUser.substring(0, sendMailUser.indexOf(","));
		  }
		  if(sendMailUser.indexOf("<") > 0){
			  sendMailUser = sendMailUser.substring(sendMailUser.indexOf("<") + 1);
		  }
		  if(sendMailUser.indexOf("/") > 0){
			  sendMailUser = sendMailUser.substring(0, sendMailUser.indexOf("/"));
		  }
		  if(sendMailUser.indexOf("_") > 0){
			  sendMailUser = sendMailUser.substring(0, sendMailUser.indexOf("_"));
		  }
		  if(po.notRead==1){
			  html = sendMailUser;
		  }else{
			  if(sendMailUser.indexOf("匿名") > 0){
				html = '<%=Resource.getValue(whir_locale,"mail","mail.anonymous")%>';
			  }else{
				html = sendMailUser;
			  }
		  }

		  if(po.mailposterid=="<%=userId%>"){
		     html="我";
		  }

		return html;
	}
                                      
    function showTitle(po,i){
		//计算当前数据偏移量
		var index = i + parseInt(document.getElementById("start_page").value-1)*parseInt(document.getElementById("page_size").value);

		var html='';
		if(po.mailhasaccessory==1){
		   html +='<img src="images/fj2.gif" alt="<%=Resource.getValue(whir_locale,"mail","mail.fujian")%>">';
		}
        var mailtitle="";
		if(po.mailsubject==null){
		   mailtitle = "无主题";
		}else{
		   mailtitle = HtmlEncode(po.mailsubject);
		}
		if(po.encrypt!=null && po.encrypt==1){
		   mailtitle += "(<%=Resource.getValue(whir_locale,"mail","mail.encrypt")%>)";
		}
		if(po.notRead==1){
		  mailtitle = "<font color='red'>"+HtmlEncode(mailtitle)+"</font>";
		}

		if(po.encrypt==null || po.encrypt==0){
			html +=  '<a href="javascript:void(0)" onclick="view('+po.mailuserid+','+po.mailid+','+index+');">'+mailtitle+'</a>';  
		}else if ("<%=cert%>"=="JC_" && po.encrypt==1){
			html +=  '<a href="javascript:void(0)" onclick="view('+po.mailuserid+','+po.mailid+','+index+');">'+mailtitle+'</a>'; 
		}else{
            html += '<a href="javascript:void(0)" onclick="alertr();">'+HtmlEncode(po.mailsubject)+'</a>'; 
		}
		return html;
	}
	function view(mailuserid,mailid,index){
		//数据总条数
		var recordCount=document.getElementById("recordCount").value;
		var searchtype = $('#searchtype').val();
		var ahref='innerMail!viewMail.action?mailuserid='+mailuserid+'&mailid='+mailid+'&index='+index+'&recordCount='+recordCount;
		var frommod="";
		if(searchtype=="allbox"){
			frommod="allbox";
		}else if(searchtype=="inbox"){
			frommod="receivebox";
		}else if(searchtype=="sendbox"){
			frommod="sendedbox";
        }else if(searchtype=="trashbox"){
			frommod="desertedbox";
		}else{
			frommod="mailfolderlist";
			var boxId = $('#searchtype').val();
			
			ahref += '&boxId='+boxId;
		}
		ahref += '&frommod='+frommod;
	    openWin({url:ahref,isFull:'true',winName: 'viewmail'+mailid });
	}
	function alertr() {
	  alert(Mail.encryptmail);
	  return;
	}

	function showAcc(po,i){
		var html= "";
		if(po.accessorySize!=null && po.accessorySize!="null" && po.accessorySize!=""){
	       html= formatFileSize(po.accessorySize);
		}
	   return html;
	}

	function getmailposttime(po,i){
		//var html = getFormatDateByLong(po.mailposttime, 'yyyy-MM-dd hh:mm');
		var html = po.mailposttime.substring(0,16);
		return html;
	}

	function delMailToDeserted() {
		 ajaxBatchOperate({url:"innerMail!delMailToDeserted.action",checkbox_name:"mailuserid",attr_name:"mailuserid",tip:Mail.confirmsingletodrash2,isconfirm:true,formId:"queryForm",callbackfunction:null});
	}
	function delMails() {
		 ajaxBatchOperate({url:"innerMail!delMails.action",checkbox_name:"mailuserid",attr_name:"mailuserid",tip:'<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>',isconfirm:true,formId:"queryForm",callbackfunction:null});
	}
	function moveMails(obj) {
		 var boxId = $('#boxName').combobox('getValue');
	     ajaxBatchOperate({url:"innerMail!moveMails.action?boxId="+boxId,checkbox_name:"mailuserid",attr_name:"mailuserid",isconfirm:false,formId:"queryForm",callbackfunction:null});
		 $('#boxName').combobox('setValue', 0);
	}

	function changsearchtype(number){
		 var currentNumber = number.options[number.selectedIndex].value;
		 if(currentNumber ==1){
		 document.all.poster.style.display="";
		 document.all.mailto.style.display="none";
		 }
		if(currentNumber ==2){
		 document.all.poster.style.display="";
		 document.all.mailto.style.display="none";
		 }
		if(currentNumber ==3){
		 document.all.poster.style.display="";
		 document.all.mailto.style.display="none";
		 }
		 if(currentNumber ==4){
		 document.all.poster.style.display="none";
		 document.all.mailto.style.display="";
		 }
    }

	function searchform() {
	   var searchtype = $('#searchtype').val();
	   var searchsubject = $('#searchsubject').val();
	   var searchuser = $('#searchuser').val();
       $('#hassearch').val('1');

       if(searchtype!="-1"){

		  initListFormToAjax({formId:"queryForm"});
		  if(searchsubject.indexOf("'") >= 0){
			  whir_alert(Mail.querycondition,null);
		      document.getElementById("searchsubject").focus();
              return;
          }
		  if(searchuser.indexOf("'") >= 0){
			  whir_alert(Mail.querycondition,null);
		      document.getElementById("searchuser").focus();
              return;
          }
		  $('#itemContainer').show();
		  $('#pagertab').show();
          refreshListForm('queryForm');
	   }else{
	      whir_alert("请选择查询范围！",null);
          return;
	   }
	}
	function chgsearchtype() {

		var searchtype = $('#searchtype').val();
        if(searchtype!="-1"){
			/***
			whir_tips("",1,'',function(){
			  location_href('innerMail!searchList.action?searchtype='+searchtype);
			});
			**/
			location_href('innerMail!searchList.action?searchtype='+searchtype);
		}
	}
	
	function resetForm1(obj) {
      var searchtype = $('#searchtype').val();
      if(searchtype=="-1"){
		  location_href('innerMail!searchList.action');
	  }else{
	      resetForm(obj);
	  }
	  
	}
	
   </script>

</html>

