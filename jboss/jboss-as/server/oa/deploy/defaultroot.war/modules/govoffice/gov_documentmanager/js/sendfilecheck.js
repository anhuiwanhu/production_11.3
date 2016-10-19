//加入督办任务
function cmdGovUnionTask(){
	var url='/defaultroot/urgetask!addTask.action?actType=addTask&fromMod=filesendcheck&unionTaskTitle=' + ($("*[name='sendFileCheckTitle']").val() );
	
	openWin({url:url,width:600,height:500,winName:'cmdGovUnionTask'});
}


//word编辑正文
function accWordEdit(name,fileType, editType){

    var t_recordId="";
	var t_editType="0";
	var t_cansave="0";
	var t_showTempSign="0";
	var t_showTempHead="0";
	var t_showSiqn="0";
	var t_showSignButton="0";
	var t_showEditButton="0";
	var t_saveDocFile="0";
 
    t_recordId=eval("document.getElementsByName(\""+name+"\")[0].value");

	if(editType=="1"){
	  t_editType="1"; 
	  t_cansave="1"
	  t_showSignButton="1";
	  t_saveDocFile="1";
	  t_showEditButton="1";
	}
	//var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+t_recordId+"&EditType=0&UserName="+$("*[name='UserName']").val() +"&ShowSign=0&CanSave=1";
	var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+t_recordId+"&EditType="+t_editType+"&UserName="+$("*[name='UserName']").val() +"&CanSave="+t_cansave+"&showTempSign="+t_showTempSign+"&showTempHead="+t_showTempHead+"&ShowSign="+t_showSiqn+"&showSignButton="+t_showSignButton+"&showEditButton="+t_showEditButton+"&saveDocFile="+t_saveDocFile+"&moduleType=govdocument&textContent=-1&FileType="+fileType+"&field="+name
	openWin({url:url,width:620,height:350,winName:'_blank'});

  // window.open("/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+t_recordId+"&EditType="+t_editType+"&UserName="+document.all.UserName.value+"&CanSave="+t_cansave+"&showTempSign="+t_showTempSign+"&showTempHead="+t_showTempHead+"&ShowSign="+t_showSiqn+"&showSignButton="+t_showSignButton+"&showEditButton="+t_showEditButton+"&saveDocFile="+t_saveDocFile+"&moduleType=govdocument&textContent=-1&FileType="+fileType+"&field="+name, "editContent", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");


}


//检查页面参数有效性
function initPara() {
  if($("input[name='sendFileCheckComeUnit']").length > 0 ){
	 var value =  $("input[name='sendFileCheckComeUnit']").val();
	 if(/^ *$/g.test(value)){
		whir_alert("来文单位不能为空！");
		return false;
	 }
     
  }

  if($("input[name='sendFileCheckTitle']").length > 0 ){
     var value =  $("input[name='sendFileCheckTitle']").val();
	 if(/^ *$/g.test(value)){
		whir_alert("文件标题不能为空！");
		return false;
	 }
     
  }
//加入自定义表单中如果是空的话就判断是否为空
	var canSubmit = beforeSubmit();
		if(!canSubmit){
			return false;
		}

  return true;
}

//批阅正文
function cmdReadtext(){
	$("*[name='RecordID']").val($("*[name='content']").val() ) ;
	
	if( $("*[name='content']").val() == null || $("*[name='content']").val() == ""){
		alert("当前没有正文，不能批阅正文！");
		return;
	}
	
	var  myDatestr=""+new Date().getTime();
	var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+
		"&EditType=1&UserName="+$("*[name='UserName']").val()+"&CanSave=1&showTempSign=0&showTempHead=1&ShowSign=0&showSignButton=1&showTransPDF=1&showEditButton=1&saveDocFile=1&moduleType=govdocument&textContent=-1";
	openWin({url:url,width:620,height:350,winName:'afadfaf'});

	//var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val() +"&EditType=1&UserName="+$("*[name='UserName']").val()+"&ShowSign=0&CanSave=1";
	//openWin({url:url,width:620,height:350,winName:'sendtoother'});
}

//起草正文
function cmdWordWindowFirst(){
 
document.getElementsByName("RecordID")[0].value =document.getElementsByName("content")[0].value;
document.getElementsByName("showSignButton")[0].value="0";
document.getElementsByName("ShowSign")[0].value="-1";
 window.open("", "editContent", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
    form1.target="editContent";
    form1.submit();
 
 
}

/**保存**/
function cmdSaveclose(){
	if(wfCheckBeforeSaveClose()){
		$('#dataForm').attr("action","/defaultroot/GovDocSendCheckProcess!save.action");

		setCallBackName("saveOk");
		//$('#dataForm').submit();
		ok(0,document.getElementById("docinfo0"));
		//alert(document.getElementById("btn"));
		//document.getElementById("btn").click();
	}
}

function saveOk(){
	whir_alert("保存成功！",function(){window.close();});
	
}

//加入督办任务
function cmdGovUnionTask(){
	var url='/defaultroot/urgetask!addTask.action?actType=addTask&fromMod=filesendcheck&unionTaskTitle=' + $("*[name='sendFileCheckTitle']").val() ;
	
	openWin({url:url,width:600,height:500,isFull:true,winName:'cmdGovUnionTaskWin'});
}

 


function cmdViewtext(){
	$("*[name='RecordID']").val($("*[name='content']").val());
	var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?copyType=1&viewdoc=true&RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val() +"&ShowSign=0&CanSave=1";
	openWin({url:url,width:620,height:350,winName:'viewtext'});
}

//编号
function cmdPrint(){
   //打印
  //打印
	var from = document.getElementsByName("from").length >0 ? document.getElementsByName("from")[0].value : "";
	//postWindowOpen("/defaultroot/GovSendFileAction.do?action=listLoad&editId=590&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&tableId=24&recordId=590&processId=952&workId=3272378", "", "TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600");
	var url='/defaultroot/GovDocSendCheckProcess!showfile.action?p_wf_openType=print&flag=print&p_wf_recordId='+ $("*[name='p_wf_recordId']").val() + 
		'&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&p_wf_tableId='+ $("*[name='p_wf_tableId']").val() + '&p_wf_processId='
		+ $("*[name='p_wf_processId']").val()  +"&from="+from;;
	//alert(url);
	openWin({url:url,width:600,height:500,isFull:true,winName:'printWindow'});

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
