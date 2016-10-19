/** 视图展示页 [BEGIN] */

// 
function checkBeforeRefreshListForm(){
    var menuType = $('#menuType').val();
    if(menuType == 'underling'){
        var queryUnderlingEmp = whirCombobox.getValue('queryUnderlingEmp');
        if(queryUnderlingEmp == ''){
            whir_alert(Personalwork.myworklog_selectemp, null, null);
            return false;
        }
    }else if(menuType == 'query'){ 
        var queryUnderlingEmp = whirCombobox.getValue('queryUnderlingEmp');
        var querySharedFromEmp = whirCombobox.getValue('querySharedFromEmp');
        if(queryUnderlingEmp == '' && querySharedFromEmp == ''){
            whir_alert(Personalwork.myworklog_selemp, null, null);
            return false;
        }
    }
    return true;
}

// 
function changeQueryByDateOffset(flag){
    $('#queryPeriodReferOffset').val(flag);
    //$("#queryForm").submit();
    refreshListForm('queryForm');
}

// 今日/本工作周/本周/本月
function changeQueryDate_toCur(){
	// 调用公共方法获取当前日期
    $('#queryDate').val(getSmpFormatNowDate(false));
    //$("#queryForm").submit();
    refreshListForm('queryForm');
}


function initDisplayFormToAjax(formJson){
    var formJson_ = eval(formJson);
    var formId = formJson_.formId;
    var displayType = formJson_.displayType;
    
    // 初始化视图显示基础
    initDisplayBasicHtml(formId, displayType);
    
    var jq_form = $('#'+formId);
    var menuType = jq_form.find('#menuType').val();
    jq_form.ajaxForm({
        beforeSend:function(){
            //alert("[" + $('.RoundedCorner').size()+']');
            $.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
        },
        success:function(responseText){
            $.dialog({id:"Tips"}).close();
            //$('#'+formId).find('#itemContainer').html('');
            //解析服务器返回的json字符串
            var json = eval("("+responseText+")").data;
            
            // 查询的时间段
            var periodJson = json.periodJson;
            //alert("periods=[" + periods.length + "]");
            var periodShow = periodJson.periodShow;
            var newPeriodReferDate = periodJson.newPeriodReferDate;
            
            var rowsMax = periodJson.rowsMax; 
            var colsMax = periodJson.colsMax; 
            
            if(resetDisplayForm(formId, displayType, rowsMax, colsMax)){
                //alert("111");
                
                var nowDate = new Date();
                var nowDateStr = format(nowDate, "yyyy-MM-dd");
                //alert('nowDateStr=[' + nowDateStr + ']');
                
                if(displayType == 'day' || displayType == 'workweek'){
                    // 工作周
                    var periods = periodJson.data;
                    //alert(periods.length);
                    for(var i=0; i<periods.length; i++){
                        // 
                        var period = periods[i];
                        //$('#'+formId).find('#date'+period.id).html(period.value);
                        var dateHtml = '<span name="dateLink" style="cursor:pointer;" >' + period.value + '</span>';
                        //var dateHtml = '<a href="javascript:void(0);" onclick="seeMoreEvent(\''+period.value+'\');">' + period.value + '</a>';
                        
                        jq_form.find('#date'+period.id).html(dateHtml);
                        jq_form.find('#date'+period.id).attr("date", period.value);
                        jq_form.find('#date'+period.id).attr("id", "date_" + period.value);
                    }
                    
                    var dayNum = jq_form.find('#date_'+nowDateStr).attr("dayNum");
                    if(dayNum != undefined && dayNum != 'undefined' && dayNum != ''){
                        jq_form.find('#dayLogDiv').find('td[dayNum="'+dayNum+'"]').each(function(){
                            //alert('111');
                            $(this).addClass("curDate");

                        });
                    }
                } else {
                    // 周、月
                    var periods = periodJson.data;
                    var curMonthFlag = 0;
                    
                    for(var i=0; i<periods.length; i++){
                        // 
                        var period = periods[i];
                        //$('#'+formId).find('#date'+period.id).html(period.value);
                        var dateStr = period.value;
                        if(displayType == 'month'){
                            if((dateStr.substring(dateStr.lastIndexOf('-')+1) == '01')){
                                curMonthFlag += 1;
                            }
                            if(curMonthFlag == 0 || curMonthFlag == 2){
                                // 不是当前月份
                                jq_form.find('#date'+period.id).parent().addClass("notCurMonth");
                                jq_form.find('#container'+period.id).parent().addClass("notCurMonth");
                            }
                            
                            if(dateStr == nowDateStr){
                                jq_form.find('#date'+period.id).parent().addClass("curDate");
                            }
                        }
                        
                        var dateHtml = '<span name="dateLink" style="cursor:pointer;" >' + period.value + '</span>';
                        //var dateHtml = '<a href="javascript:void(0);" onclick="seeMoreEvent(\''+dateStr+'\');">' + dateStr + '</a>';
                        jq_form.find('#date'+period.id).html(dateHtml);
                        
                        jq_form.find('#container'+period.id).attr("date", dateStr);
                        jq_form.find('#container'+period.id).attr("id", "container_" + dateStr);
                        
                    }
                }
                
                // 
                jq_form.find('#periodsShow').html(periodShow);
                
                // 改变查询日期区间参考日期
                jq_form.find('#queryPeriodReferDate').val(newPeriodReferDate);
                
                // 改变查询日期区间参考偏移量为空
                jq_form.find('#queryPeriodReferOffset').val('');
                
                var data = json.data;
                // Modified by Qian Min at 2013-08-16 
                // 注：为提高执行速度，将视图类别的判断，拎到循环外面了，代码上有些重复。
                //add by lifan
                var eventBeginDate = '';
                var eventEndDate = '';
                var eventDate = '';
                var eventBeginTime = '';
                var eventEndTime = '';
                var onTimeMode = '';
                
                if(displayType == 'day'){
                    // 天视图
                    //循环数据信息
                    for (var i=0; i<data.length; i++) {
                        var po = data[i];
                        // 生成记录链接内容
                        var recordLinkContent = '';
						
						//add by lifan 跨天日程时间显示问题修改
						eventBeginDate = po.eventBeginDate.substr(0,10);
						eventEndDate = po.eventEndDate.substr(0,10);
						eventBeginTime = po.eventBeginTime;
						eventEndTime = po.eventEndTime;
						eventDate = po.eventDate;
						onTimeMode = po.onTimeMode;
						
                        if(po.eventFullDay == '1'){
                            //recordLinkContent = '['+Personalwork.worklog_fullday+']';
                        }else{
							if(eventDate != eventEndDate && eventDate == eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-23:30]';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate != eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '[00:00-23:30]';
								eventBeginTime = '0';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate == eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								eventBeginTime = '0';
								recordLinkContent = '[00:00-' + formatTimeOfLongValue(eventEndTime) + ']';
							}else{
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-' + formatTimeOfLongValue(eventEndTime) + ']';
							}
                        }
                        recordLinkContent += po.eventTitle;
                        if(po.eventFullDay == '1'){
                            // 全天事件
                            addFullDayRecord(po.eventId, po.verifyCode, eventDate, recordLinkContent, po.eventIsViewed, po.canModify);
                        } else {
                            // 非全天事件
                            addPartDayRecord(i, po.eventId, po.verifyCode, eventDate, po.eventContent, po.eventIsViewed, eventBeginTime, eventEndTime, po.canModify, po.eventTitle);
                        }
                    }
                } else if(displayType == 'workweek'){
                    // 工作周视图

                    //循环数据信息
                    for (var i=0; i<data.length; i++) {
                        var po = data[i];
                        
                        // 生成记录链接内容
                        var recordLinkContent = '';
						
						//add by lifan 跨天日程时间显示问题修改
						eventBeginDate = po.eventBeginDate.substr(0,10);
						eventEndDate = po.eventEndDate.substr(0,10);
						eventBeginTime = po.eventBeginTime;
						eventEndTime = po.eventEndTime;
						eventDate = po.eventDate;
						onTimeMode = po.onTimeMode;
						
                        if(po.eventFullDay == '1'){
                            //recordLinkContent = '['+Personalwork.worklog_fullday+']';
                        }else{
							if(eventDate != eventEndDate && eventDate == eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-23:30]';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate != eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '[00:00-23:30]';
								eventBeginTime = '0';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate == eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								eventBeginTime = '0';
								recordLinkContent = '[00:00-' + formatTimeOfLongValue(eventEndTime) + ']';
							}else{
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-' + formatTimeOfLongValue(eventEndTime) + ']';
							}
                        }
                        recordLinkContent += po.eventTitle;
                        
                        // 工作周视图中的全天事件，内容截断显示
                        if(recordLinkContent.length > 50){
                            recordLinkContent = recordLinkContent.substring(0, 50) + '...';
                        }
                        
                        if(po.eventFullDay == '1'){
                            // 全天事件
                            addFullDayRecord(po.eventId, po.verifyCode, po.eventDate, recordLinkContent, po.eventIsViewed, po.canModify);
                        } else {
                            // 非全天事件
							addPartDayRecord(i, po.eventId, po.verifyCode, eventDate, po.eventContent, po.eventIsViewed, eventBeginTime, eventEndTime, po.canModify, po.eventTitle);
                        }
                    }
                } else if(displayType == 'week'){
                    // 周视图
                    
                    //循环数据信息
                    for (var i=0; i<data.length; i++) {
                        var po = data[i];
                        
                        // 生成记录链接内容
                        var recordLinkContent = '';
						
						//add by lifan 跨天日程时间显示问题修改
						eventBeginDate = po.eventBeginDate.substr(0,10);
						eventEndDate = po.eventEndDate.substr(0,10);
						eventBeginTime = po.eventBeginTime;
						eventEndTime = po.eventEndTime;
						eventDate = po.eventDate;
						onTimeMode = po.onTimeMode;
						
                        if(po.eventFullDay == '1'){
                            recordLinkContent = '['+Personalwork.worklog_fullday+']';
                        }else{
                            if(eventDate != eventEndDate && eventDate == eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-23:30]';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate != eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '[00:00-23:30]';
								eventBeginTime = '0';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate == eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								eventBeginTime = '0';
								recordLinkContent = '[00:00-' + formatTimeOfLongValue(eventEndTime) + ']';
							}else{
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-' + formatTimeOfLongValue(eventEndTime) + ']';
							}
                        }
                        recordLinkContent += po.eventTitle;
                        
                        var eventDate = po.eventDate;
                        var _location = 'container_' + eventDate;
                        
                        var html = createSingleRecordHtml(po.eventId, po.verifyCode, recordLinkContent, po.eventIsViewed, po.canModify);
                        jq_form.find("#"+_location).append(html);
                    }
                } else if(displayType == 'month'){
                    // 月视图
                    
                    //循环数据信息
                    for (var i=0; i<data.length; i++) {
                        var po = data[i];
                        
                        // 生成记录链接内容
                        var recordLinkContent = '';
						
						//add by lifan 跨天日程时间显示问题修改
						eventBeginDate = po.eventBeginDate.substr(0,10);
						eventEndDate = po.eventEndDate.substr(0,10);
						eventBeginTime = po.eventBeginTime;
						eventEndTime = po.eventEndTime;
						eventDate = po.eventDate;
						onTimeMode = po.onTimeMode;
						
                        if(po.eventFullDay == '1'){
                            recordLinkContent = '['+Personalwork.worklog_fullday+']';
                        }else{
						    if(eventDate != eventEndDate && eventDate == eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-23:30]';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate != eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								recordLinkContent = '[00:00-23:30]';
								eventBeginTime = '0';
								eventEndTime = 23 * 60 * 60 + 30 * 60;
							}else if(eventDate == eventEndDate && eventDate != eventBeginDate && '定期' != onTimeMode){
								eventBeginTime = '0';
								recordLinkContent = '[00:00-' + formatTimeOfLongValue(eventEndTime) + ']';
							}else{
								recordLinkContent = '['+formatTimeOfLongValue(eventBeginTime) + '-' + formatTimeOfLongValue(eventEndTime) + ']';
							}
                        }
                        recordLinkContent += po.eventTitle;
                        
                        var eventDate = po.eventDate;
                        var _location = 'container_' + eventDate;
                        
                        var recordCount = jq_form.find("#"+_location).find('div').size();
                        if(recordCount <= 3){
                            var html = '';
                            if(recordCount < 3){
                                /* Modified by Qian Min at 2013-09-03 when handling bug 7983 [BEGIN] */
                                html = createSingleRecordHtml_month(po.eventId, po.verifyCode, recordLinkContent, po.eventIsViewed, po.canModify);
                                /* Modified by Qian Min at 2013-09-03 when handling bug 7983 [BEGIN] */
                            } else {
                                html = createSeeMoreRecordHtml(eventDate);
                            }
                            jq_form.find("#"+_location).append(html);
                        }
                    }
                }
                
                // 
                if(displayType == 'day' || displayType == 'workweek'){
                    // 控制"全天日志"部分的显示
                    controlFullDayDisplay();
                    // 
                    // Modified by Qian Min for ezOFFICE 11.0.0.11
                    ajustDayLogDivHeight(displayType);
                }
                
                // 日程标题链接
                $('a[name="record"]').each(function(){
                    $(this).bind("click", function(){
                        if($(this).attr("recordCanModify") == '1'){
                            modiEvent($(this).attr("recordID"), $(this).attr("verifyCode"));
                        } else {
                            viewEvent($(this).attr("recordID"), $(this).attr("verifyCode"));
                        }
                    });
                });
                
                // "工作周/周/月视图"的日期部分链接到"日视图"
                $('span[name="dateLink"]').each(function(){
                    $(this).bind("mouseover", function(){
                        $(this).attr("title", Personalwork.worklog_seeSingleDate);
                    });
                    $(this).bind("click", function(){
                        seeMoreEvent($(this).html());
                    });
                });
                
                if(menuType == 'mine' || menuType == 'underling' || menuType == 'query'){
                    // 
                    if(displayType != 'day'){
                    
                        if(displayType == 'week' || displayType == 'month'){
                            // "周/月视图"的"查看更多"链接
                            $('a[name="more"]').each(function(){
                                $(this).bind("click", function(){
                                    seeMoreEvent($(this).attr("recordDate"));
                                });
                            });
                        
                            // 根据日期新增不定期事件
                            $('div[name="container"]').parent().each(function(){
                                $(this).bind("mouseover", function(){
                                    $(this).attr("title", Personalwork.worklog_addByDoubleClick);
                                });
                                $(this).bind("dblclick", function(){
                                    addEventByDate($(this).find('div[name="container"]').attr("date"));
                                });
                            });
                        }
                    }
                    
                    if(displayType == 'day' || displayType == 'workweek'){
                        // 根据日期、时间新增不定期事件--全天事件
                        $('td[name="td_fullDay"]').each(function(){
                            $(this).bind("mouseover", function(){
                                $(this).attr("title", Personalwork.worklog_addByDoubleClick);
                            });
                            $(this).bind("dblclick", function(){
                                addEventByDateTime('1', $(this).attr("dayNum"), '');
                            });
                        });
                        
                        // 根据日期、时间新增不定期事件--非全天事件
                        $('div[name="occupy"]').each(function(){
                            $(this).bind("mouseover", function(){
                                $(this).attr("title", Personalwork.worklog_addByDoubleClick);
                            });
                        });
                        /*
                        $('td[name="td_partDay"]').each(function(){
                            $(this).bind("mouseover", function(){
                                $(this).attr("title", "双击新增");
                            });
                            $(this).bind("dblclick", function(){
                                addEventByDateTime('0', $(this).attr("dayNum"), $(this).attr("hourNum"));
                            });
                        });
                        */
                    }
                }
                
                //如果没有查询到记录，给出提示
                if(data.length == 0){
                }
                
                //调用回调事件
                if(formJson_.onLoadSuccessAfter){
                    formJson_.onLoadSuccessAfter.call(this);
                }
            }
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            $.dialog({id:"Tips"}).close();
            $.dialog.alert(comm.loadfailure,function(){});
        }
    }); 
    
    //初次提交表单获得数据
    $("#"+formId).submit();
}

/** 视图展示页 [END] */
