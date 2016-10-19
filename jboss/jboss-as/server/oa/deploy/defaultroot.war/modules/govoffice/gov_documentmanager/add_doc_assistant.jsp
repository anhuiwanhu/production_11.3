<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test="docAssistantPO==null">新增组织公文员</s:if><s:else>修改组织公文员</s:else></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->

</head>
<body class="Pupwin">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="GovDocSet!saveDocAssistantPO.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
              <s:hidden name="docAssistantPO.orgIds" id="orgIds"/>
			  <s:hidden name="docAssistantPO.id" id="id"/>
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for="组织" width="100" class="td_lefttitle">  
                            组织<span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="3"> 
						     <s:textfield name="docAssistantPO.orgNames" id="orgNames" readonly="true" onkeydown="if(event.keyCode == 13) return false;" whir-options="vtype:['notempty']" maxlength="50" cssClass="inputText" cssStyle="width:96%;" /><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'orgIds', allowName:'orgNames', select:'org', single:'yes', show:'org', range:'*0*'});"/>
                        </td>  
				
                    </tr>  
					<tr>  
                        <td for="公文员" class="td_lefttitle">  
                            公文员<span class="MustFillColor">*</span>：  
                        </td>  
                        <td  colspan="3">  <s:hidden name="docAssistantPO.userIds" id="userIds"/>
                            <s:textarea name="docAssistantPO.userNames"  id="userNames" cols="112" rows="3" whir-options="vtype:['notempty']" cssClass="inputTextarea" cssStyle="width:96%;" readonly="true"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'userIds', allowName:'userNames', select:'user', single:'no', show:'userorggroup', range:'*0*'});"/>
                        </td>  
                    </tr>

                   
                    <!--tr>  
                        <td for="角色" class="td_lefttitle">  
                           角色：  
                        </td>  
                        <td>  
                            <input type="checkbox" name="type" value="0"> 会员 <input type="checkbox" name="type" value="1"> 管理员
                        </td>  
                    </tr>
                    <tr>  
                        <td for="年龄" class="td_lefttitle">年龄：</td>  
                        <td>  
                           <input type="text" class="easyui-numberspinner" data-options="min:10,max:100" style="width:80px;" name="age" id="age" ></input>
                        </td>  
                    </tr>

					 <tr>  
                        <td for="年龄" class="td_lefttitle">组织（公共选人、组织、群组）：</td>  
                        <td>  
                           <input type="text" class="inputText"  name="org" id="org" ></input>
                        </td>  
                    </tr>

					 <tr>  
                        <td for="年龄" class="td_lefttitle">联系人（zTree）：</td>  
                        <td>  
                           <s:checkboxlist name="list" list="{'Java','.Net','RoR','PHP'}" value="{'Java','.Net'}" />
                        </td>  
                    </tr-->
                    <tr class="Table_nobttomline">  
	                    <td > </td> 
                        <td nowrap>  
                            <input type="button" class="btnButton4font" onClick="{ ok(0,this);}" value="保存退出" />  
							<s:if test="docAssistantPO==null">
                            <input type="button" class="btnButton4font" onClick="ok(1,this);" value="保存继续" />  
							</s:if>
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value="重    置" />  
                            <input type="button" class="btnButton4font" onClick="window.close();" value="退    出" />  
                        </td>  
                    </tr>  
                </table>  


	</s:form>
		</div>
	</div>
</body>

<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	var isy=3;
	//设置表单为异步提交
	

	$(document).ready(function(){
		//initPara();
		initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
	});
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	//上传 红头
	function  uploadHead(){
		popup({content:'url:<%=rootPath%>/govezoffice/gov_documentmanager/senddocument_import.jsp?path=govReadHead&fileName=numPo.redHeadName&saveName=numPo.redHeadSaveName&fileMaxSize=0&fileMaxNum=1&fileType=jpg,gif,bmp,jpeg,png',title: '导入',width:620,height:350,winName:'selProcess'});
	}


	function clearHead(){
		$('#redHeadName').val("");
		$('#redHeadSaveName').val("");
	}



//判断输入的是否是数字
function checkNumber(obj,name,maxnum) {
    var regu = /[0-9]/g ;
    var re = new RegExp(regu);
    var val = obj.value ;
    if(val =="") return true  ;
     if(/^[0-9]+$/.exec(val)) {} else {
    //if (val.search(re) == -1){
		try{
        alert(name+comm.mustinteger) ;
		}catch(e){
        alert(name+"必须是正整数！") ;
		}
         //alert(name+common.mustinteger) ;
         obj.focus();
         obj.select() ;
         return false ;
     }
   // }else {
        if(parseInt(val) > maxnum) {
		try{
        alert(name+comm.notgreaterthan+maxnum+"！") ;
		}catch(e){
        alert(name+"不能大于"+maxnum+"！") ;
		}
         //alert(name+comm.notgreaterthan+maxnum+"！") ;
         obj.focus();
         obj.select() ;
         return false ;
        }
  //  }
   // if(val.indexOf(".")!=-1) {
   //      alert(name+"必须是整数！") ;
   //      obj.focus();
   //      obj.select() ;
   //      return false ;
  //  }
    return true ;
}


//检查页面参数有效性
function initPara() {
	 if($("input[name='numPo.initValue']").val() == ""){
	   alert("序号初始值,不能为空");
	   return false;
	 }
	 if($("input[name='numPo.bitNum']").val()  == ""){
	   alert("文号中序号的位数,不能为空");
	   return false;
	 }
	 var num= $("input[name='numPo.bitNum']").val()  ;

	if(num==0){
	 alert("文号中序号的位数,不能为0");
	 return false;
	}
	 var result=checkNumber( $("input[name='numPo.initValue']")[0] ,"序号初始值",999);
		 if(result==false)
		 return false;
		
	  result=checkNumber($("input[name='numPo.bitNum']")[0] ,"文号中序号的位数",8);
		 if(result==false)
		 return false;

          if($("select[name='numPo.numType']").val() =="" ){
		   alert("文号类别不能为空！");
		   return false
		  }
		 

    if($("input[name='numPo.numName']").val()==""){
    	alert("文号名称不能为空！");
        return false;
    }else{
     if( $("input[name='numPo.numName']").val()==""){
	    alert("文号名称不能为空！");
		return false;
	 }

	if( $("input[name='numPo.numName']").val().indexOf("'")>=0 ){
	alert("文号名称不能有 ' 号 ");
	return false

	}
	if( $("input[name='numPo.numName']").val().indexOf("\"")>=0 ){
	alert("文号名称不能有 \" 号 ");
	return false;

	}

    	return true;
    }
}

//保存继续
function saveContinue() {
	if(preview()==false)
		return ;
    if(initPara()==false)
    	return   ;
    SenddocumentBaseActionForm.action.value = "senddocumentnumcontinue";

	//document.all.judgeNameFrame.src="govezoffice/gov_documentmanager/senddocument_judgename.jsp?type=sendNum&typeName="+encodeURIComponent(document.all.numType.value)+"&name="+encodeURIComponent(document.all.numName.value);
	//setTimeout("submitForm()",150,"javascript");
	$.ajax({
	   type: "GET",
	   url: "govezoffice/gov_documentmanager/senddocument_ajaxjudgename.jsp?type=sendNum&typeName="+encodeURIComponent(document.all.numType.value)+"&name="+encodeURIComponent(document.all.numName.value),
	   data: "",
	   async: false,
	   success: function(msg){
	    	if(msg !="-1" && msg!=null ){
	    		alert("文号名称已经存在!");
				document.all.numName.focus();
	    	}else{
		  		SenddocumentBaseActionForm.submit() ;
		  	}
	   }
	});
}
//保存退出
function saveClose() {

	if(preview()==false)
		return ;
    if(initPara()==false) return   ;
    SenddocumentBaseActionForm.action.value = "senddocumentnumclose";
	
	//document.all.judgeNameFrame.src="govezoffice/gov_documentmanager/senddocument_judgename.jsp?type=sendNum&typeName="+encodeURIComponent(document.all.numType.value)+"&name="+encodeURIComponent(document.all.numName.value);
	//  setTimeout("submitForm()",150,"javascript");
	$.ajax({
	   type: "GET",
	   url: "govezoffice/gov_documentmanager/senddocument_ajaxjudgename.jsp?type=sendNum&typeName="+encodeURIComponent(document.all.numType.value)+"&name="+encodeURIComponent(document.all.numName.value),
	   data: "",
	   async: false,
	   success: function(msg){
	   	   	if(msg !="-1" && msg!=null ){
	    		alert("文号名称已经存在!");
				document.all.numName.focus();
	    	}else{
		  		SenddocumentBaseActionForm.submit() ;
		  	}
	   }
	});
}

/*
function submitForm(){
	if(document.all.judgeNameFrame.readyState!="complete"){
			setTimeout("submitForm()",150,"javascript");
		
	}else{
		if(document.all.judgeChannelName.value!="-1"){
			alert("名称重复!");
			document.all.numName.focus();
		}else{
	
		  SenddocumentBaseActionForm.submit() ;
		}
	}	
}
*/


//重置
function resetter() {
    SenddocumentBaseActionForm.reset() ;
	isy=3;

}

//关闭
function closer() {
    window.close();
}

function choseWord(){

	    var wordName=document.all.fileWord.value;
		var wordIds=document.all.fileWordIds.value;

		if(document.all.fileWordIds.value!=""){
			
		postWindowOpen("govezoffice/gov_documentmanager/chooseWord_two.jsp?wordName="+document.all.fileWord.value+"&wordIds="+document.all.fileWordIds.value,'选择机关代字','menubar=0,scrollbars=0,locations=0,width=274,height=230,resizable=yes');
		
		}else{
		postWindowOpen("govezoffice/gov_documentmanager/chooseWord_two.jsp",'选择机关代字','menubar=0,scrollbars=0,locations=0,width=274,height=230,resizable=yes');
		
		}
		


}

function  preview(){


  
	
	var dv=$("input[name='numPo.numFormat']").val();


       //-----------------------start  去掉多余的------------------------
    if(isy==2){//机无，年无， 如有先 去掉
      
       
        var resultY=dv.indexOf("〔年度〕");
		if(resultY==-1){
		
	    }else{

         dv=dv.substring(0,resultY)+dv.substring(resultY+4);
        }
        
		var resultY=dv.indexOf("年度");
		if(resultY==-1){
		
	    }else{

         dv=dv.substring(0,resultY)+dv.substring(resultY+2);
        }
		

		var resultJ=dv.indexOf("机关代字");
		if(resultJ==-1){
		
	    }else{
         dv=dv.substring(0,resultJ)+dv.substring(resultJ+4);
        }
 
	 
	 }else{
	  if(isy==1){// 年有 ，去机
         var resultJ=dv.indexOf("机关代字");
		if(resultJ==-1){
		
	    }else{
         dv=dv.substring(0,resultJ)+dv.substring(resultJ+4);
        }
		  
	  }else{
	   if(isy==4){//机有，  去年
	    var resultY=dv.indexOf("〔年度〕");
		if(resultY==-1){
		
	    }else{

         dv=dv.substring(0,resultY)+dv.substring(resultY+4);
        }
	     var resultY=dv.indexOf("年度");
		if(resultY==-1){
		
	    }else{

         dv=dv.substring(0,resultY)+dv.substring(resultY+2);
        }
	   
	   }
	  
	  
	  }
	 }
	$("input[name='numPo.numFormat']").val(dv);
	
//----------------------------------end -------------------------------    




	//var dd=dv.Trim();
	var dd=dv;
    var dr1="";
    var resultX=dd.indexOf("序号");
	if(resultX==-1){
		//alert("文号模式格式中，不能少‘序号’");
		showTelGraph();
		return false;
	}else{
         dr1=dd.substring(0,resultX)+"[序号]"+dd.substring(resultX+2);
    }







    if(isy==1){	
    
        var resultY=dr1.indexOf("〔年度〕");

		if(resultY==-1){
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"〔[年度]〕"+dr1.substring(resultY+4);
        }
      /*
        var resultY=dr1.indexOf("年度");

		if(resultY==-1){
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"[年度]"+dr1.substring(resultY+2);
        }*/
     } 
     if(isy==3){
	  


	
        
         var resultY=dr1.indexOf("〔年度〕");
		if(resultY==-1){
		
		  var resultY=dr1.indexOf("年度");

		if(resultY==-1){
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"[年度]"+dr1.substring(resultY+2);
        }
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		 //showTelGraph();
		 // return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"〔[年度]〕"+dr1.substring(resultY+4);
        }
        
        


        var resultJ=dr1.indexOf("机关代字");
		if(resultJ==-1){
		 // alert("文号模式格式 少‘机关代字’,系统将默认取文号中不含机关代字");
		// chooseIsWord("2");
		  //isy=1;
		 // showTelGraph();
		  //return false ;

		   // alert("文号模式格式中选了包含‘机关代字’，所以不能少‘机关代字’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultJ)+"[机关代字]"+dr1.substring(resultJ+4);
        }
	 
	 
	 }

	 if(isy==4){
	
	
		 var resultJ=dr1.indexOf("机关代字");

		if(resultJ==-1){
		  // alert("文号模式格式 少‘机关代字’,系统将默认取文号中不含机关代字");
		  // chooseIsWord("2");
		   // isy=2;
		 // showTelGraph();
		 // return false ;

		 // alert("文号模式格式中选了包含‘机关代字’，所以不能少‘机关代字’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultJ)+"[机关代字]"+dr1.substring(resultJ+4);
        }
		 
	 }
      
//机关代字 年度 序号号
 var p1=dr1.indexOf("[年度]");
 var p2=dr1.indexOf("[机关代字]");
 var p3=dr1.indexOf("[序号]");
 if( p1 != -1 ){
 	if(p1<p2){
 		alert("年度必须在机关代字之前");
 		showTelGraph();
		  return false ;
 	}
 }
 if(p3 != -1){
 	if(p2 !=-1 && p2>p3){
 		alert("序号必须在机关代字之后");
 		showTelGraph();
		  return false ;
 	}
 	if(p1 !=-1 && p1>p3){
 		alert("序号必须在年度之前");
 		showTelGraph();
		  return false ;
 	}
 }
	$("input[name='numPo.numMode']").val(dr1);

}

 function  chooseIsWord(ChooseValue){
	

   var haveY= $("input[name='numPo.numIsWord']"); 

	$("input[name='numPo.numIsWord']").each(function(){
			if(this.value==ChooseValue) {
			 
			  this.checked=true; 
		   
			 }
	});
 
 }

 
 function changeRadio(){

	var haveY= $("input[name='numPo.numIsYear']"); 
	var yvalue;
	$("input[name='numPo.numIsWord']").each(function(){
			
			 
			    if(this.checked) yvalue=this.value;  
		   
			
	});
	var wvalue;
	var haveW= $("input[name='numPo.numIsWord']"); 
	$("input[name='numPo.numIsWord']").each(function(){
			
			 
			    if(this.checked) wvalue=this.value;  
		   
			
	});

     

     if(wvalue=="3"){
       if(yvalue=="1"){//两者有
         isy=3;
	   
	   }else{//机有， 年没有
	    isy=4;
	   
	   }

	 
	 
	 }else{
      if(yvalue=="1"){//机没有 ，年有
       isy=1;

	  
	  }else{//两者没有
		isy=2;
		  
	  }
		 
		 
		 
	 }


preview();
 
 }


function showTelGraph(){
     
  if(isy==1){
	$("input[name='numPo.numFormat']").val("〔年度〕序号号");
	$("input[name='numPo.numMode']").val("〔[年度]〕[序号]号");
  }

  if(isy==2){
	$("input[name='numPo.numFormat']").val("序号号");
	$("input[name='numPo.numMode']").val("[序号]号");
  }


   if(isy==3){
	$("input[name='numPo.numFormat']").val("机关代字〔年度〕序号号");
	$("input[name='numPo.numMode']").val("[机关代字]〔[年度]〕[序号]号");
  }


   if(isy==4){

	$("input[name='numPo.numFormat']").val("机关代字 序号号");
	$("input[name='numPo.numMode']").val("[机关代字] [序号]号");
  
  }

}
 

function repreview(){
   showTelGraph();
}

</script>

</html>



