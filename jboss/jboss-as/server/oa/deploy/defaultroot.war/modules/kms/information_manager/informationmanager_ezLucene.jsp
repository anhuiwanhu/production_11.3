<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>信息列表</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<style type="text/css">   
		.trigger1:hover{color:red}   
		.boxmain{ border: 0px solid #E3E3E3;  background-position:bottom; background-repeat:repeat-x; padding:3px 0px 5px 0px; line-height:29px; font-size:14px;}
		.boxmain a{ color:#0000CC; text-decoration:none; padding-right:22px; font-size:14px;}
		.boxmain a.a1{ color:#000; text-decoration:none; font-weight:bold;}
	</style>   
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/BBSResource.js" type="text/javascript"></script>
</head>
<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="InfoList!retrieval_new.action" method="post" theme="simple">
	<s:hidden id="channelType" name="channelType" value="0"/>
	<s:hidden id="userDefine" name="userDefine" value="0"/>
	<s:hidden id="userChannelName" name="userChannelName" value="信息管理"/>
	<s:hidden id="type" name="type" value="all"/>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="searchTable" class="SearchBar">  
		<tr>
            <td width="8%" nowrap>  
				<s:text name="bbs.luceneKeyword" />：
			</td>
			<td width="25%">
				<s:textfield name="retrievalKey" id="retrievalKey" cssClass="inputText" cssStyle="width:96%"/>
			</td> 
			<td align="left">
				<input type="button" class="btnButton4font" onclick="retrievalAllser();"  value='<s:text name="bbs.lucene" />' />
			</td>
        </tr>
		<tr>
            <td width="8%" nowrap>  
				<s:text name="bbs.date" />：
			</td>
			<td colspan="2">
				<s:textfield name="startDate" id="startDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'endDate\\')}'})"/>&nbsp;<s:text name="info.to"/>&nbsp;<s:textfield name="endDate" id="endDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'startDate\\')}'})" />
			</td> 
        </tr>
		
    </table>
	<div style="height:5px;"></div>
	<div class="Public_tag">
		<ul>
			<li id="Panle0" class="tag_aon" onclick="changePanle(0);">
				<span class="tag_center"><s:text name="comm.information" /></span>
				<span class="tag_right"></span>
			</li>
			<li id="Panle1" onclick="changePanle(1);">
				<span class="tag_center"><s:text name="bbs.luceneSendFile" /></span>
				<span class="tag_right"></span>
			</li>
			<li id="Panle2" onclick="changePanle(2);">
				<span class="tag_center"><s:text name="bbs.luceneReceiveFile" /></span>
				<span class="tag_right"></span>
			</li>
			<li id="Panle3" onclick="changePanle(3);">
				<span class="tag_center"><s:text name="bbs.luceneSendFileCheck" /></span>
				<span class="tag_right"></span>
			</li>
			<li id="Panle4" onclick="changePanle(4);">
				<span class="tag_center"><s:text name="bbs.luceneContract" /></span>
				<span class="tag_right"></span>
			</li>
			<li id="Panle5" onclick="changePanle(5);">
				<span class="tag_center"><s:text name="comm.forum" /></span>
				<span class="tag_right"></span>
			</li>
			<li id="Panle6" onclick="changePanle(6);">
				<span class="tag_center"><s:text name="comm.knowledge_document" /></span>
				<span class="tag_right"></span>
			</li>
		</ul>
	</div>
	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="SearchList">
        <tbody >
            <tr>
                <td>
                    <div class="box_search_allList" style="display: none" id="showCountDiv">
                                                          当前信息管理检索“<font color="red"><span id="retrievalKeyInput"></span></font>”结果<font color="red"><span id="recordCountAll"></span></font>条记录
                    </div>
                    <div class="box_search2">
                        <ul id="lis">                       
                        </ul>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
</s:form>
<script language="javascript">
$(document).ready(function(){

	initEzLuceneListFormToAjax({formId:"queryForm"});
	$("#queryForm").find(".page").hide();
});

function changePanle(flag){
	for(var i=0;i<7;i++){
		$("#Panle"+i).removeClass();
	}
	$("#Panle"+flag).addClass("tag_aon"); 
	var retrievalKey = $("#retrievalKey").val();
	var url ;
	if(flag==0){
		url = "<%=rootPath%>/InfoList!retrievalList.action?channelType=0&userChannelName=信息管理&userDefine=0&type=all&retrievalKey="+retrievalKey;
	}else if(flag==1){
		url = "<%=rootPath%>/modules/govoffice/gov_documentmanager/ezLucene_sendfile_list.jsp?retrievalKey="+retrievalKey;
	}else if(flag==2){
		url = "<%=rootPath%>/modules/govoffice/gov_documentmanager/ezLucene_receivefile_list.jsp?retrievalKey="+retrievalKey;
	}else if(flag==3){
		url = "<%=rootPath%>/modules/govoffice/gov_documentmanager/ezLucene_sendfilecheck_list.jsp?retrievalKey="+retrievalKey;
	}else if(flag==4){
		url = "<%=rootPath%>/contract!contractInLucene.action?retrievalKey="+retrievalKey;
	}else if(flag==5){
		url = "<%=rootPath%>/ForumAction!luceneList.action?retrievalKey="+retrievalKey;
	}else if(flag==6){
		url = "<%=rootPath%>/Document!luceneList.action?retrievalKey="+retrievalKey;
	}
	location_href(url);
}

function initEzLuceneListFormToAjax(formJson){
	var formJson_ = eval(formJson);
	var formId = formJson_.formId;
	var channelType = $('#channelType').val();
	var userDefine = $('#userDefine').val();
	var userChannelName = $("#userChannelName").val();
	//分页参数等html、公共js事件绑定
	initEzLuceneList(formId);
 	var jq_form = $('#'+formId);
	jq_form.ajaxForm({
		beforeSend:function(){
			$.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
		},
		success:function(responseText){
			$.dialog({id:"Tips"}).close();
			$("#lis").html("");
			//解析服务器返回的json字符串
			var json = eval("("+responseText+")").data;
			var data = json.data;
			var pager = json.pager;
			//分页信息
			if(eval(pager.pageCount)!=0 && eval(pager.pageCount) < eval(jq_form.find("#start_page").val()) ){
				jq_form.find("#start_page").val(jq_form.find("#start_page").val()-1);
			}
			jq_form.find("#page_count").val(pager.pageCount);
			jq_form.find("#recordCount").val(pager.recordCount);

			var keySearch=$("#retrievalKey").val();//获取查询输入内容
            if((keySearch!=null)&&(keySearch!="")&&pager.recordCount!=0){
            	$("#showCountDiv").show();//显示div          	              
            } else{
				$("#showCountDiv").hide();
			}
            $("#retrievalKeyInput").html(keySearch); 
            $("#recordCountAll").html(pager.recordCount);//获取查询总数
			//循环数据信息
			var divClass = '';
			for (var i=0; i<data.length; i++) {
				var page_tr = "";
				if(i%2 != 0){
					divClass = "text1";
				}else{
					divClass = "text2";
				}
				var po = data[i];	
				var title = po.informationTitle;
                var key = $("#retrievalKey").val();
                if (title.indexOf(key)>-1) {
                    title = title.replace(key,'<font color="#FF0000">'+key+'</font>');
                }
				page_tr = "<li><div class='"+divClass+"'><h1><a href='javascript:void(0);' onclick='openWin({url:\"Information!view.action?informationId="+po.information_id+"&informationType="+po.informationType+"&userChannelName="+userChannelName+"&channelId="+po.channel_id+"&userDefine="+userDefine+"&channelType="+channelType+"\",winName:\"viewInfo"+po.information_id+"\",isFull:true});'>"+title+"</a></h1>发布人："+po.informationIssuer+"&nbsp;&nbsp;&nbsp;发布日期："+po.informationIssueTime+"</div></li>";

				$("#lis").append(page_tr);

				//alert(page_tr);

			}
			if($("#retrievalKey").val()!=''){
				setPager(formId);
			}else{
				$("#"+formId).find(".page").hide();
			}
			if(data.length == 0){
				var no_record_tip = '<li>'+comm.norecord+'</li>';
				$("#lis").append(no_record_tip);
				jq_form.find(".page").hide();
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.dialog({id:"Tips"}).close();
			$.dialog.alert(comm.loadfailure,function(){});
		}
	}); 
	//初次提交表单获得数据
	if($("#retrievalKey").val()!=''){
		$("#"+formId).submit();
	}
}

//设置分页
function setPager(formId){
	$("#"+formId).find(".page").show();
	var page_size = ($("#"+formId).find("#page_size").val())*1+0;
	var start_page = ($("#"+formId).find("#start_page").val())*1+0;

	$("#"+formId).find("#pager").jPages({
	  containerID : "lis",
	  previous : comm.lastpage,
	  next : comm.nextpage,
	  perPage : page_size,
	  startPage: start_page,
	  delay : 20,
	  formId:formId
	});
	
	setPagerDesc(formId);
	
	$("#"+formId).find("#pager a").click(function(event){ 
	     event.stopPropagation(); 
	     event.preventDefault();
	}) ;
}

//初始化表头、分页参数等html、公共js事件绑定
function initEzLuceneList(formId){
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

    //回车查询	
    $("body").on('keydown', function(event){
        if(event!=undefined && event.keyCode==13){
            var $go_start_pager_val = $go_start_pager.val();
            if($go_start_pager.attr("class")=="clicked" && $.trim($go_start_pager_val)!=""){
                $formId.find("#start_page").val($go_start_pager_val);
            }else{
                $formId.find("#start_page").val("1");
            }
			var key = $("#retrievalKey").val();
			if(key==''){
				whir_alert(bbs.pleaseEnterKeyword, null, null);
				event.preventDefault();
				event.stopPropagation();
			}else{
				$formId.submit();
				event.preventDefault();
				event.stopPropagation();
			}
        }
    });
}


function retrievalAllser(){
	var key = $("#retrievalKey").val();
	if(key == ''){
		whir_alert(bbs.pleaseEnterKeyword, null, null);
		return;
	}else{
		refreshListForm('queryForm');
	}
}

</script>
</body>
</html>