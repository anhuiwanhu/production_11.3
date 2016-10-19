<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
if($("#uploadify").length==0){
	LoadScript('<%=rootPath%>/public/upload/plupload/upload.js','');
	LoadScript('<%=rootPath%>/public/upload/plupload/browserplus-min.js','uploadify');
	LoadScript('<%=rootPath%>/public/upload/plupload/plupload.full.js','');
	LoadScript('<%=rootPath%>/scripts/plugins/progressbar/js/jquery.progressbar.js','');
	LoadScript('<%=rootPath%>/scripts/plugins/jquery_ui/jquery.blockUI.js','');	
	LoadStyle('<%=rootPath%>/public/upload/uploadify/uploadify.css','');
}
//-->
</script>
<style>
<!--
<%if(!canModify.equals("yes")){ %>
body{margin-top:-10px;}
#<%=uniqueId%>{margin-top:-10px;margin-bottom:10px;}
<%}%>

<%if(accessType.equals("iframe")){ %>
body{height:30px;}
<%}%>

#div_<%=uniqueId%>{width:<%=width%>px;height:<%=height%>px;cursor:pointer;cursor:hand;text-align:center;background-color:#fff;<%if(buttonImage.equals("null")){ %>border:1px solid gray;<%}%>padding-top:3px;margin-top:5px;}

#<%=uniqueId%> table tr td{text-align:left;padding-left:0px;}

.buttonDesc{
    margin-top:-23px;
    margin-left:100px;
}

<%=style%>
-->
</style>
<div id="<%=uniqueId%>" >
	<input type="hidden" name="total_file_size" id="total_file_size" />		
	<%if(canModify.equals("yes")){%>
	<div id="div_<%=uniqueId%>">
        <div id="pickfiles_<%=uniqueId%>"  >  
            <%if(buttonImage.equals("null")){ %>
            <%=buttonText%> 
            <%}else{ %>
            <img src="<%=buttonImage%>" border="0" />
            <%}%>
        </div> 
	</div>
    <%if(portletSettingId != null && buttonDesc != null){%><div class="buttonDesc"><%=buttonDesc%></div><%}%>
	<%}%>
	<div id="filesDiv_" style="padding-left:0px;<%if(!canModify.equals("yes")){%>margin-top:15px;<%}%>;">
        <div id="filesDiv" style="<%if(accessType.equals("iframe")){ %>margin-left:-2px;<%}%>" >
            <table id="files"></table>
        </div>
        
        <%if("yes".equals(isShowBatchDownButton)){ %>
        <!-- 批量下载 -->
        <div style="display:none">
            <iframe id="downloadFileIfr<%=uniqueId%>" name="downloadFileIfr<%=uniqueId%>" width="0" height="0"  style="width:0px;height:0px;border:0px;" ></iframe>
        </div>
        <div id="batchdownload_btn" style="display:none;text-align:left;">
            <input type="button" class="btnButton4font" id="batch_<%=uniqueId%>" value="<%=Resource.getValue(whir_locale,"common","comm.batchdownload")%>"   />
        </div>
        <%}%>
	</div>
</div>
<script type="text/javascript">
function flashChecker(){
	var hasFlash=0;　　　　//是否安装了flash
	var flashVersion=0;　　//flash版本	
	if(document.all){
		var swf = false;
		try{
			 swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
		}catch(e){
			 swf = false;
		}
		if(swf) {
			hasFlash=1;
			VSwf=swf.GetVariable("$version");
			flashVersion=parseInt(VSwf.split(" ")[1].split(",")[0]);
		}
	}
	return {f:hasFlash,v:flashVersion};
}

$(document).ready(function() {
    var _lochref = location.href+'';
	if(_lochref.indexOf('/archivesfile/')!=-1 && _lochref.indexOf('/archivesfile/GW_')==-1){//<%--档案系统文件--%>
		return;
	}

	var myapi = null;
	if("undefined" != typeof api){
		myapi = api;
	}
	var uniqueId = '<%=uniqueId%>';
	var realFileNameInputId = '<%=realFileNameInputId%>';
	var saveFileNameInputId = '<%=saveFileNameInputId%>';
    uniqueId = replaceDollar(uniqueId);
    realFileNameInputId = replaceDollar(realFileNameInputId);
    saveFileNameInputId = replaceDollar(saveFileNameInputId);
	
	if('<%=canModify%>' == 'yes'){
		/**-- --plupload---- --*/
		 var max_file_size_ = '<%=fileSizeLimit%>';
		 var uploadLimit = <%=uploadLimit%>;
		 uploadLimit = uploadLimit*1 + 0;
	     var uploader = new plupload.Uploader({
	     	 id: 'uploader_<%=uniqueId%>',
	         runtimes : 'html5,flash,silverlight,gears,browserplus',
	         browse_button : 'pickfiles_<%=uniqueId%>',
	         container : 'div_<%=uniqueId%>',
	         max_file_size : '<%=fileSizeLimit%>',
	         //chunk_size : '1000mb',
			 unique_names : false,
			 multi_selection : <%=multi%>,
	         url : '<%=rootPath%>/public/upload/uploadify/uploader.jsp?dir=<%=dir%>&makeYMdir=<%=makeYMdir%>&thumbnail=<%=thumbnail%>&domainId=<%=domainId%><%=portletSettingId!=null?"&portletSettingId="+portletSettingId:""%>',
	         flash_swf_url : '<%=rootPath%>/public/upload/plupload/plupload.flash.swf',
	         silverlight_xap_url : '<%=rootPath%>/public/upload/plupload/plupload.silverlight.xap'<%if(",msie,firefox,".indexOf(whir_browser)!=-1 && whir_agent.toLowerCase().indexOf("msie 10")==-1){%>,
	         filters : [
	             {title : "所有文件", extensions : "<%=fileTypeExts_default%>"}
	             <%if(img_b){%> ,{title : "图片文件",       extensions : "<%=fileTypeExts_img%>"}<%}%>
	             <%if(ms_b){%>  ,{title : "微软办公文件",   extensions : "<%=fileTypeExts_ms%>"}<%}%>
	             <%if(file_b){%>,{title : "压缩和文本文件", extensions : "<%=fileTypeExts_file%>"}<%}%>
	             <%if(vm_b){%>  ,{title : "音频视频文件",   extensions : "<%=fileTypeExts_vm%>"}<%}%>
	             <%if(cust_b){%>,{title : "自定义文件",     extensions : "<%=fileTypeExts_cust%>"}<%}%>
	         ]<%}%>
	     });  
	    
	     whirPluploader = uploader;
	     window.up_<%=uniqueId%> = uploader;
	     uploader.bind('Init', function(up, params) {
	         //初始化操作
			<%if(!onInit.equals("")){%>
				<%=onInit%>.call(<%=onInit%>, {dir:'<%=dir%>', uniqueId:uniqueId, canModify:'<%=canModify%>', realFileNameInputId:realFileNameInputId, saveFileNameInputId:saveFileNameInputId});
			<%}%>

			<%if(!onSWFReady.equals("")){%>
				<%=onSWFReady%>.call(<%=onSWFReady%>);
			<%}%>
	     });      
	     uploader.init();   
	     uploader.bind('FilesAdded', function(up, files) {
	     	 var uploaded = $('#'+uniqueId).find("#files").find("tr").length + files.length;
	     	 if(uploadLimit>0 && (uploaded > uploadLimit)){
		     	//此处修改，
                if(typeof(W) != "undefined"){
	     	 	    W.whir_alert(comm.whir_upload_1+uploadLimit+comm.whir_upload_2,function(){up.refresh();},null);
                }else{
                    whir_alert(comm.whir_upload_1+uploadLimit+comm.whir_upload_2,function(){up.refresh();},null);
                }
	     	 	$.each(files, function(i, file) {
	     	 		up.removeFile(file); 
	     	 	});   
	     	 }else if(compareFileSize(max_file_size_,files[0].size)=="<"){
	     	 	if(max_file_size_.indexOf("-")==0 || max_file_size_.indexOf("0")==0){
	     	 		whir_alert(comm.whir_upload_3,function(){up.refresh();},null);
	     	 	}else{
	     	 		whir_alert(comm.whir_upload_4+max_file_size_,function(){up.refresh();},null);
	     	 	}
	     	 	$.each(files, function(i, file) {
	     	 		up.removeFile(file); 
	     	 	});   
	     	 }else{
	     	     var b = false;
	     	     var allowtypes = ',<%=fileTypeExts.replaceAll("'", "\\\\\'")%>,';
		         $.each(files, function(i, file) { 
		             var filename = file.name;
		             var filetype = (','+filename.substring(filename.lastIndexOf(".")+1)+',').toLowerCase();
		             if(file.size==0){
		             	whir_alert(comm.whir_upload_5,function(){up.refresh();},myapi);
		             	b = true;
		             	up.removeFile(file); 
		             	//return false;
		             }else if(allowtypes.indexOf(filetype)< 0){
		             	whir_alert(comm.whir_upload_6+"<%=fileTypeExts%>",function(){up.refresh();},myapi);
		             	b = true;
		             	up.removeFile(file); 
		             	//return false;
                     }else if('<%=dir%>'.indexOf('customform') != -1 && (filename.indexOf(",") != -1 || filename.indexOf(";") != -1)){
		             	whir_alert(comm.whir_upload_invalidchar,function(){up.refresh();},myapi);
		             	b = true;
		             	up.removeFile(file); 
		             	//return false;
		             }else{
			        	var select_json = 	{file:file, uniqueId:uniqueId, dir:'<%=dir%>', realFileNameInputId:realFileNameInputId, saveFileNameInputId:saveFileNameInputId, files:files, uploader:uploader};	
						<%if(!onSelect.equals("")){%>																	
							<%=onSelect%>.call(<%=onSelect%>, select_json);
						<%}%>
					 }
		         });
                 if(<%=auto%>){
                    uploader.start();
                 }
	         }
	     });    
	      
	     uploader.bind('UploadProgress', function(up, file) {
	         var progress_json =  {file:file, uniqueId:uniqueId, percent:file.percent, dir:'<%=dir%>', realFileNameInputId:realFileNameInputId, saveFileNameInputId:saveFileNameInputId};
			 <%if(!onUploadProgress.equals("")){%>
				<%=onUploadProgress%>.call(<%=onUploadProgress%>, progress_json);
			 <%}%>
	     });      
	     
	     uploader.bind('Error', function(up, err) {
	         if(err.code==-601){
	         	whir_alert(comm.whir_upload_6+"<%=fileTypeExts%>",function(){up.refresh();},myapi);
	         }else if(err.code==-600){
	         	whir_alert(comm.whir_upload_4+max_file_size_,function(){up.refresh();},null);
	         }
	         
	     });  
	
	     uploader.bind('FileUploaded', function(up, file, data) {
	         var json =  eval("("+data.response+")");
			 var success_json = {dlcode:json.dlcode, file_type:json.file_type, save_name:json.save_name, file_name:json.file_name, relative_path:json.relative_path, file_size:file.size, uniqueId:uniqueId, dir:'<%=dir%>', realFileNameInputId:realFileNameInputId, saveFileNameInputId:saveFileNameInputId};
			 <%if(!onUploadSuccess.equals("")){%>
				<%=onUploadSuccess%>.call(<%=onUploadSuccess%>, success_json);
			 <%}%>	
			 //我的文档容量,更新当前fileSizeLimit
			 <%if("netdisk".equals(dir)){%>
				var leaveSize = <%=leaveSize%> ;
				max_file_size_ = (leaveSize - file.size)/(1024*1024)+"mb";
				uploader.settings.max_file_size = max_file_size_;
			 <%}%>
	     });

         if($.browser.opera || whir_agent.indexOf("MSIE 10")>=0 ){
             var _plupload = $('div.plupload[id$=_html5_container]'); 
             _plupload.css('height', _plupload.parent().height()).css('width', _plupload.parent().width());
         }
	}else{
		//初始化操作
		<%if(!onInit.equals("")){%>
			<%=onInit%>.call(<%=onInit%>,{dir:'<%=dir%>',uniqueId:uniqueId,canModify:'<%=canModify%>',realFileNameInputId:realFileNameInputId,saveFileNameInputId:saveFileNameInputId});
		<%}%>
	}
	
	if($(".doc_width").length>0){
		$("#<%=uniqueId%>").closest("td").css("padding-left","5px");
	}
});
</script>