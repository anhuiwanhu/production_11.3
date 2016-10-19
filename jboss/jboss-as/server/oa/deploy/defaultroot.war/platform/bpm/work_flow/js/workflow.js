 /**
 流程发起
 */
function  cmdSend(){
	if(!judgePageIsShowAll()){
		whir_alert(workflowMessage_js.waitingload,function(){});
		return false;
	}
     
	// $("#dataForm").attr("action","/defaulrtoot/wfoperate!showSend.action");
 
    $("#dataForm").attr("action",whirRootPath+"/wfoperate!showStart.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
   	setWf_dialog_title(workflowMessage_js.startProcess);
    $("#dataForm").submit();
}

function  cmdEnd(){
   alert("cmdEnd");
}


/**
 关联流程
 */
function cmdRelation(){

     refreshRelation();
     var url=whirRootPath+"/wfdealwith!dealwithList.action?openType=relation&relation=1";
	 var processId=$("#p_wf_processId").val(); 
	 var recordId=$("#p_wf_recordId").val();
	 var moduleId=$("#p_wf_moduleId").val();
	 if(recordId==""||recordId=="null"){
		 recordId="-1";
	 }
	 url+="&rmoduleId="+moduleId+"&rrecordId="+recordId;   
	 popup({id:'relation',title:  workflowMessage_js.Relatedworkflow,fixed: true, width:'95%',height:'580px',top: '10%',autoSize:true,padding: 0,drag: true,lock: true,content: 'url:'+url}); 
   //popup({id:'relation',title: workflowMessage_js.Relatedworkflow,fixed: true,width:'95%',height:'580px',top: '100%', autoSize:true,padding: 0,drag: true,lock: true,content: 'url:'+url}); 
}


/**
退回
*/
function cmdBack(){
	 var url=whirRootPath+"/wfbuttonevent!showBack.action?";
    	// p_wf_isForkTask p_wf_workStatus p_wf_stepCount p_wf_tableId  p_wf_recordId
		// p_wf_forkStepCount p_wf_forkId p_wf_cur_activityId
     var para="p_wf_tableId="+$("#p_wf_tableId").val()+"&p_wf_recordId="+$("#p_wf_recordId").val()+
		      "&p_wf_workStatus="+$("#p_wf_workStatus").val()+"&p_wf_isForkTask="+$("#p_wf_isForkTask").val()+
		      "&p_wf_stepCount="+$("#p_wf_stepCount").val()+"&p_wf_forkStepCount="+$("#p_wf_forkStepCount").val()+
		      "&p_wf_forkId="+$("#p_wf_forkId").val()+"&p_wf_cur_activityId="+$("#p_wf_cur_activityId").val();
 
	 url=url+para;

	 url=encodeURI(url);

	 //'视窗11',width:'640px',height:'400px'

	 popup({id:'workflowDialog',title: workflowMessage_js.newactivitybuttonback,width:'640px',height:'400px',fixed: true, autoSize:true,padding: 0,drag: true,lock: true,resize: true,content: 'url:'+url}); 
}


/**
 打印
*/
function cmdPrint(){
       
	//updatePrint('add');
    //打开打印页面
    var openurl=whirRootPath+"/PrintForm!printForm.action";
	var para="?p_wf_workId="+$("#p_wf_workId").val()+"&wfWorkId="+$("#p_wf_workId").val()+"&p_wf_recordId="+$("#p_wf_recordId").val()+
		     "&p_wf_processId="+$("#p_wf_processId").val()+"&p_wf_tableId="+$("#p_wf_tableId").val()+
		     "&p_wf_openType="+$("#p_wf_openType").val()+"&verifyCode="+$("#verifyCode").val()+"&p_wf_isprint=1";

	openurl=openurl+para;
    //openWin({url:openurl,width:850,height:750,winName:'openWorkFlow'+$("#p_wf_workId").val()});
 
    openWin({url:openurl,width:850,height:750,winName:'printProcess'}); 
    
	//更新打印次数
	var ajaxurl=whirRootPath+"/wfopenflow!updatePrint.action";
	ajaxurl=ajaxurl+para+"&type=update";
 
	var responseText = $.ajax({url: ajaxurl,async: false,cache:false}).responseText;

	var msg_json = eval("("+responseText+")");
    var judegeresult=msg_json.result; 
	 
	$("#viewPrintNum").html(judegeresult);
 
}

function  viewPrint(){
	if($("#p_wf_recordId").val()!=null&&$("#p_wf_recordId").val()!=""){
		var para="?p_wf_workId="+$("#p_wf_workId").val()+"&wfWorkId="+$("#p_wf_workId").val()+"&p_wf_recordId="+$("#p_wf_recordId").val()+
				 "&p_wf_processId="+$("#p_wf_processId").val()+"&p_wf_tableId="+$("#p_wf_tableId").val()+
				 "&p_wf_openType="+$("#p_wf_openType").val()+"&verifyCode="+$("#verifyCode").val()+"&p_wf_isprint=1"; 
		//更新打印次数
		var ajaxurl=whirRootPath+"/wfopenflow!updatePrint.action";
		ajaxurl=ajaxurl+para+"&type=view";
 
		var responseText = $.ajax({url: ajaxurl,async: false,cache:false}).responseText;
		var msg_json = eval("("+responseText+")");
        var judegeresult=msg_json.result; 
		if(judegeresult==null||judegeresult==""||judegeresult=="null"){
			judegeresult="0";
		}
	 
		$("#viewPrintNum").html(judegeresult);
	}

}
 

 /**
  办理任务
 */
function  cmdCompleteTask(){
	if(!judgePageIsShowAll()){
		whir_alert(workflowMessage_js.waitingload,function(){});
		return false;
	}

	var result=true;
    if(!include_setComment("0")){
		result=false;
		return false;
	}
	if(!include_saveSignature()){	
		//连接金格数据库失败！请与管理员联系
		whir_alert(workflowMessage_js.includegoldlinkerror,function(){});
		result=false;
		return false;
	} 

	if($("#p_wf_openType").val()=="waitingRead"){
		//确定办理阅件
		whir_confirm(workflowMessage_js.includeconfirmsaveread, function (){ completeRead();}) ;   
	}else{
		$("#dataForm").attr("action",whirRootPath+"/wfoperate!showCompleteTask.action");
		setCallBackName("showCompleteTask");
		$("#dataForm").submit();
	}   
}

//作废
function cmdDelete(){
  whir_confirm(workflowMessage_js.includeconfirmdelete,  function(){include_deleteSubmit();});
}


//转办
function cmdTran(){
	if(!judgePageIsShowAll()){
		whir_alert(workflowMessage_js.waitingload,function(){});
		return false;
	}

	$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showTran.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title(workflowMessage_js.newactivitybuttontran);
    $("#dataForm").submit();

}


//阅件
function cmdSelfsend(){
	if(!judgePageIsShowAll()){
		whir_alert(workflowMessage_js.waitingload,function(){});
		return false;
	}

	$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showSelfsend.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title(workflowMessage_js.f_review);
    $("#dataForm").submit();
}


//加签
function cmdAddSign(){
	if(!judgePageIsShowAll()){
		whir_alert(workflowMessage_js.waitingload,function(){});
		return false;
	}

    $("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showAddsign.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title(workflowMessage_js.addsign);
    $("#dataForm").submit();
}


//转阅
function cmdTranRead(){
	if(!judgePageIsShowAll()){
		whir_alert(workflowMessage_js.waitingload,function(){});
		return false;
	}

	$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showTranread.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title(workflowMessage_js.newactivitybuttontransferforreview);
    $("#dataForm").submit();
}


//撤办
function cmdUndo(){
   whir_confirm(workflowMessage_js.includeconfirmundo,  function(){include_undoSubmit();});
}
 
 
//反馈
function cmdFeedback(){
    /*$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showFeedback.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
    $("#dataForm").submit();*/
 
 
	var url=whirRootPath+"/wfbuttonevent!showFeedback.action";
	url+="?p_wf_msgFrom="+$("#p_wf_msgFrom").val();
	url+="&p_wf_tableId="+$("#p_wf_tableId").val();
	url+="&p_wf_recordId="+$("#p_wf_recordId").val();
	url+="&p_wf_processId="+$("#p_wf_processId").val();
	url+="&p_wf_remindField="+$("#p_wf_remindField").val();
	url+="&p_wf_submitTime="+$("#p_wf_submitTime").val();
	url+="&p_wf_processName="+$("#p_wf_processName").val();
	url+="&p_wf_submitPerson="+$("#p_wf_submitPerson").val();

    url=encodeURI(url);
 
	popup({id:'workflowDialog',title: workflowMessage_js.newactivitybuttonfeedback,fixed: true, left: '50%', top: '40%',
		 width:'590px',height:'450px', drag: true, resize: true,lock: true,content: "url:"+url}); 
} 


//收回
function cmdReturn(){
	 /*$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showReturn.action");
     //$("#submitFormType").val("showPopup");
     setCallBackName("showPopup");
     $("#dataForm").submit();*/
 
	var url=whirRootPath+"/wfbuttonevent!showReturn.action";
	url+="?p_wf_msgFrom="+$("#p_wf_msgFrom").val();
	url+="&p_wf_tableId="+$("#p_wf_tableId").val();
	url+="&p_wf_recordId="+$("#p_wf_recordId").val();
	url+="&p_wf_processId="+$("#p_wf_processId").val();
	url+="&p_wf_remindField="+$("#p_wf_remindField").val();
	url+="&p_wf_submitTime="+$("#p_wf_submitTime").val();
	url+="&p_wf_processName="+$("#p_wf_processName").val();
	url+="&p_wf_submitPerson="+$("#p_wf_submitPerson").val();

	url=encodeURI(url);

	popup({id:'workflowDialog',title: workflowMessage_js.newactivitybuttonreturn,fixed: true, left: '50%', top: '40%',
		 width:'515px',height:'250px', drag: true, resize: true,lock: true,content: "url:"+url}); 
} 


 

//取消
function cmdCancel(){
	/*$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showCancel.action");
	//$("#submitFormType").val("showPopup");
	setCallBackName("showPopup");
	$("#dataForm").submit();*/
	var url=whirRootPath+"/wfbuttonevent!showCancel.action";
	
	popup({id:'workflowDialog',title: workflowMessage_js.i_newinfocancel,fixed: true, left: '50%', top: '40%',
		 width:'565px',height:'258px', drag: true, resize: true,lock: true,content: "url:"+url});
} 

//新建流程
function cmdAddNew(){ 
	/*var url=whirRootPath+"/wfmyflow!newAdd.action?moduleId=1&rprocessId="+$("#p_wf_processId").val()
		+"&rtableId="+$("#p_wf_tableId").val()+"&rrecordId="+$("#p_wf_recordId").val();*/
	var url=whirRootPath+"/bpmscope!canStart.action?moduleId=1&rmoduleId="+$("#p_wf_moduleId").val()
		 +"&rrecordId="+$("#p_wf_recordId").val(); 
	
	popup({id:'workflowDialog',title: workflowMessage_js.i_newProcess,fixed: true,width:'800px',height:'600px', left: '50%', top: '10%', padding: 0,drag: true, resize: true,lock: true,content: 'url:'+url}); 
}


//催办
function cmdWait(){
   /*$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showPress.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
    $("#dataForm").submit();*/
	
	var url=whirRootPath+"/wfbuttonevent!showPress.action";
	url+="?p_wf_msgFrom="+$("#p_wf_msgFrom").val();
	url+="&p_wf_tableId="+$("#p_wf_tableId").val();
	url+="&p_wf_recordId="+$("#p_wf_recordId").val();
	url+="&p_wf_processId="+$("#p_wf_processId").val();
	url+="&p_wf_remindField="+$("#p_wf_remindField").val();
	url+="&p_wf_submitTime="+$("#p_wf_submitTime").val();
	url+="&p_wf_processName="+$("#p_wf_processName").val();
	url+="&p_wf_submitPerson="+$("#p_wf_submitPerson").val();

    url=encodeURI(url);

	popup({id:'workflowDialog',title:  workflowMessage_js.newactivitybuttonwait,fixed: true, left: '50%', top: '40%',
		 width:'610px',height:'430px', drag: true, resize: true,lock: true,content: "url:"+url}); 
} 


//邮件转发
function cmdEmailSend(){
	/*var params = $("#"+formId).serializeArray();
	alert(params);
	popup({id:'workflowDialog',title: '流程操作',fixed: true, left: '50%', top: '10%',
		 padding: 0,drag: true, resize: true,lock: true,content: "url:/defaultroot/wfoperate!showSendTask.action?"+params}); */
 
	var url=whirRootPath+"/wfbuttonevent!showMailSend.action";
 
	popup({id:'workflowDialog',title:  workflowMessage_js.i_emailSend,fixed: true, left: '50%', top: '40%',
		 width:'615px',height:'360px', drag: true, resize: true,lock: true,content: "url:"+url}); 
    
	/*
	$("#dataForm").attr("action",whirRootPath+"/wfbuttonevent!showMailSend.action");
	//$("#submitFormType").val("showPopup");
	setCallBackName("showPopup");
	$("#dataForm").submit();*/
} 

//保存退出
function cmdSaveclose(){
	//保存前检测
	if(wfCheckBeforeSaveClose()){
		$("#dataForm").attr("action",whirRootPath+"/wfoperate!saveclose.action");
		setCallBackName("");
		$("#dataForm").submit();
	}
}