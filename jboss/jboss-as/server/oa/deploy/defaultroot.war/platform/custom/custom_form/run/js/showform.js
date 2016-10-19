;
if(document.getElementById('wf_ua')){
    if(document.getElementsByName('wf_ua').length>1){
    }else{
        document.getElementById(document.getElementById('wf_ua').value).value=$('#user_Account').val();
    }
}

setNoWrap();
initRow();

function compute_filed_auto(){__compute_field__();}
function compute_filed_auto2(){
	var __s__ = event.srcElement.onpropertychange?event.srcElement.onpropertychange.toString():"";
	if(__s__.indexOf("compute_filed_auto()")==-1)return;
	__compute_field__();
}
//document.onkeyup=compute_filed_auto2;

//--start--
var click_cnt=0;
function compute_filed_auto3(){
    if(click_cnt>0){
        //return;
    }
    click_cnt++;

    try{
        __compute_field__()
    }catch(e){}
}
//document.onclick=compute_filed_auto3;
sumSubTableFieldFunc();
//--end--

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

function checkOnlyField(val, flag){
    val = findAutoCodeFields(val);
	if(val==""){
		return true;
	}
	var field=val.split(",");

	var pageId=$('#Page_Id').val();
	var infoId=$('#Info_Id').val();
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
                                    whir_alert(_descname + Workflow.repeatfield, function(){
                                        try{
                                            _fieldObjectsCompare[j1].focus();
                                        }catch(e){}
                                    });
                                    return false;
                                }
                            }

                            //xmlHttp.open("GET", encodeURI(whirRootPath + "/platform/custom/custom_form/run/checkform/check_onlyfield.jsp?pageId="+pageId+"&infoId="+infoId+"&field="+fieldName+"&fieldValue="+fieldValue+"&fieldId="+_fieldId+"&isSubTableField=1"), false);
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
                        var fieldValue = document.getElementById(fieldName).value;

                        //xmlHttp.open("GET", encodeURI(whirRootPath + "/platform/custom/custom_form/run/checkform/check_onlyfield.jsp?pageId="+pageId+"&infoId="+infoId+"&field="+fieldName+"&fieldValue="+fieldValue+"&fieldId="+_fieldId), false);
                        xmlHttp.open("GET", encodeURI(whirRootPath+"/platform/custom/ezform/run/check_onlyfield.jsp?pageId="+pageId+"&infoId="+infoId+"&field="+fieldName+"&fieldValue="+fieldValue+"&fieldId="+_fieldId), false);
                        xmlHttp.send();

                        if(xmlHttp.readyState==4) {
                            if(xmlHttp.status==200) {
                                var responsedata = xmlHttp.responseText;
                                if(responsedata.indexOf('more')!=-1){
                                     whir_alert(_descname + Workflow.repeatfield, null);

                                     if(_showtype_&&_showtype_=='111'){//自动编号
                                         var _autoflag_ = false;
                                         var _autoselect_ = document.getElementById(fieldName+"_autoselect");
                                         if(_autoselect_){
                                            _autoselect_.onchange();
                                            _autoflag_ = true;
                                         }else{
                                             var _fOBJ = document.getElementById(fieldName);
                                             $.ajax({
                                                type: 'POST',
                                                url: whirRootPath + '/platform/custom/custom_form/run/checkform/getNextAutoCode.jsp?time='+(new Date().getTime()),
                                                cache: false,
                                                async: false,
                                                data: "fieldId="+$(_fOBJ).attr('fieldId')+"&fieldName="+fieldName+"&tableId="+$(_fOBJ).attr('tableId')+"&orgName="+encodeURIComponent($('#sys_orgSimpleName').val()),
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
                                         if(_autoflag_){
                                             whir_alert('编号已变更。', null);
                                         }
                                     }

                                     try{
                                         document.getElementById(fieldName).focus();
                                     }catch(e){}
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
        canSubmit = checkOnlyField($('#page_only_field').val(), flag);
        if (!canSubmit) {
            return false;
        }
    }

    return true;
}

var fieldName;
function getAutoCode(obj, field) {
    fieldName = field;

    $.ajax({
        type: 'POST',
        url: whirRootPath + "/platform/custom/custom_form/run/checkform/getAutoCode.jsp?time="+(new Date().getTime()),
        cache: false,
        async: false,
        data: "pageId="+$('#Page_Id').val()+"&field=" + field + "&head=" + encodeURIComponent(obj.value),
        dataType: 'html',
        success: function(response) {
            var _newVal = $.trim(response);
            document.getElementById(fieldName).value = _newVal;
        }
    });
}

function getAutoCode2(obj, field, type, fmt) {
    fieldName = field;
    var _tableId=$(obj).attr('tableId');
	var _fieldName=$(obj).attr('fieldName');
	var _fieldId=$(obj).attr('fieldId');
	var _orgName=$(obj).attr('orgName');
    var _urlParams = "&_tableId=" + _tableId + "&_fieldName=" + _fieldName + "&_fieldId=" + _fieldId + "&_orgName=" + encodeURIComponent(_orgName);

    $.ajax({
        type: 'POST',
        url: whirRootPath + "/platform/custom/custom_form/run/checkform/getAutoCode2.jsp?time="+(new Date().getTime()),
        cache: false,
        async: false,
        data: "pageId="+$('#Page_Id').val()+"&field=" + field + "&head=" + encodeURIComponent(obj.value) + "&type=" + encodeURIComponent(type) + "&fmt=" + encodeURIComponent(fmt) + _urlParams,
        dataType: 'html',
        success: function(response) {
            var _newVal = $.trim(response);
            document.getElementById(fieldName).value = _newVal;
        }
    });
}

function updateAutoCode() {
    if (xmlHttp.readyState < 4) {}
    if (xmlHttp.readyState == 4) {
        var response = $.trim(xmlHttp.responseText);alert(response);
        document.getElementById(fieldName).value = response;
    }
}

function beforeSubmit() {
	setComputeForeignField();
	compute_filed_auto();
    setHtmlValue();

    var canSubmit = true;    

    var mustWriteObj = document.getElementsByName("mustWrite");
    for(var i=0; i<mustWriteObj.length; i++){
        $must = mustWriteObj[i];
        var mustVal = $must.value;
        var obj = document.getElementsByName(mustVal);
        var objType = "";
        if (obj.type) {
            objType = obj.type.toUpperCase();
        } else {
            if (obj.length) {
                for (var k = 0; k < obj.length; k++) {
                    //i++;
                    objType = obj[k].type.toUpperCase();
                    var objTemp = obj[k];
                    if (objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA" || objType == "SELECT-ONE") {
                        if (textIsEmpty(objTemp)) {
                            /*whir_alert(Workflow.fillrequired, function(){
                                if (objTemp.style && objTemp.style.display && objTemp.style.display == 'none');
                                else
                                    objTemp.focus();
                                canSubmit = false;
                            });*/
                            if (objTemp.style && objTemp.style.display && objTemp.style.display == 'none'){
                                whir_alert(Workflow.fillrequired, null);
                            }else{
                                try{changePanle(0);}catch(e){}
                                whir_poshytip($(objTemp), Workflow.fillrequired);
                                objTemp.focus();
                            }
                            canSubmit = false;
                            break;
                        }
                    } else if (objType == "TEXT/X-SCRIPTLET") {
                        if (textIsEmpty(objTemp)) {
                            try{changePanle(0);}catch(e){}
                            /*whir_alert(Workflow.fillrequired, function(){
                                objTemp.focus();
                                canSubmit = false;
                            });*/
                            whir_poshytip($(objTemp), Workflow.fillrequired);
                            objTemp.focus();
                            canSubmit = false;
                            break;
                        }
                    } else if (objType == "HIDDEN") {
                        if (textIsEmpty(objTemp)) {
                            whir_alert(Workflow.fillrequired, null);
                            //obj.focus();
                            canSubmit = false;
                            break;
                        }
                    } else if (objType == "CHECKBOX" || objType == "RADIO") {
                        if (!checkboxIsChecked(obj)) {
                            try{changePanle(0);}catch(e){}
                            //whir_alert(Workflow.fillrequired, null);
                            //obj.focus();
                            //whir_poshytip($(obj[0]), Workflow.fillrequired);
                            canSubmit = false;
                            whir_alert(Workflow.fillrequired, null);
                            break;
                        }
                    } else if (objType == "HTML") {
                        if (eval(objTemp.id + ".getHTML()") == "") {
                            whir_alert(Workflow.fillrequired, null);
                            canSubmit = false;
                        }
                    }
                }
                if (!canSubmit) {
                    break;
                }
                //continue;
            } else {
                objType = "HTML";
            }
        }

        if (objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA" || objType == "SELECT-ONE") {
            if (textIsEmpty(obj)) {
                /*whir_alert(Workflow.fillrequired, function(){
                    if (obj.style && obj.style.display && obj.style.display == 'none');
                    else
                        obj.focus();
                    canSubmit = false;
                });*/
                if (obj.style && obj.style.display && obj.style.display == 'none'){
                    whir_alert(Workflow.fillrequired, null);
                }else{
                    try{changePanle(0);}catch(e){}
                    whir_poshytip($(objTemp), Workflow.fillrequired);
                    obj.focus();
                }
                canSubmit = false;
                break;
            }
        } else if (objType == "TEXT/X-SCRIPTLET") {
            if (textIsEmpty(obj)) {
                try{changePanle(0);}catch(e){}
                /*whir_alert(Workflow.fillrequired, function(){
                    obj.focus();
                    canSubmit = false;
                });*/
                whir_poshytip($(objTemp), Workflow.fillrequired);
                obj.focus();
                canSubmit = false;
                break;
            }
        } else if (objType == "HIDDEN") {
            if (textIsEmpty(obj)) {
                whir_alert(Workflow.fillrequired, null);
                canSubmit = false;
                break;
            }
        } else if (objType == "CHECKBOX" || objType == "RADIO") {
            if (!checkboxIsChecked(obj)) {
                //whir_alert(Workflow.fillrequired, null);
                //whir_poshytip($(obj[0]), Workflow.fillrequired);
                canSubmit = false;
                whir_alert(Workflow.fillrequired, null);
                break;
            }
        } else if (objType == "HTML") {
            if (eval(obj.id + ".getHTML()") == "") {
                whir_alert(Workflow.fillrequired, null);
                canSubmit = false;
            }
        }

        obj = document.getElementById(mustVal+"_Id");//eval("document.all." + document.all.mustWrite[i].value + "_Id");
        if (obj) {
            if (obj.value == "") {
                whir_alert(Workflow.fillrequired, null);
                canSubmit = false;
                break;
            }
        }

        var fieldNameObj = document.getElementsByName("fieldName");
        for (var m = 0; m < fieldNameObj.length; m++) {
            if (fieldNameObj[m].value == mustVal + "_file") {
                if (document.getElementById(mustVal+"_fileName")){//!eval("document.all." + mustVal + "_fileName")) {
                    whir_alert(Workflow.fillrequired, null);
                    canSubmit = false;
                    break;
                }
            }
        }
        if (!canSubmit) {
            break;
        }
    }

    if (!canSubmit) {
        return false;
    }

    //提醒项判断
    if (document.getElementById("remindField") != undefined && document.getElementById("remindField").value != undefined) {
        var remindField = document.getElementById("remindField").value;
        if (remindField != '') {
            var _tmp = remindField.split('SS');
            for (var i = 0; i < _tmp.length; i++) {
                var _name = '';
                if (i == 0) {
                    _name = _tmp[i].substring(1, _tmp[i].length);
                } else {
                    _name = _tmp[i].substring(0, _tmp[i].length - 1);
                }
                if (_tmp.length == 1) {
                    _name = _name.substring(0, _name.length - 1);
                }

                if (document.getElementById(_name) != undefined && document.getElementById(_name).value != undefined) {
                    if (document.getElementById(_name).value.indexOf('#') != -1) {
                        var _div = document.getElementsByTagName('DIV');
                        for (var j = 0; j < _div.length; j++) {
                            if (_div[j].id != undefined) {
                                var _id = _div[j].id;
                                if (_id.indexOf('-' + _name) != -1) {
                                    var _name = _div[j].parentElement.previousSibling.innerText;
                                    if (_name != '' && (_name.substring(_name.length - 1, _name.length) == '：' || _name.substring(_name.length - 1, _name.length) == ':')) {
                                        _name = _name.substring(0, _name.length - 1);
                                    }
                                    //alert(_name);
                                    whir_alert(Workflow.remindedoptions + _name + Workflow.cannotcontainchar, null);
                                    canSubmit = false;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    if (!canSubmit) {
        return false;
    }

    //17.	属性关联
    if (checkAttributeRelation() == false) {
        canSubmit = false;
        return canSubmit;
    }

    //验证上传附件字数过多
    $("input[type=hidden][name$=_showtype][value=115]").each(function(n){
        var _name = $(this).attr('name');
        var _fieldName = _name.substring(0, _name.length-9);
        var _new_component_ = document.getElementsByName('new_component_'+_fieldName)[0].value;
        var _fileName = document.getElementById(_fieldName + _new_component_ + '_fileName').value;
        var _saveName = document.getElementById(_fieldName + _new_component_ + '_saveName').value;

        var _size = $(document.getElementsByName(_fieldName+'_type')[0]).attr('size');//var _size = document.getElementsByName(_fieldName+'_size')[0].value;
        if (_size == '8') {
            canSubmit = true;
            return true;
        }

        var _temp = (_fileName + _saveName).replace(/[^\x00-\xff]/g, "***");
        var _cnt = (_fileName + _saveName).split('\|').length + 5;
        if (_temp.length > (parseInt(_size, 10) - _cnt)) {
            canSubmit = false;
            whir_alert(Workflow.checkuploadtextlength1 + (parseInt(_size) / 3).toFixed(0) + Workflow.checkuploadtextlength2, function(){
                canSubmit = false;
                return canSubmit;
            });            
            return canSubmit;
        }
    });

    if (!canSubmit) {
        return false;
    }

    __compute_field__();

    sumSubTableFieldFunc();

    //假期情况判断
    if (checkShowform() == false) {
        canSubmit = false;
        return canSubmit;
    }

    if (canSubmit) {
        setHtmlValue();
    }

    //检查是否有唯一字段
    canSubmit = checkOnlyFields(true);
    if (!canSubmit) {
        return false;
    }

    //工作流程表单设置验证
    if (typeof _checkForm_FUNC == 'function') {
        if (_checkForm_FUNC() == false) {
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

<!--
//17.	属性关联
function checkAttributeRelation(){
    return true;
}

var __attributeFieldInitValue = [];
function setting__attributeFieldInitValue(attr){
    if(__attributeFieldInitValue.length==0)__attributeFieldInitValue.push(attr);
    for(var i=0, klen=__attributeFieldInitValue.length; i<klen; i++){
        var ele = __attributeFieldInitValue[i];//alert(ele[0]+"   --   "+ele[1]+"   --      "+ele[2]+"   --      "+ele[3]);
        if(ele[0]==attr[0]){
            return;
        }
    }
    __attributeFieldInitValue.push(attr);
}

function resetting__attributeFieldInitValue(obj, asscoFieldName){
    if(obj==null)return;
    if(__attributeFieldInitValue.length==0)return;
    for(var i=0, klen=__attributeFieldInitValue.length; i<klen; i++){
        var ele = __attributeFieldInitValue[i];
        if(ele[0]==asscoFieldName){
            obj.value = ele[1];
            if(ele[2]){
                obj.readOnly = ele[2];
                //if(obj.className)obj.className="flowInputNoBorder";
            }
            if(ele[3]){
                if(obj.style.width)obj.style.width=ele[3];
            }
            break;
        }
    }
}

function cleanMustFillField(obj, asscoFieldName){
    resetting__attributeFieldInitValue(obj, asscoFieldName);

    var mustWrite = document.getElementsByName("mustWrite");
    for(var j=0; j<mustWrite.length; j++){
        if(mustWrite[j].value == asscoFieldName){
            $(mustWrite[j]).parent().remove();//.nextSibling.removeNode(true);
            //$(mustWrite[j]).remove();//.removeNode(true);
        }
    }
}

function __eventAssoHander(obj, index, arr){
    var __arr = arr;
    if(obj.options){
        if(__arr && __arr.length>0){
            var __ff = ",";
            for(var i=0; i<__arr.length; i++){
                var selectFieldVal = __arr[i][0];
                var asscoFieldName = __arr[i][1]; 
                var asscoFieldAttr = __arr[i][2];
                var __attrField = document.getElementsByName(asscoFieldName);
                var __attrFieldRequired = $(document.getElementsByName(asscoFieldName+"_showtype")[0]).attr('mustfilled');
                if(obj.options[obj.selectedIndex].value == selectFieldVal){
                    if(__attrField.length > 0){
                        var alen = __attrField.length;
                        //var objType = __attrField.type.toUpperCase();
                        if(asscoFieldAttr=='0'){//必填
                            var mustWrite = document.getElementsByName("mustWrite");
                            var __flag = false;
                            for(var j=0; j<mustWrite.length; j++){
                                if(mustWrite[j].value==asscoFieldName){
                                    __flag = true;
                                    break;
                                }
                            }
                            if(__flag==false){
                                if(__attrField[alen-1].type){
                                    var objType = __attrField[__attrField.length-1].type.toUpperCase();
                                    if(objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA"){
                                        setting__attributeFieldInitValue([asscoFieldName, __attrField[alen-1].value, __attrField[alen-1].readOnly, __attrField[alen-1].style.width]);

                                        if(__attrField[alen-1].readOnly)__attrField[alen-1].readOnly=false;
                                        //if(__attrField[alen-1].className)__attrField[alen-1].className="flowInput";
                                        if(__attrField[alen-1].style.width)__attrField[alen-1].style.width="94%";      
                                    }
                                }
                                
                                __attrField[alen-1].parentNode.insertAdjacentHTML('beforeEnd', '<span class=mustFillSpan><input type=hidden name=mustWrite value='+asscoFieldName+'><label class=MustFillColor>*</label></span>');
                                __ff += asscoFieldName + ",";
                            }
                        }else{
                            cleanMustFillField(__attrField[alen-1], asscoFieldName);
                            if(__attrField[alen-1].type){
                                var objType = __attrField[alen-1].type.toUpperCase();
                                if(objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA"){
                                    setting__attributeFieldInitValue([asscoFieldName, __attrField[alen-1].value, __attrField[alen-1].readOnly, __attrField[alen-1].style.width]);

                                    if(__attrField[alen-1].readOnly)__attrField[alen-1].readOnly=false;
                                    //if(__attrField[alen-1].className)__attrField[alen-1].className="flowInput";
                                    if(__attrField[alen-1].style.width)__attrField[alen-1].style.width="98%";
                                }
                            }
                            __ff += asscoFieldName + ",";
                        }
                    }
                }
            }
            
            for(var i=0; i<__arr.length; i++){
                var asscoFieldName = __arr[i][1];
                var __attrFieldRequired = $(document.getElementsByName(asscoFieldName+"_showtype")[0]).attr('mustfilled');
                if(__ff.indexOf(','+asscoFieldName+',')==-1 && __attrFieldRequired=='0'){
                    var __attrField = document.getElementsByName(asscoFieldName);
                    cleanMustFillField(__attrField[__attrField.length-1], asscoFieldName);
                }
            }
        }
    } else {
        if(obj.checked){
            if(__arr && __arr.length>0){
                var __ff = ",";
                for(var i=0; i<__arr.length; i++){
                    var selectFieldVal = __arr[i][0];
                    var asscoFieldName = __arr[i][1]; 
                    var asscoFieldAttr = __arr[i][2];
                    var __attrField = document.getElementsByName(asscoFieldName);
                    var __attrFieldRequired = $(document.getElementsByName(asscoFieldName+"_showtype")[0]).attr('mustfilled');
                    if(obj.value == selectFieldVal){
                        if(__attrField.length>0){
                            var alen = __attrField.length;
                            //var objType = __attrField.type.toUpperCase();
                            if(asscoFieldAttr=='0'){//必填
                                var mustWrite = document.getElementsByName("mustWrite");
                                var __flag = false;
                                for(var j=0; j<mustWrite.length; j++){
                                    if(mustWrite[j].value==asscoFieldName){
                                        __flag = true;
                                        break;
                                    }
                                }
                                if(__flag==false){
                                    if(__attrField[alen-1].type){
                                        var objType = __attrField[alen-1].type.toUpperCase();
                                        if(objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA"){
                                            setting__attributeFieldInitValue([asscoFieldName, __attrField[alen-1].value, __attrField[alen-1].readOnly, __attrField[alen-1].style.width]);

                                            if(__attrField[alen-1].readOnly)__attrField[alen-1].readOnly=false;
                                            //if(__attrField[alen-1].className)__attrField[alen-1].className="flowInput";
                                            if(__attrField[alen-1].style.width)__attrField[alen-1].style.width="94%";      
                                        }
                                    }
                                    
                                    __attrField[alen-1].parentNode.insertAdjacentHTML('beforeEnd', '<span class=mustFillSpan><input type=hidden name=mustWrite value='+asscoFieldName+'><label class=MustFillColor>*</label></span>');
                                    __ff += asscoFieldName + ",";
                                }
                            }else{
                                cleanMustFillField(__attrField[alen-1], asscoFieldName);
                                if(__attrField[alen-1].type){
                                    var objType = __attrField[alen-1].type.toUpperCase();
                                    if(objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA"){
                                        setting__attributeFieldInitValue([asscoFieldName, __attrField[alen-1].value, __attrField[alen-1].readOnly, __attrField[alen-1].style.width]);

                                        if(__attrField[alen-1].readOnly)__attrField[alen-1].readOnly=false;
                                        //if(__attrField[alen-1].className)__attrField[alen-1].className="flowInput";
                                        if(__attrField[alen-1].style.width)__attrField[alen-1].style.width="98%";       
                                    }
                                }
                                __ff += asscoFieldName + ",";
                            }
                        }
                    }
                }//alert(__ff);
                
                for(var i=0; i<__arr.length; i++){
                    var asscoFieldName = __arr[i][1];
                    var __attrFieldRequired = $(document.getElementsByName(asscoFieldName+"_showtype")[0]).attr('mustfilled');
                    if(__ff.indexOf(','+asscoFieldName+',')==-1 && __attrFieldRequired=='0'){
                        var __attrField = document.getElementsByName(asscoFieldName);
                        cleanMustFillField(__attrField[__attrField.length-1], asscoFieldName);
                    }
                }
            }
        }else{
            for(var i=0; i<__arr.length; i++){
                var asscoFieldName = __arr[i][1];
                var __attrField = document.getElementsByName(asscoFieldName);
                cleanMustFillField(__attrField[__attrField.length-1], asscoFieldName);
            }
        }
    }
}


function checkAttrField(objType, __attrField){
    var objType = __attrField.type.toUpperCase();
    if(objType == "TEXT" || objType == "PASSWORD" || objType == "TEXTAREA" || objType == "SELECT-ONE"){
        if(textIsEmpty(__attrField)){
            return false;
        }
    }else if(objType == "TEXT/X-SCRIPTLET"){
        if(textIsEmpty(__attrField)){
            return false;
        }
    }else if(objType == "HIDDEN"){
        if(textIsEmpty(__attrField)){
            return false;
        }
    }else if(objType == "CHECKBOX" || objType == "RADIO"){
        if(!checkboxIsChecked(__attrField)){
            return false;
        }
    }else if(objType == "HTML"){
        if(eval(__attrField.id + ".getHTML()")==""){
            return false;
        }
    }
    return true;
}