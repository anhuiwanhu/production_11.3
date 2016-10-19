;
//************************************************************
// Custom_form's AND Ezform's common JS METHOD !!!
// 修改时注意兼容性。
//************************************************************
String.prototype.lenB  = function(){return this.length;}
String.prototype.lenB2 = function(){return this.replace(/[^\x00-\xff]/g,"**").length;}
String.prototype.lenB3 = function(){return this.replace(/[^\x00-\xff]/g,"***").length;}

function MM_openBrWindow(theURL,winName,features){ //v2.0
    window.open(encodeURI(theURL),winName,features);
}

var xmlHttp = false;
try {
    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
} catch (e) {
    try {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e2) {
        xmlHttp = false;
    }
}
if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
    xmlHttp = new XMLHttpRequest();
}

var _isChecked = false; //必须放在函数外
function change(obj, type, unsigned) {
}
function change0(obj, type, unsigned) {
    //if(isNaN(obj.value))return;
    /* 
	 *obj:要检查的文本框对象,一般调用的时候请填this检查本身, 
	 *type:要输入的数据类型,整数请输入integer,小暑请输入double 
	 *unsigned:限制数据是非负数请填true,允许输入负数请填false 
	 *例: 
	 *<input style="ime-mode:disabled" onpropertychange=change(this,"integer",true)> 
	 *为限制只允许输入非负整数 
	 *其中的style="ime-mode:disabled"必须添加,因为部分输入法会与脚本冲突使IE崩溃,而且数字文本框也没有输入中文的必要 
	*/
    if (type.toUpperCase() != new String("integer").toUpperCase()) type = "double";
    else type = "integer";

    if (unsigned) unsigned = true;
    else unsigned = false;

    /*var val = obj.value;

    if(val != ''){
        val = val.replace(/,/igm, '');
    }*/

    if (!_isChecked) {
        _isChecked = true;
        var str = new String(obj.value);
        var num = new Number(obj.value);
        var ok = true;
        if (unsigned) ok = str.match("-") == null;
        if (type == "integer" && ok) ok = str.match("\\.") == null;
        /*  \.是正则表达式中代替小数点的方法，但是因为match函数中要求输入一个字符串参数，所以要用\\来代替\，所以最终用\\.来代替小数点  */
        if (num.toString() == "NaN" && str != "-") ok = false;
        if (obj.value.match("\\-0\\d|\\b^\\.?0\\d")) ok = false; //避免输入01,-0000.01之类的数字 
        if (!ok) obj.value = obj.backupValue == undefined ? "": obj.backupValue;
        else {
            matchStr = obj.value.match("\\-?\\b[0-9]*\\.?[0-9]*\\b\\.?|\\-"); //用正则表达式清空前后空格 
            if (matchStr != obj.value) {
                obj.value = matchStr == null ? "": matchStr;
                _isChecked = true;
            }
            obj.backupValue = obj.value;
        }
    } else {
        _isChecked = false; //避免无限递归 
        return;
    }
}

function changeExt(obj,type,unsigned) {
	//if(isNaN(obj.value))return;
	/* 
	 *obj:要检查的文本框对象,一般调用的时候请填this检查本身, 
	 *type:要输入的数据类型,整数请输入integer,小暑请输入double 
	 *unsigned:限制数据是非负数请填true,允许输入负数请填false 
	 *例: 
	 *<input style="ime-mode:disabled" onpropertychange=change(this,"integer",true)> 
	 *为限制只允许输入非负整数 
	 *其中的style="ime-mode:disabled"必须添加,因为部分输入法会与脚本冲突使IE崩溃,而且数字文本框也没有输入中文的必要 
	*/ 
	if(type.toUpperCase()!=new String("integer").toUpperCase()) 
		type="double"; 
	else 
		type="integer"; 

	if(unsigned) 
		unsigned=true; 
	else 
		unsigned=false; 

	if(!_isChecked) { 
		_isChecked=true; 
		var str=new String(obj.value); 
		var num=new Number(obj.value); 
		var ok=true; 
		if(unsigned) 
			ok=str.match("-")==null; 
		if(type=="integer"&&ok) 
			ok=str.match("\\.")==null; 
		/*  \.是正则表达式中代替小数点的方法，但是因为match函数中要求输入一个字符串参数，所以要用\\来代替\，所以最终用\\.来代替小数点  */ 
		if(num.toString()=="NaN"&&str!="-") 
			ok=false; 
		if(obj.value.match("\\-0\\d|\\b^\\.?0\\d")) 
			ok=false;//避免输入01,-0000.01之类的数字 
		if(!ok) 
			obj.value=obj.backupValue==undefined?"":obj.backupValue; 
		else {
			matchStr=obj.value.match("\\-?\\b[0-9]*\\.?[0-9]*\\b\\.?|\\-");//用正则表达式清空前后空格 
			if(matchStr!=obj.value) { 
				obj.value=matchStr==null?"":matchStr; 
				_isChecked=true; 
			} 
			obj.backupValue=obj.value; 
		} 
	} else { 
		_isChecked=false;//避免无限递归 
		return; 
	} 
}

function checkNum(obj) {
    var attrOptions = $(obj).attr('attr-options');
    var isNumber;
    if(attrOptions && attrOptions != ''){
        attrOptions = eval("("+attrOptions+")");
        isNumber = attrOptions.type;
    }

    var val = obj.value;
    if(val!='' && isNumber == 'number'){
        val = val.replace(/,/igm,'');
    }
    
    if (val!=''){
        if(val.substring(0,1) == '-'){
            val = val.substring(1);
        }
        if(isNaN(val)) {
            whir_alert(Workflow.inputnum, function(){
                obj.value='';
                obj.focus();
            });
        }
    }

    try{
        var _size = $(document.getElementsByName($(obj).attr('name')+'_type')[0]).attr('size');//document.getElementsByName($(obj).attr('name')+'_size')[0].value;
        if (_size == '9') {
            if(val.indexOf('.')!=-1){
                whir_alert('请输入整数！', function(){
                    obj.focus();
                    obj.select();
                });
            }
        }
    }catch(e){}
}

function checkTextareaMaxlength(oInObj) { 
	var iMaxLen = parseInt(oInObj.getAttribute('maxlength'));
	if(iMaxLen==''||iMaxLen=='null'||iMaxLen=='0')return true;
	var iCurLen = oInObj.value.length;

	if(oInObj.getAttribute && iCurLen > iMaxLen) {
		oInObj.value = oInObj.value.substring(0, iMaxLen);
	}
}

function checkInputMaxlength(oInObj){
    var iMaxLen = parseInt(oInObj.getAttribute('maxlength'));
	if(iMaxLen == 'NaN' || iMaxLen == '' || iMaxLen == 'null' || iMaxLen == '0')return 0;
    var iCurLen = oInObj.value.length;

	if(oInObj.getAttribute && iCurLen > 10) {
        return iMaxLen;
    }
    return 0;
}

function textIsEmpty(objText) {
    if (objText.length == undefined || objText.options != undefined) {
        var value = objText.value;
        if (value.length == 0) {
            return true;
        } else {
            var j = 0;
            for (var i = 0; i < value.length; i++) {
                if (value.substring(i, i + 1) == ' ') {
                    j++;
                } else {
                    break;
                }
            }
            if (j == value.length) {
                return true;
            } else {
                return false;
            }
        }
    } else {
        for (var kk = 0; kk < objText.length; kk++) {
            var value = objText[kk].value;
            if (value.length == 0) {
                return true;
            } else {
                var j = 0;
                for (var i = 0; i < value.length; i++) {
                    if (value.substring(i, i + 1) == ' ') {
                        j++;
                    } else {
                        break;
                    }
                }
                if (j == value.length) {
                    return true;
                } else {
                    return false;
                }
            }
        }
    }
}

//判断单选框(objCheckbox)是否被选中
//如果有被选中的则返回true，如果没有被选中的则返回false
function checkboxIsChecked(objCheckbox) {
    if (objCheckbox) {
        if (objCheckbox.length) {
            var j = 0;
            for (var i = 0; i < objCheckbox.length; i++) {
                if (objCheckbox[i].disabled || objCheckbox[i].checked) {
                    j++;
                    break;
                }
            }
            if (j == 0) {
                return false;
            } else {
                return true;
            }
        } else {
            if (objCheckbox.disabled || objCheckbox.checked) {
                return true;
            } else {
                return false;
            }
        }
    } else {
        return false;
    }
}

//复制样式
function fnSetTdStyle(newTd, oriTd) {
    /*newTd.style.verticalAlign = oriTd.style.verticalAlign;
    newTd.style.textAlign = oriTd.style.textAlign;
    newTd.style.height = oriTd.style.height;
    newTd.style.width = oriTd.style.width;

    newTd.style.backgroundColor = oriTd.style.backgroundColor;

    if (oriTd.style.borderTop != "") newTd.style.borderTop = oriTd.style.borderTop;
    if (oriTd.style.borderLeft != "") newTd.style.borderLeft = oriTd.style.borderLeft;
    if (oriTd.style.borderRight != "") newTd.style.borderRight = oriTd.style.borderRight;
    if (oriTd.style.borderBottom != "") newTd.style.borderBottom = oriTd.style.borderBottom;

    newTd.noWrap = oriTd.noWrap;
    newTd.width = oriTd.width;
    newTd.height = oriTd.height;
    newTd.align = oriTd.align;
    newTd.vAlign = oriTd.vAlign;
    newTd.className = oriTd.className;
    newTd.bgColor = oriTd.bgColor;
    newTd.background = oriTd.background;
    newTd.borderColor = oriTd.borderColor;
    newTd.borderColorLight = oriTd.borderColorLight;
    newTd.borderColorDark = oriTd.borderColorDark;*/

    var _oriTd = $(oriTd);
    var _newTd = $(newTd);
    for(var a in oriTd){
        var v = _oriTd.attr(a);
        if(v){
            _newTd.attr(a, v);
        }
    }
}

function fnSetTdStyleClone(newTd, oriTd) {
    newTd.style.verticalAlign = oriTd.style.verticalAlign;
    newTd.style.textAlign = oriTd.style.textAlign;
    newTd.style.height = oriTd.style.height;
    newTd.style.width = oriTd.style.width;

    newTd.style.backgroundColor = oriTd.style.backgroundColor;

    if (oriTd.style.borderTop != "") newTd.style.borderTop = oriTd.style.borderTop;
    if (oriTd.style.borderLeft != "") newTd.style.borderLeft = oriTd.style.borderLeft;
    if (oriTd.style.borderRight != "") newTd.style.borderRight = oriTd.style.borderRight;
    if (oriTd.style.borderBottom != "") newTd.style.borderBottom = oriTd.style.borderBottom;

    newTd.noWrap = oriTd.noWrap;
    newTd.width = oriTd.width;
    newTd.height = oriTd.height;
    newTd.align = oriTd.align;
    newTd.vAlign = oriTd.vAlign;
    newTd.className = oriTd.className;
    newTd.bgColor = oriTd.bgColor;
    newTd.background = oriTd.background;
    newTd.borderColor = oriTd.borderColor;
    newTd.borderColorLight = oriTd.borderColorLight;
    newTd.borderColorDark = oriTd.borderColorDark;
}

//设置页面元素的样式
function setStyle(obj, evt) {
    var event = window.event ? window.event : evt;

    try {
        if (obj.readonly) return;
    } catch (e) {}

    //增加只读的不改变变宽颜色
    if (obj) {
        if (obj.className && obj.className == "mustwrite") return;
        if (event.type.toUpperCase() == "MOUSEOVER" && obj.className) {
            $(obj).removeClass('flowInput').addClass('flowInputenter');
        } else if (obj.className && event.type.toUpperCase() == "MOUSEOUT") {
            $(obj).removeClass('flowInputenter').addClass('flowInput');
        }

        var attrOptions = $(obj).attr('attr-options');
        if(attrOptions){
            attrOptions = eval("("+attrOptions+")");
            var isNumber = attrOptions.type;
            if(isNumber == 'number'){
                checkNum(obj);
            }
        }
    }
}

//计算统计字段的值
function setTotalValue() {
    var tlFld = document.getElementsByName('totalField');
    for (var i = 0; i < tlFld.length; i++) {
        var tlFld_obj = tlFld[i];
        if (tlFld_obj && tlFld_obj.value != "") {
            var flds = tlFld_obj.value.split(",");
            for (var j = 0, jlen=flds.length; j < jlen; j++) {
                //alert(flds[j]);
                if (flds[j].length < 1) continue;
                try {
                    var fldArr = document.getElementsByName(flds[j]);
                    var decnum = fldArr[0].getAttribute("decnum");
                    var total = 0;
                    var dotIndex = 0;
                    for (var k = 0, klen=fldArr.length; k < klen; k++) {
                        var val = fldArr[k].value;
                        val = val.replace(/,/gm, '');
                        if (!isNaN(val)) {
                            //val = val.replace(/,/gm, '');
                            var pos = val.indexOf(".");
                            if (pos > 0) {
                                if ((val.length - pos - 1) > dotIndex) dotIndex = val.length - pos - 1;
                            }
                            total += eval(val * 1);
                        }
                    }
                    if(dotIndex == 1) dotIndex = 2;
                    if(decnum){
                        if(parseInt(decnum, 10) > 0){
                            dotIndex = parseInt(decnum, 10);
                        }
                    }
                    if(dotIndex > 0) total = FormatNumber(total.toString(), dotIndex);
                    document.getElementById(flds[j] + "totallabel").innerHTML = '<strong><font color=red>' + formatComma(total) + '&nbsp;&nbsp;&nbsp;</font></strong>';
                } catch (ex) {}
            }
        }
    }
}

//格式化数字
function FormatNumber(srcStr, nAfterDot) {
    var srcStr, nAfterDot;
    var resultStr, nTen;
    srcStr = "" + srcStr + "";
    strLen = srcStr.length;
    dotPos = srcStr.indexOf(".", 0);
    if (dotPos == -1) {
        resultStr = srcStr + ".";
        for (i = 0; i < nAfterDot; i++) {
            resultStr = resultStr + "0";
        }
        return resultStr;
    } else {
        if ((strLen - dotPos - 1) >= nAfterDot) {
            nAfter = dotPos + nAfterDot + 1;
            nTen = 1;
            for (j = 0; j < nAfterDot; j++) {
                nTen = nTen * 10;
            }
            resultStr = Math.round(parseFloat(srcStr) * nTen) / nTen;
            return resultStr;
        } else {
            resultStr = srcStr;
            for (i = 0; i < (nAfterDot - strLen + dotPos + 1); i++) {
                resultStr = resultStr + "0";
            }
            return resultStr;
        }
    }
}

//格式化千分位
function formatComma(num) {
    if ((num + "").length == 0) {
        return "";
    }

    if (isNaN(num)) {
        return "";
    }

    num = num + "";
    if (/^.*\..*$/.test(num)) {
        var pointIndex = num.lastIndexOf(".");
        var intPart = num.substring(0, pointIndex);
        var pointPart = num.substring(pointIndex + 1, num.length);
        intPart = intPart + "";
        var re = /(-?\d+)(\d{3})/;
        while (re.test(intPart)) {
            intPart = intPart.replace(re, "$1,$2");
        }
        num = intPart + "." + pointPart;
    } else {
        num = num + "";
        var re = /(-?\d+)(\d{3})/;
        while (re.test(num)) {
            num = num.replace(re, "$1,$2");
        }
    }
    return num;
}

//检查页面元素的长度
function checkSize(obj) {
    var index = 0;
    var _size = $(document.getElementsByName(obj.id+'_type')[0]).attr('size');//document.getElementsByName(obj.id+"_size");
    if (obj.value != "" && obj.id && _size && _size.length>0) {
        var maxSize = parseInt(_size, 10);//parseInt(_size[index].value);
        if (maxSize < 10) {
            maxSize = maxSize * 4;
        }
        if (maxSize == 18) {
            maxSize = maxSize * 2;
        }

        var _type = document.getElementsByName(obj.id+"_type");
		if(_type[index].value=='number'){
            if (obj.value.lenB() > maxSize - 3) {
                try {
                    //alert(Workflow.overLengthConfirmMsg);
                    whir_alert('字段长度超过最大长度限制，请修改。',function(){
                        obj.focus();
                    });
                    obj.focus();
                } catch(e) {}
            }
        } else {
            if (obj.value.lenB3() > maxSize -1){// * 0.33) {
                try {
                    //alert(Workflow.overLengthConfirmMsg);
                    whir_alert('字段长度超过最大长度限制，请修改。', function(){
                        obj.focus();
                    });
                    obj.focus();
                } catch(e) {}
            }
        }
    }
}

function setHtmlValue(){
    try{
        $("input[type=hidden][name='hasHtml']").each(function(){
            $html = $(this);
            var htmlEditName = $html.val();
            if($.browser.msie){
                document.getElementById(htmlEditName).value=eval(htmlEditName+"_html").getHTML();
            }else{
                if($.browser.mozilla){
                    document.getElementById(htmlEditName).value=eval(htmlEditName+"_html").contentWindow.getHTML();
                }else{
                    document.getElementById(htmlEditName).value=eval(htmlEditName+"_html").getHTML();
                }
            }
        });
    }catch(e){}
}

//设置表单html编辑器内容到对应的隐藏字段
function setFormHtmlEditorValue(){
    setHtmlValue();
}

function accountBig(fb, fs) {
    var ind = 0;
    try {
        if (currentRow && currentRow.rowIndex) ind = currentRow.rowIndex - 1;
    } catch (e) {}

    var fs_obj = document.getElementsByName(fs);
    var fsv = (ind >= 0 && fs_obj && fs_obj[ind]) ? fs_obj[ind].value : (fs_obj && fs_obj[0]?fs_obj[0].value:""); //eval("document.all."+fs+".value");

	fsv = fsv.replace(/,/igm, '');
    if (fsv.length > 12) {
        whir_alert('超出转换最大范围！', null); //alert(Workflow.overMaxlengthMsg);
        try {
            ;//fs_obj[ind].focus();
        } catch (e) {}
        return false;
    }

    fsv = convertCurrency(fsv);
    if (fsv == '') {
        try {
            //fs_obj[ind].focus();
            ;
        } catch (e) {}
        return false;
    }

    var fb_obj = document.getElementsByName(fb);
    if (ind >= 0 && fb_obj && fb_obj[ind]) {
        fb_obj[ind].value = fsv;
    } else {
        fb_obj[0].value = fsv;
    }
}

function convertCurrency(currencyDigits) {
    // Constants:
    var MAXIMUM_NUMBER = 99999999999999.99;//999999999999.99;
    // Predefine the radix characters and currency symbols for output:
    var CN_ZERO = "零";
    var CN_ONE = "壹";
    var CN_TWO = "贰";
    var CN_THREE = "叁";
    var CN_FOUR = "肆";
    var CN_FIVE = "伍";
    var CN_SIX = "陆";
    var CN_SEVEN = "柒";
    var CN_EIGHT = "捌";
    var CN_NINE = "玖";
    var CN_TEN = "拾";
    var CN_HUNDRED = "佰";
    var CN_THOUSAND = "仟";
    var CN_TEN_THOUSAND = "万";
    var CN_HUNDRED_MILLION = "亿";
    //var CN_SYMBOL = "￥:";
    var CN_SYMBOL = "";
    var CN_DOLLAR = "元";
    var CN_TEN_CENT = "角";
    var CN_CENT = "分";
    var CN_INTEGER = "整";
    var CN_SING = "";
    if (currencyDigits.substring(0, 1) == '-') {
        CN_SING = "负";
        currencyDigits = currencyDigits.substring(1);
    }

    // Variables:
    var integral; // Represent integral part of digit number.
    var decimal; // Represent decimal part of digit number.
    var outputCharacters; // The output result.
    var parts;
    var digits, radices, bigRadices, decimals;
    var zeroCount;
    var i, p, d;
    var quotient, modulus;

    // Validate input string:
    currencyDigits = currencyDigits.toString();
    if (currencyDigits == "") {
        //alert("请输入要转换的数字!");
        return "";
    }
    if (currencyDigits.match(/[^-,.\d]/) != null) {
        whir_alert(Workflow.numberContainsInvalidCharacterMsg, null);
        return "";
    }
    if ((currencyDigits).match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
        //alert("错误的数字格式!");
        return "";
    }

    // Normalize the format of input digits:
    currencyDigits = currencyDigits.replace(/,/g, ""); // Remove comma delimiters.
    currencyDigits = currencyDigits.replace(/^0+/, ""); // Trim zeros at the beginning.
    // Assert the number is not greater than the maximum number.
    if (Number(currencyDigits) > MAXIMUM_NUMBER) {
        whir_alert(Workflow.overMaxlengthMsg, null);
        return "";
    }

    // Process the coversion from currency digits to characters:
    // Separate integral and decimal parts before processing coversion:
    parts = currencyDigits.split(".");
    if (parts.length > 1) {
        integral = parts[0];
        decimal = parts[1];
        // Cut down redundant decimal digits that are after the second.
        decimal = decimal.substr(0, 2);
        if(parseInt(decimal,10) == 0){
            decimal = "";
        }
    } else {
        integral = parts[0];
        decimal = "";
    }
    // Prepare the characters corresponding to the digits:
    digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE, CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
    radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
    bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION, CN_TEN_THOUSAND);
    decimals = new Array(CN_TEN_CENT, CN_CENT);
    // Start processing:
    outputCharacters = "";
    // Process integral part if it is larger than 0:
    if (Number(integral) > 0) {
        zeroCount = 0;
        for (i = 0; i < integral.length; i++) {
            p = integral.length - i - 1;
            d = integral.substr(i, 1);
            quotient = p / 4;
            modulus = p % 4;
            if (d == "0") {
                zeroCount++;
            } else {
                if (zeroCount > 0) {
                    outputCharacters += digits[0];
                }
                zeroCount = 0;
                outputCharacters += digits[Number(d)] + radices[modulus];
            }
            if (modulus == 0 && zeroCount < 4) {
                outputCharacters += bigRadices[quotient];
            }
        }
        outputCharacters += CN_DOLLAR;
    }
    // Process decimal part if there is:
    if (decimal != "") {
        for (i = 0; i < decimal.length; i++) {
            d = decimal.substr(i, 1);
            if (d != "0") {
                outputCharacters += digits[Number(d)] + decimals[i];
            }
        }
    }
    // Confirm and return the final output string:
    if (outputCharacters == "") {
        outputCharacters = CN_ZERO + CN_DOLLAR;
    }
    if (decimal == "") {
        outputCharacters += CN_INTEGER;
    }
    outputCharacters = CN_SYMBOL + outputCharacters;
    outputCharacters = CN_SING + outputCharacters;
    return outputCharacters;
}

//计算子表中计算字段的值
function setComputeForeignField() {
    //var dd = new Date().getTime();
    //alert("begin");
    var computeForeignFieldObj = document.getElementsByName('computeForeignField');
    var computeForeignFieldValueObj = document.getElementsByName('computeForeignFieldValue');
    
    var _length = computeForeignFieldObj.length;//document.getElementsByName('computeForeignField').length;
    for (var i = 0; i < _length; i++) {
        //alert(document.getElementsByName(document.getElementsByName('computeForeignField')[i].value).length);

        var v_computeForeignField = computeForeignFieldObj[i].value;
        var v_computeForeignFieldValue = computeForeignFieldValueObj[i].value;

        var str = v_computeForeignFieldValue.replace(/\*/g, '|').replace(/\+/g, '|').replace(/\-/g, '|').replace(/\//g, '|').replace(/\(/g, '|').replace(/\)/g, '|');
        while (str.indexOf("||") >= 0) {
            str = str.replace("||", "|");
        }
        var fields = str.split("|");

        var v_computeForeignField_obj = document.getElementsByName(v_computeForeignField);
        for (var j = 0, _v_len=v_computeForeignField_obj.length; j < _v_len; j++) {
            //alert(j);
            try {
                //computeForeignField(document.getElementsByName('computeForeignFieldValue')[i], document.getElementsByName('computeForeignField')[i].value,j);

                var computeFieldValue = "";
                var computeForeignFieldValue = v_computeForeignFieldValue;

                var dian1 = 0;
                var dian2 = 0;
				var jj = fields.length;
                for (var k = 0, flen=fields.length; k < flen; k++) {
                    var fieldsEl = fields[k];
                    if (document.getElementsByName(fieldsEl).length>0) {
                        var val = document.getElementsByName(fieldsEl)[j].value;
                        var isPercent = $(document.getElementsByName(fieldsEl)[j]).attr("isPercent");
                        val = val.replace(/,/igm, '');
                        if (val!=''&&!isNaN(val)) {
                            if(isPercent == '1'){
                                val = (parseFloat(val) / 100) + "";
                            }
                            //val = val.replace(/,/igm, '');
                            if (val.indexOf(".") != -1) dian2 = val.substring(val.indexOf(".") + 1).length;
                            if (dian1 < dian2) dian1 = dian2;
                            computeForeignFieldValue = computeForeignFieldValue.replace(fieldsEl, "(" + val + ")"); //加括号，处理负数
                        } else {
                            var testInfinity = computeForeignFieldValue.replace(fieldsEl, '0');
                            var testField = null;
                            try{
                                testField = eval(testInfinity)
                            }catch(e){}
                            if('Infinity' == testField){
                                computeForeignFieldValue = computeForeignFieldValue.replace(fieldsEl, '1');
                            }else{
                                computeForeignFieldValue = computeForeignFieldValue.replace(fieldsEl, '0');
                            }
							jj--;
                        }
                    }
                }

				if(jj == 0){
					v_computeForeignField_obj[j].value = '';
                    try{
					    document.getElementsByName(v_computeForeignField + '_cmp')[j].value='';
                    }catch(e){}
					continue;
				}

                //alert(computeForeignFieldValue);

                if(dian1>3)dian1=2;

                var __isPercent = $(v_computeForeignField_obj[j]).attr("isPercent");
                if (__isPercent != undefined && __isPercent == '1') {
                    var _temp_ = eval(computeForeignFieldValue) + '';
                    if (_temp_.indexOf(".") != -1) {
                        if (dian1 == 0) {
                            dian1 = 2;
                        }
                    }
                    if(dian1 < 2)dian1=2;

                    var decnum = $(v_computeForeignField_obj[j]).attr("decnum");
                    if(decnum){
                        if(parseInt(decnum, 10) > 0){
                            dian1 = parseInt(decnum, 10);
                        }
                    }

                    computeFieldValue = eval(computeForeignFieldValue);//.toFixed(dian1);
                    computeFieldValue = parseFloat(computeFieldValue) * 100 + '';
					//computeFieldValue = eval(computeForeignFieldValue).toFixed(dian1);

                    if(computeFieldValue.indexOf(".") != -1){
                        var dd = computeFieldValue.substring(computeFieldValue.indexOf(".") + 1).length;
                        if(dd>3){
                            computeFieldValue = eval(computeFieldValue).toFixed(dian1);
                        }
                    }else{
                        computeFieldValue = eval(computeFieldValue).toFixed(dian1);
                    }
                } else {
                    var _temp_ = eval(computeForeignFieldValue) + '';
                    if (_temp_.indexOf(".") != -1) {
                        if (dian1 == 0) {
                            dian1 = 2;
                        }
                    }

                    var decnum = $(v_computeForeignField_obj[j]).attr("decnum");
                    if(decnum){
                        if(parseInt(decnum, 10) > 0){
                            dian1 = parseInt(decnum, 10);
                        }
                    }

                    computeFieldValue = eval(computeForeignFieldValue).toFixed(dian1);
                }

                v_computeForeignField_obj[j].value = isNaN(computeFieldValue)?"":computeFieldValue;
                try{
                    document.getElementsByName(v_computeForeignField + '_cmp')[j].value = isNaN(computeFieldValue)?"":computeFieldValue;
                }catch(e){}
            } catch(e) {}
        }
    }
    //var dd2 = new Date().getTime();alert(dd2-dd);
}

function getComputeValue(exp, isPercent){
	try{
		var str = exp;
		str = str.replace(/\*/g,'|').replace(/\+/g,'|').replace(/\-/g,'|').replace(/\//g,'|').replace(/\(/g,'|').replace(/\)/g,'|');
		while(str.indexOf("||")>=0){
			str = str.replace("||","|");
		}
		var fields = str.split("|");

		var i=0;
		var dian = 2;
		var _float = false;
		var _flag = false;
		for(;i<fields.length;i++){
			var _field_ = fields[i];
			if(isNaN(parseFloat(_field_)) && _field_.length>5){
				var oldVal = document.getElementsByName(_field_)[0].value;
				var val = oldVal;
				if(val == null || val == '') {
					val='0';
				}else{
                    _flag=true;
                }
				val = val.replace(/,/igm,'');

				exp = exp.replace(_field_, "("+val+")");//加括号，处理负数
                var valSize = $(document.getElementsByName(_field_+'_type')[0]).attr('size');//document.getElementsByName(_field_+"_size");
				if(_float == false && valSize.length>0 && valSize == '18'){//[0].value == 18){
					_float = true;
				}
				if(oldVal.indexOf(".")!=-1){
					var _xsw = oldVal.substring(oldVal.indexOf(".")+1);
					if(_xsw.length > dian){
						dian = _xsw.length;
					}
				}
			}
		}

		if(!_flag)return "";

		var _ret = eval(exp)+'';
        if(_ret=='Infinity'){
            return "";
        }

        if(isPercent!=undefined&&isPercent=='1')dian=4;//百分率

		if(_float == true && _ret!=undefined){
			if(_ret.indexOf(".")!=-1){
				return eval(_ret);//.toFixed(dian);
			}else{
				return eval(_ret);//.toFixed(2);
			}
		}
		return eval(_ret);//.toFixed(0);

	}catch(e){return "";}
}

function __compute_field__(){
	var _computeField_obj_ = document.getElementsByName("computeField");
    if(_computeField_obj_) {
        //有计算字段
		var _len_ = _computeField_obj_.length;
        //不止一个计算字段
        for(var i = 0; i < _len_; i ++){
            var computeField = document.getElementsByName("computeField")[i].value;
            var computeFieldValue = document.getElementsByName("computeFieldValue")[i].value;
            var _computeField_ = document.getElementsByName(computeField)[0];
            
            //处理预算金额为子表合计字段
            if(computeFieldValue.indexOf("@[")!=-1 || computeFieldValue==""){
    			continue;
    		}
            
            if(_computeField_){
                var __isPercent = '';
                try{
                    __isPercent = $(_computeField_).attr("isPercent");//百分率
                }catch(e){}
                var d = 2;
                var decnum = $(_computeField_).attr("decnum");
                if(decnum){
                    if(parseInt(decnum, 10) > 0){
                        d = parseInt(decnum, 10);
                    }
                }
                if(__isPercent==undefined)__isPercent='';
                var __cfv__ = getComputeValue(computeFieldValue, __isPercent);
                if(__cfv__!=''){
                    if(__isPercent&&__isPercent=='1'){
                        __cfv__ = parseFloat(__cfv__)*100 + '';
                    }

                    __cfv__ = parseFloat(__cfv__).toFixed(d);
                }
                _computeField_.value = __cfv__;
                var _computeField_cmp_ = document.getElementsByName(computeField+"_cmp")[0];
                if(_computeField_cmp_){
                    _computeField_cmp_.value = __cfv__;
                }
            }
        }
    }
}

//自动计算字段
function compute_filed_auto() {
    __compute_field__();

    $('input.accountBigInput').each(function(i){
        var $this = $(this);
        var fieldName = $this.attr('name');
        var sourceBigField = $this.attr('sourceBigField');
        if(sourceBigField != ''){
            accountBig(fieldName, sourceBigField);
        }
    });
}

//计算子表合计字段->主表字段
function sumSubTableFieldFunc(){
    var __sumSubTableField = document.getElementsByName("sumSubTableField");
    if(__sumSubTableField.length>0){
        for(var i=0, _sum_len=__sumSubTableField.length; i<_sum_len; i++){
            var t = __sumSubTableField[i].value;
            if(t!=""){
                var g = t.split("=");
                var mainField = g[0];
                var subField = g[1];
                if(document.getElementById(mainField)){
                    var val='';
                    var subObj = document.getElementsByName(subField);
                    var d=0;
                    if(subObj.length>0){
                        var vv = 0;
                        for(var j=0; j<subObj.length; j++){
                            var v = subObj[j].value.replace(/,/gm,'');								
                            if(v&&!isNaN(v)){
                                if(v.indexOf(".")!=-1){
                                    var __d = v.substring(v.indexOf(".")+1).length;
                                    if(__d>d){
                                        d=__d;
                                    }
                                }
                                vv += parseFloat(v);
                            }
                        }
                        val = ''+vv;
                    }

                    if(val!=''){
                        d = d > 2 ? 2 : d;
                        var decnum = document.getElementById(mainField).getAttribute("decnum");
                        if(decnum){
                            if(parseInt(decnum, 10) > 0){
                                d = parseInt(decnum, 10);
                            }
                        }
                        document.getElementById(mainField).value=formatComma(parseFloat(val).toFixed(d));
                        document.getElementById(mainField).blur();
						$('input.accountBigInput').click();
                    }else{
                        document.getElementById(mainField).value='';
                        document.getElementById(mainField).blur();
						$('input.accountBigInput').click();
                    }
                }
            }
        }
    }
}

//单选弹出选择404|多选弹出选择405
function choice(type, fieldId, str, field, evt) {
    if (str.length > 0) {
        //str = str.substring(1);
        var field_obj = document.getElementsByName(field);
        var popIndex = getPopIndex(field_obj, evt);

        if (str.indexOf('人事管理.') != -1 && str.indexOf('hrm.') != -1) {
            openWin({url:whirRootPath + '/PopSelect!intSelectHRMData.action?selectType=' + type + '&fieldId='+fieldId+'&fieldValue=' + str + '&fieldName=' + field + '&popIndex=' + popIndex,width:800,height:600,winName:'pop'+fieldId,isFull:false});
        } else {
            openWin({url:whirRootPath + '/PopSelect!initPopSelectList.action?selectType=' + type + '&fieldId='+fieldId+'&fieldValue=' + str + '&fieldName=' + field + '&popIndex=' + popIndex,width:800,height:600,winName:'pop'+fieldId,isFull:false});
        }
    }
}

//弹出窗口
function openPopWin(field, popUrl, evt) {
    if (popUrl == '') return;

    var field_obj = document.getElementsByName(field);
    var popIndex = getPopIndex(field_obj, evt);

    popUrl += (popUrl.indexOf('?') != -1 ? '&': '?') + 'popIndex=' + popIndex + '&field=' + field;
    //MM_openBrWindow(popUrl, '', 'TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600');
    openWin({url:popUrl,width:800,height:600,isFull:false});
}

//外部接口数据
function openOutterPopWin(fieldId, field, type, ds, evt) {
    if (type == '') return;

    var field_obj = document.getElementsByName(field);
    var popIndex = getPopIndex(field_obj, evt);

    var url = whirRootPath + "/PopSelect!selectOutterDataForPop.action";
    url += "?selectType=" + type;
    url += "&ds=" + ds;
    url += "&popIndex=" + popIndex;
    url += "&fieldName=" + field;
    url += "&fieldId=" + fieldId;
    openWin({url:url,width:800,height:600,winName:'outter'+fieldId,isFull:false});
}

//外部接口数据
function openOutterDataInterfacePopWin(fieldId, field, type, ds, evt) {
    if (type == '') return;

    var field_obj = document.getElementsByName(field);
    var popIndex = getPopIndex(field_obj, evt);

    var url = whirRootPath + "/PopSelect!selectOutterData.action";
    url += "?selectType=" + type;
    url += "&ds=" + ds;
    url += "&popIndex=" + popIndex;
    url += "&fieldName=" + field;
    url += "&fieldId=" + fieldId;
    openWin({url:url,width:800,height:600,winName:'outter'+fieldId,isFull:false});
}

//自动关联两个数据库中相同的字段值
function selAssociateFields(obj, mainTableId, asscoiateTable, field, fieldId, evt){
    var field_obj = document.getElementsByName(obj.name);
    var popIndex = getPopIndex(field_obj, evt);

	var id = obj.value;
    
    $.ajax({
        type: 'POST',
        url: whirRootPath + '/platform/custom/ezform/asscoiatefield/getAsscoiateField_ajax.jsp?time='+(new Date().getTime()),
        cache: false,
        async: false,
        data: "id="+id+"&mainTableId="+mainTableId+"&asscoiateTable="+asscoiateTable+"&field="+field+"&fieldId="+fieldId+"&popIndex="+popIndex,
        dataType: 'html',
        success: function(response) {
            eval(response);
        }
    });
}

//获取选择对象下标
function getPopIndex(field_obj, evt) {
    var popIndex = 0;
    var target = window.event?window.event.srcElement:evt.target;
    for(var i=0;i<field_obj.length;i++){
        //if (target.offsetParent == field_obj[i].parentElement) {
        if(target.parentElement == field_obj[i].parentElement){ 
            popIndex = i; 
            break; 
        } 
    }
    return popIndex;
}

function getPopIndexByName(fieldName, evt) {
    var field_obj = document.getElementsByName(fieldName);
    if(field_obj){
        if(field_obj.length == 1){//only one field
            return 0;
        }else if(field_obj.length == 0){//no field
            return -1;
        }
    }
    return getPopIndex(field_obj, evt);
}

//---------------------------------------------------------------------
//业务初始化START
//---------------------------------------------------------------------
//员工调动审批表
function cb_func_whir$staff_ddsp_ddr(){
    var selectedObj = getObjectByName('whir$staff_ddsp_ddr', 0, '_Id');
    if(selectedObj){
        var selectedObjVal = selectedObj.value;
        $.ajax({
            url: whirRootPath + "/PopSelect!getUserInfo.action",
            type: "POST",
            cache: false,
            async: false,
            dataType: 'json',
            data: {"empId":selectedObjVal},
            success: function(data){
                //json
                var succ = data.success;
                if(succ == 'true'){
                    var orgname = data.orgname;//组织名称
                    var orgnamestring = data.orgnamestring;//组织名称串
                    var empposition = data.empposition;//岗位
                    var empduty = data.empduty;//职务

                    var xrzbm = getObjectByName('whir$staff_ddsp_xrzbm', 0, '');
                    var xrgw = getObjectByName('whir$staff_ddsp_xrgw', 0, '');
                    var xrzw = getObjectByName('whir$staff_ddsp_xrzw', 0, '');

                    if(xrzbm){
                        xrzbm.value = orgnamestring;
                    }
                    if(xrgw){
                        xrgw.value = empposition;
                    }
                    if(xrzw){
                        xrzw.value = empduty;
                    }
                }
            }
        });
    }
}

//数据联动
function cb_func_added_whir$staff_ddsp_ddr(){
    cb_func_whir$staff_ddsp_ddr();
}

//清除数据
function cb_func_popped_whir$staff_ddsp_ddr(){
    var xrzbm = getObjectByName('whir$staff_ddsp_xrzbm', 0, '');
    var xrgw = getObjectByName('whir$staff_ddsp_xrgw', 0, '');
    var xrzw = getObjectByName('whir$staff_ddsp_xrzw', 0, '');

    if(xrzbm){
        xrzbm.value = '';
    }
    if(xrgw){
        xrgw.value = '';
    }
    if(xrzw){
        xrzw.value = '';
    }
}
//---------------------------------------------------------------------
//业务初始化END
//---------------------------------------------------------------------

//customform字段联动start
/*var __eventHander = function (obj, index, trigId, trigFieldName, paraFieldNames, flag, evt){//flag 暂不用 0-表示onload触发 1-表示onchange触发
    return __eventHanderFunc(obj, index, trigId, trigFieldName, paraFieldNames, flag, evt);
}*/

function __eventHanderFunc(obj, index, trigId, trigFieldName, paraFieldNames, flag, evt){//flag 暂不用 0-表示onload触发 1-表示onchange触发
    if(document.getElementsByName(trigFieldName).length == 0){
        var _new_component_ = document.getElementsByName("new_component_"+trigFieldName);
        if(_new_component_.length>0){
            if(document.getElementsByName(trigFieldName+_new_component_[0].value+'_Id').length>0){
                trigFieldName = trigFieldName+_new_component_[0].value+'_Id';
            }
        }
    }
    
    if(document.getElementsByName(trigFieldName).length>0){
        var attrIndex = 0;
        var target = window.event?window.event.srcElement:evt.target;
        try{
            for(var i=0;i<document.getElementsByName(trigFieldName).length;i++){ 
                //if(window.event.srcElement.offsetParent == document.getElementsByName(trigFieldName)[i].parentElement){
                if(target.parentElement == document.getElementsByName(trigFieldName)[i].parentElement){ 
                    attrIndex = i; 
                    break;
                } 
            }
        }catch(e){}

        var _urlParams = "";
        if(paraFieldNames){
            for(var i0=0; i0<paraFieldNames.length; i0++){
                _urlParams += "&paramName=" + paraFieldNames[i0];
                var _val = "";                    

                if(flag==2){
                    var _new_component_ = document.getElementsByName("new_component_"+paraFieldNames[i0]);
                    if(_new_component_.length>0){
                        if(_new_component_.length>0){
                            for(var k0=0; k0<_new_component_.length; k0++){
                                var newObj = document.getElementsByName(paraFieldNames[i0]+_new_component_[k0].value+'_Id');
                                if(newObj.length>0){
                                    _val = newObj[index].value;
                                }
                            }
                        }
                    }
                }else{
                    if(document.getElementsByName(paraFieldNames[i0]).length>0){
                        _val = document.getElementsByName(paraFieldNames[i0])[index].value;
                    }else{
                        var _new_component_ = document.getElementsByName("new_component_"+paraFieldNames[i0]);
                        if(_new_component_.length>0){
                            for(var k0=0; k0<_new_component_.length; k0++){
                                var newObj = document.getElementsByName(paraFieldNames[i0]+_new_component_[k0].value);
                                if(newObj.length>0){
                                    var newObjShow = document.getElementsByName(paraFieldNames[i0]+"_showtype")[0].value;//103-单选 104-多选
                                    for(var j0=0; j0<newObj.length; j0++){
                                        if(newObj[j0].checked){
                                            _val += newObj[j0].value + (newObjShow=='104'?',':'');
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                _urlParams += "&paramValue=" + encodeURIComponent(_val);
            }
        }//alert(_urlParams);

        $.ajax({
            type: 'POST',
            url: whirRootPath + '/platform/custom/custom_form/run/checkform/wf_trigger_field.jsp?time='+(new Date().getTime()),
            cache: false,
            async: true,
            data: "trigId="+trigId+_urlParams,
            dataType: 'html',
            success: function(response) {
                //var responsedata = xmlHttp.responseText;
                eval(response);
                if(__triggerFields){
                    for(var i0=0; i0<__triggerFields.length; i0++){
                        var destObj = document.getElementsByName(__triggerFields[i0][0]);
                        if(destObj && destObj.length>0){
                            var _val_ = __triggerFields[i0][1];//00:00:00.0
                            if(_val_=='null'||_val_=='NULL'){
                                _val_ = '';
                            }else{
                                _val_ = _val_.replace(/ 00:00:00.0$/, '');
                            }
                            destObj[attrIndex].value=_val_;
                        }else{
                            var _val_ = __triggerFields[i0][1];//00:00:00.0
                            if(_val_=='null'||_val_=='NULL'){
                                _val_ = '';
                            }else{
                                _val_ = _val_.replace(/ 00:00:00.0$/, '');
                            }
                            var _new_component_ = document.getElementsByName("new_component_"+__triggerFields[i0][0]);
                            if(_new_component_.length>0){
                                for(var k0=0; k0<_new_component_.length; k0++){
                                    var newObj = document.getElementsByName(__triggerFields[i0][0]+_new_component_[k0].value);
                                    if(newObj.length>0){
                                        var newObjShow = document.getElementsByName(__triggerFields[i0][0]+"_showtype")[0].value;//103-单选 104-多选
                                        if(newObjShow=='103' || newObjShow=='104'){
                                            for(var j0=0; j0<newObj.length; j0++){
                                                newObj[j0].checked = false;
                                                if((","+_val_+",").indexOf("," + newObj[j0].value + ",") >= 0) {
                                                    newObj[j0].checked = true;
                                                }
                                            }
                                        }else{
                                            newObj[attrIndex].value=_val_;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        });
    }
}
//customform字段联动end

function openDocEdit(fieldName, index, defaultVal, fileType, newOrUpdate){
    index = 0;
    if(newOrUpdate == "0"){//不可编辑
        window.open(whirRootPath +"/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+document.getElementsByName(fieldName)[0].value+"&EditType=4&_rowIndex="+index+"&UserName="+document.getElementById("sys_userName").value+"&showTempSign=0&ShowSign=0&CanSave=0&moduleType=information&saveHtmlImage=0&saveDocFile=0&field="+fieldName+"&FileType="+fileType+"&showSignButton=1&viewdoc=true&showCoverPrint=1&fromModule=custom&initRecordId="+defaultVal, "", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
    }else if(newOrUpdate == "1"){//可编辑
        window.open(whirRootPath+"/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+document.getElementsByName(fieldName)[0].value+"&EditType=1&_rowIndex="+index+"&UserName="+document.getElementById("sys_userName").value+"&textContent=-1&showTempSign=0&ShowSign=0&CanSave=1&moduleType=information&saveHtmlImage=0&saveDocFile=1&field="+fieldName+"&FileType="+fileType+"&showEditButton=1&showSignButton=1&showCoverPrint=1&fromModule=custom&initRecordId="+defaultVal, "", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
    }
}

function processAutoIncrement(){
    var autoIncrementInputArr = "|";
    $('input.autoIncrementInput,textarea.autoIncrementInput').each(function(i){
        var _name = $(this).attr('name');
        if(autoIncrementInputArr.indexOf("|"+_name+"|")==-1){
            autoIncrementInputArr += _name + "|";
        }
    });

    if(autoIncrementInputArr.length>2){
        var autoIncrementInputArr = autoIncrementInputArr.substring(1, autoIncrementInputArr.length-1);
        var _arr = autoIncrementInputArr.split('|');
        for(var j=0; j<_arr.length; j++){
            $('.autoIncrementInput[name="'+_arr[j]+'"]').each(function(i){
                var opt = $(this).attr('ext-options');
                if(opt != ''){
                    var json = eval('('+opt+')');
                    var autoIncrement_initval = parseInt(json.AUTO_INCREMENT, 10);
                    var step = i;
                    if(json.STEP){
                        step = parseInt(json.STEP, 10) * i;
                    }

                    var head = '';
                    if(json.HEAD){
                        head = json.HEAD;
                    }
                    var tail = '';
                    if(json.TAIL){
                        tail = json.TAIL;
                    }

                    var middle = autoIncrement_initval + step;

                    var fill = '';
                    if(json.FILL){
                        fill = json.FILL;
                        if(fill != ''){
                            var length = 0;
                            if(json.LENGTH){
                                length = parseInt(json.LENGTH, 10);

                                var tmp = '' + middle;
                                var len = tmp.length;
                                var n = length - len;
                                if(n > 0){
                                    for(var k=0; k<n; k++){
                                        tmp = fill + '' + tmp;
                                    }
                                    middle = tmp;
                                }
                            }
                        }
                    }

                    $(this).val(head + middle + tail);
                }
            });
        }
    }

    //非国产化下
    if(checkCOS() == false){
        autoHeightInput();
    }
}

function processWordStyle(){
    //非国产化下
    if(checkCOS() == false){

        //处理word导入表单模板不居中问题
        $('table.MsoNormalTable,table.MsoTableGrid').each(function(){
            var _marginLeft = $(this).css('margin-left')+'';
            if(_marginLeft.indexOf('pt')!=-1 || _marginLeft.indexOf('px')!=-1){
                $(this).css('margin-left', 'auto');
            }
            var _marginRight = $(this).css('margin-right')+'';
            if(_marginRight.indexOf('pt')!=-1 || _marginRight.indexOf('px')!=-1){
                $(this).css('margin-right', 'auto');
            }
        });

    }

    $('input[type=hidden][name="hideTable"]').each(function(){
        var _val = $(this).val().replace(/\$/m, '\\$');
        $('#'+_val+'DIV').addClass("subtablediv");

    });
    $('input[type=hidden][name="showTable"]').each(function(){
        var _val = $(this).val().replace(/\$/m, '\\$');
        $('#'+_val+'DIV').addClass("subtablediv");
    });
}

function lazyTextareaHeight() {
    $("textarea.formTextarea,textarea.formTexttareaMust").each(function(){
        $(this).height(Math.max(94, this.scrollHeight));
        $(this).textareaAutoHeight({ minHeight:94, maxHeight:1000 });
    });
}

function autoHeightInput(){
    if($.browser.msie){
        setTimeout(lazyTextareaHeight, 500);
    }else{
        lazyTextareaHeight();
    }

    $("textarea.autoHeight").each(function(){
        $(this).height(this.scrollHeight);
        $(this).textareaAutoHeight({ minHeight:27, maxHeight:1000 });
    });
    //$(".autoHeight").textareaAutoHeight({ minHeight:27, maxHeight:200 });
}

//print use
function printRelationObj(){
    var isFormPrint = $('#isFormPrint').val();
    if(isFormPrint == '1'){
        if(document.getElementById('relationIFrame')){
            setTimeout(function(){
                var relationIFrameHtml = $(document.getElementById('relationIFrame').contentWindow.document.body).html();//window.frames['relationIFrame'];
                $('#relationObjectDIV').html(relationIFrameHtml);
                $('#relationIFrame').remove();
            }, 1000);
        }
    }
}