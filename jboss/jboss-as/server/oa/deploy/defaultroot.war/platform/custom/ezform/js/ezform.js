//提交时调用方法
var __checkFuns__ = [];

//取得字符串长度
function resizeWin(w, h) {
    window.resizeTo(w, h);
    var t = 0;
    var l = 0;
    l = (screen.width - w) / 2;
    t = (screen.height - h) / 2;
    window.moveTo(l, t);
}

function getObjectById(id){
    var ret = document.getElementById(id);
	if (ret == undefined || ret == null) {
		ret = document.getElementsByName(id);
		if (ret.length > 0){
            ret = ret[0];
            return ret;
		}else{
            ret = null;
        }
	}
	return ret;
}

function getWinEvent() {
    if(window.ActiveXObject){
        return window.event;
    }
    var func = getWinEvent.caller;
    while(func != null){
        var arg0 = func.arguments[0];
        if(arg0){
            if((arg0.constructor == Event || arg0.constructor == MouseEvent)
                || (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)){
                return arg0;
            }
        }
        func = func.caller;
    }
    return null;
}

//---------------------------------------------
var EZFORM = new Object();
var G_RND  = 7001;
var PREFIX_NEW_COMPONENT = "new_component_";
//表单控件下标唯一标志
EZFORM.getRandomNum = function(){
    return "_rnd_"+ (G_RND++);
}

/*获取当前用户ID*/
EZFORM.currentUserId = function(){
    return getObjectById("sys_userId").value;
}

/*获取当前组织ID*/
EZFORM.currentOrgId = function(){
    return getObjectById("sys_orgId").value;
}

/*获取当前组织简称*/
EZFORM.currentOrgSimpleName = function(){
    return getObjectById("sys_orgSimpleName").value;
}

/*获取当前表单ID*/
EZFORM.formId = function(){
    return getObjectById("formId").value;
}

/*获取当前表单Code*/
EZFORM.formCode = function(){
    return getObjectById("formCode").value;
}


/*获取当前表单业务主表数据ID*/
EZFORM.infoId = function(){
    return getObjectById("infoId").value;
}

/*获取当前表单流程ID*/
EZFORM.processId = function(){
    return getObjectById("processId").value;
}

/*根据字段name获取对象*/
function getDocObjectByName(name/*对象名称*/, index/*下标，默认为0*/, suffix/*后缀：1)选择组织用户：'_Id', '_Name'; 2)附件：'_fileName', '_saveName'; 3)其它无后缀，为空''*/) {
    return getObjectByName(name, index, suffix);
}
//---------------------------------------------

//---------------------------------------------
/*表单加载onload事件*/
function _form_onload(){
}

/*表单保存前onsbumit事件*/
function _form_onsubmit(){
}

/*表单保存后oncomplete事件*/
function _form_oncomplete(){
}

/*表单数据校验事件*/
function _form_dataCheckVaild(){
}

//---------------------------------------------

//---------------------------------------------
var currentRow = null;
var tblTR = new Array();
var tblTRHTML = new Array();

//设置添加、删除行图标的位置
function setAbsolute(obj) {
    var div = document.getElementById("adddelrow_div");
    if(div == undefined) return;
    if(obj == null) {
        div.style.visibility = "hidden";
        return;
    }

    if(document.readyState!="complete"){
        return;
    }

    var positon = $(obj).position();
    var rowHeight = $(obj).height();
    var rowId = $(obj).attr('id');

    var showTables = document.getElementsByName("showTable");
    var hideTables = document.getElementsByName("hideTable");
    for(var i=0; i<hideTables.length; i++){
        if(rowId.indexOf(hideTables[i].value+'TR')!=-1){
            div.style.visibility = "hidden";
            return;
        }
    }

    try {
        var trId = obj.id;
        var tableName = trId.substring(0, trId.length-2);
        var oPoint = obj;
        currentRow = obj;
        var _top = oPoint.offsetTop;
        var _left = oPoint.offsetLeft;
        var div = document.getElementById("adddelrow_div");
        var div_width = div.offsetWidth;

        var showFlag = true;
        var showTables = document.getElementsByName("showTable");
        var hideTables = document.getElementsByName("hideTable");
        for(var i=0; i<hideTables.length; i++){
            if(hideTables[i].value==tableName){
                showFlag = false;
                break;
            }
        }

        if(showFlag){
            div.style.visibility = "visible";
        }else{
            div.style.visibility = "hidden";
        }

        var div_width = $(div).width();
        var div_height = $(div).height();

        var _scrollTop = 0;
        var _position = $('body').css('position');
        if(_position=='relative'){
            _scrollTop = $(document.body).scrollTop();//$('.docbox_noline').scrollTop();
        }

        if(positon.left <= 30){
			div.style.width="15px";
			div_width -= 3;
		}else{
			div.style.width="30px";
		}

        div.style.left= (positon.left - div_width - 5) + 'px';
        div.style.top = (positon.top + _scrollTop + (rowHeight-div_height)/2) + 'px';

    } catch(E) {}
}

//子表自动编号(全局)
var g_subAutoCodeArr = [];
//添加行
function addRow(){
    addRow(-1, true);
}

function addRow(ind, isInvoke) {
    var dd = new Date().getTime();
    //解决流程归档，重复出行
    var locHref = location.href + "";
    if (locHref.indexOf("/archivesfile/LC_") != -1) {
        return;
    }

    var form_p_wf_cur_ModifyField = "";
    try{
        form_p_wf_cur_ModifyField = document.getElementById("p_wf_cur_ModifyField").value;
    }catch(e){}

    //子表自动编号
    if(g_subAutoCodeArr.length == 0){
        $("input[autocode='111'][isSubTableField='true']").each(function(){
            g_subAutoCodeArr.push($(this).val());
        });
    }

    try {
        var tbl = currentRow.parentNode;
        row = currentRow;

        var TRID = currentRow.id;
        if (TRID) {
            var TRID_OBJ = $('#'+TRID.replace(/\$/igm,'\\$'))[0];//document.getElementsByName(TRID)[0];
            if (TRID_OBJ && TRID_OBJ.style.display == 'none') {
                TRID_OBJ.style.display = '';
                return;
            }
        }

        var ri = row.rowIndex;
		if(ind && ind != -1){
			ri = ind; 
		}

        var newTr = tbl.insertRow(ri + 1);

        //var newTr = tbl.insertRow(row.rowIndex + 1);
        newTr.id = currentRow.id;
        //var begin = getTRIndex(tbl.rows[1].id);
        var newTd = null;
        var _cnt = currentRow.rowIndex;
        var _index = _cnt-1;
        //alert(_cnt);
        for (var i = 0, k=row.cells.length; i < k; i++) {
            newTd = newTr.insertCell(-1);
            var cell = row.cells[i];
            var _html = cell.innerHTML;

            //alert(_html);
            var _field_name = "";
            var _new_name = "";
            var _new_id = "";
            var _showtype_ = "";
            var _autocode_ = "";
            var _htmlObj = $(_html);
            $(_htmlObj).find("input[type=hidden][name$=_showtype]").each(function(n){
                var thisVal = $(this).val();
                var thisName = $(this).attr("name");
                thisName = thisName.substring(0, thisName.length-9);
                _showtype_ = thisVal;

                _field_name = thisName;

                if(_showtype_=='103'||//单选
                    _showtype_=='104'||//多选
                    _showtype_=='115'||//附件上传
                    _showtype_=='116'||//Word编辑
                    _showtype_=='117'||//Excel编辑
                    _showtype_=='118'||//WPS编辑
                    _showtype_=='210'||//单选人
                    _showtype_=='211'||//多选人
                    _showtype_=='212'||//单选组织
                    _showtype_=='214'||//多选组织
                    _showtype_=='704'||//单选人（本组织）
                    _showtype_=='705'//多选人（本组织）
                ){
                    var _new_ran_ = EZFORM.getRandomNum();
                    var _old_ran_ = document.getElementsByName(PREFIX_NEW_COMPONENT+thisName)[_index].value;
                    while(_html.indexOf(_old_ran_)!=-1){
                        _html = _html.replace(_old_ran_, _new_ran_);
                    }

                    if(_showtype_=='115'){
                        _new_name = thisName + _new_ran_ + "_fileName";
                        _new_id = thisName + _new_ran_ + "_saveName";
                    }else if(_showtype_=='210'||
                        _showtype_=='211'||
                        _showtype_=='212'||
                        _showtype_=='214'||
                        _showtype_=='704'||
                        _showtype_=='705'){
                        _new_name = thisName + _new_ran_ + "_Name";
                        _new_id = thisName + _new_ran_ + "_Id";
                    }else{
                        _new_name = thisName + _new_ran_;
                    }
                }else if(_showtype_ == '203'){
                    document.getElementsByName(thisName)[n].value = '';
                }else if(_showtype_ == '111' && form_p_wf_cur_ModifyField.indexOf('$'+_field_name+'$')!=-1){//自动编号-可编辑
                    var _fieldObj = document.getElementsByName(_field_name);
                    var params = "";
                    for(var j=0; j<_fieldObj.length; j++){
                        params += "&autoCodeVal="+_fieldObj[j].value;
                    }
                    var tableId = $(_fieldObj[0]).attr('tableId');
                    var dataParams = "fieldId="+$(this).attr("fieldId")+"&fieldName="+_field_name+"&tableId="+tableId+params;
                    //alert(dataParams);
                    $.ajax({
                        type: 'POST',
                        url: whirRootPath+"/platform/custom/ezform/run/getSubAutoCode.jsp?time="+(new Date().getTime()),
                        cache: false,
                        async: false,
                        data: dataParams,
                        dataType: 'html',
                        success: function(response) {
                            _autocode_ = $.trim(response);
                        }
                    });
                }
            });
            //alert(_html);
            newTd.innerHTML = _html;

            if(_showtype_=='116'||
                _showtype_=='117'||
                _showtype_=='118'){
                $(newTd).find('span.docedit').html(comm.notext);
            }else if(_showtype_=='111'){
                var isAddCode = true;
                for(var j=0; j<g_subAutoCodeArr.length; j++){
                    if(g_subAutoCodeArr[j] == _autocode_){
                        isAddCode = false;
                        break;
                    }
                }
                //子表自动编号
                if(isAddCode)g_subAutoCodeArr.push(_autocode_);
                document.getElementsByName(_field_name)[ri].value = _autocode_;
            }

            if(_new_name!=''){
                if(_showtype_=='115'||
                    _showtype_=='116'||
                    _showtype_=='117'||
                    _showtype_=='118'||
                    _showtype_=='210'||
                    _showtype_=='211'||
                    _showtype_=='212'||
                    _showtype_=='214'||
                    _showtype_=='704'||
                    _showtype_=='705'){
                    document.getElementById(_new_name).value = '';

                    if(_new_id!=''){
                        if(_showtype_=='115'||
                            _showtype_=='210'||
                            _showtype_=='211'||
                            _showtype_=='212'||
                            _showtype_=='214'||
                            _showtype_=='704'||
                            _showtype_=='705'){
                            document.getElementById(_new_id).value = '';
                        }
                    }
                }
            }else{
            	document.getElementsByName(_field_name)[ri].value = '';//提到if外面用于在带有子表的表单中复制子表时下拉框的数据置空
                if(form_p_wf_cur_ModifyField.indexOf('$'+_field_name+'$')==-1){//不可编辑
                    document.getElementsByName(_field_name)[ri].value = '';
                    try{
                        document.getElementsByName(_field_name+"selecttext")[ri].value = '';//105
                    }catch(e){}
                }
            }

            //if (cell.colSpan)newTd.colSpan = cell.colSpan;
            //if (cell.rowSpan)newTd.rowSpan = cell.rowSpan;

            fnSetTdStyle(newTd, cell);

            //newTd.focus();
        }

        try{
            //更新页面自动编号
            updateSubAutoCodeArr(g_subAutoCodeArr);
        }catch(e){}

        currentRow.onmouseover = function() {}; //.detachEvent("onmouseover",new Function("setAbsolute(this)"));
        //-----------------------------------------------------------------------
        currentRow.onmouseover = new Function("setAbsolute(this)");
        //-----------------------------------------------------------------------
        newTr.onmouseover = new Function("setAbsolute(this)");
        currentRow = newTr;
        setAbsolute(currentRow);

        //-----------------------------------------------------------------------
        if(isInvoke==undefined || isInvoke == true){
            batchInvoke();
        }
        //-----------------------------------------------------------------------
    } catch(ex) {
        //alert(ex.message);
    }
    //var dd2 = new Date().getTime();alert(dd2-dd);
}

function batchInvoke(){
    invokeRowEvents();
    processAutoIncrement();
}

//删除行
function delRow() {
    var tbl = currentRow.parentNode;
    //-----------------------------------------------------------------------
    var tbl_rows = tbl.rows.length;
    //-----------------------------------------------------------------------
    row = currentRow;

    if (tbl_rows > 2) {
        var __s = tbl.rows[tbl_rows - 1].innerHTML;
        if (tbl_rows == 3 && (__s.indexOf('TOTALTD ') != -1 || __s.indexOf('TOTALTD"') != -1) && __s.indexOf('合计') != -1) {
            return;
        }
    }

    if (tbl_rows > 2){// && !confirm(Workflow.delConfirmMsg)) {
        //子表自动编号
        //var subAutoCodeArr = getSubAutoCodeArr();
        whir_confirm(Workflow.delConfirmMsg, function(){
            if (tbl_rows > 2) {
                currentRow = tbl.rows[row.rowIndex-1];//.previousSibling;
                if(/*row.previousSibling.rowIndex*/(row.rowIndex-1) == 0){
					currentRow = tbl.rows[row.rowIndex+1];//row.nextSibling;
                }
                //-----------------------------------------------------------------------
                var _rowIndex = currentRow.rowIndex; //modify
                //-----------------------------------------------------------------------
                tbl.deleteRow(row.rowIndex);

                try {
                    if (_rowIndex > 1) {
                        currentRow.onmouseover = new Function("setAbsolute(this)");
                        setAbsolute(currentRow);
                    } else {
                        //currentRow = row.nextSibling;
                        currentRow.onmouseover = new Function("setAbsolute(this)");
                        setAbsolute(currentRow);
                    }
                } catch(e) { 
                    //alert(e.message);
                }

                try{
                    //更新页面自动编号
                    updateSubAutoCodeArr(g_subAutoCodeArr);
                }catch(e){}
            }

            //-----------------------------------------------------------------------
            batchInvoke();
            //-----------------------------------------------------------------------
        }, null, null );
        return;
    }
}

//新增行事件触发
function invokeRowEvents(){
    //注：脚本执行顺序
    setComputeForeignField();
    sumSubTableFieldFunc();//0
    compute_filed_auto();//1
    setTotalValue();//2
}

//子表自动编号
function getSubAutoCodeArr(){
    var autoCodeArr = [];
    $("input[autocode='111'][isSubTableField='true']").each(function(){
        autoCodeArr.push($(this).val());
    });
    return autoCodeArr;
}

//更新子表自动编号
function updateSubAutoCodeArr(autoCodeArr){
    if(autoCodeArr.length > 0){
        $("input[autocode='111'][isSubTableField='true']").each(function(i){
            $(this).val(autoCodeArr[i]);
        });
    }
}

//添加子表统计行
function addTotalRow(id, html, flag) {
    if (document.getElementsByName(id + 'TOTALTD').length > 0) return;
    try {
        var tbl = document.getElementById(id+"TR").parentNode;//document.getElementsByName(id + "TR")[0].parentNode;
        row = tbl.rows[tbl.rows.length - 1];
        var newTr = tbl.insertRow(row.rowIndex + 1);
        var newTd = null;
        var arrI = 0;
        newTd = newTr.insertCell(-1);
        newTd.colSpan = 1;
        for (var i = 0; i < row.cells.length; i++) {
            if (row.cells[i].colSpan) newTd.colSpan += row.cells[i].colSpan;
            else newTd.colSpan += 1;
        }
        newTd.colSpan -= 1;
        //alert(newTd.colSpan);
        newTd.innerHTML = "<strong>合计&nbsp;&nbsp;&nbsp;</strong>";
        fnSetTdStyleClone(newTd, row.cells[0]);
        newTd.align = "right";
        newTd.style.textAlign = "right";
        newTd.id = id + 'TOTALTD';

        //tbl.attachEvent('onclick', new Function('setTotalValue()'));
        $(tbl).bind('blur', function(){
            setTotalValue();
        });
    } catch(ex) {
        whir_alert(ex + ex.description + "-" + id, null);
    }

    if(flag){
        document.getElementById(id + "TOTALTD").innerHTML += html;
        setTotalValue();
    }
}

//--------------------------------------------------------------------------
//检测自动编号
function findAutoCodeFields(page_only_field){
    var _AutoCodeFields_ = $("input[name$='_showtype'][value='111']");//自动编号
    var ret = page_only_field;
    for(var i=0; i<_AutoCodeFields_.length; i++){
        var val = _AutoCodeFields_[i].name;
        val = val.substring(0, val.length-9);
        if(ret.indexOf(val)==-1){
            ret += "," + val;
        }
    }
    ret = ret.replace(/,,/gm,',');
    return ret;
}

//flag-是否聚焦
function checkOnlyField_(val, flag){
    val = findAutoCodeFields(val);
	if(val==""){
		return true;
	}

	var field=val.split(",");
	var pageId=EZFORM.formId();
	var infoId=EZFORM.infoId();
    var _p_wf_openType = $('#p_wf_openType').val();
    if(_p_wf_openType == 'startAgain'){//再次发送
        infoId = '';
    }

	for(var i=0; i<field.length; i++){
		var fieldName=field[i];
        if(fieldName!=''){
            var _fieldObjects = document.getElementsByName(fieldName);
            if(_fieldObjects.length > 0){
                var thisObj = document.getElementsByName(fieldName+"_showtype")[0];
                var _showtype_ = thisObj.value;
                var _descname = $(thisObj).attr('descname');
                var _fieldId = $(thisObj).attr('fieldId');
                for(var j=0; j<_fieldObjects.length; j++){
                    var _isSubTableField = $(_fieldObjects[j]).attr('isSubTableField');
                    var fieldValue = _fieldObjects[j].value;
                    if(_isSubTableField == 'true'){
                        if(fieldValue != ''){
                            var _fieldObjectsCompare = document.getElementsByName(fieldName);
                            for(var j1=0; j1<_fieldObjectsCompare.length; j1++){
                                var fieldValueCompare = _fieldObjectsCompare[j1].value;
                                if(j != j1 && fieldValue == fieldValueCompare){
                                    if(flag){
                                        whir_alert(_descname + Workflow.repeatfield, function(){
                                            try{
                                                _fieldObjectsCompare[j1].focus();
                                            }catch(e){}
                                        });
                                        return false;
                                    }
                                }
                            }

                            xmlHttp.open("GET", encodeURI(whirRootPath+"/platform/custom/ezform/run/check_onlyfield.jsp?pageId="+pageId+"&infoId="+infoId+"&field="+fieldName+"&fieldValue="+fieldValue+"&fieldId="+_fieldId+"&isSubTableField=1"), false);
                            xmlHttp.send();
                            if(xmlHttp.readyState==4) {
                                if(xmlHttp.status==200) {
                                    var responsedata = xmlHttp.responseText;
                                    if(responsedata.indexOf('more')!=-1){
                                        whir_alert(_descname + Workflow.repeatfield, null);
                                        return false;
                                    }
                                }
                            }
                        }

                    }else{
                        xmlHttp.open("GET", encodeURI(whirRootPath+"/platform/custom/ezform/run/check_onlyfield.jsp?pageId="+pageId+"&infoId="+infoId+"&field="+fieldName+"&fieldValue="+fieldValue+"&fieldId="+_fieldId), false);
                        xmlHttp.send();

                        if(xmlHttp.readyState==4) {
                            if(xmlHttp.status==200) {
                                var responsedata = xmlHttp.responseText;
                                if(responsedata.indexOf('more')!=-1){
                                    if(flag){
                                        whir_alert(_descname + Workflow.repeatfield, null);
                                    }

                                    if(_showtype_&&_showtype_=='111'){//自动编号
                                        var _autoflag_ = false;
                                        var _autoselect_ = document.getElementById(fieldName+"_autoselect");
                                        if(_autoselect_){
                                            _autoselect_.onchange();
                                            _autoflag_ = true;
                                        }else{
                                            var _fOBJ = _fieldObjects[j];
                                            $.ajax({
                                                type: 'POST',
                                                url: whirRootPath + '/platform/custom/ezform/run/getNextAutoCode.jsp?time='+(new Date().getTime()),
                                                cache: false,
                                                async: false,
                                                data: "fieldId="+$(_fOBJ).attr('fieldId')+"&fieldName="+fieldName+"&tableId="+$(_fOBJ).attr('tableId')+"&orgName="+encodeURIComponent(EZFORM.currentOrgSimpleName()),
                                                dataType: 'html',
                                                success: function(response) {
                                                    var _newVal = $.trim(response);
                                                    if(_newVal!=''){
                                                        _fOBJ.value = _newVal;
                                                        _autoflag_ = true;
                                                    }
                                                }
                                            });
                                         }
                                         if(flag){
                                             if(_autoflag_){
                                                 whir_alert('编号已变更。', null);
                                             }
                                         }
                                     }
                                     if(flag){
                                         try{
                                             _fieldObjects[j].focus();
                                         }catch(e){}
                                     }
                                     return false;
                                }
                            }
                        }
                    }
                }
            }
		}
	}
	return true;
}

//检查是否有唯一字段
function checkOnlyFields(flag){
    var canSubmit = true;
    if (document.getElementById("page_only_field")) {
        canSubmit = checkOnlyField_($('#page_only_field').val(), flag);
        if (!canSubmit) {
            return false;
        }
    }
    return true;
}

//--------------------------------------------------
function getAutoCode2(obj, field, type, fmt){
	fieldName = field;
	var _tableId=$(obj).attr('tableId');
	var _fieldName=$(obj).attr('fieldName');
	var _fieldId=$(obj).attr('fieldId');
	var _orgName=$(obj).attr('orgName');
	var _urlParams = "&_tableId="+_tableId+"&_fieldName="+_fieldName+"&_fieldId="+_fieldId+"&_orgName="+encodeURIComponent(_orgName);

    $.ajax({
        type: 'POST',
        url: whirRootPath+"/platform/custom/ezform/run/getAutoCode2.jsp?time="+(new Date().getTime()),
        cache: false,
        async: false,
        data: "pageId="+EZFORM.formId()+"&field="+field+"&head="+encodeURIComponent(obj.value)+"&type="+encodeURIComponent(type)+"&fmt="+encodeURIComponent(fmt)+_urlParams,
        dataType: 'html',
        success: function(response) {
            var _newVal = $.trim(response);
            document.getElementById(fieldName).value = _newVal;
        }
    });
}

//更新自动编号
function updateAutoCode(){
	if (xmlHttp.readyState < 4) {
	}
	if (xmlHttp.readyState == 4) {
		var response = xmlHttp.responseText;
        document.getElementById(fieldName).value = $.trim(response);
	}
}
//--------------------------------------------------

//提交验证
function beforeSubmit(){
	setComputeForeignField();
	compute_filed_auto();
    var canSubmit = checkMustWrite();

    if(canSubmit){
        if(typeof __checkFuns__ !== 'undefined'){//--start
            if(__checkFuns__.length){
                for(var i=0; i<__checkFuns__.length; i++){
                    try{
                        var _func = eval(__checkFuns__[i]);
                        if(typeof _func == 'function'){
                            if(_func()==false){
                                canSubmit = false;
                                return canSubmit;
                            }
                        }
                    }catch(e){}
                }
            }
        }//--end
    }

    return canSubmit;
}

//校验必填项
function checkMustWrite(){
    var canSubmit = true;

    //工作流程表单设置验证
    if(typeof _checkForm_before_FUNC == 'function'){
        if(_checkForm_before_FUNC()==false){
            canSubmit = false;
            return canSubmit;
        }
    }

    //-----------------------------
    //赋值html字段
    setHtmlValue();
    //-----------------------------

    var mustWriteFields = document.getElementsByName("mustWrite");
    for(var i=0, mlen=mustWriteFields.length; i<mlen; i++){
        var obj = document.getElementsByName(mustWriteFields[i].value);
        if(obj){
            var objType = "";
            if (obj.length) {
                for (var k = 0, len=obj.length; k < len; k++) {
                    objType = obj[k].type.toUpperCase();
                    var objTemp = obj[k];
                    if (objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA" || objType == "SELECT-ONE") {
                        if (textIsEmpty(objTemp)) {
                            canSubmit = false;
                            if (objTemp.style && 
                                objTemp.style.display && 
                                objTemp.style.display == 'none'){
                                whir_alert(Workflow.fillrequired, null);
                            }else {
                                try{changePanle(0);}catch(e){}
                                try{changePanle(0);}catch(e){}
                                whir_poshytip($(objTemp), Workflow.fillrequired);
                                objTemp.focus();
                            }
                            break;
                        }
                    } else if (objType == "TEXT/X-SCRIPTLET") {
                        if (textIsEmpty(objTemp)) {
                            canSubmit = false;
                            try{changePanle(0);}catch(e){}
                            whir_poshytip($(objTemp), Workflow.fillrequired);
                            objTemp.focus();
                            break;
                        }
                    } else if (objType == "HIDDEN") {
                        var _showtype = $(obj[k]).attr('showtype');
                        if(_showtype != '103' && _showtype != '104' && _showtype != '105'){
                            if (textIsEmpty(objTemp)) {
                                canSubmit = false;                            
                                whir_alert(Workflow.fillrequired, null);
                                //objTemp.focus();                            
                                break;
                            }
                        }
                    } else if (objType == "CHECKBOX" || objType == "RADIO") {
                        if (!checkboxIsChecked(obj)) {
                            try{changePanle(0);}catch(e){}
                            //whir_poshytip($(obj[0]), Workflow.fillrequired);
                            //objTemp.focus();
                            canSubmit = false;
                            whir_alert(Workflow.fillrequired, null);
                            break;
                        }
                    } else if (objType == "HTML") {
                        if (eval(objTemp.id + ".getHTML()") == "") {
                            canSubmit = false;
                            whir_alert(Workflow.fillrequired, function(){
                                canSubmit = false;
                            });
                        }
                    }
                    if (!canSubmit) {
                        canSubmit = false;
                        return canSubmit;
                    }
                }
            }else{
                var showType = document.getElementsByName(mustWriteFields[i].value + "_type");
                for (var k = 0, len=showType.length; k < len; k++) {
                    if (showType[k].value == 'relation_object'){//相关对象
                        var divlen = $('#relationObjectDIV > div').length;
                        if (divlen == 0) {
                            canSubmit = false;
                            whir_alert(Workflow.fillrequired, function(){
                                canSubmit = false;
                            });
                        }
                    }
                }
                if (!canSubmit) {
                    canSubmit = false;
                    return canSubmit;
                }
            }
        }
        if (!canSubmit) {
            canSubmit = false;
            return canSubmit;
        }
    }

    $("input[type=text][maxlength],textarea[maxlength]").each(function(){
        var _display = $(this).css('display');
        if(_display != 'none'){
            var _maxlength = $(this).attr('maxlength');
            var _val = $(this).val();
            if(_maxlength=='18')_val=_val.replace(/,/igm,'');
            if(_val.length > _maxlength){
                canSubmit = false;
                try{changePanle(0);}catch(e){}
                whir_poshytip($(this), "输入不能超过最大长度"+_maxlength+"！");
                $(this).focus();
                return false;
            }
        }
    });

    $("input[type=hidden][name$=_showtype][value=115]").each(function(n){
        var _name = $(this).attr('name');
        var _fieldName = _name.substring(0, _name.length-9);
        var _new_component_ = document.getElementsByName('new_component_'+_fieldName)[0].value;
        var _fileName = document.getElementById(_fieldName + _new_component_ + '_fileName').value;
        var _saveName = document.getElementById(_fieldName + _new_component_ + '_saveName').value;

        var _size = $(document.getElementsByName(_fieldName+'_type')[0]).attr('size');//document.getElementsByName(_fieldName+'_size')[0].value;

        if (_size == '8') {
            canSubmit = true;
            return true;
        }

        var _temp = (_fileName + _saveName).replace(/[^\x00-\xff]/g, "***");
        var _cnt = (_fileName + _saveName).split('\|').length + 5;
        if (_temp.length > (parseInt(_size, 10) - _cnt)) {
            canSubmit = false;
            whir_alert(Workflow.checkuploadtextlength1 + (parseInt(_size) / 3).toFixed(0) + Workflow.checkuploadtextlength2, null);            
            return false;
        }
    });

    if(!canSubmit){
        canSubmit = false;
        return canSubmit;
    }

    //检查是否有唯一字段
    canSubmit = checkOnlyFields(true);
    if (!canSubmit) {
        return false;
    }

    //工作流程表单设置验证
    if(typeof _checkForm_after_FUNC == 'function'){
        if(_checkForm_after_FUNC()==false){
            canSubmit = false;
            return canSubmit;
        }
    }

    //假期情况判断
    if(typeof checkShowform == 'function'){
        if (checkShowform() == false) {
            canSubmit = false;
            return canSubmit;
        }
    }

    //会议申请-设置验证
    if(typeof _check_boardroomapply == 'function'){
        if(_check_boardroomapply()==false){
            canSubmit = false;
            return canSubmit;
        }
    }

    //预算管理
    if (typeof beforeSubmitBudgetEvent == 'function') {
        try {
            canSubmit = beforeSubmitBudgetEvent();
        } catch (e) {}
    }

    if (!canSubmit) {
        return false;
    }

    //项目管理预算
    if (typeof beforeSubmitProjectEvent == 'function') {
        try {
            canSubmit = beforeSubmitProjectEvent();
        } catch (e) {}
    }

    if (!canSubmit) {
        return false;
    }

    return canSubmit;
}

function checkFileNameLength(){
    var canSubmit = true;
    $("input[type=hidden][name$=_showtype][value=115]").each(function(n){
        var _name = $(this).attr('name');
        var _fieldName = _name.substring(0, _name.length-9);
        var _new_component_ = document.getElementsByName('new_component_'+_fieldName)[n].value;
        var _fileName = document.getElementById(_fieldName + _new_component_ + '_fileName').value;
        var _saveName = document.getElementById(_fieldName + _new_component_ + '_saveName').value;

        var _size = $(document.getElementsByName(_fieldName+'_type')[0]).attr('size');//document.getElementsByName(_fieldName+'_size')[0].value;

        if (_size == '8') {
            canSubmit = true;
            return true;
        }

        var _temp = (_fileName + _saveName).replace(/[^\x00-\xff]/g, "***");
        var _cnt = (_fileName + _saveName).split('\|').length + 5;
        if (_temp.length > (parseInt(_size, 10) - _cnt)) {
            canSubmit = false;
            whir_alert(Workflow.checkuploadtextlength1 + (parseInt(_size) / 3).toFixed(0) + Workflow.checkuploadtextlength2, null);            
            return false;
        }
    });

    return canSubmit;
}

//-----------------------------------------------------------------------
//子表数据导入脚本
//-----------------------------------------------------------------------
function initSubtableImport(){
    var subTable = $("input[name=showTable]");//showTable
    for(var i=0; i<subTable.length; i++){
        var val = subTable[i].value;
        var div_ = document.getElementById(val+"DIV");
        if(div_){
            var tr_ = document.getElementById(val+"TR");
            var _parent = tr_.offsetParent;
            var tr_w = tr_.offsetWidth;
            var tr_l = 0;
            while (_parent) {
                tr_l += _parent.offsetLeft;
                _parent = _parent.offsetParent;
            }
            tr_l = tr_l + tr_w - 130;//margin-left:"+tr_l+"
            //div_.insertAdjacentHTML("beforeBegin", "<div id="+val+"_subtable align=right style='width:140px;border:0px solid black;margin-bottom:3px;'><a style='cursor:pointer' onclick='javascript:downloadSubtableTemplate(\""+val+"\", \"\")' target='_blank'>下载导入模版</a>&nbsp;<input type='button' onclick='impSubData(\""+val+"\", \"\")' title='导入文件的数据列必须与子表数据列一一对应' class='btnButton4font' value='导&nbsp;&nbsp;&nbsp;入'/></div>");
            $("#"+replaceDollar(val)+"DIV").prepend("<div id="+val+"_subtable align=right style='width:192px;border:0px solid black;margin-bottom:3px;'><a style='cursor:pointer' onclick='javascript:downloadSubtableTemplate(\""+val+"\", \"\")' target='_blank'>下载导入模版</a>&nbsp;<input type='button' onclick='impSubData(\""+val+"\", \"\")' title='导入文件的数据列必须与子表数据列一一对应' class='btnButton4font' value='导&nbsp;&nbsp;&nbsp;入' style='vertical-align:middle'/></div>");
        }
    }
}

function downloadSubtableTemplate(subTable, formCode){
    if(formCode=='')formCode = EZFORM.formCode();

    var fields = "";
    var row = $('#'+subTable.replace(/\$/igm,'\\$')+'TR')[0];//document.getElementsByName(subTable+'TR')[0];
    for (var i = 0; i < row.cells.length; i++) {
        var cell = row.cells[i];
        var _html = cell.innerHTML;
        var _htmlObj = $(_html);
        $(_htmlObj).find("input[type=hidden][name$=_showtype]").each(function(n){
            var thisVal = $(this).val();
            var thisName = $(this).attr("name");
            thisName = thisName.substring(0, thisName.length-9);
            //_showtype_ = thisVal;
            fields += thisName + ",";

            //alert(thisName);
        });
    }
    //alert(fields);

    if(fields!=''){
        location.href=whirRootPath + "/platform/custom/ezform/run/imp/subtableTemplate_download.jsp?formCode="+formCode+"&subTable="+subTable+"&fields="+fields;
    }else{
        whir_alert("表单未绑定子表字段，请检查。", null);
    }
}

function impSubData(subTable, formCode){
    if(formCode=='')formCode = EZFORM.formCode();

    var fields = "";
    var fieldShow = "";
    var fieldType = "";
    var row = $('#'+subTable.replace(/\$/igm,'\\$')+'TR')[0];//document.getElementsByName(subTable+'TR')[0];
    for (var i = 0; i < row.cells.length; i++) {
        var cell = row.cells[i];
        var _html = cell.innerHTML;
        var _htmlObj = $(_html);
        $(_htmlObj).find("input[type=hidden][name$=_showtype]").each(function(n){
            var thisVal = $(this).val();
            var thisName = $(this).attr("name");
            thisName = thisName.substring(0, thisName.length-9);
            //_showtype_ = thisVal;
            fields += thisName + ",";
            fieldShow += thisVal + ",";
            fieldType += document.getElementsByName(thisName+"_type")[0].value + ",";

            //alert(thisName);
        });
    }
    //alert(fields);
    //alert(fieldType);

    //window.open(encodeURI(whirRootPath + "/platform/custom/ezform/run/imp/importSubData.jsp?formCode="+formCode+"&subTable="+subTable+"&fields="+fields+"&fieldShow="+fieldShow),'导入','menubar=0,scrollbars=0,locations=0,width=550,height=250,resizable=no');
    openWin({url:whirRootPath + "/platform/custom/ezform/run/imp/importSubData.jsp?formCode="+formCode+"&subTable="+subTable+"&fields="+fields+"&fieldShow="+fieldShow+"&fieldType="+fieldType,width:600,height:230,winName:'pop',isFull:false});
}

//初始化加载
function initFormFunc(){
    processAutoIncrement();

    if(isPad()==false && isSurface()==false){
        initSubtableImport();
    }

    $('.scrollBox').bind('scroll', function(){
        setAbsolute(currentRow);
    });

    try{
        $('.doc_Scroll').scroll(function(){setAbsolute(currentRow);});
    }catch(e){}

    //处理word导入表单模板不居中问题
    processWordStyle();

    printRelationObj();
}