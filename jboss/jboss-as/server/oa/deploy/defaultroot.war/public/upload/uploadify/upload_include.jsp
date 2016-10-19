<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init_base.jsp"%>
<%@ page import="com.whir.org.bd.usermanager.UserBD" %>
<%@ page import="com.whir.ezoffice.netdisk.bd.NetdiskBD"%>
<%
//门户portlet设置图片、媒体上传
String portletSettingId = request.getParameter("portletSettingId");
String domainId = session.getAttribute("domainId")!=null?session.getAttribute("domainId").toString():"0" ;
//包含方式
String accessType     = request.getParameter("accessType")!=null?request.getParameter("accessType"):"include";
//上传完成后的js回调函数名称
String onInit = request.getParameter("onInit")!=null?request.getParameter("onInit"):"init";
String onSelect = request.getParameter("onSelect")!=null?request.getParameter("onSelect"):"onSelect";
String onUploadProgress = request.getParameter("onUploadProgress")!=null?request.getParameter("onUploadProgress"):"onUploadProgress";
String onUploadSuccess = request.getParameter("onUploadSuccess")!=null?request.getParameter("onUploadSuccess"):"onUploadSuccess";
String onSWFReady = request.getParameter("onSWFReady")!=null?request.getParameter("onSWFReady"):"";
//是否创建年月文件夹
String makeYMdir = request.getParameter("makeYMdir")!=null?request.getParameter("makeYMdir"):"yes";
//基本参数
String dir = EncryptUtil.htmlcode(request.getParameter("dir")!=null?request.getParameter("dir"):"dir").replaceAll("'","");
String uniqueId  = EncryptUtil.htmlcode(request.getParameter("uniqueId")!=null?request.getParameter("uniqueId"):"uniqueId").replaceAll("'","");
String realFileNameInputId  = EncryptUtil.htmlcode(request.getParameter("realFileNameInputId")!=null?request.getParameter("realFileNameInputId"):"realFileNameInputId").replaceAll("'","");
String saveFileNameInputId  = EncryptUtil.htmlcode(request.getParameter("saveFileNameInputId")!=null?request.getParameter("saveFileNameInputId"):"saveFileNameInputId").replaceAll("'","");
String canModify  = request.getParameter("canModify")!=null?request.getParameter("canModify"):"yes";
if(!"yes".equalsIgnoreCase(canModify)){
    canModify = "no";
}
//如果是ipad 禁止上传
if(!isForbiddenPad){
    canModify="false";
}

//缩略图信息，格式：150x150;300x300
String thumbnail  = request.getParameter("thumbnail")!=null?request.getParameter("thumbnail"):"";
//是否显示批量下载按钮，'yes'或'no' ,默认'yes'
String isShowBatchDownButton  = request.getParameter("isShowBatchDownButton")!=null?request.getParameter("isShowBatchDownButton"):"yes";
//样式
String style  = request.getParameter("style")!=null?request.getParameter("style"):"";

//其他参数
String auto  = request.getParameter("auto")!=null?request.getParameter("auto"):"true";
String width  = request.getParameter("width")!=null?request.getParameter("width"):"90";
if(!whir_locale.toLowerCase().equals("zh_cn") && !whir_locale.toLowerCase().equals("zh_tw")){
	//width = "130";
}
String height = request.getParameter("height")!=null?request.getParameter("height"):"20";
String multi  = request.getParameter("multi")!=null?request.getParameter("multi"):"true";
String buttonClass  = request.getParameter("buttonClass")!=null?request.getParameter("buttonClass"):"upload_btn";
String buttonImage  = request.getParameter("buttonImage")!=null?request.getParameter("buttonImage"):"null";
String buttonText   = request.getParameter("buttonText")!=null?request.getParameter("buttonText"):Resource.getValue(whir_locale,"common","comm.attupload");
String buttonDesc   = request.getParameter("buttonDesc");
//The maximum size of an uploadable file in KB (Accepts units B KB MB GB if string, 0 for no limit)
String fileSizeLimit  = request.getParameter("fileSizeLimit")!=null?request.getParameter("fileSizeLimit"):"500MB";
if("0".equals(fileSizeLimit)){
	fileSizeLimit = "1000MB";
}
fileSizeLimit = fileSizeLimit.toUpperCase();
int int_fileSizeLimit = 0;
try{int_fileSizeLimit=Integer.parseInt(fileSizeLimit);}catch(Exception e){}
if(fileSizeLimit.indexOf("GB")>0){
	int_fileSizeLimit = Integer.parseInt(fileSizeLimit.substring(0, fileSizeLimit.indexOf("GB")))*1024*1024*1024;
}else if(fileSizeLimit.indexOf("MB")>0){
	int_fileSizeLimit = Integer.parseInt(fileSizeLimit.substring(0, fileSizeLimit.indexOf("MB")))*1024*1024;
}else if(fileSizeLimit.indexOf("KB")>0){
	int_fileSizeLimit = Integer.parseInt(fileSizeLimit.substring(0, fileSizeLimit.indexOf("KB")))*1024;
}else if(fileSizeLimit.indexOf("B")>0){
	int_fileSizeLimit = Integer.parseInt(fileSizeLimit.substring(0, fileSizeLimit.indexOf("B")));
}

Map map = (Map) com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(), domainId);
String fileSizeLimitAll="110240000";
if(map != null && map.get("FileSizeLimitAll") != null){
    fileSizeLimitAll = map.get("FileSizeLimitAll").toString();
    if(fileSizeLimitAll.startsWith("1")){
        int fileSize=Integer.parseInt(fileSizeLimitAll.substring(1));
        if(int_fileSizeLimit==0 || int_fileSizeLimit > fileSize){
        	fileSizeLimit = (fileSize/(1024*1024))+"MB";
        }
    }
}

//The description for file types in the browse dialog
String fileTypeDesc  = request.getParameter("fileTypeDesc")!=null?request.getParameter("fileTypeDesc"):"";
//Allowed extensions in the browse dialog (server-side validation should also be used)
String fileTypeExts         = "";
String fileTypeExts_img     = "*.jpg;*.jpeg;*.gif;*.png;*.bmp;";boolean img_b = false;
String fileTypeExts_ms      = "*.doc;*.docx;*.xls;*.xlsx;*.xlsm;*.ppt;*.pptx;*.pps;*.wps;*.mpp;*.odt;*.ods;*.odp;";boolean ms_b = false;
String fileTypeExts_file    = "*.rar;*.zip;*.7z;*.txt;*.pdf;*.xml;*.dwg;*.vsd;*.eml;*.msg;*.ceb;*.tif;*.tiff;*.key;*.iso;*.ofd;";boolean file_b = false;
String fileTypeExts_vm      = "*.asf;*.wmv;*.wav;*.swf;*.flv;*.mp3;*.mp4;*.rm;*.rmvb;*.avi;";boolean vm_b = false;
String fileTypeExts_default = fileTypeExts_file + fileTypeExts_ms + fileTypeExts_img + fileTypeExts_vm;
String fileTypeExts_cust    = "";boolean cust_b = false;

String fileTypeExts_re = request.getParameter("fileTypeExts")!=null?request.getParameter("fileTypeExts").toLowerCase():"";
if(fileTypeExts_re.trim().equals("")){
	fileTypeExts = fileTypeExts_default;img_b = true;ms_b = true;file_b = true;vm_b = true;
}else{
    String[] fileTypeExts_reArr = fileTypeExts_re.split(";");
    for(int i0=0; i0<fileTypeExts_reArr.length; i0++){
        if(fileTypeExts_img.indexOf(fileTypeExts_reArr[i0])!=-1){
            img_b = true;break;
        }else if(fileTypeExts_ms.indexOf(fileTypeExts_reArr[i0])!=-1){
            ms_b = true;break;
        }else if(fileTypeExts_file.indexOf(fileTypeExts_reArr[i0])!=-1){
            file_b = true;break;
        }else if(fileTypeExts_vm.indexOf(fileTypeExts_reArr[i0])!=-1){
            vm_b = true;break;
        }
    }
	/*if(fileTypeExts_re.indexOf("*.jpg")>=0){
		fileTypeExts += fileTypeExts_img;img_b = true;
	}
	if(fileTypeExts_re.indexOf("*.doc")>=0){
		fileTypeExts += fileTypeExts_ms;ms_b = true;
	}
	if(fileTypeExts_re.indexOf("*.rar")>=0){
		fileTypeExts += fileTypeExts_file;file_b = true;
	}
	if(fileTypeExts_re.indexOf("*.asf")>=0){
		fileTypeExts += fileTypeExts_vm;vm_b = true;
	}*/
	
	String fileTypeExts_re_str = fileTypeExts_re;
	if(fileTypeExts_re_str.indexOf(";")<0){
		fileTypeExts_re_str += ";";
	}
	String[] fileTypeExts_re_arr = fileTypeExts_re_str.split(";");
	for(int i=0; i<fileTypeExts_re_arr.length; i++){
		if(!fileTypeExts_re_arr[i].equals("") && fileTypeExts.indexOf(fileTypeExts_re_arr[i])<0 ){
			fileTypeExts_cust += fileTypeExts_re_arr[i]+";";cust_b = true;
		}
	}
	fileTypeExts += fileTypeExts_cust;
}

if(fileTypeExts.endsWith(";")){
	fileTypeExts = fileTypeExts.substring(0,fileTypeExts.length()-1);
}
if(fileTypeExts_img.endsWith(";")){
	fileTypeExts_img = fileTypeExts_img.substring(0,fileTypeExts_img.length()-1);
}
if(fileTypeExts_ms.endsWith(";")){
	fileTypeExts_ms = fileTypeExts_ms.substring(0,fileTypeExts_ms.length()-1);
}
if(fileTypeExts_file.endsWith(";")){
	fileTypeExts_file = fileTypeExts_file.substring(0,fileTypeExts_file.length()-1);
}
if(fileTypeExts_vm.endsWith(";")){
	fileTypeExts_vm = fileTypeExts_vm.substring(0,fileTypeExts_vm.length()-1);
}
if(fileTypeExts_cust.endsWith(";")){
	fileTypeExts_cust = fileTypeExts_cust.substring(0,fileTypeExts_cust.length()-1);
}
//The maximum number of files that can be in the queue at one time
String queueSizeLimit  = request.getParameter("queueSizeLimit")!=null?request.getParameter("queueSizeLimit"):"999";
//The maximum number of files you can upload
String uploadLimit  = request.getParameter("uploadLimit")!=null?request.getParameter("uploadLimit"):"0";

double leaveSize = 1024*1024*1024;
if("netdisk".equals(dir)){
    UserBD ubd = new UserBD();
	NetdiskBD netdiskBD = new NetdiskBD();
	String userId = session.getAttribute("userId").toString();
	double usedFileSize= netdiskBD.getAllFileSizeByUser(userId);//得到当前用户我的文档总容量
	double fileMaxSize = ubd.getNetDiskSize(userId);//分配的容量
    leaveSize = fileMaxSize*1024*1024 - usedFileSize ;//单位：B '100B'
    fileSizeLimit = (int)leaveSize/1024 + "kb";
}
%>
<%if("iframe".equals(accessType)){%>
<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>";
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=whir_agent%>"; 
	var whir_locale = "<%=whir_locale.toLowerCase()%>"; 
</script>
<script src="<%=rootPath%>/scripts/jquery-1.8.0.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<link   href="<%=rootPath%>/themes/common/common.css" rel="stylesheet" type="text/css"/>
<%}%>
<%
//是否为FTP上传
String isEncrypt = (String)sysMap.get("加密存储");
//customize biz import datas
if ("datas".equals(dir) || "fileimport".equals(dir)) {
    isEncrypt = "0";
}
%>
<script type="text/javascript">
    var whir_isEncrypt  = "<%=isEncrypt%>";
    var isAttachPreview = "<%=sysMap.get("attachPreview")%>";
    var attachPortletSettingId = "<%=portletSettingId%>";
</script>
<%
String agent = request.getHeader("user-agent");
if(agent.indexOf("MSIE 6")>=0){
%>
   <%@ include file="upload_include2.jsp"%>
<%}else{
	fileTypeExts         = fileTypeExts.replaceAll("\\*.","").replaceAll(";",",");
	fileTypeExts_default = fileTypeExts_default.replaceAll("\\*.","").replaceAll(";",",");
	fileTypeExts_img     = fileTypeExts_img.replaceAll("\\*.","").replaceAll(";",",");
	fileTypeExts_ms      = fileTypeExts_ms.replaceAll("\\*.","").replaceAll(";",",");
	fileTypeExts_file    = fileTypeExts_file.replaceAll("\\*.","").replaceAll(";",",");
	fileTypeExts_vm      = fileTypeExts_vm.replaceAll("\\*.","").replaceAll(";",",");
	fileTypeExts_cust    = fileTypeExts_cust.replaceAll("\\*.","").replaceAll(";",",");
	fileSizeLimit        = fileSizeLimit.toLowerCase();
%>
   <%@ include file="upload_include1.jsp"%>
<%}%>