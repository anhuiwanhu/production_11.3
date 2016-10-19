function changeInfoType(val){
	if(val==0){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").show();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==1){
		$("#temp").show();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").show();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==2){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").show();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==3){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").show();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		//处理ie10点击选择文件没反应问题-----20130929
		//whir_uploader_reset("uploadFile");
	}else if(val==4){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").show();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==5){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").show();
		$("#ppt").hide();
	}else if(val==6){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").show();
	}
}
//选择栏目
function changeChannel(val){
	var channelId = val.substring(0,val.indexOf(","));
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: false,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				if(data.processId!="0"){
					$("#informationReaderId").val(data.canReader);
					$("#informationReaderId_").val(data.canReader);
					$("#informationReaderName").val(data.canReaderName);
				}else{
					$("#channel").val(val);
					$("#reader").val(data.canReader);
					$("#readerName").val(data.canReaderName);
					if($(':radio[name="information.informationType"]:checked').val()=='1'){
						$("#tempContent").val(document.getElementById("newedit").contentWindow.getHTML());
					}
					$("#form").submit();
				}
			initOutSiteSynDiv();
			}
		}
	});
}
function fileLink(json){
	$("#fileLinkContent").val(json.file.name);
}
function uploadSuccess(json){
	$("#fileLinkContentHidd").val(json.save_name+json.file_type);
}
function selectReader(){
	var channelReader_ = $("#informationReaderId_").val();
	if(channelReader_!=""){
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelReader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}
function selectPrinter(){
	var channelPrinter_ = $("#informationPrinterId_").val();
	if(channelPrinter_!=""){
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelPrinter_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}
function selectDownLoader(){
	var channelDownLoader_ = $("#informationDownLoaderId_").val();
	if(channelDownLoader_!=""){
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelDownLoader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}
//加载网站同步信息
function initOutSiteSynDiv(){
    var _channel = whirExtCombobox.getValue("channelId");//whirCombobox.getValue("selectChannel");
	var _channelId="";
	if(_channel!=""&&_channel!="0"&&_channel!=null){
	    _channelId=_channel.substring(0,_channel.indexOf(","));
	}
	if(_channelId==""){
	    return ;
	}
	var url=whirRootPath+"/modules/kms/information_manager/informationmanager_info_synsite_div.jsp?channelId="+_channelId+"&informationId="+$("#informationId").val();
	var html = $.ajax({url: url,async: false}).responseText;
	$("#outSiteSynDiv").html(html);
}
//页面初始化方法
function initfunction(yiboflag,modifyflag){
    if($("#textContent").val().indexOf("<br>")){
		$("#textContent").val($("#textContent").val().replace(/<br>/ig,"\n"));
	}
	$(":radio[name='information.informationValidType']").change(function(){
		if(this.value==1){
			$("#validBeginTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validEndTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validTime").show();
		}else{
			$("#validBeginTime").val('');
			$("#validEndTime").val('');
			$("#validTime").hide();
		}
	});
	var valid = $(":radio[name='information.informationValidType']:checked").val();
	if(valid==1){
		$("#validTime").show();
	}
	changeInfoType($("#informationType").val());
	//初始进入易播栏目信息的修改页面，部分页面元素隐藏处理等
	var isYiBoChannel = yiboflag;
	if(isYiBoChannel == "1"){
		$(document).attr("title","修改易播信息");//修改title
		//针对办理查阅进入页面，不展示详细信息页签（20160108 -by jqq）
		if(modifyflag == "1"){
			$("#info_add_center_1").hide();
		}else{
			$("#Panle1").hide();
		}
		$("#info_add_1").hide();
		$("#temp").hide();
		$("#info_add_2").hide();
		$("#selectAppend").hide();
	}
}