

var noteTimer=null;
function getNote(index,e){

	var xx = e.originalEvent.x || e.originalEvent.layerX || 0; 
var yy = e.originalEvent.y || e.originalEvent.layerY || 0; 


 var sTop=document.getElementById("mainContent").scrollTop;
 var noteDiv="noteDiv_"+index;
$("#"+noteDiv+"").css("float","right");
 $("#"+noteDiv+"").css("left",xx-200);
 $("#"+noteDiv+"").css("top",yy);
  $("#"+noteDiv+"").css("display","inline");
  //var d=document.getElementById(noteDiv);
 // d.style.left=event.x-200;
// alert(xx);
  // d.style.left=xx;
  //  d.style.top=yy;
 // d.style.top=event.y+sTop-30;
   // d.style.top=event.y-30;
  //d.style.display="inline";
}
function hiddenNote(dd){
	var dealFunct="closeNote('"+dd+"')";
  noteTimer=window.setTimeout(dealFunct,500);
}
function closeNote(dd){
	  var noteDiv="noteDiv_"+dd;
  var d=document.getElementById(noteDiv);
  d.style.display="none";
}
function lockedNote(){
  window.clearTimeout(noteTimer);
}
function setNote(obj,dd){
	document.getElementById(dd).value+=obj.innerText;
}
function setNoteExt(obj,dd,ddId,issueUnitName,issueUnitID){

	issueUnitID = '~' + issueUnitID + '~';
	var nameValue = document.getElementById(dd).value;
	var idValue = document.getElementById(ddId).value;
	if(obj.checked){
		nameValue +=issueUnitName + ',';
		idValue += issueUnitID + '';
	}else{
		var idIndex =idValue.indexOf(issueUnitID);
		var idLen = issueUnitID.length;
		var idPre = idValue.substring(0,idIndex);
		var idSuf = idValue.substring((idIndex + idLen)+1);

		idValue = idPre + idSuf;

		var nameIndex = nameValue.indexOf(issueUnitName);
		var nameLen = issueUnitName.length;
		var namePre = nameValue.substring(0,nameIndex);
		var nameSub = nameValue.substring((nameIndex+nameLen)+1);
		
		nameValue = namePre + nameSub;
	}
	document.getElementById(dd).value = nameValue;
	document.getElementById(ddId).value = idValue;
	
	//document.getElementById(dd).value+=obj.innerText;
}



//检查页面参数有效性
function initPara() {

  if($("input[name='documentSendFileTitle']")[0].value==""){
    whir_alert("标题不能为空！",function(){$("input[name='documentSendFileTitle']").focus()});
    return false;
  }

  if($("input[name='documentSendFileTitle']")[0].value.indexOf("#")>=0){
    whir_alert("标题不能含'#'",function(){$("input[name='documentSendFileTitle']").focus()});
     return false;
  }


 // if(!judgeSpword()){
	//return false;
  //}

 //if(!isPhone(document.all.field10)){
  // return false;
 // }
  
  if($("input[name='content']")[0].value==""){
      whir_alert("您还没有起草正文！");
     return false;
  
  }
  return true;
	/*
   if (checkTextLengthOnly(GovSendFileActionForm.documentSendFileTopicWord,200,"主题词")&& checkTextLengthOnly(GovSendFileActionForm.field1,20,"文号")&&checkNumber(GovSendFileActionForm.field2,"发文序号",99999)&&checkText(GovSendFileActionForm.documentSendFileTitle,95,"发文标题")&& checkNumber(GovSendFileActionForm.documentSendFilePrintNumber,"份数",9999)&&checkTextLengthOnly(GovSendFileActionForm.sendFileAccessoryDesc,500,"附件描述")&&checkTextLengthOnly(GovSendFileActionForm.toPerson1,200,"主送")&&checkTextLengthOnly(GovSendFileActionForm.toPersonBao,200,"抄报")&&checkTextLengthOnly(GovSendFileActionForm.toPerson2,200,"抄送")&&checkTextLengthOnly(GovSendFileActionForm.toPersonInner,200,"内部发送")
    ){
	 
	setNewUpdate();
	trimrnTitle();//去掉 标题与 附件描述的 换行
	return true;

   }else{
   
    return false;
   }*/
}


/**
保存草稿
*/
function cmdSaveDraft(){

	//if(!initPara()) return;
	$('#dataForm').attr("action","/defaultroot/GovDocSendProcess!saveDraft.action");

	setCallBackName("saveDraftOk");
	$('#dataForm').submit();
	//ok(0,$('#dataForm'));
}

function saveDraftOk(){
	whir_alert("保存成功！");
	window.close();
}

/**
起草正文
*/
function cmdWordWindowFirst(){

	var underwriteTime="";
	var hasSeal="";
	var departWord="";
	var  wordValue=$("*[name='sendFileDepartWord']")[0].value;   
	if(wordValue!=""){		 
		mystr=wordValue.split(";");      
		departWord=mystr[1];               
	}
	
	$("input[name='RecordID']")[0].value = $("input[name='content']")[0].value; // document.all.content.value;
	$("input[name='Template']")[0].value = "";
	$("input[name='showSignButton']")[0].value="0";
	$("input[name='ShowSign']")[0].value="-1";
	$("input[name='textContent']")[0].value="";
	$("input[name='loadTemp']")[0].value="0"
    // 选择 编辑 类型
   /* if(confirm(" 是否默认word起草正文？ \n 点‘确认’则默认word起草，点‘取消’则wps起草！")){
    document.all.documentWordType.value=".doc";
	document.all.FileType.value=".doc";	
	}else{
    document.all.documentWordType.value=".wps";
	document.all.FileType.value=".wps";
	}*/
	var  myDatestr=""+new Date().getTime(); 
	window.open("", "ec"+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
	form1.target="ec"+myDatestr;
	form1.submit();
}

//补发
function cmdSendToMyOther(){
	/*$.dialog({
		title:'补发',
		id: 'LHG1976DD',
			resize: false,
		height:300,
			width:620,
				max: false,
		min: false,
		
		content: 'url:',
		lock:true
	});*/
	//openWin({url:'',width:620,height:350,winName:'sendtoother'});
	//window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	//document.sendToMyOtherForm.target="target";
	//document.sendToMyOtherForm.submit();
//alert($("*[name='sendToMyOtherForm']"));
//alert(1);
		$("#sendToMyOtherForm").ajaxForm({
		     success: function(responseText){ 
			     popup({id:'LHG1976D1',title: '补发',fixed: true,  width:'300',left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
/*
				 $.dialog({
					title:'补发',
					id: 'LHG1976D1',
						resize: false,
					height:200,
						width:420,
							max: false,
					min: false,
					/* ifrst.html 和 second.html 中的代码请自行查看 * /
					content: responseText,
					lock:true
				});*/
			      // popup({title: '补发',fixed: true, left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			 }
		});	
		$("#sendToMyOtherForm").submit();
}

//分发范围
function cmdSendToMyRange(){
	//window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	//document.sendToMyForm.target="target";
	//document.sendToMyForm.sendFileId.value = document.all.editId.value;
	//document.sendToMyForm.submit();
		$("input[name='p_wf_recordId']")[0].value = $("input[name='p_wf_recordId']")[0].value;//form[name='sendToMyForm'] 

	openWin({url:"/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_range2.jsp?p_wf_recordId="+ $("input[name='p_wf_recordId']")[0].value,width:620,height:420,winName:'ddddddddddddddd'});
	return;
		var wind = window.open("about:blank","_blank","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");//openWin({url:"about:blank",width:620,height:420,winName:'windowsfffw'});
		$("#sendToMyForm").ajaxForm({
		     success: function(responseText){ 
				// alert(responseText);
				//openWin({url:"",width:620,height:420,winName:'ddddddddddddddd'});
				// openWin({url:"about:blank",width:620,height:350,winName:'aaadfdf'});
				// wind.document.write(responseText);
				// alert(responseText);
			     //  popup({id:'cmdSendToMyRange_show_pop',title: '分发范围',fixed: true,  width:'300',left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			 }
		});	
		$("#sendToMyForm").submit();
}

//下载文件
function cmdDowntext(){
	//alert(1);///defaultroot/public/upload/download/download.jsp?FileName=2013051414111050017252965.zip&name=%E6%B5%81%E7%A8%8B%E8%AF%B4%E6%98%8Ev1.0.zip&path=govdocumentmanager
		//window.location.href = '/defaultroot/public/upload/download/download.jsp?FileName='+$("*[name='content']").val()+'.doc&name='+encodeURIComponent($("*[name='documentSendFileTitle']").val())+'.doc&path=govdocumentmanager';
		location_href('/defaultroot/public/upload/download/download.jsp?verifyCode='+$("*[name='fileVerifyCode']").val()+'&FileName='+$("*[name='content']").val()+'.doc&name='+encodeURIComponent($("*[name='documentSendFileTitle']").val())+'.doc&path=govdocumentmanager');
		//window.location.href = 'http://192.168.0.28:7099/oafile/download.jsp?FileName='+document.getElementById("content").value+'.doc&name='+encodeURIComponent(document.getElementById("documentSendFileTitle").value)+'.doc&path=govdocumentmanager';
	
}
//编号
function cmdPrint(){
   //打印
var from = document.getElementsByName("from").length >0 ? document.getElementsByName("from")[0].value : "";
	
	//postWindowOpen("/defaultroot/GovSendFileAction.do?action=listLoad&editId=590&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&tableId=24&recordId=590&processId=952&workId=3272378", "", "TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600");
	var url='/defaultroot/GovDocSendProcess!showfile.action?p_wf_openType=modifyView&p_wf_recordId='+ $("*[name='p_wf_recordId']").val() + 
		'&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&p_wf_tableId='+ $("*[name='p_wf_tableId']").val() + '&p_wf_processId='
		+ $("*[name='p_wf_processId']").val() +"&from="+from  ;
	//alert(url);
	openWin({url:url,width:600,height:500,isFull:true,winName:'printWindow'});

}


function   changeSenddocumentWord(){
	
  var  wordValue=$("*[name='sendFileDepartWord']")[0].value;//document.all.sendFileDepartWord.value; 

     if(wordValue!=""){	
		  mystr=wordValue.split(";"); 	
	
          if(mystr.length>3){
				   var  sendWordId=mystr[0]; //机关代字 id 
			       var  sendWord=mystr[1];   //机关代字名
				   var  temId="";      //模班id 		
				   for(ii=2;ii<mystr.length;ii++){
                        temId+=mystr[ii]+";";
				   }
				   temId=temId.substring(0,temId.length-1);
				   
	               $("*[name='templateId']")[0].value=temId;	
				
				  
				   //document.all.templateId.value=temId;			 
			 }else{
				
				  var  sendWordId=mystr[0]; //机关代字 id 
			      var  sendWord=mystr[1];   //机关代字名
			      var  temId=mystr[2];      //模班id 		
			
	             // document.all.templateId.value=temId;	
				 $("*[name='templateId']")[0].value=temId;		
			
			 }         
                
	 }else{
		 $("*[name='templateId']")[0].value="";			
	    // document.all.templateId.value="";
	 
	 }  
	
	$("*[name='documentSendFileByteNumber']")[0].value="";	
	$("*[name='sendFilePoNumId']")[0].value="";	
	 //document.all.documentSendFileByteNumber.value="";
	 //document.all.sendFilePoNumId.value="";


}




//分发范围 显示
function cmdSendToMyRange_show(){
	
	//window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	//$("form[name='sendToMyForm']")[0].target="target";
	//$("form[name='sendToMyForm'] input[name='sendFileId']")[0].value = $("input[name='editId']")[0].value;//.submit();
	//$("form[name='sendToMyForm']")[0].submit();
	//document.sendToMyForm.target="target";
	//document.sendToMyForm.sendFileId.value = document.all.editId.value;
	//document.sendToMyForm.submit();

		$("form[name='sendToMyForm'] input[name='p_wf_recordId']")[0].value = $("input[name='p_wf_recordId']")[0].value;
		$("#sendToMyForm").ajaxForm({
		     success: function(responseText){ 
				 //  alert(responseText);
			       popup({id:'cmdSendToMyRange_show_pop',title: '分发范围',fixed: true, left: '50%', top: '50%',padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			 }
		});	
		$("#sendToMyForm").submit();
}

//发文分发
function cmdSendclose(){

    //sendClose();
    //openPupWin(CommonJSResource.rootPath+"/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp",500,250);
    //openPupWin(CommonJSResource.rootPath+"/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?sendFileId=" + document.all.editId.value+"&processId=" +document.all.processId.value +"&tableId=" +document.all.tableId.value + "&recordId=" + document.all.recordId.value +"&activityId=" + document.all.curActivityId.value+"&submitPersonId=" +document.all.submitPersonId.value+"&tranFromPersonId="+document.all.tranFromPersonId.value ,500,250);
	var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp" ;
	//openWin({url:hhref,width:620,height:350,winName:'SendcloseWin'});
	$.dialog({id:'SendcloseWinId',title:'分发',content: 'url:'+hhref+''});
}

//发文分发（发送到我的收文箱）  sendType:1 分发     sendType:0 转本部门    只有 分发 才计算在已查看用户之列
function cmdSendToMy(){
	var  toId=$("input[name='sendToMyId']")[0].value;

	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;

	var  p_wf_recordId=$("input[name='p_wf_recordId']")[0].value;//document.all.editId.value;
 	if(toName==""){
	    alert("请选择接收者");
	    return;
	}

	$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovDocSend!sendToMyReceive.action?sendType=0&p_wf_recordId="+p_wf_recordId+"&isEdit=1&documentSendFileTitle="+$("input[name='documentSendFileTitle']").val()+"&sendFileNeedMail="+$("input[name='sendFileNeedMail']").val()+"&sendFileNeedRTX="+$("input[name='sendFileNeedRTX']").val()+"&sendFileNeedSendMsg2="+$("input[name='sendFileNeedSendMsg2']").val()+"&isinmodijsp=0&isInModify=isInModify&sendStatus=&isSendToMyOther="+$("input[name='isSendToMyOther']").val());
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	//$("form[name='GovSendFileActionForm']")[0].submit();

	$("form[name='GovSendFileActionForm']").ajaxSubmit();
	alert("分发成功！");
	$("form[name='GovSendFileActionForm']")[0].target="";

   // document.all.GovSendFileActionForm.action="GovSendFileAction.do?action=sendToMy&sendType=0&sendToId="+toId+"&toName="+encodeURIComponent(toName)+"&editId="+editId+"&isEdit=1&documentSendFileTitle="+encodeURIComponent(document.all.sendFileTitle.value)+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value;
	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	//document.all.GovSendFileActionForm.submit();
    //document.all.GovSendFileActionForm.target="";
}


// 发文分发
function cmdSendToMy2(){
//< %=sendStatus% >

	var  toId=$("input[name='sendToMyId']")[0].value;

	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;

	var  p_wf_recordId=$("input[name='p_wf_recordId']")[0].value;//document.all.editId.value;

	if(toName==""){
	    whir_alert("请选择接收者");
	    return;
	}
	//$("#GovSendFileActionForm").ajaxForm({
		    // success: function(responseText){ 
					//alert("分发成功！");
					//var api = frameElement.api, W = api.opener; 
					//api.close();
					// $.dialog({id:'LHG1976D1'}).close();
			       //popup({id:'sendtoMyDialog',title: '补发',fixed: true, left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			// }
	//});	
	//$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+document.all.isSendToMyOther.value);
	$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovDocSend!sendToMyReceive.action?sendType=0&p_wf_recordId="+p_wf_recordId+"&isEdit=1&documentSendFileTitle="+$("input[name='documentSendFileTitle']").val()+"&sendFileNeedMail="+$("input[name='sendFileNeedMail']").val()+"&sendFileNeedRTX="+$("input[name='sendFileNeedRTX']").val()+"&sendFileNeedSendMsg2="+$("input[name='sendFileNeedSendMsg2']").val()+"&isinmodijsp=0&isInModify=isInModify&sendStatus=&isSendToMyOther="+$("input[name='isSendToMyOther']").val());
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	//$("form[name='GovSendFileActionForm']")[0].submit();

	$("form[name='GovSendFileActionForm']").ajaxSubmit();
	whir_alert("分发成功！");
	$("form[name='GovSendFileActionForm']")[0].target="";

	
	//alert(3);
	//$("#GovSendFileActionForm").submit();

	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	//document.all.GovSendFileActionForm.submit();
	//document.all.GovSendFileActionForm.target="";
}



// 发文分发
function cmdSendToMyDep(){
//< %=sendStatus% >


	var  toId=$("input[name='sendToMyId']")[0].value;

	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;

	var  p_wf_recordId=$("input[name='p_wf_recordId']")[0].value;//document.all.editId.value;

	if(toName==""){
	    alert("请选择接收者");
	    return;
	}
	//$("#GovSendFileActionForm").ajaxForm({
		    // success: function(responseText){ 
					//alert("分发成功！");
					//var api = frameElement.api, W = api.opener; 
					//api.close();
					// $.dialog({id:'LHG1976D1'}).close();
			       //popup({id:'sendtoMyDialog',title: '补发',fixed: true, left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			// }
	//});	
	//$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+document.all.isSendToMyOther.value);
	$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovDocSend!sendToMyReceive.action?sendType=0&p_wf_recordId="+p_wf_recordId+"&isEdit=1&documentSendFileTitle="+$("input[name='documentSendFileTitle']").val()+"&sendFileNeedMail="+$("input[name='sendFileNeedMail']").val()+"&sendFileNeedRTX="+$("input[name='sendFileNeedRTX']").val()+"&sendFileNeedSendMsg2="+$("input[name='sendFileNeedSendMsg2']").val()+"&isinmodijsp=0&isInModify=isInModify&sendStatus=&isSendToMyOther="+$("input[name='isSendToMyOther']").val());
	//$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	$("form[name='GovSendFileActionForm']")[0].submit();

	//$("form[name='GovSendFileActionForm']").ajaxSubmit();
	//alert("分发成功！");
	//$("form[name='GovSendFileActionForm']")[0].target="";

	/*
	var  toId=$("input[name='sendToMyId']")[0].value;

	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;

	var  p_wf_recordId=$("input[name='p_wf_recordId']")[0].value;//document.all.editId.value;

	if(toName==""){
	    alert("请选择接收者");
	    return;
	}
	//$("#GovSendFileActionForm").ajaxForm({
		    // success: function(responseText){ 
					//alert("分发成功！");
					//var api = frameElement.api, W = api.opener; 
					//api.close();
					// $.dialog({id:'LHG1976D1'}).close();
			       //popup({id:'sendtoMyDialog',title: '补发',fixed: true, left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			// }
	//});	
	//$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+document.all.isSendToMyOther.value);
	$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovDocSend!sendToMyReceive.action?p_wf_recordId="+p_wf_recordId+"&isEdit=1&documentSendFileTitle="+$("input[name='documentSendFileTitle']").val()+"&sendFileNeedMail="+$("input[name='sendFileNeedMail']").val()+"&sendFileNeedRTX="+$("input[name='sendFileNeedRTX']").val()+"&sendFileNeedSendMsg2="+$("input[name='sendFileNeedSendMsg2']").val()+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+$("input[name='isSendToMyOther']").val());
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	//$("form[name='GovSendFileActionForm']")[0].submit();

	$("form[name='GovSendFileActionForm']").ajaxSubmit();
	//alert("分发成功！");
	$("form[name='GovSendFileActionForm']")[0].target="";

	
	//alert(3);
	//$("#GovSendFileActionForm").submit();

	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	//document.all.GovSendFileActionForm.submit();
	//document.all.GovSendFileActionForm.target="";*/
}



//去掉所有的换行
String.prototype.Trimrn = function(){
	//return this.replace(/(^\s*)|(\s*$)/g, "");
	var reg = /[\r\n]/g; 
    return   this.replace(reg,"");
}


//补发直接发送
function cmdSupplySend(){
    if(!initPara()) return;

	if($("input[name='sendToId2']")[0].value==""){
		whir_alert("请选择要发送的人！");
		return;
	}

	$("form[name='GovSendFileActionForm']")[0].action="target";
	$("form[name='GovSendFileActionForm']")[0].submit();
    //GovSendFileActionForm.action = "< %=rootPath% >/GovSendFileAction.do?action=supplySend";
    //GovSendFileActionForm.submit();
}


//套用模板时检验
function checkTextBe(){
  //if(document.all.sendFileDepartWord.value==""){
  if( $("*[name='sendFileDepartWord']").val() == "" ){
   whir_alert("机关代字不能为空！");
   return false;
  }
  // if(document.all.documentSendFileTitle.value==""){
  if( $("*[name='documentSendFileTitle']").val() == "" ){
   whir_alert("标题不能为空！");
   return false;
  }

 return true;

}
function trimrnTitle(){
	var title=  $("*[name='documentSendFileTitle']").val() ;//document.all.documentSendFileTitle.value;
	title=title.Trimrn();
	//document.all.documentSendFileTitle.value=title;
	$("*[name='documentSendFileTitle']").val(title) ;


	var sendFileAccessoryDescStr=""+ $("*[name='sendFileAccessoryDesc']").val() ; //document.all.sendFileAccessoryDesc.value;
	sendFileAccessoryDescStr=sendFileAccessoryDescStr.Trimrn();
	//document.all.sendFileAccessoryDesc.value=sendFileAccessoryDesc;
	$("*[name='sendFileAccessoryDesc']").val(sendFileAccessoryDescStr);
}	

//生成正式文件
function cmdWordWindowDue(){
	 $("*[name='loadTemp']").val("1");
	 //document.all.loadTemp.value="1";
	 var underwriteTime="";
	 var hasSeal="";
	 var underwritePerson="";
	
	 underwriteTime=(($("*[name='signsendTime']").length > 0)?$("*[name='signsendTime']").val():"");
	// underwriteTime.replaceAll("/","-");

	 if(underwriteTime!=""){
	
	   underwriteTime=baodate2chinese(underwriteTime);
	 }

	 underwritePerson="";
	 hasSeal="1";	 
	  var departWord="";
	  
      var  wordValue=(( $("*[name='sendFileDepartWord']").length > 0)? $("*[name='sendFileDepartWord']").val():"");  
      if(wordValue!=""){		 
             mystr=wordValue.split(";");      
			  departWord=mystr[1];               
	  }
            
	 //检查
	 if(!checkTextBe()){
		 return ;
	 }

	trimrnTitle();//去掉 标题与 附件描述的 换行
	$("*[name='RecordID']").val($("*[name='content']").val());
	//document.all.RecordID.value = document.all.content.value;
	var rr ='';
	if($("*[name='documentSendFileSendTime']").length > 0){
	rr=$("*[name='documentSendFileSendTime']").val();
	rr=rr.replace("/","年");
	rr=rr.replace("/","月");
	rr=rr+"日"; 
	}
	
	//document.all.documentSendFileSendTime_1.value=rr;
	$("*[name='sendFileRedHeadId_1']").val( $("*[name='sendFileRedHeadId_1']")  );
	$("*[name='sendFileRedHeadId_1']").val( (( $("*[name='sendFileRedHeadId']").length > 0)? $("*[name='sendFileRedHeadId']").val():"") );
	//document.all.sendFileRedHeadId_1.value = ((document.all.sendFileRedHeadId)?document.all.sendFileRedHeadId.value:"");
	$("*[name='hasSeal']").val(hasSeal);
	//document.all.hasSeal.value =hasSeal;
	$("*[name='$underwriteTime']").val("[签发日期]"+underwriteTime);
	//document.all.$underwriteTime.value="[签发日期]"+underwriteTime;
	$("*[name='$sendFileGrade']").val(  "[办理缓急]"+((  $("*[name='sendFileGrade']").length > 0 )?   $("*[name='sendFileGrade']").val() :"") );

	//document.all.$sendFileGrade.value = "[办理缓急]"+((document.all.sendFileGrade)?document.all.sendFileGrade.value:"");

	$("*[name='$documentSendFileWriteOrg']").val(  "[拟稿单位]"+((  $("*[name='documentSendFileWriteOrg']").length > 0 )?   $("*[name='documentSendFileWriteOrg']").val() :"") );
	//document.all.$documentSendFileWriteOrg.value = "[拟稿单位]"+((document.all.documentSendFileWriteOrg)?document.all.documentSendFileWriteOrg.value:"");
	//document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"")+" "+((document.all.documentFileType)?document.all.documentFileType.value:"");
	
	$("*[name='$documentSendFileTopicWord']").val(  "[主题词]"+((  $("*[name='documentSendFileTopicWord']").length > 0 )?   $("*[name='documentSendFileTopicWord']").val() :"") );
	
	//document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"");

	$("*[name='$documentFileType']").val(  "[文件种类]"+((  $("*[name='documentFileType']").length > 0 )?   $("*[name='documentFileType']").val() :"") );

	//document.all.$documentFileType.value = "[文件种类]"+((document.all.documentFileType)?document.all.documentFileType.value:"");

	$("*[name='$toPerson1']").val(  "[主送]"+((  $("*[name='toPerson1']").length > 0 )?   $("*[name='toPerson1']").val() :"") );
	//document.all.$toPerson1.value = "[主送]"+((document.all.toPerson1)?document.all.toPerson1.value:"");

	$("*[name='$toPerson2']").val(  "[主送]"+((  $("*[name='toPerson2']").length > 0 )?   $("*[name='toPerson2']").val() :"") );
	//document.all.$toPerson2.value = "[抄送]"+((document.all.toPerson2)?document.all.toPerson2.value:"");

	if($("*[name='toPersonBao']").length > 0){
		$("*[name='$toPersonBao']").val(  "[抄报]"+((  $("*[name='toPersonBao']").length > 0 )?   $("*[name='toPersonBao']").val() :"") );
	  //document.all.$toPersonBao.value = "[抄报]"+((document.all.toPersonBao)?document.all.toPersonBao.value:"");
	}

	//if(document.all.toPersonInner){
	  //document.all.$toPersonInner.value = "[内部发送]"+((document.all.toPersonInner)?document.all.toPersonInner.value:"");
	//}
	$("*[name='$documentSendFilePrintNumber']").val(  "[共印]"+((  $("*[name='documentSendFilePrintNumber']").length > 0 )?   $("*[name='documentSendFilePrintNumber']").val() :"") );
	//document.all.$documentSendFilePrintNumber.value = "[共印]"+((document.all.documentSendFilePrintNumber)?document.all.documentSendFilePrintNumber.value:"");
	$("*[name='$sendFileDepartWord']").val(   "[机关代字]"+departWord );
	//document.all.$sendFileDepartWord.value = "[机关代字]"+departWord;

	$("*[name='$senddocumentTitle']").val(   "[发文标题]"+((  $("*[name='documentSendFileTitle']").length > 0 )?   $("*[name='documentSendFileTitle']").val() :"") );
	//document.all.$senddocumentTitle.value = "[发文标题]"+((document.all.documentSendFileTitle)?document.all.documentSendFileTitle.value:"");

	$("*[name='$underwritePerson']").val(   "[签发人]"+underwritePerson );
	//document.all.$underwritePerson.value = "[签发人]"+underwritePerson;

	$("*[name='$securityGrade']").val(   "[秘密级别]"+((  $("*[name='documentSendFileSecurityGrade']").length > 0 )?   $("*[name='documentSendFileSecurityGrade']").val() :"") );
	//document.all.$securityGrade.value = "[秘密级别]"+((document.all.documentSendFileSecurityGrade)?document.all.documentSendFileSecurityGrade.value:"");
	//document.all.$documentSendFilePrintNumber.value = "[印刷份数]"+document.all.documentSendFilePrintNumber.value;

	$("*[name='$documentSendFileSendTime']").val(   "[印发日期]"+rr);
	//document.all.$documentSendFileSendTime.value = "[印发日期]"+rr;
	//document.all.$documentSendFileSendTime.value = "[印发时间]"+rr;
	//document.all.$sendFileAccessoryDesc.value = "[附件描述]"+((document.all.sendFileAccessoryDesc)?document.all.sendFileAccessoryDesc.value:"");
	$("*[name='$sendFileAccessoryDesc']").val(   "[附件描述]"+((  $("*[name='sendFileAccessoryDesc']").length > 0 )?   $("*[name='sendFileAccessoryDesc']").val() :"") );

	//document.all.$sendfileNUM.value = "[文号]"+((document.all.documentSendFileByteNumber)?document.all.documentSendFileByteNumber.value:"");
	$("*[name='$sendfileNUM']").val(   "[文号]"+((  $("*[name='documentSendFileByteNumber']").length > 0 )?   $("*[name='documentSendFileByteNumber']").val() :"") );

	//document.all.$field10.value = "[联系电话]"+((document.all.field10)?document.all.field10.value:"");

	$("*[name='$field10']").val(   "[联系电话]"+((  $("*[name='field10']").length > 0 )?   $("*[name='field10']").val() :"") );

	$("*[name='$sendFileDraft']").val(   "[拟稿人]"+((  $("*[name='sendFileDraft']").length > 0 )?   $("*[name='sendFileDraft']").val() :"") );
	//document.all.$field10.value = "[联系电话]"+document.all.field10.value;
	//document.all.$sendFileDraft.value="[拟稿人]"+((document.all.sendFileDraft)?document.all.sendFileDraft.value:"");

	//document.all.$zjkySeq.value="[流水号]"+((document.all.zjkySeq)?document.all.zjkySeq.value:"");
	$("*[name='$zjkySeq']").val(   "[流水号]"+((  $("*[name='zjkySeq']").length > 0 )?   $("*[name='zjkySeq']").val() :"") );

	//document.all.$zjkySecrecyterm.value="[保密期限]"+((document.all.zjkySecrecyterm)?document.all.zjkySecrecyterm.value:"");

	$("*[name='$zjkySecrecyterm']").val(   "[保密期限]"+((  $("*[name='zjkySecrecyterm']").length > 0 )?   $("*[name='zjkySecrecyterm']").val() :"") );

	$("*[name='$zjkyContentLevel']").val(   "[内容紧急]"+((  $("*[name='zjkyContentLevel']").length > 0 )?   $("*[name='zjkyContentLevel']").val() :"") );
	//document.all.$zjkyContentLevel.value="[内容紧急]"+((document.all.zjkyContentLevel)?document.all.zjkyContentLevel.value:"");

	$("*[name='$documentSendFileCounterSign']").val(   "[会签单位]"+((  $("*[name='documentSendFileCounterSign']").length > 0 )?   $("*[name='documentSendFileCounterSign']").val() :"") );
	//document.all.$documentSendFileCounterSign.value="[会签单位]"+((document.all.documentSendFileCounterSign)?document.all.documentSendFileCounterSign.value:"");

	$("*[name='$openProperty']").val(   "[公开属性]"+((  $("*[name='openProperty']").length > 0 )?   $("*[name='openProperty']").val() :"") );

	//document.all.$openProperty.value="[公开属性]"+((document.all.openProperty)?document.all.openProperty.value:"");

	//document.all.$documentSendFileCheckDate.value="[呈送签批时间要求]"+document.all.documentSendFileCheckDate.value;

	if($("*[name='$sendFileFileType']").length > 0 && $("*[name='sendFileFileType']").length > 0){
		$("*[name='$sendFileFileType']").val(   "[文件类别]"+((  $("*[name='sendFileFileType']").length > 0 )?   $("*[name='sendFileFileType']").val() :"") );
	}

	//if(document.all.sendFileFileType && document.all.$sendFileFileType){
		//document.all.$sendFileFileType.value="[文件类别]" + document.all.sendFileFileType.value;
	//}

	if( $("*[name='documentSendFileTime']").length > 0){
	//if(document.all.documentSendFileTime){
		 var  nigaoshijian= $("*[name='documentSendFileTime']").val(); //document.all.documentSendFileTime.value;
	     nigaoshijian=nigaoshijian.replace("/","年");
		 nigaoshijian=nigaoshijian.replace("/","月");
		 nigaoshijian=nigaoshijian+"日";
		 $("*[name='$documentSendFileTime']").val("[拟稿日期]"+nigaoshijian);
		 // document.all.$documentSendFileTime.value="[拟稿日期]"+nigaoshijian;	
	}
	if( $("*[name='showTempSign']").length > 0){
		$("*[name='showTempSign']").val("1");
	}

	//if(document.all.showTempSign)
	//document.all.showTempSign.value="1";
	if( $("*[name='showTempHead']").length > 0){
		$("*[name='showTempHead']").val("1");
	}

	//if(document.all.showTempHead)
	//document.all.showTempHead.value="1";

	if( $("*[name='showTransPDF']").length > 0){
		$("*[name='showTransPDF']").val("1");
	}
	//if(document.all.showTransPDF)
	//document.all.showTransPDF.value="1";

	if( $("*[name='FileType']").length > 0){
		$("*[name='FileType']").val(   ((  $("*[name='documentWordType']").length > 0 )?   $("*[name='documentWordType']").val() :"")  );
	}

	//if(document.all.FileType)
	//document.all.FileType.value=((document.all.documentWordType)?document.all.documentWordType.value:"");
	

	if( $("*[name='wordId']").length > 0){
		//$("*[name='wordId']").val(   ((  $("*[name='documentWordType']").length > 0 )?   $("*[name='documentWordType']").val() :"")  );

		 var  wordValue=((  $("*[name='sendFileDepartWord']").length > 0 )?   $("*[name='sendFileDepartWord']").val() :"") ;//((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
		 if(wordValue!=""){		 
				 mystr=wordValue.split(";");    
				 $("*[name='wordId']").val( mystr[0] );
				// document.all.wordId.value=mystr[0];               
		 }else{
			// document.all.wordId.value="";	 
			  $("*[name='wordId']").val( "" );
		 }  	
	}

	//if(document.all.wordId){
   // var  wordValue=((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
    // if(wordValue!=""){		 
        //     mystr=wordValue.split(";");    
		//	 document.all.wordId.value=mystr[0];               
	 //}else{
	    // document.all.wordId.value="";	 
	// }  	
	//}

	 var  templateIds=(  $("*[name='templateId']").length > 0 )?   $("*[name='templateId']").val() :"" ;//((document.all.templateId)?document.all.templateId.value:"");

	 var  templateArr=templateIds.split(";");

	 if(templateArr.length>1){ 
		 alert("ok");
	   // postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/senddocument_singleTemplate.jsp?templates="+((document.all.templateId)?document.all.templateId.value:""), "fff", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
	 }else{
	  var  myDatestr=""+new Date().getTime();  
	  $("*[name='Template']").val(  ((  $("*[name='templateId']").length > 0 )?   $("*[name='templateId']").val() :"") );
	 //document.all.Template.value = ((document.all.templateId)?document.all.templateId.value:"");
	 window.open("", "ec2"+$("*[name='RecordID']").val()+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
	// form1.target="ec2"+document.all.RecordID.value+myDatestr;
	 
	 form1.target="ec2"+ $("*[name='RecordID']").val()+myDatestr;
	
	 form1.submit();
	 //alert(1);
	 managerDueWord();
	 }
    //setdispaly();
}


function selecttw() {
  var hhref = "GovDocSend!chooseSendTopical.action" ;
  openWin({url:hhref,width:620,height:350,winName:'sendToReceive'});
 // postWindowOpen(hhref,'','TOP=0,LEFT=0,scrollbars=yes,resizable=no,width=600,height=300') ;
}


// 生成正文管理文件

 function managerDueWord(){
   if($("*[name='content']").val() !=""){
    var oldName=$("*[name='contentAccSaveName']").val()  ;
	if(oldName==""){
		$("*[name='contentAccSaveName']").val($("*[name='content']").val() + $("*[name='documentWordType']").val()    )  ;
	// document.all.contentAccSaveName.value=document.all.content.value+document.all.documentWordType.value;
     //document.all.contentAccName.value=document.all.documentSendFileTitle.value+document.all.documentWordType.value;
		$("*[name='contentAccName']").val($("*[name='documentSendFileTitle']").val() + $("*[name='documentWordType']").val()    )  ;
	}else{
        var  name= $("*[name='content']").val() + $("*[name='documentWordType']").val()     ;//document.all.content.value+document.all.documentWordType.value;
        var resultJ=oldName.indexOf(name);
		if(resultJ==-1){
			$("*[name='contentAccSaveName']").val( $("*[name='content']").val() + $("*[name='documentWordType']").val() );
          // document.all.contentAccSaveName.value+="|"+document.all.content.value+document.all.documentWordType.value;
           //document.all.contentAccName.value+="|"+document.all.documentSendFileTitle.value+document.all.documentWordType.value;		
		   $("*[name='contentAccName']").val( $("*[name='documentSendFileTitle']").val() + $("*[name='documentWordType']").val() );
		}
	
	}
    
   
   }
 
 }



//选择主送 ，抄送
function openEndowSend(type){

	if(type=="toPerson1"){   
		//openEndow('toPerson1Id','toPerson1',document.all.toPerson1Id.value,document.all.toPerson1.value,'userorggroup','no','userorggroup','*0*');
		openSelect({allowId:'toPerson1Id', allowName:'toPerson1', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}
	if(type=="toPerson2"){   
		//openEndow('toPerson2Id','toPerson2',document.all.toPerson2Id.value,document.all.toPerson2.value,'userorggroup','no','userorggroup','*0*');
		openSelect({allowId:'toPerson2Id', allowName:'toPerson2', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}

	if(type=="toPersonBao"){   
		//openEndow('toPersonBaoId','toPersonBao',document.all.toPersonBaoId.value,document.all.toPersonBao.value,'userorggroup','no','userorggroup','*0*');
		openSelect({allowId:'toPersonBaoId', allowName:'toPersonBao', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}

	if(type=="toPersonInner"){   
		//openEndow('toPersonInnerId','toPersonInner',document.all.toPersonInnerId.value,document.all.toPersonInner.value,'org','no','org','*0*');
		openSelect({allowId:'toPersonInnerId', allowName:'toPersonInner', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}
}


//转收文
function cmdSendToReceive(){

	openWin({url:'/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?isMyReceiveDoc=1&receiveFileSendFileUnit='+(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&seqNum="+(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+(document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"") +'&accessorySaveName='+(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='+(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='+(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),width:620,height:350,winName:'sendToReceive'});
}


//转本部门
function cmdDepartSend(){
	var canDownLoad = $("#canDownLoad").val();
   	var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMyDep.jsp?todeaprat=1&tranType=1&canDownLoad="+canDownLoad ;
	openWin({url:hhref,width:620,height:420,winName:'SendcloseWinId'});
}


//收文 转文件送审签
function  cmdToSendfilecheck(){
	//postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?id="+document.all.editId.value+"&sendType=sendFile&fileTitle="+document.all.documentSendFileTitle.value+"&accessory1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
	//postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?sendFileCheckComeUnit=初始化组织.初始二级组织.初始三级组织&id="+document.all.editId.value+"&sendType=sendFile&sendFileCheckComeUnit=&fileTitle=test&accessory1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
	//openWin({url:'/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp',width:620,height:350,winName:'sendToReceive'});
	$.dialog({
		title:'转文件送审签',
		id: 'LHG1976DE',
			resize: false,
		height:200,
			max: false,
    min: false,

			width:420,
		/* ifrst.html 和 second.html 中的代码请自行查看 */
		content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?sendFileCheckComeUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+document.getElementsByName("documentSendFileByteNumber")[0].value+"&seqNum="+(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) +'&accessorySaveName='+(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='+(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='+(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
		lock:true
	});
}

//公文交换
function  cmdGovExchange(){
	
	var url = "/defaultroot/GovExchange!load.action?editId=" +  $("input[name='p_wf_recordId']")[0].value +"&tableId="+  $("input[name='p_wf_tableId']")[0].value;
	openWin({url:url,width:620,height:350,winName:'govexchange'});
	//alert("暂未实现！");
	return;
	openPupWinScroll("/defaultroot/ExchangeAction.do?action=load&editId=" + document.all.editId.value+"&tableId=62",'width=600,height=500');
}

//
function cmdViewtext(){
	$("*[name='RecordID']").val($("*[name='content']").val());
	
	var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?viewdoc=true&RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val() +"&ShowSign=0&CanSave=1";
	openWin({url:url,width:620,height:350,winName:'viewtext'});
}
//批阅正文
function cmdReadtext(){
	$("*[name='RecordID']").val($("*[name='content']").val() ) ;
	

	var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val() +"&EditType=1&UserName="+$("*[name='UserName']").val()+"&ShowSign=0&CanSave=1";
	openWin({url:url,width:620,height:350,winName:'sendtoother'});
}

//查看历史痕迹
function cmdReadHistorytext(){
/*弹出WORK编辑器，编辑正文*/
$("*[name='RecordID']").val($("*[name='content']").val() ) ;
 var url="/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val()+"&CanSave=0&showTempSign=0&showTempHead=1&ShowSign=0&showSignButton=1&showEditButton=0&saveDocFile=0&moduleType=govdocument&textContent=-1&FileType="+$("*[name='documentWordType']").val()+"&isViewOld=1";
 openWin({url:url,width:620,height:350,winName:'sendtoother'});

}


//已查看用户
function showHasRead() {	postWindowOpen('/defaultroot/GovReceiveFileBoxAction.do?action=userinfo&type=showHasRead&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

//未查看用户
function showNotRead() {	postWindowOpen('/defaultroot/GovReceiveFileBoxAction.do?action=userinfo&type=showNotRead&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

//查看传阅
function viewRead(){
		alert("暂未实现！");
	return;
	postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_Read_main.jsp?tableId="+document.all.tableNameOrId.value+"&processId="+document.all.read_processId.value+"&recordId="+document.all.editId.value,'查看传阅','menubar=0,scrollbars=0,locations=0,width=800,height=600,resizable=no');
}

//阅读情况
function cmdGovRead(){

	
	//alert("暂未实现！");
	//return;
	//postWindowOpen('/defaultroot/GovReceiveFileBoxAction.do?action=userinfo&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
	//var url='/defaultroot/GovDocSend!userinfo.action?type=0&editId='+$("*[name='editId']").val();

	var url='/defaultroot/modules/govoffice/gov_documentmanager/readInfo.jsp?id='+$("*[name='p_wf_recordId']").val();
	openWin({url:url,isFull:true,winName:'readinfo'});
	

}


//查看正文
	function  cmdSeeWord(){
						$("*[name='RecordID']").val($("*[name='content']").val());
				        var url="";
			        	url="/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val()+"&CanSave=1&hiddenStatus=1&showTempSign=2&showTempHead=1&ShowSign=0&showSignButton=1&showEditButton=0&FileType="+$("*[name='documentWordType']").val() ;
				       if(document.all.sendFileCheckTitle){
							url+="&copyType=1";
				       }
					 //  alert(url);
						openWin({url:url,width:620,height:350,winName:'seeword'});

	//var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val() +"&ShowSign=0&CanSave=1";
	//openWin({url:url,width:620,height:350,winName:'viewtext'});
					//	openWin({url:'',width:620,height:350,winName:'sendtoother'});
                    //  postWindowOpen(url, "editContent", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
					
	}
//编号
function cmdChangeNumber(){
   
	var  wordValue=$("*[name='sendFileDepartWord']").val(); 

     if(wordValue!=""){		 
             mystr=wordValue.split(";");      
       		 var  sendWordId=mystr[0];
			
	   if(sendWordId==""){
		  whir_alert("请先选择机关代字！");
        return ;

          }else{
			  //openPupWin("/defaultroot/GovSendFileAction.do?action=initZjkySendWord&sendWordId="+sendWordId+"&changeNumType=add",400,200);
	//openPupWin("/defaultroot/GovSendFileAction.do?action=initZjkySendWord&sendWordId="+sendWordId+"&changeNumType=add",400,200);
   				popup({id:'cmdChangeNumber_pop',title: '编号',fixed: true, left: '50%', top: '50%',width:'400px',padding: 0,drag: true, resize: true,lock: true,content: 'url:GovDocSend!initZjkySendWord.action?sendWordId='+sendWordId+'&changeNumType=add'}); 	
		   }
                
	 }else{
		 whir_alert("请先选择机关代字！");
	 
	  return;
	 
	 }       

}

//加入督办任务
function cmdGovUnionTask(){

	var url='/urgetask!addTask.action?actType=addTask&fromMod=sendfile&unionTaskTitle=' + $("*[name='documentSendFileTitle']").val() ;
	
	openWin({url:url,width:600,height:500,winName:'cmdGovUnionTask'});
	
	}



/*选择文号*/
function changeNumber2(){
    if(GovSendFileActionForm.documentSendFileHead.value ==-1) {
    GovSendFileActionForm.documentSendFileByteNumber.value = "" ;
	if(GovSendFileActionForm.field1&&GovSendFileActionForm.field1.type!="hidden")
    GovSendFileActionForm.field1.value = "" ;
    if(GovSendFileActionForm.field2&&GovSendFileActionForm.field2.type!="hidden")
    GovSendFileActionForm.field2.value = "" ;
	if(GovSendFileActionForm.field3&&GovSendFileActionForm.field3.type!="hidden")
	GovSendFileActionForm.field3.value = "" ;
    return ;
    }
    document.all.ifrm.src = "/defaultroot/GovSendFileAction.do?action=initNumber&fileNumberId="+GovSendFileActionForm.documentSendFileHead.value+"&sendFileYear="+ GovSendFileActionForm.field2.value;
}

/**保存**/
function cmdSaveclose(){
	if(wfCheckBeforeSaveClose()){
		$('#dataForm').attr("action","/defaultroot/GovDocSendProcess!save.action");

		//setCallBackName("saveOk");
		//$('#dataForm').submit();
		ok(0,document.getElementById("docinfo0"));
		//alert(document.getElementById("btn"));
		//document.getElementById("btn").click();
	}
}



//退回
function cmdBackDoc(){
	//sendFileUserId='+po.sendFileUserId+'&empId='+po.empId +'&id='+po.id
		//打开退回窗口
		openWin({url:"/defaultroot/modules/govoffice/gov_documentmanager/sendocument_back.jsp?close=true&sendFileUserId=" + document.getElementsByName("sendFileUserId")[0].value+"&empId=" + document.getElementsByName("empId")[0].value+"&id=" + document.getElementsByName("sendFileId")[0].value,width:620,height:420,winName:'ddddddddddddddd'});
	    
		return;
		ajaxOperate( {
			urlWithData: url, // 业务访问的url地址：带数据.
			tip:'退回', // 提示.
			isconfirm:true , // 是否需要确认提示.
			formId:'queryForm' , // 待刷新列表的表单id.
			callbackfunction:null // 回调函数.
		});
	
}


function cmdClose(){
	if(window.confirm("确定关闭窗口？")){
		window.close();
	}
}

function saveOk(){
	//whir_alert("保存成功！");
	//window.close();
}

//加入督办任务
function cmdGovUnionTask(){
	var url='/defaultroot/urgetask!addTask.action?actType=addTask&fromMod=sendfile&unionTaskTitle=' + $("*[name='documentSendFileTitle']").val() ;
	
	openWin({url:url,width:600,height:500,isFull:true,winName:'cmdGovUnionTaskWin'});
}

$(document).ready(function(){
		/*
		if($("input[name='documentSendFileTitle']").length >0){
			$("input[name='documentSendFileTitle']").change(function(){
				$("#p_wf_titleFieldName").val($("input[name='documentSendFileTitle']").val());
	
			});
		}*/
});
