;
/**/
$.browser = $.browser || {};
$.browser.mozilla = /firefox/.test(navigator.userAgent.toLowerCase());
$.browser.webkit = /webkit/.test(navigator.userAgent.toLowerCase());
$.browser.opera = /opera/.test(navigator.userAgent.toLowerCase());
$.browser.msie = /msie/.test(navigator.userAgent.toLowerCase());

var G_PREFIX_NEW_COMPONENT = "new_component_";

/*根据字段name获取对象*/
function getObjectByName(name/*对象名称*/, index/*下标，默认为0*/, suffix/*后缀：1)选择组织用户：'_Id', '_Name'; 2)附件：'_fileName', '_saveName'; 3)其它无后缀，为空''*/) {
    var ret = null;
    var newComponent = document.getElementsByName(G_PREFIX_NEW_COMPONENT + name);
    if(newComponent.length > 0){
        var newComponentValue = newComponent[index].value;
        try{
            ret = document.getElementsByName(name+newComponentValue + suffix)[index];
        }catch(e){
            ret = document.getElementsByName(name+newComponentValue + suffix)[0];
        }
    }else{
        try{
            ret = document.getElementsByName(name)[index];
        }catch(e){
            ret = document.getElementsByName(name)[0];
        }
    }

    return ret;
}

//验证是否国产化系统
function checkCOS(){
    var navigator_ = window.navigator;
    var userAgent_ = navigator_.userAgent.toLowerCase();
    if(userAgent_.indexOf('linux')!=-1 && userAgent_.indexOf('firefox')!=-1){//国产化
        return true;
    }
    return false;
}

/**
 * 比较两个文件的大小.
 * @param f1  文件1的大小.
 * @param f2  文件2的大小.
 * @return    返回">","=","<",表示第一个文件和第二个文件的大小关系.
 */
function compareFileSize(f1, f2){
	f1 = (f1+"").toUpperCase();
	f2 = (f2+"").toUpperCase();
	var s1 = 0,s2 = 0 ;
	if(f1.indexOf("GB")>0){
		s1 = (f1.substring(0,f1.indexOf("GB")))*1024*1024*1024+0;
	}else if(f1.indexOf("MB")>0){
		s1 = (f1.substring(0,f1.indexOf("MB")))*1024*1024+0;
	}else if(f1.indexOf("KB")>0){
		s1 = (f1.substring(0,f1.indexOf("KB")))*1024+0;
	}else if(f1.indexOf("B")>0){
		s1 = (f1.substring(0,f1.indexOf("B")))+0;
	}else{
		s1 = (f1*1)+0;
	}
	
	if(f2.indexOf("GB")>0){
		s2 = (f2.substring(0,f2.indexOf("GB")))*1024*1024*1024+0;
	}else if(f2.indexOf("MB")>0){
		s2 = (f2.substring(0,f2.indexOf("MB")))*1024*1024+0;
	}else if(f2.indexOf("KB")>0){
		s2 = (f2.substring(0,f2.indexOf("KB")))*1024+0;
	}else if(f2.indexOf("B")>0){
		s2 = (f2.substring(0,f2.indexOf("B")))+0;
	}else{
		s2 = (f2*1)+0;
	}
	
	if(s1<s2){
		return "<";
	}else if(s1==s2){
		return "=";
	}else if(s1>s2){
		return ">";
	}
}

function setMoveButton(){
	var m  = document.getElementById("whir_mainMenuBar");
	var mW = document.getElementById("whir_mainMenuBarBox2").offsetWidth-m.offsetWidth;
	var sW = m.scrollLeft;
	
	if(sW<=0){
		$("#whir_moveLeftSpan").removeClass("whir_scrollArrowLeft");
        $("#whir_moveLeftSpan").addClass("whir_scrollArrowLeftDisabled");
	}else{
		$("#whir_moveLeftSpan").removeClass("whir_scrollArrowLeftDisabled");
		$("#whir_moveLeftSpan").addClass("whir_scrollArrowLeft" );
	}
	
	if(sW<mW){
		$("#whir_moveRightSpan").removeClass("whir_scrollArrowRightDisabled");
		$("#whir_moveRightSpan").addClass("whir_scrollArrowRight");
	}else{
		$("#whir_moveRightSpan").removeClass("whir_scrollArrowRight");
		$("#whir_moveRightSpan").addClass("whir_scrollArrowRightDisabled");
	}
}

/**
 * 向右滑动事件.
 */
function whir_menuMoveRight(){
	var m  = document.getElementById("whir_mainMenuBar");
	var mW = document.getElementById("whir_mainMenuBarBox2").offsetWidth - m.offsetWidth;
	var sW = m.scrollLeft;
	if(sW<mW){
        sW+=150;
	}
    if(sW>mW){
		sW=mW
	}
	m.scrollLeft = sW;
	setMoveButton();
}

/**
 * 向左滑动事件.
 */
function whir_menuMoveLeft(){
	var m  = document.getElementById("whir_mainMenuBar");
	var mW = 0;
	var sW = m.scrollLeft;
	if(sW>mW){
        sW-=150;
	}
    if(sW<mW){sW=mW}
	m.scrollLeft=sW;
	setMoveButton();
}

function loadMenu(){
	var w=document.body.offsetWidth;
	var m=document.getElementById("whir_mainMenuBar");
	m.style.width=(w-220)+"px";
	setMoveButton();
}

function checkMenuImg(){
	if(btnMod){
		var menuLength=btnMod.length;
		if(menuLength>0){
			if(btnMod[0].style.display=='none'){
				$("#whir_moveLeftSpan").addClass("whir_scrollArrowLeft");
			}else{
				$("#whir_moveLeftSpan").addClass("whir_scrollArrowLeftDisabled");
			}

			if(btnMod[menuLength-1].style.display=='none'){
				$("#whir_moveRightSpan").addClass("whir_scrollArrowRight");
			}else{
				$("#whir_moveRightSpan").addClass("whir_scrollArrowRightDisabled");
			}
		}
	}
}

/***********************************************************公共业务相关************************************************************************************/
//js replaceAll正则
String.prototype.replaceAll_ = function(reallyDo, replaceWith, ignoreCase) {
 　 if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);
     } else {
        return this.replace(reallyDo, replaceWith);
    }
}

//判断是否是XX开头
String.prototype.endWith=function(s){
	if(s==null||s==""||this.length==0||s.length>this.length)
	   return false;
	if(this.substring(this.length-s.length)==s)
	   return true;
	else
	   return false;
	return true;
}

//判断是否是XX结尾
String.prototype.startWith=function(s){
	if(s==null||s==""||this.length==0||s.length>this.length)
	   return false;
	if(this.substr(0,s.length)==s)
	   return true;
	else
	   return false;
	return true;
}

//去除头尾空格
String.prototype.trimLR = function() {
    return this.replace(/(^ +| +$)/, "");
}

 /**
 * 导入js文件.
 * @param s_Url   文件的全路径.
 * @param id      id唯一标识.
 */
function LoadScript(s_Url, id){
	document.write('<scr' + 'ipt type="text/javascript" src="' + s_Url + '" id="'+id+'"><\/scr' + 'ipt>');
}

 /**
 * 导入css文件.
 * @param s_Url   文件的全路径.
 * @param id      id唯一标识.
 */
function LoadStyle(s_Url, id){
	document.write('<link href="'+s_Url+'" rel="stylesheet" type="text/css"/>');
}

function isPad(){
    var navigator = window.navigator;
    var userAgent = navigator.userAgent.toLowerCase();

    if(navigator.platform=='iPad' || 
        (userAgent.indexOf('msie')!=-1 && userAgent.indexOf('touch')!=-1 && userAgent.indexOf('tablet pc')!=-1) || 
        (userAgent.indexOf('linux')!=-1 && userAgent.indexOf('android')!=-1)){
        return true;
    }

    //navigator.userAgent
    return false;
}

function isSurface(){
    var navigator = window.navigator;
    var userAgent = navigator.userAgent.toLowerCase();

    if(userAgent.indexOf('msie')!=-1 && userAgent.indexOf('touch')!=-1 && userAgent.indexOf('tablet pc')!=-1){
        return true;
    }

    //navigator.userAgent
    return false;
}

function getScrollTopWithRelative(relativeId){
    var _scrollTop = 0;
    var _position = $('body').css('position');
    if(_position=='relative'){
        _scrollTop = $(relativeId).scrollTop();
    }
    return _scrollTop;
}

 /**
 * 合并行.
 * @param table   table的id.
 * @param rowindex   第几行开始匹配.
 * @param cellindex  对第几列匹配.
 */
 function mergeCells(table, rowindex, cellindex, type){
    for(var i=rowindex; i<$("#"+table+" tr").length-1; i=i+rowSpan){
        var td_ = $("#"+table+" tr").eq(i).find("td").eq(cellindex);
        var rowSpan = 1;
        var text_ = td_.text();
        for(var j=(i+1); j<$("#"+table+" tr").length; j++){
            var td =  $("#"+table+" tr").eq(j).find("td").eq(cellindex);
            var text = td.text();
            if(text == text_){
                rowSpan += 1;
                td.hide();
            }else{
                break;
            }
        }
        td_.attr("rowSpan", rowSpan);
    }
 }
 
 /**
 * 两个 多项下拉选择框 互相转移 选择项.
 * @param srcObj   要转移的select的id.
 * @param desObj   目标select的id.
 */
function transferOptions(srcObj, desObj){
    if($("#"+srcObj+" option:selected").length>0){
        $("#"+srcObj+" option:selected").each(function(){
            $(this).wrap("<div id='wrap'></div>");
            $("#"+desObj).append($("#wrap").html());
            $("#wrap").remove();
        });
    } else {
        $.dialog.alert(comm.whir_selectfield, function(){});
    }
}

 /**
 * 两个 多项下拉选择框 互相转移 选择项，全部转移情况.
 * @param srcObj   要转移的select的id.
 * @param desObj   目标select的id.
 */
function transferOptionsAll(srcObj, desObj){
    if($("#"+srcObj+" option").length>0){
        $("#"+srcObj+" option").each(function(){
            $(this).wrap("<div id='wrap'></div>");
            $("#"+desObj).append($("#wrap").html());
            $("#wrap").remove();
        });
    } else {
    }
}

/**
 * 多项下拉选择框 向下移动 选择项.
 * @param selectObj   多项下拉选择框的id.
 */
function moveUp(selectObj){
    var theObjOptions=selectObj.options;
    for(var i=1, len=theObjOptions.length; i<len; i++) {
        if( theObjOptions[i].selected && !theObjOptions[i-1].selected ) {
            swapOptionProperties(theObjOptions[i],theObjOptions[i-1]);
        }
    }
}

/**
 * 多项下拉选择框 向上移动 选择项.
 * @param selectObj   多项下拉选择框的id.
 */
function moveDown(selectObj){
    var theObjOptions=selectObj.options;
    for(var i=theObjOptions.length-2; i>-1; i--) {
        if( theObjOptions[i].selected && !theObjOptions[i+1].selected ) {
            swapOptionProperties(theObjOptions[i],theObjOptions[i+1]);
        }
    }
}

 /**
 * 多项下拉选择框 上下转移 选择项.
 * @param selectId   select的id.
 * @param direct     方向，'up' 或者 'down'.
 */
function upOrDownOptions(selectId, direct){ 
    var selectObj = $("#"+selectId)[0];
    if(direct == 'up'){
        moveUp(selectObj);
    }else{
        moveDown(selectObj);
    }
}

function swapOptionProperties(option1, option2){
    $(option1).wrap("<div id='wrap1'></div>");
    $(option2).wrap("<div id='wrap2'></div>");
    var temp = $("#wrap1").html();
    $("#wrap1").html( $("#wrap2").html() );
    $("#wrap2").html( temp );

    $("#wrap1,#wrap2").find("option").unwrap();
}
 
 /**
 * 公共添加tr，请根据自己的需要传入修改后的json串.
 * commonAddTr({tableId:'',trIndex:1,operate:'clone',position:'end',isKeep:false,obj:null,callbackfunction:null}).
 * @param opeJson   参数json串.
 * <p>有以下默认值：</br>
 	{</br>
	    tableId: '',		     // 操作的table的id.</br>
		trIndex:0,      		 // 对table的第几行进行操作（复制或显示），注意table的tr的索引从0开始.</br>
		operate:'auto' ,         // 操作，'clone'表示只复制，'display'表示只显示，'auto'表示trIndex行若隐藏则进行显示，若显示则进行复制.</br>
		position:'end' ,      	 // 复制的tr放置的位置，'follow'表示放在添加事件所在行之后，'end'表示放在table最后.</br>
		isKeep:false ,           // false表示不保留已填写的数据，true表示保留.</br>
		obj:null    			 // 添加事件所在行的操作对象，一般是行内的按钮或图片.</br>
		callbackfunction:null    // 复制后的自定义的回调函数,有一个参数，为新添加的行的jquery对象.</br>
	}</br>
 * </p>
 */
function commonAddTr(opeJson){
    var opeJson_ = {
        tableId  : opeJson.tableId  || '' ,
        trIndex  : opeJson.trIndex  || 0 ,
        operate  : opeJson.operate  || 'auto' ,
        position : opeJson.position || 'end' ,
        isKeep   : opeJson.isKeep!=undefined?opeJson.isKeep:false ,
        obj      : opeJson.obj      || null ,
        callbackfunction : opeJson.callbackfunction || null 
    };
    var newTr = null;
    if( opeJson_.operate == 'display'){
        displayData(opeJson_);
    }else if( opeJson_.operate == 'clone'){
        newTr = cloneData(opeJson_);
    }else if( opeJson_.operate == 'auto'){
        if( !$("#"+opeJson_.tableId+" tr").eq(opeJson_.trIndex).is(":visible") ){
            displayData(opeJson_);
        }else{
            newTr = cloneData(opeJson_);
        }
    }
    if(opeJson_.callbackfunction!=null){
        opeJson_.callbackfunction.call(opeJson_.callbackfunction,newTr);
    }
}

function displayData(opeJson_){
    $("#"+opeJson_.tableId+" tr").each(function(){
        var index = $(this).index();
        if( index <= opeJson_.trIndex ){
            $(this).show();
        }
    });
}

function cloneData(opeJson_){
    var newTrIndex = 1 ;
    var eventTr = null ;
    var copyHtml = ""; //复制来源
    if(opeJson_.obj!=null){ //来源于事件触发所在行
        eventTr = $(opeJson_.obj).closest("tr");
        copyHtml = eventTr.clone(true) ;
    }else{ //来源于trIndex指定行
        copyHtml = $("#"+opeJson_.tableId+" tr").eq(opeJson_.trIndex).clone(true) ;
    }
    //放置位置
    if( opeJson_.position == 'end'){
        $(copyHtml).appendTo($("#"+opeJson_.tableId));
        newTrIndex = $("#"+opeJson_.tableId+" tr").length-1 ;
    }else{
        $(copyHtml).insertAfter(eventTr);
        newTrIndex = eventTr.index() + 1 ;
    }
    var newTr = $("#"+opeJson_.tableId+" tr").eq(newTrIndex);
    //是否保留数据
    if(!opeJson_.isKeep){
        clearData(newTr);
    }
    //复制样式
    cloneStyle(newTr);
    return newTr;
}

function clearData(tr){
    $(tr).find("input:text,input:hidden,textarea").each(function() { $(this).val(""); });
    $(tr).find("input:radio,input:checkbox").each(function() {$(this).prop("checked", false); });
    $(tr).find("select").each(function() { $(this).find("option:first").attr('selected','selected'); });
}

function clearStyle(tr){
    tr.find("input:radio,input:checkbox").each(function() {
        var b = false;
        if( $(this).parent().attr("class")=='checked' ){
            b = true ;
        }
        $(this).parent().parent().replaceWith($(this).parent().html()); 
        if(b){
            $(this).prop("checked",true);
            $(this).click();
        }
    });
}

function cloneStyle(tr){
    $(tr).find("input,select,textarea").each(function(){
        var id = $(this).attr("id");
        if(id!=null && id!=undefined && id.indexOf("_")>=0){
            var pre = id.substring(0,id.indexOf("_")+1);
            var newId = pre + $(tr).index();
            $(this).attr("id",newId);
        }
    });
    setStyle();
}

 /**
 * 公共删除tr，请根据自己的需要传入修改后的json串.
 * @param opeJson   参数json串.
 * <p>有以下默认值：</br>
 	{</br>
	    obj: null,		     	 // 点击的操作对象，一般是行内的按钮或图片.</br>
	    trIndex:0,               // 对table的第几行进行操作（复制或显示），注意table的tr的索引从0开始.</br>
		callbackfunction:null    // 删除后的自定义的回调函数.</br>
	}</br>
 * </p>
 */  
function commonRemoveTr(opeJson){
    var obj = opeJson.obj || null ;
    var operate = opeJson.operate || 'remove' ;
    var callbackfunction = opeJson.callbackfunction || null ;
    if(obj!=null){
        if(operate == 'remove'){
            $(obj).closest("tr").remove();
        }else{
            clearData($(obj).closest("tr"));
            $(obj).closest("tr").hide();
        }
    }
    if(callbackfunction!=null){
        callbackfunction.call(callbackfunction);
    }
}

 /**
 * 获取iframe document.
 * @param frame   编辑器iframe的id，不要加引号.
 */
function getFrameDoc(frame) {
    var doc = frame.contentWindow ? frame.contentWindow.document : frame.contentDocument ? frame.contentDocument : frame.document;
    return doc;
}

 /**
 * 获取编辑器HTML.
 * @param frame   编辑器iframe的id，不要加引号.
 */
function getWebeditorHTML(frame){
    /*if($.browser.mozilla){
        return frame.contentWindow.getHTML();
    }else if($.browser.chrome){
        return frame.contentWindow.getHTML();
    }else{
        return frame.getHTML();
    }*/
    try{
        return frame.contentWindow.getHTML();
    }catch(e){
        return frame.getHTML();
    }
}

 /**
 * 设置编辑器HTML.
 * @param frame   编辑器iframe的id，不要加引号.
 */
function setWebeditorHTML(frame, html){
    /*if($.browser.mozilla){
        frame.contentWindow.setHTML(html);
    }else if($.browser.chrome){
        frame.contentWindow.setHTML(html);
    }else{
        frame.setHTML(html);
    }*/
    try{
        frame.contentWindow.setHTML(html);
    }catch(e){
        frame.setHTML(html);
    }
}

 /**
 * 设置编辑器HTML.
 * @param frame   编辑器iframe的id，不要加引号.
 */
function insertWebeditorHTML(frame, html){
    /*if($.browser.mozilla){
        frame.contentWindow.insertHTML(html);
    }else if($.browser.chrome){
        frame.contentWindow.insertHTML(html);
    }else{
        frame.insertHTML(html);
    }*/
    try{
        frame.contentWindow.insertHTML(html);
    }catch(e){
        frame.insertHTML(html);
    }
}
 
 /**
 * 创建动态form,导出excel.
 * @param formJson   参数json格式：{formId:'列表页查询表单的ID', action:'提交url地址' }.
 */
function commonExportExcel(formJson) {
    //序列化列表元素 返回 JSON 数据结构数据
    var formId = formJson.formId;
    var params = [];
    if(formId!=undefined && formId!=''){
        params = $("#"+formId).serializeArray();
    }

    var $form = $('#exportForm');
    if ($form.length > 0) {
        $form.remove();
    }

    var selectedId = formJson.selectedId || undefined;
    if(selectedId){//SELECTED EXPORT:selectExportId
        params.push({name: 'selectExportId', value: getCheckBoxData(selectedId, selectedId)});
    }

    if($("#exportIframe").length==0){
        var exportIframe = '<div style="display:none"><iframe id="exportIframe" name="exportIframe" width="0" height="0"></iframe></div>';
        $("body").append(exportIframe);
    }

    var _target = "exportIframe";
    //iPad
    if(isPad()){
        _target = "_blank";
    }

    var $form = createDynamicForm({id:'exportForm', target:_target,action:formJson.action,params:params,method:'post'});
    if($form) {
        $form.submit();
    }
}

 /**
 * 创建动态form,并提交.
 * @param formJson   参数json格式：{formId:'列表页查询表单的ID', action:'提交url地址' }.
 */
function commonSubmitDynamicForm(formJson) {
	//序列化列表元素 返回 JSON 数据结构数据
    var formId = formJson.formId;
    var params = [];
    if(formId!=undefined && formId!=''){
    	params = $("#"+formId).serializeArray();
    }

    if (formJson.params) {
        var _p = formJson.params;
        for (var i = 0, len=_p.length; i < len; i++) {
            params.push({'name':_p[i].name, 'value': _p[i].value});
        }
    }

    var method  = formJson.method || 'post';
    var _target = formJson.target || '_self';

    var _action = formJson.action;
    //iPad
    if(isPad()){
        _target = '_blank';
        //_action = _action.replace(/\/public\/download\/download.jsp/, '/DownloadServlet');
        //_action = _action + '&cd=inline&isPad=true';
    }

    var $form = createDynamicForm({id:'exportForm', target:_target, action:_action, params:params, method:method});
    if($form) {
        $form.submit();
    }
}

/**
 * 创建动态form，参数json格式：{id:'表单ID', action:'提交url地址', method:'提交方式get or post， 默认：get'（可选）, params:参数（可选）, dest:目标对象（可选），默认'body'}
 * params说明：
 * [ 
 *     {name: 'param1', value: 'val1'}, 
 *     {name: 'param2', value: 'val2'}
 * ]
 * @return 返回form对象
 */
function createDynamicForm(formJson) {
    if (formJson == null || formJson.id == undefined) return null;

    var $form = $('#' + formJson.id);
    if ($form.length > 0) {
        $form.remove();
    }
    var id = formJson.id;
    var action = formJson.action;
    var method = formJson.method || 'get';
    var target = formJson.target || '_self';
    
    var  contents = "";
    var  mainUrl = ""; 
    if (action.indexOf("?") > 0){
       //分解URL,第二的元素为完整的查询字符串
       var arrayParams = action.split("?");   
       //分解查询字符串
       	   mainUrl=arrayParams[0];   
       var arrayURLParams = arrayParams[1].split("&");
       //遍历分解后的键值对
       for (var i = 0, len=arrayURLParams.length; i < len; i++){
          //分解一个键值对
          var sParam =  arrayURLParams[i].split("=");  
          //if ((sParam[0] != "") && (sParam[1] != "")){ 
			  contents+=" <input  type=\"hidden\"   name=\""+sParam[0] +"\"  value=\""+sParam[1]+"\" >";
          //}
       }  
    }else{
 	  	mainUrl=action;
    }
    
    $form = $('<form id="' + id + '" name="' + id + '" action="' + mainUrl + '" method="' + method + '" target="' + target + '" enctype="application/x-www-form-urlencoded" />');
	
	$(contents).appendTo($form);
	
    var params = formJson.params || undefined;
    if (params) {
        for (var i = 0, len=params.length; i < len; i++) {
            $('<input type="hidden" name="' + params[i].name + '" value="' + (params[i].value ? params[i].value : "") + '"/>').appendTo($form);
        }
    }

    var dest = formJson.dest || 'body';
    $form.appendTo(dest);
    return $form[0];
}

 /**
 * 异步操作列表中的记录.，请根据自己的需要传入修改后的json串.
 * @param opeJson   弹出窗口的属性json串.
 * <p>有以下默认值：</br>
 	{</br>
	    urlWithData: '',		 // 业务访问的url地址：带数据.</br>
		tip:'操作',      		 // 提示.</br>
		isconfirm:true ,         // 是否需要确认提示.</br>
		formId:'' ,              // 待刷新列表的表单id.</br>
		callbackfunction:null,   // 回调函数.</br>
        customMessage:''         // 自定义提示信息.</br>
	}</br>
 * </p>
 */  
function ajaxOperate(opeJson){
    var opeJson_ = {
        urlWithData: opeJson.urlWithData || opeJson.url,
        tip:opeJson.tip || comm.whir_operate,
        isconfirm: opeJson.isconfirm!=undefined?opeJson.isconfirm:true,
        formId:opeJson.formId || '',
        callbackfunction:opeJson.callbackfunction || null,
        data:opeJson.data || '',
        customMessage:opeJson.customMessage
    }
    if(opeJson_.isconfirm){
        var title = comm.whir_confirm+opeJson_.tip+comm.whir_confirmlast;
        if(opeJson_.customMessage && opeJson_.customMessage != ''){
            title = opeJson_.customMessage;
        }
        
        $.dialog.confirm(title, function(){ 
            ajaxOperate_(opeJson_);
        });
    }else{
        ajaxOperate_(opeJson_);
    }
}

function ajaxOperate_(opeJson_){
    $.dialog.tips(comm.whir_being+opeJson_.tip+'....',1000,'loading.gif',function(){}); 
    jQuery.ajax({
        type : "POST",
        url  : opeJson_.url || opeJson_.urlWithData,
        data : opeJson_.data || '',
        success: function(msg){
            $.dialog({id:"Tips"}).close();
            var msg_json = eval("("+msg+")");
            if(msg_json.result == "success"){
                if(msg_json.data!=undefined && msg_json.data.message!=undefined){
                    $.dialog.alert(msg_json.data.message,function(){
                        if(opeJson_.callbackfunction!=null){
                            opeJson_.callbackfunction.call(opeJson_.callbackfunction,opeJson_,msg_json);
                        }
                        if(opeJson_.formId!=""){
                            $("#"+opeJson_.formId).submit();
                        }
                    }); 
                }else{
                    $.dialog.tips(opeJson_.tip+comm.whir_success,1,'success.gif',function(){
                        if(opeJson_.callbackfunction!=null){
                            opeJson_.callbackfunction.call(opeJson_.callbackfunction,opeJson_,msg_json);
                        }
                        if(opeJson_.formId!=""){
                            $("#"+opeJson_.formId).submit();
                        }
                    });
                }
            }else{
                $.dialog.alert($.trim(msg_json.result),function(){}); 
            } 
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            $.dialog.alert(opeJson_.tip+comm.whir_failure,function(){}); 
        }
    });
}

/**
 * 批量异步操作列表中的记录，请根据自己的需要传入修改后的json串.
 * @param opeJson   弹出窗口的属性json串,调用：ajaxBatchOperate({url:"",checkbox_name:"",attr_name:"",tip:"",isconfirm:true,formId:"queryForm",callbackfunction:null}).
 * <p>有以下默认值：</br>
 	{</br>
	    url: '',		 		 // 业务访问的url地址.</br>
	    checkbox_name: '',		 // 列表中的获得操作记录的多选框的名字.</br>
	    attr_name: '',		 	 // 列表中的获得操作记录的多选框的属性的名字.</br>
		tip:'操作',      		 // 提示.</br>
		isconfirm:true ,         // 是否需要确认提示.</br>
		formId:'' ,              // 待刷新列表的表单id.</br>
		callbackfunction:null,   // 回调函数.</br>
        customMessage:''         // 自定义提示信息.</br>
	}</br>
 * </p>
 */
function ajaxBatchOperate(opeJson){
    var opeJson_ = {
        url: opeJson.url,
        tip:opeJson.tip || comm.whir_operate,
        isconfirm: opeJson.isconfirm!=undefined?opeJson.isconfirm:true,
        formId:opeJson.formId || '',
        callbackfunction:opeJson.callbackfunction || null,
        data:'',
        customMessage:opeJson.customMessage
    }

    var datastr = "";
    var data = "";
    var attr_name_arr = opeJson.attr_name.split(",");
    for(var i=0, len=attr_name_arr.length; i<len; i++){
        if(attr_name_arr[i]!=""){
            datastr += "&"+attr_name_arr[i]+"="+getCheckBoxData(opeJson.checkbox_name,attr_name_arr[i]);
            if(i == 0){
                data = getCheckBoxData(opeJson.checkbox_name,attr_name_arr[i]);
            }
        }		
    }
    opeJson_.data = datastr ;

    if(data == ""){
        $.dialog.alert(comm.whir_notselect,function(){});
    }else{
        ajaxOperate(opeJson_);
    }
}

/**
 * 异步删除列表中的记录.
 * @param urlWithData      删除业务访问的url地址：带数据.
 * @param obj			   点击的dom对象.
 */
function ajaxDelete(urlWithData, obj){
    var opeJson = {
        urlWithData: urlWithData,
        tip:comm.whir_delete,
        isconfirm:true,
        formId:$(obj).parents("form").attr("id"),
        callbackfunction:null   
    }
    ajaxOperate(opeJson);
}

/**
 * 异步批量删除列表中的记录.
 * @param url      删除业务访问的url地址.
 * @param checkbox_name  列表中的获得删除记录的多选框的名字.
 * @param attr_name      列表中的获得删除记录的多选框的属性的名字.
 * @param obj            点击的dom对象.
 */
function ajaxBatchDelete(url, checkbox_name, attr_name,obj){
    var opeJson = {
        url: url,
        checkbox_name:checkbox_name,
        attr_name: attr_name,
        tip:comm.whir_delete,
        isconfirm:true,
        formId:$(obj).parents("form").attr("id"),
        callbackfunction:null   
    }
    ajaxBatchOperate(opeJson);
}

/***********************************************************分页相关************************************************************************************/
//设置分页中的文字说明部分
function setPagerDesc(formId){
    var $formId = $("#"+formId);
    $formId.find("#pager_desc").html(''+comm.currentpage+'&nbsp;<font color="red">'+$formId.find("#start_page").val()+"</font>/"+$formId.find("#page_count").val()+'&nbsp;'+comm.page+'&nbsp;&nbsp;&nbsp;'+comm.total+'&nbsp;'+$formId.find("#recordCount").val()+'&nbsp;'+comm.records+'&nbsp;' );
}

//设置分页
function setPager(formId){
    var jq_form = $("#"+formId);
    jq_form.find(".page").show();

    var page_size = (jq_form.find("#page_size").val())*1+0;
    var start_page = (jq_form.find("#start_page").val())*1+0;

    jq_form.find("#pager").jPages({
      containerID : "itemContainer",
      previous : comm.lastpage,
      next : comm.nextpage,
      perPage : page_size,
      startPage: start_page,
      delay : 20,
      formId:formId
    });

    setPagerDesc(formId);

    jq_form.find("#pager a").click(function(event){ 
         event.stopPropagation(); 
         event.preventDefault();
    }) ;
}

//跳转至某页,Go按钮.
function goPager(obj){
    if($(obj).prev().val() == ""){
        return ;
    }

    var $form = $(obj).parents("form")
    $form.find("#start_page").val($(obj).prev().val());
    $form.submit();
}

//跳转至某页，页码.
function pageClick(pagenumber, obj){
    if($(obj).attr('class')=='jp-current'){
        return;
    }

    var pform = $(obj).parents("form");
    pform.find("#start_page").val(pagenumber);
    pform.find("#go_start_pager").val("");
    pform.submit();
}

//点击分页按钮事件.
function pageBtnClick(obj, btn){
    var pform = $(obj).parents("form");
    var curpage = pform.find("#start_page").val();
    var page_count = pform.find("#page_count").val();

    if(btn == "previous"){
        if(curpage == "1"){
            return ;
        }else{
            curpage = curpage*1 - 1 ;
        }
    }else if(btn == "next"){
        if(curpage == page_count){
            return ;
        }else{
            curpage = curpage*1 + 1 ;
        }	
    }

    if($(obj).attr("class").indexOf("jp-disabled")<0){
        pageClick(curpage,obj);
    }
}

/***********************************************************列表页页相关************************************************************************************/
	
/**
 * 刷新列表页,可以重写以添加自己的特殊处理,比如校验字段.
 * @param formId  列表页面的加载数据用的表单id.
 */
function refreshListForm(formId){
    //在这里你可以做些刷新前的事情.....
    $("#start_page").val("1");
    $("#"+formId).submit();
}

function refreshListForm_(formId){
    $("#"+formId).submit();
}

/**
 * html编码.
 * @param str  html字符串.
 */
function HtmlEncode(str){   
     if(typeof str !== 'string') return str;
     //str = str.replace(/&/g, '&amp;');
     str = str.replace(/</g, '&lt;');
     str = str.replace(/>/g, '&gt;');
     //str = str.replace(/(?:t| |v|r)*n/g, '<br />');
     str = str.replace(/  /g, '&nbsp; ');
     //str = str.replace(/t/g, '&nbsp; &nbsp; ');
     str = str.replace(/x22/g, '&quot;');
     str = str.replace(/x27/g, '&#39;');
     //保留换行
     str = str.replaceAll_('&lt;br/&gt;', '<br/>');
     return str;
}

/**
 * html解码.
 * @param str  html字符串.
 */
function HtmlDecode(str){   
     if(typeof str !== 'string') return str;
     //str = str.replace(/&/g, '&amp;');
     str = replaceAll(str,'&lt;','<');
     str = replaceAll(str,'&gt;','>');
     //str = str.replace(/(?:t| |v|r)*n/g, '<br />');
     //str = str.replace(/  /g, '&nbsp; ');
     //str = str.replace(/t/g, '&nbsp; &nbsp; ');
     str = replaceAll(str,'&quot;','"');
     str = replaceAll(str,'&#39;',"'");
     return str;
}

/**
 * 日期字符串截取，格式:'yyyy-MM-dd'.
 * @param str  日期字符串.
 */
function common_DateFormat(datestr){
    if(datestr.length > 10){
        return datestr.substring(0,10);
    }
    return datestr;
}

/**
 * 日期字符串截取，格式:'yyyy-MM-dd hh:mm:ss'.
 * @param str  日期字符串.
 */
function common_DateFormatFull(datestr){
    if(datestr.length > 19){
        return datestr.substring(0,19);
    }
    return datestr;
}

/**
 * 日期字符串截取，格式:'yyyy-MM-dd hh:mm'.
 * @param str  日期字符串.
 */
function common_DateFormatMinite(datestr){
    if(datestr.length > 16){
        return datestr.substring(0,16);
    }
    return datestr;
}

/**
 * 列表页面，初始化<b>表单</b>为异步提交方式.
 * @param formJson  用于初始化的参数json.
 * <p>有以下默认值：</br>
 	{</br>
	    formId: '',		//列表页的表单ID.</br>
		onLoadSuccessAfter: null     //列表加载完毕回调函数.</br>
	}</br>
 * </p>
 */
function initListFormToAjax_extend(formJson){
    var formJson_ = eval(formJson);
    var formId = formJson_.formId;

    //初始化表头、分页参数等html、公共js事件绑定
    initList(formId);

    var jq_form = $('#'+formId);

    jq_form.ajaxForm({
        beforeSend:function(){
            $.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
        },
        success:function(responseText){
            $.dialog({id:"Tips"}).close();
            
            jq_form.find("#itemContainer").html("");
            jq_form.find("#itemContainer").html(responseText);
            
            //调用回调事件
            if(formJson_.onLoadSuccessAfter!=undefined){
                formJson_.onLoadSuccessAfter.call(this);
            }            
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            $.dialog({id:"Tips"}).close();
            $.dialog.alert(comm.loadfailure,function(){});
        }
    });
}

/**
 * 列表页面异步取数据.
 * @param formJson  用于初始化的参数json.
 * initListFormToAjax_extend_call({formId: '',pageCount: '',recordCount: '',listSize: ''});
 * <p>有以下默认值：</br>
 	{</br>
	    formId: '',		   //列表页的表单ID.</br>
		pageCount: '',     //总页数.</br>
		recordCount: '',   //总记录数.</br>
		listSize: ''       //当前页记录数.</br>
	}</br>
 * </p>
 */
function initListFormToAjax_extend_call(formJson){
    var formJson_ = eval(formJson);
    var formId = formJson_.formId;
    var jq_form = $('#'+formId);

    var td_length = jq_form.find("#headerContainer").find("td,th").length ;
        
    //分页信息
    if(eval(formJson_.pageCount)!=0 && eval(formJson_.pageCount) < eval(jq_form.find("#start_page").val()) ){
        jq_form.find("#start_page").val(jq_form.find("#start_page").val()-1);
    }
    jq_form.find("#page_count").val(formJson_.pageCount);
    jq_form.find("#recordCount").val(formJson_.recordCount);

    //设置列表样式部分
    setList(formId);

    //如果没有查询到记录，给出提示
    if(formJson_.listSize == 0){
        var no_record_tip = '<tr><td colspan="'+td_length+'" align="center" >'+comm.norecord+'</td></tr>';
        jq_form.find("#itemContainer").html(no_record_tip);
        jq_form.find(".page").hide();
    }
}

/**
 * 列表页面，初始化<b>表单</b>为异步提交方式.
 * @param formJson  用于初始化的参数json.
 * <p>有以下默认值：</br>
 	{</br>
	    formId: '',		//列表页的表单ID.</br>
		echoId: '',     //用于回显checkbox或者radio为选中状态的dom对象的id，从该dom对象中可以取出用于回显的值的拼串.</br>
		opener: '',     //弹出层方式打开时的父窗口对象.</br>
		onLoadSuccessAfter: null     //列表加载完毕回调函数.</br>
	}</br>
 * </p>
 */
function initListFormToAjax(formJson){
    var formJson_ = eval(formJson);
    var formId = formJson_.formId;

    //初始化表头、分页参数等html、公共js事件绑定
    initList(formId);

    var jq_form = $('#'+formId);

    var $headerContainer = jq_form.find("#headerContainer");
    var head_td = $headerContainer.find(".listTableHead").find("td");
    var win = window;
    try{
        if(frameElement!=null && frameElement.api==undefined && self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && self.frameElement.name!='customFieldFrame' ){
            win = window.parent;
        }
    }catch(e){}

    var $start_page = jq_form.find("#start_page");

    //行信息
    var tr_options = $headerContainer.attr("whir-options");
    var tr_render = null;
    if( tr_options!=undefined ){
        tr_options = eval("({"+tr_options+"})");
        if( tr_options.renderer!=undefined ){
            tr_render = tr_options.renderer;
        }
    }

    var td_length = head_td.length;
    var td_length_1 = td_length - 1;

    var tdOptions = new Array();
    head_td.each(function(){
        var whir_options_ = $(this).attr("whir-options");
        if(whir_options_==undefined){
            return true;
        }
        var whir_options_jo = eval("({"+whir_options_+"})");
        tdOptions.push(whir_options_jo);
    });

    var $itemContainer = jq_form.find("#itemContainer");
    var $page_count  = jq_form.find("#page_count");
    var $recordCount = jq_form.find("#recordCount");

    var echoId  = formJson_.echoId;
    var opener_ = formJson_.opener;
    jq_form.ajaxForm({
        /*beforeSend:function(){
            $.dialog.tips(comm.loadingdata,10,'loading.gif',function(){});
        },*/
        success:function(responseText){
            //var s = new Date().getTime();

            if(responseText.indexOf('?errorType=overtime')!=-1){
                top.document.write(responseText);
                return;
            }

            //解析服务器返回的json字符串
            responseText = responseText.replaceAll_("\\\\","\\\\");
            var json = eval("("+responseText+")").data;
            var pager = json.pager;
            var data  = json.data;

            //分页信息
            var _pageCount = parseInt(pager.pageCount, 10);
            var _start_page = parseInt($start_page.val(), 10);
            if(_pageCount != 0 && _pageCount < _start_page){
                $start_page.val(_start_page - 1);
            }

            $page_count.val(_pageCount);
            $recordCount.val(pager.recordCount);

            //设置列表样式部分
            setList(formId);
            jq_form.find(".page").hide();

            //循环数据信息
            var page_tr = "";
            var dataLen = data.length;
            if(dataLen > 0){
                for (var i=0; i<dataLen; i++) {
                    var po = data[i];
                    var tr_style = "";
                    if( tr_render != null){
                        tr_style = tr_render.call(tr_render, po, i);
                    }

                    var tr = '<tr '+tr_style+' class="listTableLine1" >';
                    if(i%2 == 1){
                        tr = '<tr '+tr_style+' class="listTableLine2" >';
                    }

                    var arr =  new Array();
                    for(var j=0, len=tdOptions.length; j<len; j++){
                        var td_class = '';
                        if(j == td_length_1){
                            td_class += 'class="listTableLineLastTD" ';
                        }

                        //主要数据
                        var whir_options = tdOptions[j];
                        var checkbox = whir_options.checkbox;
                        var radio    = whir_options.radio;
                        var renderer = whir_options.renderer;
                        var field    = whir_options.field;
                        var after    = whir_options.after;
                        
                        var field_value = "";
                        if(checkbox || radio){
                            if(field != "") field_value = eval("po."+field);

                            var echo_str = "";
                            var type_ = checkbox?"checkbox":"radio";
                            if(echoId != undefined){
                                if(opener_ != undefined){
                                    echo_str = ","+$("#"+echoId, opener_.document).val()+",";
                                }else{
                                    echo_str = ","+$("#"+echoId).val()+",";
                                }
                            }
                            var b = echo_str.indexOf(","+field_value+",")>=0;
                            var checked = b?"checked=true":"";
                            var str= "" ;
                            if(renderer){
                                str = renderer.call(renderer, po, i);
                            }
                            tr += '<td align="center" '+td_class+' ><input type="'+type_+'" '+checked+' name="'+field+'" '+field+'="'+field_value+'" '+str+' /></td>';
                        }else if(renderer){
                            if((renderer+"").indexOf("common_") >=0 ){
                                if(field != "") field_value = eval("po."+field);
                                field_value = renderer.call(renderer, field_value);
                                if(field_value == "") field_value = "&nbsp;";
                                var appendTd = '<td '+td_class+' >'+field_value+'</td>';
                                if(after != undefined){
                                    arr[after] = appendTd;
                                }else{
                                    tr += appendTd;
                                }
                            }else{	
                                field_value = renderer.call(renderer, po, i);//renderer
                                if(field_value == "") field_value = "&nbsp;";
                                var temp_value = $.trim(field_value);
                                if(temp_value.indexOf('<script>')!=-1 && temp_value.indexOf('<\/script>')!=-1){
                                    field_value = field_value.replace(/\<script\>/igm,'&lt;script&gt;').replace(/\<\/script\>/igm,'&lt;/script&gt;');
                                }
                                var appendTd = '<td '+td_class+' >'+field_value+'</td>';
                                if(after != undefined){
                                    arr[after] = appendTd;
                                }else{
                                    tr += appendTd;
                                }
                            }
                        }else{
                            if(field != "") field_value = eval("po."+field);
                            field_value = HtmlEncode(field_value);
                            if(field_value == "") field_value = "&nbsp;";

                            var appendTd = '<td '+td_class+' >'+field_value+'</td>';
                            if(after != undefined){
                                arr[after] = appendTd;
                            }else{
                                tr += appendTd;
                            }
                        }
                    }

                    $.each(arr, function(key, val) {
                        tr += val ;
                    });

                    tr += "</tr>";
                    page_tr += tr ;
                }

                //win.$.dialog({id:"Tips"}).close();
                $itemContainer.html(page_tr);
                jq_form.find(".page").show();
                if($.browser.msie){
					var ver = $.browser.version;
					if(ver >= 9.0){
                        var tmp = location.href + '';
                        if(tmp.indexOf('SelectOrgAndUser!') == -1){//避免IE10选择用户界面变形
                            $(document.body).parent().css('height', 'auto');
                        }
						$(window).scrollTop(0);
					}
				}
                //var d = new Date().getTime();alert(d-s);
            }else{
                //win.$.dialog({id:"Tips"}).close();
                //如果没有查询到记录，给出提示
                var no_record_tip = '<tr><td colspan="'+td_length+'" align="center" >'+comm.norecord+'</td></tr>';
                $itemContainer.html(no_record_tip);
                jq_form.find(".page").hide();
            }

            //调用回调事件
            if(formJson_.onLoadSuccessAfter){
                formJson_.onLoadSuccessAfter.call(this, json);
            }
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            //$.dialog({id:"Tips"}).close();
            //$.dialog.alert(comm.loadfailure,function(){});

            setTimeout(function(){
                jq_form.submit();
            }, 500);
        }
    });

    setTimeout(function(){
        //初次提交表单获得数据
        jq_form.submit();
    }, 1);
}

function initList(formId){
    initList(formId, true);
}

//初始化表头、分页参数等html、公共js事件绑定
function initList(formId, bindBodyEvtFlag){
    var $formId = $('#'+formId);
    var $headerContainer = $formId.find("#headerContainer");
    var $listTableHead = $headerContainer.find(".listTableHead");
    var $td = $listTableHead.find("td");

    //设置td宽度
    $td.each(function(){
        var $this = $(this);
        var whirOptions = $this.attr("whir-options");
        if(whirOptions == undefined){
            return true;
        }

        var whir_options = eval("({"+whirOptions+"})");
        var width = whir_options.width;
        $this.attr("width", width);

        var field = whir_options.field;
        if(whir_options.allowSort){
            var _len = $(this).find('#_img_'+(field.replace(/\$/m, '\\$'))).length;
            if(_len==0){
                var _html = $this.html();
                $this.html(_html+'<img id="_img_'+field+'" src="'+whirRootPath+'/images/blanksort.gif" style="cursor:pointer" onClick="orderBy(this,\''+field+'\');" >');
            }
        }
    });

    //允许排序的渲染
    if($("#"+formId+" #orderByFieldName").length == 0){
        $formId.append('<input type="hidden" id="orderByFieldName" name="orderByFieldName" value=""/><input type="hidden" id="orderByType" name="orderByType" value=""/>');
    }

    //分页参数的渲染
    if($("#"+formId+" #start_page").length==0){
        var pager_param = '<input type="hidden" id="start_page" name="startPage" defaultValue="1" value="1"/><input type="hidden" id="page_count" name="pageCount" defaultValue="1" value="1"/><input type="hidden" id="recordCount" defaultValue="0" name="recordCount" value="0"/>';
        $formId.append(pager_param);
    }

    //分页跳转事件的渲染	
    var $go_start_pager = $formId.find("#go_start_pager");
    $go_start_pager.bind('focus keyup blur mouseout',function(){
        //数字校验
        checkNumber($go_start_pager);
        
        var go_start_pager = $go_start_pager.val();
        if(go_start_pager == ""){
            return false;
        }
        
        var page_count = $formId.find("#page_count").val();
        if( (go_start_pager*1+0) > (page_count*1+0) ){
            $go_start_pager.val(page_count);
        }
        if( go_start_pager != "" && (go_start_pager*1+0) == 0 ){
            $go_start_pager.val(1);
        }
    });	

    //是否绑定回车事件
    if(bindBodyEvtFlag === undefined || bindBodyEvtFlag){
        //回车查询	
        $("body").on('keydown', function(event){
            if(event!=undefined && event.keyCode==13){
                var $go_start_pager_val = $go_start_pager.val();
                if($go_start_pager.attr("class")=="clicked" && $.trim($go_start_pager_val)!=""){
                    $formId.find("#start_page").val($go_start_pager_val);
                }else{
                    $formId.find("#start_page").val("1");
                }
                $formId.submit();
                event.preventDefault();
                event.stopPropagation();
            }
        });
    }
}

//设置列表样式部分
function setList(formId){
    var jq_form = $('#'+formId);

    //设置分页
    setPager(formId);

    //设置多选单选样式
    var theadcheckbox = jq_form.find(".listTableHead").find("input[type=checkbox]").eq(0);
    theadcheckbox.prop("checked", false);
}

//列表页表头排序事件
function orderBy(obj, orderByFieldName){
    $(obj).parents("#headerContainer").find(".listTableHead").find("img").not($(obj)).attr("src",whirRootPath+"/images/blanksort.gif");

    var orderByType = "desc";
    $("#orderByFieldName").val(orderByFieldName);

    var $src = $(obj).attr("src");
    if($src.indexOf("blanksort.gif")>=0 || $src.indexOf("arrow_up.gif")>=0){
        $(obj).attr("src", whirRootPath+"/images/arrow_down.gif");
        orderByType = "desc";
    }else if($src.indexOf("arrow_down.gif")>=0){
        $(obj).attr("src",whirRootPath+"/images/arrow_up.gif");
        orderByType = "asc";
    }
    $("#orderByType").val(orderByType);
    $(obj).parents("form").submit();
}

/**
 * 重置列表页的查询form表单.
 * @param obj 重置按钮的dom对象.
 */
function resetForm(obj){
    resetDataForm(obj);
    $(obj).parents("form").find("#headerContainer").find("img").each(function(){
        $(this).attr("src",whirRootPath+"/images/blanksort.gif");	
    });
    refreshListForm($(obj).parents("form").attr("id"));
}

/***********************************************************新增、修改页相关************************************************************************************/

/**
 * 重置新增、修改页的查询form表单.
 * @param obj 按钮的dom对象.
 */
function resetDataForm(obj){
    if($('#_whir_private_param_').length == 0){
        var $form = $(obj).parents("form");
        $form[0].reset();
        $form.find("select").each(function(){
            $(this).find("option[value='"+$(this).attr("defaultValue")+"']").attr("selected", true);
        });
        $form.find("input[type='hidden']").each(function(){
            $(this).val($(this).attr("defaultValue"));
        });
        $form.find(".easyui-combobox").each(function(){
            $(this).combobox("reset");
        });
    }else{
        _reloadForm(obj);
    }
}

/**
 * Reload重置新增、修改页的查询form表单.
 * @param obj 按钮的dom对象.
 */
function _reloadForm(obj) {
    var this_href = location.href;
    if(this_href.indexOf('?') != -1){
        this_href = this_href.substr(0, this_href.indexOf('?'));
    }
    var decodeUrl = Base64.decode($('#_whir_private_param_').val());
    this_href += decodeUrl;
    var $form = createDynamicForm({id:'_postForm_', target:'_self', action:this_href, method:'post'});
    if($form) {
        $form.submit();
    }
}

/**
 * 重置新增、修改页的查询form表单.
 * @param obj 按钮的dom对象.
 */
function resetDataFormById(formId){
    if($('#_whir_private_param_').length == 0){
        $("#"+formId)[0].reset();
        $("#"+formId).find("input[type='hidden']").each(function(){
            $(this).val($(this).attr("defaultValue"));
        });
        $("#"+formId).find(".easyui-combobox").each(function(){
            $(this).combobox("reset");
        });
    }else{
        _reloadForm(null);
    }
}

/**
 * 关闭弹出窗口.
 * @param obj 当使用openWin打开窗口时为null，当使用popup弹出层时为api，api是在弹出的页面中这样获得的：var api = frameElement.api ;.
 */
function closeWindow(obj){
    if(obj==null){
        //window.close();
        _closeWin();
    }else{
        obj.close();
    }
}

/**
 * 表单验证提示弹出层.
 * @param obj    需要验证的表单的元素，可以使dom对象，也可以是jquery对象.
 * @param tipText  提示内容.
 */
function whir_poshytip(obj, tipText, alignX){
    if(whir_agent.indexOf("MSIE 7")>=0){
        $("body").css("position","static");
    }
    var alignX_ = alignX || 'inner-left';
    $(obj).poshytip({
        content:tipText,
        className: 'tip-yellowsimple',
        showOn: 'none',
        alignTo: 'target',
        alignX: alignX_,
        offsetX: 0,
        offsetY: 5
    });	

    $(obj).focus();
    var class_ = $(obj).attr("class");
    if(class_!=undefined){
        if(class_.indexOf('Wdate')>=0 || class_.indexOf('public_overflow')>=0 ){
            var ranId= Math.floor(Math.random()*10000);
            $('<input type="text" id="wanhutest_'+ranId+'" style="width:0px;" />').insertBefore($(obj));
            $('#wanhutest_'+ranId).focus();
            $('#wanhutest_'+ranId).remove();
        }
    }
                
    $(obj).poshytip('show');
    setTimeout(function(){
        $(obj).poshytip('destroy');
        if(whir_agent.indexOf("MSIE 7")>=0){
            $("body").css("position","relative");
        }
    },2000);
}

/**
 * 表单验证.
 * @param formId 需要验证的表单的id.
 * @return       true:验证通过；false:验证不通过.
 */
function validateForm(formId){
    if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){
        $("body").css("position","static");
    }

    var validation = true;
	// 注：针对hidden域的校验，需要在hidden元素中添加自定义属性及其值 validate="true"
    $("#"+formId).find("input[class^='inputText'],textarea[class^='inputText'],.selectlist,.inputTextarea,.Wdate,.htmleditor,select[class^='easyui-combobox'],input[type='hidden'][validate='true']").each(function(){
        var whirOptions = $(this).attr("whir-options");
        if(whirOptions == undefined){
            return true;
        }
        
        var whir_options = eval("({"+whirOptions+"})");
        
        var class_ = $(this).attr('class');
        var obj = this;	
        var value = $(this).val();
        if(class_!=undefined && class_.indexOf("easyui-combobox")>=0){
            value = $("input[name='"+$(obj).attr("comboname")+"']").eq(0).val();
        }

        var promptText = whir_options.promptText;
        if(promptText!=undefined && value==promptText){
            value = "";
        }
        
        if(class_ == 'htmleditor'){
            value = KindEditor.instances[0].html();
            $(this).val(value);
        }
        
        var text = $(this).closest("td").prev().attr("for");
        //添加子表验证查找for规则
        if(text==undefined){
            var td = $(this).parent();
            var tr = td.parent();
            var table = tr.parent();
            var index = td.index();
            var ftd = table.find("tr:first").find("td").eq(index);
            text = $(ftd).attr("for");
        }
		if(text==undefined){ 
            text = whir_options.tiptext;
        }
        
        var tip = "";
        var vtype = whir_options.vtype;
        if(vtype!=undefined){
               vtype = eval(vtype);
               for(var i=0;i<vtype.length;i++){
                    var vtype_ = vtype[i];
                    if( vtype_ == 'notempty' || $.trim(value)!='' ){
                        tip = myValidate(value,vtype_);
                        if(tip != "" && tip != true ){
                            break;
                        }
                    }
               }		
        }

        //2013.07.02 增加自定义验证函数
        if(tip === false){
            validation = false;
            return false;
        }else if(tip != "" && tip != true ){
            text += tip;
        }
        
        if(tip != "" && tip != true ){
            if($(this).closest("div[id^='docinfo']").length>0){
                $("div[id^='docinfo']").hide();
                $(this).closest("div[id^='docinfo']").show();
                var index = $(this).closest("div[id^='docinfo']").index();
                $(".Public_tag ul li").attr("class","");
                $(".Public_tag ul li").eq(index).attr("class","tag_aon");
            }
            validation = false;
            var focusId = whir_options.focusId;
            if(focusId == undefined){
                if(class_ == 'htmleditor'){
                    obj = $(".ke-edit-iframe");
                }
                if($(obj).attr("class").indexOf("easyui-combobox")>=0){
                    obj = $(obj).next().find("input[type='text']").eq(0);
                }
                
                if(class_.indexOf('Wdate')>=0 || class_.indexOf('public_overflow')>=0 ){
                    var ranId= Math.floor(Math.random()*10000);
                    $('<input type="text" id="wanhutest_'+ranId+'" style="width:0px;" />').insertBefore($(obj));
                    $('#wanhutest_'+ranId).focus();
                    $('#wanhutest_'+ranId).remove();
                    //$("body,html,document").scrollTop($(obj).offset().top);
                }else{
                    $(obj).focus();
                }
            } else {
                obj = $("#"+focusId+" input[type=text]");
                $(obj).focus();
            }

            $(obj).poshytip('destroy');
            $(obj).poshytip({
                content:text,
                className: 'tip-yellowsimple',
                showOn: 'none',
                alignTo: 'target',
                alignX: 'inner-left',
                //alignY:	'inner-bottom',
                offsetX: 0,
                offsetY: 5
            });
            
            $(obj).poshytip('show');
            setTimeout(function(){
                $(obj).poshytip('destroy');
                if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){
                    $("body").css("position","relative");
                }
            },2000);
            return false;
        }
            
    });
    //prompt提交置空
    if(validation){
        $("input[class^='input'],.inputTextarea").each(function(){	
            if($(this).attr('whir-options')!=undefined){
                var whir_options = eval("({"+$(this).attr("whir-options")+"})");
                var promptText = whir_options.promptText;
                if(promptText!=undefined){	
                    if($.trim($(this).val())==promptText){
                        $(this).val("");
                    }
                }
            }
        });
    }
    return validation;
}

/**
 * 新增或修改页面，初始化<b>表单</b>为异步提交方式，<br/>如果parFormId=="callback"，<br/>那么操作完成后将调用父页面的callback()方法，<br/>如果parFormId==""，则无操作.
 * @param dataForm : ''  lhgdialog弹出窗口的表单id.
 * @param queryForm : '' 父页面的查询form的id.
 * @param tip  :''		 操作完成后的业务提示，如"保存"、"添加"等.
 * @param reset : 'yes'    操作完成后是否需要重置表单，前提操作继续而不是退出,'yes' 或 'no'.
 * @param successtip :true     操作完成后是否需要弹出成功提示 ,true 或 false.
 * @param callbackfunction : null    回调函数.
 * @param tip_lock : true    提示信息是否锁屏.
 */
function initDataFormToAjax(dialog_json){
    //暂时不用了
    var api = dialog_json.api;
    var W   = dialog_json.W;

    var dataForm = dialog_json.dataForm || '' ;
    var queryForm = dialog_json.queryForm || '' ;
    var tip = dialog_json.tip || comm.whir_operate ;
    var reset = dialog_json.reset || 'yes' ;
    var successtip = dialog_json.successtip!=undefined?dialog_json.successtip:true ;
    var callbackfunction = dialog_json.callbackfunction || null ;
    var tip_lock = dialog_json.tip_lock!=undefined?dialog_json.tip_lock:true;

    //保存继续或退出
    var pager_param = '<input type="hidden" id="saveType" name="saveType" value="0" />';
    var $dataForm = $('#'+dataForm);
    $dataForm.append(pager_param);

    $dataForm.ajaxForm({
        beforeSend:function(){
            if(successtip){
                $.dialog.tips(comm.isdoing+tip+"...",50,'loading.gif',function(){},tip_lock);
            }
        },
        success:function(responseText){
            $.dialog({id:"Tips"}).close();
            
            var msg_json = eval("("+responseText+")");
            if(msg_json.result == "success"){
                if(successtip){
                    var tip_ = tip+comm.success;
                    if(msg_json.data!=null && msg_json.data.tip!=null){
                        tip_ = msg_json.data.tip;
                    }
                    $.dialog.tips(tip_,1,'success.gif', function(){
                        initDataFormToAjax_(dialog_json,msg_json);
                    },true);
                }else{
                    initDataFormToAjax_(dialog_json,msg_json);
                }
            }else{
                if(msg_json.result=='failure'){
                    $.dialog.alert(tip+comm.failure, function(){
                        if(callbackfunction!=null ){
                                callbackfunction.call(callbackfunction,msg_json);
                        }
                    });
                }else{
                    $.dialog.alert(msg_json.result, function(){
                        if(callbackfunction!=null ){
                                callbackfunction.call(callbackfunction,msg_json);
                        }
                    });
                }
            }
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            $.dialog({id:"Tips"}).close();
            $.dialog.alert(tip+comm.failure,function(){
            });
        }
    });
}

function initDataFormToAjax_(dialog_json,msg_json){
    var dataForm = dialog_json.dataForm || '' ;
    var queryForm = dialog_json.queryForm || '' ;
    var tip = dialog_json.tip || comm.whir_operate ;
    var reset = dialog_json.reset || 'yes' ;
    var successtip = dialog_json.successtip!=undefined?dialog_json.successtip:true ;
    var callbackfunction = dialog_json.callbackfunction || null ;
    if(queryForm!="" && window.opener!=null){	
        window.opener.refreshListForm_(queryForm);
    }
    var saveType = $("#"+dataForm).find("#saveType").val();
    if(callbackfunction!=null ){
        callbackfunction.call(callbackfunction,msg_json);
    }
    if(saveType == "0"){
        //window.close();
        _closeWin();
    }
    if(saveType == "1"){
        if(reset=='yes'){
            resetDataFormById(dataForm);
        }
    }
}

function _closeWin(){
    var browserName=navigator.appName;
    if (browserName=="Netscape") {
        //window.opener = null;
        window.open('','_self','');
        window.close();
    } else {
        window.opener = null;
        window.close();
    }
}

/**
 * 新增或修改页面点击保存退出或保存继续按钮触发的事件.
 * @param n   0:保存退出；1:保存继续.
 * @param obj 保存按钮的dom对象.
 */
function ok(n, obj){
    var $form = $(obj).parents("form");
    var formId = $form.attr("id");
    var validation = validateForm(formId);
    /*if(validation){
        $form.find("#saveType").val(n);
        $('#'+formId).submit();
        try{obj.blur();}catch(e){}
    }*/
    oksubmit(n, obj, validation);
}

/**
 * 新增或修改页面点击保存退出或保存继续按钮触发的事件.
 * @param n   0:保存退出；1:保存继续.
 * @param obj 保存按钮的dom对象.
 * @param cb 自定义验证方法.
 */
function ok(n, obj, cb){
    var $form = $(obj).parents("form");
    var formId = $form.attr("id");
    var validation = validateForm(formId);
    if(validation){
        if(cb != null){
            validation = cb.call(cb);
            if(!validation){
                return;
            }
        }
    }
    oksubmit(n, obj, validation);
}

/**
 * 新增或修改页面点击保存退出或保存继续按钮触发的事件.
 * @param n   0:保存退出；1:保存继续.
 * @param obj 保存按钮的dom对象.
 * @param validation 自定义验证状态 true-通过 false-不通过.
 */
function oksubmit(n, obj, validation){
    if(validation){
        var $form = $(obj).parents("form");
        var formId = $form.attr("id");
        $form.find("#saveType").val(n);
        $('#'+formId).submit();
        try{obj.blur();}catch(e){}
    }
}

/***********************************************************提示相关************************************************************************************/
//创建浮动层，备用
function floatTip(txt){	
    //IE6位置
    if (!window.XMLHttpRequest) {
        $("#targetFixed").css("top", $(document).scrollTop() + 2);	
    }
    //创建半透明遮罩层
    if (!$("#overLay").size()) {
        $('<div id="overLay"></div>').prependTo($("body"));
        $("#overLay").css({
            width: "100%",
            backgroundColor: "#000",
            opacity: 0,
            position: "absolute",
            left: 0,
            top: 0,
            zIndex: 99
        }).height($(document).height());
    }
    //显示操作提示，最关键核心代码
    $("#targetFixed").powerFloat({
        eventType: null,
        targetMode: "doing",
        target: txt,
        position: "1-2"
    });
    //定时关闭，测试用
    setTimeout(function() {
        $("#overLay").remove();
        $.powerFloat.hide();
    }, 2000);
}

/**
 * 弹出警告.
 * @param title    警告信息.
 * @param callback 回调函数.
 * @param parent   弹出层父层.
 */
function whir_alert(title, callback, parent){
    var win = this;
    if(parent!=null){
        win = parent.opener ;
    }
    if(win.$.dialog){
        win.$.dialog.alert(title,function(){ 
            if(callback!=null){
                callback.call(callback);
            }
        },parent);
    }else{
        top.$.dialog.alert(title,function(){ 
            if(callback!=null){
                callback.call(callback);
            }
        },parent);
    }
}

/**
 * 弹出警告.
 * @param title    警告信息.
 * @param callback 回调函数.
 * @param parent   弹出层父层.
 */
function whir_alert_fix(title, callback, parent, _left, _top){
    var win = this;
    if(parent!=null){
        win = parent.opener ;
    }
    win.$.dialog.alert_wf(title,function(){ 
        if(callback!=null){
            callback.call(callback);
        }
    },_left,_top);
}

/**
 * 弹出警告.
 * @param title    警告信息.
 * @param callback 回调函数.
 * @param parent   弹出层父层.
 * @param width    弹出层宽度.
 * @param height   弹出层高度.
 */
function whir_alert_eh(title, callback, parent, width, height){
    var win = this;
    if(parent!=null){
        win = parent.opener ;
    }
    win.$.dialog.alert_eh(title,function(){ 
        if(callback!=null){
            callback.call(callback);
        }
    },parent,width,height);
}

/**
 * 弹出提示.
 * @param title    提示信息.
 * @param time     显示时间，单位是秒，例如time=3表示提示时间为3秒钟.
 * @param icon     提示图标，直接传入图片名称，如tip.gif,所有提示类图片都放在WebRoot/scripts/lhgdialog/skins/icons下.
 * @param callback 回调函数.
 */	
function whir_tips(title, time, icon, callback, parent){
    if(title==""){
        title = comm.loadingdata;//"正在加载...";
    }
    if(icon==""){
        icon = "loading.gif";
    }
    var win = this;
    if(parent!=null){
        win = parent.opener ;
    }
    win.$.dialog.tips(title,time,icon,function(){
        if(callback!=null){
            callback.call(callback);
        }
    });
}

/**
 * 弹出确认.
 * @param content  确认信息.
 * @param callback 回调函数.
 */	
function whir_confirm(content, callback, callback2, parent){
    var win = this;
    if(parent!=null){
        win = parent.opener ;
    }
    if(win.$.dialog){
        win.$.dialog.confirm(content, 
            function(){ 
                if(callback!=null){
                    callback.call(callback);
                }
            },
            function(){ 
                if(callback2!=null){
                    callback2.call(callback2);
                }
            }
        ,parent);
    }else{
        top.$.dialog.confirm(content,
            function(){ 
                if(callback!=null){
                    callback.call(callback);
                }
            },
            function(){ 
                if(callback2!=null){
                    callback2.call(callback2);
                }
            }
        ,parent);
    }
}

/***********************************************************弹出窗口相关************************************************************************************/
/**
 * 窗口重新设置高度和宽度并移动至屏幕中央
 * @param w   窗口宽度.
 * @param h   窗口高度.
 */
function resizeWin(w, h){
    window.resizeTo(w,h);
    var t=0;
    var l=0;
    l=(screen.width-w)/2;
    t=(screen.height-h)/2;
    window.moveTo(l,t);
}

/**
 * 公共文件导入接口方法，请根据自己的需要传入修改后的json串.
 * @param winJson   弹出窗口的属性json串.
 * <p>有以下默认值：</br>
 	{</br>
	    importer: '',			// 导入文件保存数据的处理器，是自己模块写的一个action或者一个jsp，其导入成功时异步打印'success',失败时异步打印失败的原因.</br>
		title: '文件导入'     	// 弹出窗口的标题.</br>
		filetype: 'excel'     	// 文件类型.</br>
	}</br>
 * </p>
 */
function excelImport(winJson){
    var title = winJson.title?winJson.title:comm.whir_importfile;
    var filetype = winJson.filetype?winJson.filetype:"*.xls";
    var url = whirRootPath+"/public/upload/fileimport/common_import.jsp?filetype="+filetype+"&importer="+winJson.importer;
    popup({id:"excelImport",content:"url:"+url,title:title,width:550,height:250,lock:true});
}

/**
 * 跳转地址转为href方式，保证refer存在.
 * @param url  跳转地址.
 */	
function location_href(url){
    if(document.all){
        if ($.browser.msie && ($.browser.version == "6.0") ) {
            document.write("<a href='javascript:void(0);' id='whir_alink_tttt' onclick='window.location.href=\""+url+"\";return false;'></a>");
            document.close();
            document.getElementById('whir_alink_tttt').click();
        }else{
            var gotoLink = document.createElement('a');
            gotoLink.href = url;
            document.body.appendChild(gotoLink);
            gotoLink.click();
        } 
    }else{
        window.location.href=url;
    }
}

/**
 * 新增、修改或查看等页面的弹出方法，请根据自己的需要传入修改后的json串.
 * @param dialogJson   弹出窗口的属性json串.
 * <p>有以下默认值：</br>
 	{</br>
	    content: '',				//弹出窗口显示的内容，如"<div>我是内容</div>"，如果是一个地址，请写成"url:访问的页面地址"，如"url:content/content.html".</br>
		title: '视窗',     			// 标题,默认'视窗'</br>
		button: null,	     		// 自定义按钮</br>
		ok: null,					// 确定按钮回调函数</br>
		cancel: null,				// 取消按钮回调函数</br>
		init: null,					// 对话框初始化后执行的函数</br>
		close: null,				// 对话框关闭前执行的函数</br>
		okVal: '确定',				// 确定按钮文本,默认'确定'</br>
		cancelVal: '取消',			// 取消按钮文本,默认'取消'</br>
		skin: '',					// 多皮肤共存预留接口</br>
		esc: true,					// 是否支持Esc键关闭</br>
		show: true,					// 初始化后是否显示对话框</br>
		width: 'auto',				// 内容宽度</br>
		height: 'auto',				// 内容高度</br>
		icon: null,					// 消息图标名称</br>
		path: _path,                // lhgdialog路径</br>
		lock: true,				    // 是否锁屏</br>
		focus: true,                // 窗口是否自动获取焦点</br>
		parent: null,               // 打开子窗口的父窗口对象，主要用于多层锁屏窗口</br>
		padding:'10px',		   		// 内容与边界填充距离</br>
		fixed: true,				// 是否静止定位</br>
		left: '50%',				// X轴坐标</br>
		top: '40%',					// Y轴坐标</br>
		max: true,                  // 是否显示最大化按钮</br>
		min: true,                  // 是否显示最小化按钮</br>
		zIndex: 1976,				// 对话框叠加高度值(重要：此值不能超过浏览器最大限制)</br>
		resize: true,				// 是否允许用户调节尺寸</br>
		drag: true, 				// 是否允许用户拖动位置</br>
		cache: true,                // 是否缓存窗口内容页</br>
		data: null,                 // 传递各种数据</br>
		extendDrag: false,          // 增加lhgdialog拖拽体验</br>
		time:null,                  //设置对话框显示时间,单位为秒</br>
		focus:true,                  //弹出窗口后是否自动获取焦点</br>
		opener:null                  //父窗口对象</br>
	}</br>
 * </p>
 */
function popup(dialogJson){
    var win = this;
    if(dialogJson.parent!=null && dialogJson.parent!=undefined){
        win = dialogJson.parent.opener ;
        win.$.dialog(dialogJson);
    }else{
        $.dialog(dialogJson);
    }
}

/**
 * 给弹出层的父窗口的元素赋值.
 * @param W 弹出层的父窗口对象.
 * @param ids  父窗口被赋值的元素的id数组.
 * @param values  值的数组，注意顺序和ids一致.
 */
function setOpenerValue(W, ids, values){
    for(var i=0;i<ids.length;i++){
        $("#"+ids[i], W.document).val(values[i]);
    }
}

/**
 * 得到弹出层的父窗口的元素的值.
 * @param W 弹出层的父窗口对象.
 * @param ids  父窗口元素的id数组.
 * @return 返回值的数组.
 */
function getOpenerValue(W, ids){
    var values = new Array();　
    for(var i=0;i<ids.length;i++){
        values.push($("#"+ids[i], W.document).val());
    }
    return values;
}

/**
 * 打开新窗口，请根据自己的需要传入修改后的json串.
 * @param winJson   弹出窗口的属性json串.
 * <p>有以下默认值：</br>
 	{</br>
	    url: '',					// 业务访问的url地址.</br>
		isPost: false,     			// 是否要求post方式打开，true:要求，false:不要求.</br>
		isFull: false,	     		// 是否要求全屏打开，true:要求，false:不要求.</br>
		width:  300,				// 窗口宽度.</br>
		height: 150,				// 窗口高度.</br>
		isScroll: 'yes',			// 是否允许滚动条，'yes':允许，'no':不允许.</br>
		isResizable: 'yes',			// 是否允许调节窗口大小，'yes':允许，'no':不允许.</br>
		winName: 'winName'			// 窗口名称.</br>
	}</br>
 * </p>
 */
function openWin(winJson) {
    var winJson_ = {
        url: winJson.url || '',
        isPost: winJson.isPost === undefined ? true : winJson.isPost,
        isFull: winJson.isFull || false,
        width:  winJson.width || 300,
        height: winJson.height || 150,
        isScroll: winJson.isScroll || 'yes',
        isResizable: winJson.isResizable || 'yes',
        winName: winJson.winName || ('w'+Math.round(Math.random()*100000))
    };

    try{winJson_.height = parseInt(winJson_.height);}catch(e){}

    if(isSurface()){//ms pad
        if(winJson.height){
            if(winJson.height >= 600){
                winJson_.isFull = true;
            }
        }
    }

    var wn = winJson_.winName;
    if(wn.length>20){
        wn = wn.substring(0,20);
        winJson_.winName = wn ;
    }

    if(winJson_.isFull){
        winJson_.width  = screen.availWidth;
        winJson_.height = screen.availHeight;
    }
    var l = (screen.availWidth - winJson_.width) / 2;
    var t = (screen.availHeight - winJson_.height) / 2;

    if(!winJson_.isFull){
        if(whir_browser=='firefox' || whir_browser=='chrome' || whir_browser=='opera' ){
            winJson_.height = (winJson_.height)-15 ;
        }else if(whir_browser=='safari' ){
            winJson_.height = (winJson_.height) - 100 ;
        }else if( whir_agent.indexOf("MSIE 10")>=0 ){
            winJson_.height = (winJson_.height) + 30 ;
        }else if( whir_agent.indexOf("rv:11")>=0  ){
            winJson_.height = (winJson_.height) + 30 ;
        }else{
            winJson_.height = (winJson_.height) + 60 ;
        }
    }else{
    }

    var s = 'width=' + winJson_.width + ', height=' + winJson_.height + ', top=' + t + ', left=' + l;
    s += ', toolbar=no, scrollbars='+winJson_.isScroll+', menubar=no, locations=0,location=no, status=no, status=0,resizable='+winJson_.isResizable;
    if(winJson_.isPost){
        if (window.attachEvent){ //ie,360兼容模式（其实是当前系统上装的ie浏览器对应的版本）
            UTFWindowOpen(winJson_.url, winJson_.winName, s, l, t, winJson_.width, winJson_.height, winJson_.isFull);
        }else{
            whir_openWindow(encodeURI(winJson_.url), winJson_.winName, s, l, t, winJson_.width, winJson_.height, winJson_);
        }
    }else{
        window.open(encodeURI(winJson_.url), winJson_.winName, s);
    }
}

function whir_openWindow(url, name, features, l, t, width, height, winJson_) {
    var targeturl = url;
    targeturl = targeturl.replace(/#/,'%23');

    if(checkCOS()){
        window.open(targeturl, name, features);
    }else{
        var newwin = window.open("", name, features);
        if( (whir_browser == 'chrome' || whir_agent.indexOf("MSIE 10")>=0 ||whir_agent.indexOf("rv:11")>=0 || whir_browser=='safari' ) && winJson_.isFull){
            newwin.moveTo(l, t);
            newwin.resizeTo(width, height);
        }
        newwin.location = targeturl;
    }
} 

//被openWin方法调用
function UTFWindowOpen(sURL, winName, features, l, t, width, height, isFull) { 
    var oW;
    var contents = "";
    var mainUrl  = ""; 
    if(sURL.indexOf("?") > 0){
        var arrayParams = sURL.split("?");
        var arrayURLParams = arrayParams[1].split("&");
        mainUrl = arrayParams[0];
        for (var i = 0, len=arrayURLParams.length; i < len; i++){
            var sParam = arrayURLParams[i].split("=");
            if ((sParam[0] != "") && (sParam[1] != "")){
                contents += "<input type=\"hidden\" name=\""+sParam[0] +"\" value=\""+sParam[1]+"\"/>";
            }else if (sParam[0] != "" && sParam[1] == ""){
                contents += "<input type=\"hidden\" name=\""+sParam[0] +"\" value=\"\"/>";
            }
        }
    }else{
        mainUrl=sURL;
    }

    oW = window.open('', winName, features);
    oW.document.open();
    oW.document.write('<form name="postform" id="postform" action="'+mainUrl+'" method="post" accept-charset="utf-8">'+contents+'</form><script type="text/javascript">document.getElementById("postform").submit();</script>');
    oW.document.close();
    //$("#postform", oW.document).submit();

    oW.moveTo(l, t);
    oW.resizeTo(width, height);
}

/***********************************************************控件操作、渲染相关************************************************************************************/
function replaceDollar(str){
    if(str.indexOf('$')!=-1) {
        return str.replace(/\$/m, '\\$');
    }
    return str;
}

/**
 * 获得checkbox的选中值，如果返回值为空说明没有任何checkbox被选中.
 * @param checkbox_name checkbox的名称.
 * @param attr_name   你打算获得的属性值的属性名字，如id、value等属性.
 * @return 获得的属性值的拼串，多个值之间以英文半角逗号分隔且最后一个逗号被自动去除，如"value1,value2,value3" ，如果返回值为空说明没有任何checkbox被选中.
 */
function getCheckBoxData(checkbox_name, attr_name) {
    checkbox_name = replaceDollar(checkbox_name);
    var r = "" ;
    $("input[name='"+checkbox_name+"'][type='checkbox']").each(function(){
        if($(this).prop("checked")==true ){
            r = r + $(this).attr(attr_name)+",";
        }
    });
    if(r.indexOf(",")>0){
        r = r.substring(0, r.length-1);
    }
    return r;
}

/**
 * 获得checkbox的选中值，如果返回值为空说明没有任何checkbox被选中.
 * @param paramJson 参数json，有以下key：.
 * rangeId 搜索范围id.
 * checkbox_name checkbox的名称.
 * attr_name   你打算获得的属性值的属性名字，如id、value等属性.
 * @return 获得的属性值的拼串，多个值之间以英文半角逗号分隔且最后一个逗号被自动去除，如"value1,value2,value3" ，如果返回值为空说明没有任何checkbox被选中.
 */
function getCheckBoxData4J(paramJson) {
    var checkbox_name = paramJson.checkbox_name;
    var attr_name = paramJson.attr_name;
    var rangeId = paramJson.rangeId;
    if(rangeId==undefined){
        rangeId = "";
    }else{
        rangeId = "#"+rangeId+" ";
    }
    checkbox_name = replaceDollar(checkbox_name);
    var r = "" ;
    $(rangeId+"input[name="+checkbox_name+"]").each(function(){
        if($(this).prop("checked")==true ){
            r = r + $(this).attr(attr_name)+",";
        }
    });
    if(r.indexOf(",")>0){
        r = r.substring(0,r.length-1);
    }
    return r;
}

/**
 * 操作checkbox的选中状态.
 * @param checkbox_name 需要设置状态的checkbox的名称.
 * @param state   true:设置为选中状态;false:设置为未选中状态.
 */
function setCheckBoxState(checkbox_name, state) {
    checkbox_name = replaceDollar(checkbox_name);
    $("input[name="+checkbox_name+"]").each(function(){
        if($(this).prop("disabled") == false){
            $(this).prop("checked", state);
        }
    });
}

/**
 * 操作checkbox的选中状态.
 * @param paramJson 参数json，有以下key：.
 * rangeId 搜索范围id.
 * checkbox_name 需要设置状态的checkbox的名称.
 * state   true:设置为选中状态;false:设置为未选中状态.
 */
function setCheckBoxState4J(paramJson) {
    var checkbox_name = paramJson.checkbox_name;
    var state = paramJson.state;
    var rangeId = paramJson.rangeId;
    if(rangeId==undefined){
        rangeId = "";
    }else{
        rangeId = "#"+rangeId+" ";
    }
    checkbox_name = replaceDollar(checkbox_name);
    $(rangeId+"input[name="+checkbox_name+"]").each(function(){
        if($(this).prop("disabled") == false){
            $(this).prop("checked", state);
        }
    });
}

/**
 * 标签输入，用于邮件选择接收人等场合.
 * @param floatObj  需要做标签输入的dom对象.
 * @param tagJson   标签组件的属性json串.
 * <p>有以下默认值：</br>
 	{</br>
	    allowDuplicates   : false,	// 是否允许输入重复的值.</br>
		caseSensitive     : true,   // 自动完成搜索时是否忽略大小写，true:忽略，false:不忽略.</br>
		fieldName         : 'tags',	// 标签组件映射的具体的input输入域的名字.</br>
		readOnly          : false,	// 是否不可编辑</br>
		tagLimit          : null,   // 最多输入标签数，null为无限制.</br>
		availableTags     : [],		// 用于自动完成搜索的数据源，为数组形式.</br>
		autocomplete	  : {},		// 重写availableTags.</br>
showAutocompleteOnFocus   : false,	// 是否允许提前显示自动完成的options.</br>
		allowSpaces		  : false,	// 是否允许标签内容输入空格.</br>
		singleField	      : false,	// 是否映射为单一输入域.</br>
	singleFieldDelimiter  : ',',	// 分隔符.</br>
		singleFieldNode   : null,	// 标签组件映射的具体的input输入域jQuery对象.</br>
		beforeTagAdded    : null,	// 输入前回调函数</br>
		afterTagAdded     : null,	// 输入后回调函数</br>
		beforeTagRemoved  : null,	// 删除前回调函数</br>
		afterTagRemoved   : null,   // 删除后回调函数</br>
		onTagClicked      : null,	// 点击时回调函数</br>
		onTagLimitExceeded: null,   // 标签个数超过限制时回调函数</br>
	}</br>
 * </p>
 */
function tag_it(tagObj, tagJson){
    $(tagObj).tagit(tagJson);
}

/**
 * 显示卡片信息或大图片的浮动层.
 * @param floatObj    浮动层的触发对象.
 * @param floatJson   浮动层的属性json串.
 * <p>有以下默认值：</br>
 	{</br>
	    width: "auto",				// 可选参数：inherit，数值(px).</br>
		eventType: "hover",     	// 事件类型，其他可选参数有：click, focus.</br>
		showDelay: 0,	     		// 鼠标hover显示延迟.当targetMode为ajax的时候，建议该值大于0</br>
		hoverFollow: false,			// true或是关键字x, y.</br>
		targetMode: "common",       // 浮动层的类型，其他可选参数有：ajax, list, remind</br>
		target: null, 				// target对象获取来源，优先获取，如果为null，则从targetAttr中获取。</br>
		targetAttr: "rel", 			// target对象获取来源，当targetMode为list时无效</br>
		container: null, 			// 转载target的容器，可以使用"plugin"关键字，则表示使用插件自带容器类型</br>
		reverseSharp: false, 		// 是否隐藏反向小三角的显示，默认ajax, remind是显示三角的，其他如list和自定义形式是不显示的</br>
	}</br>
 * </p>
 */
function whir_float(floatObj, floatJson){
    $(floatObj).powerFloat(floatJson);
}

//输入域颜色
function setInputStyle(){
    setStyle();
}

function setStyle(){
    var id = null;
    $(".inputText,.inputText_hover,.inputTextPrompt,.inputTextPrompt_hover").each(function(){
        promptCss(this);
    });
}

function promptCss(obj){
    var $obj = $(obj);
    if($obj.attr('whir-options')!=undefined){
        var whir_options = eval("({"+$obj.attr("whir-options")+"})");
        var promptText = whir_options.promptText;

        if(promptText!=undefined){
            $obj.attr('class','inputTextPrompt');
            if($obj.val() == ""){
                $obj.val(promptText);
            }
            $obj.on('focus',function(){
                if($.trim($obj.val())==promptText){
                    $obj.val("");
                }
            });
            $obj.on('blur',function(){
                if($.trim($obj.val())==""){
                    $obj.val(promptText);
                }
            });
        }
    }
}

/***********************************************************ajax调用相关************************************************************************************/
/**
 * 同步ajax调用.
 * @param url 访问的url地址.
 * @param data_str   各个参数的拼串，如"p1=v1&p2=v2&p3=v3"等.
 * @return 返回从服务器获得的数据.
 */
function ajaxForSync(url, data_str){
    var r = $.ajax({
              type:'post',
              url: url,
              data:data_str+'&date='+Math.random(),
              async: false
         }).responseText;
    r = $.trim(r);
    return r;
}

/**
 * 异步ajax调用.
 * @param url 访问的url地址.
 * @param data_str   各个参数的拼串，如"p1=v1&p2=v2&p3=v3"等.
 * @param callbackfunc 回调函数.
 */
function ajaxForAsync(url, data_str, callbackfunc){
    $.ajax({
        type: "post",
        url: url,
        data:data_str+'&date='+Math.random(),
        success: function(msg){
            if(callbackfunc!=null){
                callbackfunc.call(callbackfunc,msg);
            }
        }
    });
}

/***********************************************************常用工具相关************************************************************************************/
/**
 * iframe高度自适应.
 * @param iframe 	iframe对象或iframe的id.
 * @param div    	iframe内的div对象或div的id.
 * @param offset    可调节偏移量，以适应不同的页面情况，为整数.
 */
function iframeResizeHeight(iframe, div, offset){
    var Jiframe = null;
    var Jdiv = null;
    if((typeof iframe) == "string" ){
        Jiframe = $("#"+iframe,parent.document);
    }else{
        Jiframe = $(iframe,parent.document);
    }
    if((typeof div) == "string" ){
        Jdiv = $("#"+div);
    }else{
        Jdiv = $(div);
    }
    if(Jiframe.length>0){
        var div_height = Jdiv[0].scrollHeight;
        div_height = (div_height*1 + offset);
        Jiframe.height(div_height);
    }
}

// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子：
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
Date.prototype.format_ = function(fmt) { //author: meizz
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o) 
    if(new RegExp("("+ k +")").test(fmt)) 
    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;   
}

/**     
 * 转换日期对象为日期字符串. 
 * @param date 日期对象.     
 * @param isFull 是否为完整的日期数据,为true时, 格式如"2000-03-05 01:05:04" ; 为false时, 格式如 "2000-03-05".
 * @return 符合要求的日期字符串.     
 */      
function getSmpFormatDate(date, isFull) {
    var pattern = "";
    if (isFull == true || isFull == undefined) {
        pattern = "yyyy-MM-dd hh:mm:ss";
    } else {
        pattern = "yyyy-MM-dd";
    }
    return getFormatDate(date, pattern);
}    

/**     
 * 转换当前日期对象为日期字符串 .     
 * @param isFull 是否为完整的日期数据, 为true时, 格式如"2000-03-05 01:05:04" ; 为false时, 格式如 "2000-03-05".
 * @return 符合要求的日期字符串 .    
 */
function getSmpFormatNowDate(isFull) {
    return getSmpFormatDate(new Date(), isFull);
}

/**     
 * 转换long值为日期字符串.     
 * @param l long值.     
 * @param isFull 是否为完整的日期数据,为true时, 格式如"2000-03-05 01:05:04"; 为false时, 格式如 "2000-03-05".
 * @return 符合要求的日期字符串 .    
 */
function getSmpFormatDateByLong(l, isFull) {
    return getSmpFormatDate(new Date(l), isFull);
}

/**     
 * 转换long值为日期字符串.     
 * @param l long值.     
 * @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss .
 * @return 符合要求的日期字符串.  
 */
function getFormatDateByLong(l, pattern) {
    return getFormatDate(new Date(l), pattern);
}

/**     
 * 转换日期对象为日期字符串.     
 * @param date 日期对象.       
 * @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss .
 * @return 符合要求的日期字符串.     
 */
function getFormatDate(date, pattern) {
    if (date == undefined) {
        date = new Date();
    }
    if (pattern == undefined) {
        pattern = "yyyy-MM-dd hh:mm:ss";
    }
    return format(date,pattern);    
}    
    
/**
 * javascript的format方法，<br/>例如：(new Date()).Format("yyyy-MM-dd hh:mm:ss") ==> 2006-07-02 08:09:04.
 * @param dateObj     待格式化的js日期对象.
 * @param formatStyle 格式化样式.
 * @return 返回格式化后的日期字符串.
 */
function format(dateObj, formatStyle){
	return dateObj.format_(formatStyle);
}

/**
 * javascript的replaceAll方法.
 * @param sourceStr 源字符串.
 * @param reallyDo   待替换的字符串.
 * @param replaceWith   替换成的字符串.
 * @return 返回替换后的新字符串.
 */
function replaceAll(sourceStr, reallyDo, replaceWith){
	return sourceStr.replaceAll_(reallyDo, replaceWith);
}

/**
 * 检验一个字符串中是否含有特殊字符,防止sql注入攻击.
 * @param str 源字符串.
 * @return false:不包含特殊字符；true:包含特殊字符.
 */
function checkSpeChar(str){
    var inj_str ="'|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare|;|or|-|+|,";//这里的东西还可以自己添加
    var inj_arr =inj_str.split("|");
    for(var i=0, len=inj_arr.length; i < len; i++){
        if(str.indexOf(inj_arr[i])>=0){
            return true;
        }
    }
    return false;
}

/**
 * 输入时间与当前时间比较大小,如:<br/>var r = compareWithNow("2011-11-11").
 * @param date_str 输入时间字符串，形如"yyyy-MM-dd hh:mm:ss".
 * @return  符号字符串  "<":输入时间小于当前时间；"=":输入时间等于当前时间；">":输入时间大于当前时间.
 */
function compareWithNow(date_str){
    var inpdate = new Date(replaceAll(date_str, "-", "/"));
    var nowDate = new Date();

    if((Date.parse(inpdate) - Date.parse(nowDate)) < 0){
        return "<";
    }else if((Date.parse(inpdate) - Date.parse(nowDate)) == 0){
        return "=";
    }else{
        return ">";
    }
}

/**
 * 比较两个时间大小,如:<br/>var r = compareTwoDate("2011-11-11","2012-12-12").
 * @param date_st1r 输入时间字符串，形如"yyyy-MM-dd hh:mm:ss".
 * @param date_str2 输入时间字符串，形如"yyyy-MM-dd hh:mm:ss".
 * @return  符号字符串  "<":第一个时间小于第二个时间；"=":第一个时间等于第二个时间；">":第一个时间大于第二个时间.
 */
function compareTwoDate(date_str1, date_str2){
    var date1 = new Date(replaceAll(date_str1,"-","/"));
    var date2 = new Date(replaceAll(date_str2,"-","/"));

    if((Date.parse(date1) - Date.parse(date2)) < 0){
        return "<";
    }else if((Date.parse(date1) - Date.parse(date2)) == 0){
        return "=";
    }else{
        return ">";
    }
}

/**
 * 格式化文件大小.
 * @param size 文件大小,整数.
 * @return  符合要求的字符串表示，如 20KB,1MB等.
 */
function formatFileSize(size){
    var file_size = "";
    if(size>=(1024*1024)){
        size = (size/(1024*1024)).toFixed(2);
        file_size = size+"M";
    }else{
        size = (size/1024).toFixed(2);
        file_size = size+"KB";
    }
    return file_size;
}

/***********************************************************数字类验证相关************************************************************************************/
//整数输入域
function checkNumber(obj){
    $(obj).val($(obj).val().replace(/\D/g,''));
    //如果第二位不是.则第一位不能是0
    if($(obj).val()!="" && (($(obj).val())*1+0)==0){
        $(obj).val("0");
    }
}

//带小数点输入域,pointLength是保留小数点后的位数
function checkNumberWithPoint(obj,pointLength){
    $(obj).val($(obj).val().replace(/[^\d.]/g,""));
    $(obj).val($(obj).val().replace(/^\./g,""));
    $(obj).val($(obj).val().replace(/\.{2,}/g,"."));
    $(obj).val($(obj).val().replace(".","$#$").replace(/\./g,"").replace("$#$","."));
    //如果第二位不是.则第一位不能是0
    if($(obj).val().length>=2){
       var first = $(obj).val().substring(0,1);
       var second = $(obj).val().substring(1,2);
       if(first=='0' && second !='.'){
            $(obj).val($(obj).val().substring(1,$(obj).val().length));
       }
    }
    //保留pointLength小数
    var _val = $(obj).val();
    if(_val.indexOf(".")>0){
        var intPart = _val.substring(0, _val.indexOf(".")+1);
        var pointPart = _val.substring(_val.indexOf(".")+1, _val.length);
        if(pointPart.length > pointLength){
            pointPart = pointPart.substring(0, pointLength);
            $(obj).val(intPart+pointPart);
        }
    }
}

//如果最后一位是小数点则清除掉.
function clearPoint(obj){
    //如果第二位不是.则第一位不能是0
    if( $(obj).val()!="" && (($(obj).val())*1+0)==0){
        $(obj).val("0");
    }
    if($(obj).val().substring($(obj).val().length-1, $(obj).val().length) == '.'){
        $(obj).val($(obj).val().substring(0, $(obj).val().length-1));
    }
}

//数字或小数校验
function digitCheck(){
    $(".inputText,.inputText_hover,.inputTextPrompt,.inputTextPrompt_hover").each(function(){
        var whir_options_ = $(this).attr("whir-options");
        if(whir_options_!=undefined){
            var whir_options = eval("({"+whir_options_+"})");
            var vtype =  whir_options.vtype;
            if(vtype != undefined){
               vtype = eval(vtype);
               for(var i=0,len=vtype.length; i<len; i++){
                    var vtype_ = vtype[i];
                    if((typeof vtype_)!= "string" ){
                        var maxlength = "";
                        var point = "";
                        $.each(vtype_, function (k, v){ 
                            if(k=='maxLength'){
                                maxlength = v;
                            }
                            if(k=='point'){
                                point = v;
                            }
                        });
                        if(maxlength!=""){
                            $(this).attr("maxlength",maxlength);
                        }
                        if(point!=""){
                            //解决小数输入问题
                            $(this).bind('keyup blur',function(){checkNumberWithPoint(this,point);});
                            $(this).bind('blur',function(){clearPoint(this);});
                        }
                    }else{
                        if(vtype_.indexOf("decimal")>=0 ){
                            //解决小数输入问题
                            $(this).bind('keyup blur',function(){checkNumberWithPoint(this,4);});	
                            $(this).bind('blur',function(){clearPoint(this);});
                        } 
                        if(vtype_.indexOf("p_integer")>=0 ){
                            //解决整数输入问题	
                            $(this).bind('keyup blur mouseout',function(){checkNumber(this);});
                        }
                    }
               }
            }
        }
    });
}

function whir_uploader_reset(uniqueId){
    if($.browser.opera || whir_agent.indexOf("MSIE 10")>=0 ){
        var uploader = eval("up_"+uniqueId);
        if(typeof uploader == undefined){
            return false;
        }
        var html5Div = $("#"+uniqueId).find("input[type='file']").eq(0).parent();
        var upDiv = html5Div.parent();
        if(html5Div.css("width")=="0px"){
            $(html5Div).remove();
            uploader.init();
            upDiv.find("div[id$='_html5_container']").eq(1).remove();
        }
    }
}

/**
 * 科学计数法的数字转为普通的字符串.
 * @param value 需要转化的值.
 * @return      转化后的值.
 */
function convertNUM(value) {
     //转换之前的科学计数法表示
     var tempValue = value;
     var tempValueStr = new String(tempValue);
     if((tempValueStr.indexOf('E') != -1) || (tempValueStr.indexOf('e') != -1)){
         var regExp = new RegExp( '^((\\d+.?\\d+)[Ee]{1}(\\d+))$', 'ig' );
         var result = regExp.exec(tempValue);
         var resultValue = "";
         var power =  "" ;
         if(result != null){
            resultValue = result[2];
            power = result[3];
            result = regExp.exec(tempValueStr);
         }
         if(resultValue != ""){
             if(power != ""){
                var powVer = Math.pow(10, power);
                resultValue = resultValue * powVer;
            }
         }
         return resultValue;
    }
    return value;
}

function loadCss(url, callback){
    var link = document.createElement('link');
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.media = 'screen';
    link.href = url;
    document.getElementsByTagName('head')[0].appendChild(link);
}

function getBaseUrl(){
    var base = '.';
    var scripts = document.getElementsByTagName('script');
    for(var i=0,len=scripts.length; i<len; i++){
        var src = scripts[i].src;
        if (!src) continue;
        var m = src.match(/\/scripts\/main\/whir\.application\.js(\W|$)/i);
        if (m){
            base = src.substring(0, m.index);
            break;
        }
    }
    return base;
}

function fixedBrowserCss(){ 
	//
	var  nowUrlName=window.location.pathname; 
	if(nowUrlName.indexOf("login.jsp")>=0||nowUrlName.indexOf("desktop.jsp")>=0){
		return;
	}  
    var _themesBaseUrl = getBaseUrl() + '/themes/common/';
    if($.browser.msie){
        var ver = $.browser.version;
        var ie_css_style = '';
        if(ver <= 6.0){
            ie_css_style = 'style_ie6.css';
        }else if(ver <= 7.0){
            ie_css_style = 'style_ie7.css';
        }else if(ver <= 8.0){
            ie_css_style = 'style_ie8.css';
        }else if(ver <= 9.0){
            ie_css_style = 'style_ie9.css';
        }else {
            ie_css_style = 'style_ie10.css';
        }
        loadCss(_themesBaseUrl + ie_css_style, null);
    }else if($.browser.safari){
        loadCss(_themesBaseUrl + 'style_safari.css', null);
    }else if($.browser.opera){
        loadCss(_themesBaseUrl + 'style_opera.css', null);
    }else if($.browser.chrome){
        loadCss(_themesBaseUrl + 'style_chrome.css', null);
    }else{
        loadCss(_themesBaseUrl + 'style_other.css', null);
    }
}

$(document).ready(function(){
    fixedBrowserCss(); 
    if(isPad()){
        if(isSurface()){
		    $('input.whir_datebox').css('width', '90px');
        }else{
            $('input.whir_datebox').css('width', '76px');
        }
	}
});

function loadingLock(){
    var txt = "正在加载页面内容....";
    var $targetFixed = $("#targetFixed");

    //IE6位置
    if(whir_agent.indexOf("MSIE 6")>=0 ){ 
        $targetFixed.css("top", $(document).scrollTop() + 200).css("left", 600);
        $targetFixed.css("left", 600);
    }else{
        $targetFixed.css("top",  200).css("left", 600);
    }

    //创建半透明遮罩层
    if ($("#overLay").length==0) {
        $('<div id="overLay"></div>').prependTo($("body"));
        $("#overLay").css({
            width: "100%",
            backgroundColor: "#000",
            opacity: 0.2,
            position: "absolute",
            left: 0,
            top: 0,
            zIndex: 99
        }).height(document.documentElement.scrollHeight);
    }

    //显示操作提示，最关键核心代码
    $targetFixed.powerFloat({
        eventType:null,
        targetMode:"doing",	
        target:txt,
        position:"1-2"
    });
}




function jumpnew_(myLeftUrl, myMainUrl){ 

	removeDesktopBJ();
	//
	var leftTree = $("#desktop_leftTh"); 
	leftTree.show();  
    if(isNeedLeftIframe(myLeftUrl)){ 
    }else{
		try{ 
			//左侧load 菜单页面
			$("#leftMenuDiv").load(encodeURI(myLeftUrl),function(responseTxt,statusTxt,xhr){  
				//调整 desktop 左右区域的高度
				autoDesktopHeight();
			});
		}catch(e){
			alert('错误' + e.message + '发生在' +   e.lineNumber + '行 :'+e.name +'');  
			 
		} 
    }
    //右侧iframe 显示
    $("#mainFrame").attr("src", encodeURI(myMainUrl)); 
}
/**
桌面 点击顶部菜单 打开左右区域
myLeftUrl: 左侧菜单URL
myMainUrl:主iframeURL
*/
function jumpnew(myLeftUrl, myMainUrl) {
	
	//console.log(" jumpnew KAISH  "+myLeftUrl);

    //如果为0 则不是在主框架内
	var mainFrameLength= top.$("#mainFrame").length;
	if(mainFrameLength==0){
		return false;
	}
	//处理左右打开地址 是否要加根目录名
	if(myLeftUrl.indexOf("http")==0){

	}else if(myLeftUrl.indexOf(whirRootPath+"/")==0){
		myLeftUrl=myLeftUrl;
	}else{
		if(myLeftUrl.substring(0,1)=="/"){
			myLeftUrl=whirRootPath + myLeftUrl;
		}else{
			myLeftUrl=whirRootPath + "/" + myLeftUrl;
		}
	} 

	//
	if(myMainUrl.indexOf("http")==0){

	}else if(myMainUrl.indexOf(whirRootPath+"/")==0){
		myMainUrl=myMainUrl;
	}else{
		if(myMainUrl.substring(0,1)=="/"){
			myMainUrl=whirRootPath +myMainUrl;
		}else{
			myMainUrl=whirRootPath + "/" +myMainUrl;  
		}
	} 
  

	var leftTree = $("#desktop_leftTh"); 
	//iframe里的页面
	if(leftTree.length==0){
		/* leftTree=top.$("#desktop_leftTh"); 
		 leftTree.show();  
		 //左侧load 菜单页面
	     top.$("#leftMenuDiv").load(myLeftUrl,function(responseTxt,statusTxt,xhr){  
              //调整 desktop 左右区域的高度
		      top_autoDesktopHeight();
         }); 
	     //右侧iframe 显示
	     top.$("#mainFrame").attr("src",myMainUrl); */

		 parent.jumpnew_(myLeftUrl,myMainUrl);
	}else{ 
	   /*leftTree.show();  
	   if(isNeedLeftIframe(myLeftUrl)){ 
	   }else{
		   //左侧load 菜单页面
		   $("#leftMenuDiv").load(myLeftUrl,function(responseTxt,statusTxt,xhr){  
			   //调整 desktop 左右区域的高度
			   autoDesktopHeight();
		   }); 
	   }
	   //右侧iframe 显示
	   $("#mainFrame").attr("src",myMainUrl); */
	   jumpnew_(myLeftUrl,myMainUrl);
	} 
};


function isNeedLeftIframe(url){    
	if(url.indexOf('&leftNeedIframe=1')>=0||url.indexOf("http:")==0||url.indexOf("/platform/system/transcenter/loginCheck.jsp")>=0||url.indexOf("jump.jsp")>=0){ 
		//url="http://localhost:7001/defaultroot/login.jsp?menuName=发发发";
		$("#leftMenuDiv").html("");  
		var menuName=getParaValueWith(url,"menuName"); 
		var iframeInfo='<div class="wh-l-msg">'+
					   '	<a href="#" class="clearfix">'+
					   '		<i class="fa fa-cog fa-color"></i>'+
					   '		<span>'+
					   ''+menuName+
					   ''+
					   '		</span>'+
					   '	</a>'+
					   ' </div>'+
					   '<div class="wh-l-con wh-l-noscroll">'+
					   '   <iframe src="" allowtransparency="transparent" scrolling="auto" class="wh-portal" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0" id="leftIframe" name="leftIframe"></iframe>'+
					 '</div>';
 

		$("#leftMenuDiv").append(iframeInfo);  
		$('iframe#leftIframe').attr('src',  encodeURI(url));    
		$('iframe#leftIframe').load(function()   
		{   
			 autoDesktopHeight();
		});  
		return  true;
	}else{
        return false;
	} 
}






/**
左侧菜单树 点击打开右侧iframe区域 原来的函数名保持不变
*/
function menuJump(url){
	//如果为0 则不是在主框架内
	var mainFrameLength= top.$("#mainFrame").length;
	if(mainFrameLength==0){
		return false;
	}

	var leftTree = $("#desktop_leftTh"); 
	//iframe里的页面
	if(leftTree.length==0){
		top.$("#mainFrame").attr("src",encodeURI(url)); 
	}else{
	    $("#mainFrame").attr("src",encodeURI(url)); 
	}
};


/**
左侧菜单树 点击弹出新的窗口  原来的函数名保持不变
*/
function menuJumpNew(url) {
     window.open(encodeURI(url));
};


function whir_initMenu(){

}

/***
设置桌面左右区域的高度
*/
function  autoDesktopHeight(){ 
	setTimeout(whir_initMenu, 90);
	//whir_initMenu();
	//alert($('iframe#leftIframe').length);
	setTimeout(destopResizeFunction, 200);
};

function destopResizeFunction(){
	var winHeight = $(window).height();   
	$(".wh-con-table td").css({'height':winHeight - 74});
	if($(".wh-l-con").length>0){
	     $(".wh-l-con").css({'height':winHeight - 118});  
	}else{
	
	}   
}

/***
设置桌面左右区域的高度
*/
function  top_autoDesktopHeight(){ 
	//117  
    var winHeight = top.$(window).height();    
	var  divHeight=parent.$(".wh-wrapper").height(); 
	top.$(".wh-con-table td").css({'height':divHeight - 74});
	if(top.$(".wh-l-con").length>0){
		//console.log("top_autoDesktopHeight22222222222:"+(winHeight - 130));
		 top.$(".wh-l-con").css({'height':divHeight - 118});  
		 console.log("top_autoDesktopHeight end :"+top.$(".wh-l-con").height());  
	} 
 
};


function getParaValueWith(sURL,paraName){ 
	var  paravalue="";
    if(sURL.indexOf("?") > 0){
        var arrayParams = sURL.split("?");
        var arrayURLParams = arrayParams[1].split("&");  
        for (var i = 0, len=arrayURLParams.length; i < len; i++){
            var sParam = arrayURLParams[i].split("=");
            if ((sParam[0] != "") && (sParam[1] != "")){  
				if(sParam[0]==paraName){
					paravalue=sParam[1]
				}
            }else if (sParam[0] != "" && sParam[1] == ""){ 
				if(sParam[0]==paraName){
					paravalue=""
				}
            }
        }

		if(paravalue==""){
			paravalue=getParaValueWith2(sURL,paraName);
		}
    }else{
        paravalue=""; 
    } 
	return paravalue;
};

/**
*/
function getParaValueWith2(sURL,paraName){
	var  paravalue="";
    if(sURL.indexOf("?") > 0){
        var arrayParams = sURL.split("?");
        var arrayURLParams = arrayParams[1].split("%26");  
        for (var i = 0, len=arrayURLParams.length; i < len; i++){
            var sParam = arrayURLParams[i].split("=");
            if ((sParam[0] != "") && (sParam[1] != "")){  
				if(sParam[0]==paraName){
					paravalue=sParam[1]
				}
            }else if (sParam[0] != "" && sParam[1] == ""){ 
				if(sParam[0]==paraName){
					paravalue=""
				}
            }
        }
    }else{
        paravalue=""; 
    } 
	return paravalue;
};


/**
点击首页 知道  知识文库 
桌面 加灰色背景
*/
function  addDesktopBJ(){
	$("html,body").addClass("wh-gray-bg");
};

/**
桌面 去掉灰色背景
*/
function  removeDesktopBJ(){
	$("html,body").removeClass("wh-gray-bg");
};
