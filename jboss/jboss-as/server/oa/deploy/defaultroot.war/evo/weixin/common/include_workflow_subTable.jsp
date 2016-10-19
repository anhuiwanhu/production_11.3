<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
String docXml = request.getParameter("docXml");
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
%>
<c:if test="${not empty param.docXml}">
<input type="hidden" id="subTableFlag"/>
<x:parse xml="${param.docXml}" var="doc2"/>
<x:forEach select="$doc2//subTableList/subTable" var="st" >
<c:set var="name"><x:out select="$st/name/text()"/></c:set>
<c:set var="tableName"><x:out select="$st/tableName/text()"/></c:set>
<!-- 子表编辑dom begin -->
<header class="wh-header" id="subHeader_${tableName}" style="display:none" data-hide="0">
    <div class="wh-wrapper">
        <div class="wh-hd-op-left"></div>
        <div class="wh-container">
            <nav class="wh-info-nav">
                <ul class="wh-i-n-default swiper-wrapper" id="swiper_ul_${tableName}">
                <c:if test="${not empty docXml}">
        			<x:if select="$doc2//subTableList/subTable">
			        	<c:set var="liNum"></c:set>
			        	<x:forEach select="$st/subFieldList" varStatus="xhli">
			        		<c:set var="liNum">${xhli.index+1}</c:set>
	                    	<li <c:if test="${liNum eq 1}">class="col-xs-2 swiper-slide nav-active"</c:if>
	                    	<c:if test="${liNum ne 1}">class="col-xs-2 swiper-slide"</c:if> data-checkbox="check">
	                    		<a href="#stp${liNum}_${tableName}">${liNum}</a><em><i class="fa fa-check-circle"></i></em>
                    		</li>
	                	</x:forEach>
	                </x:if>
                </c:if>
                </ul>
            </nav>
        </div>
        <div class="wh-hd-op-right"></div>
    </div>
</header>
<section class="wh-section wh-section-topfixed wh-section-bottomfixed" id="subSection_${tableName}" style="display:none">
    <article class="wh-edit wh-edit-forum">
        <div class="wh-container" id="subTableContent_${tableName}">
        	<c:if test="${not empty docXml}">
        		<x:if select="$doc2//subTableList/subTable">
		        	<c:set var="subFieldsNum"></c:set>
		        	<x:forEach select="$st/subFieldList" var="ct" varStatus="xh">
		        		<c:set var="subFieldsNum">${xh.index+1}</c:set>
			            <span class="wh-place-holder" id="stp${subFieldsNum}_${tableName}"></span>
						<c:set var="dataId"><x:out select="$ct/dataId/text()"/></c:set>
						<!-- TODO -->
				            <div <c:if test="${subFieldsNum eq 1}">class="wh-edit-lists wh-edit-list-d wh-edit-list-d-fst"</c:if>
				            <c:if test="${subFieldsNum ne 1}">class="wh-edit-lists wh-edit-list-d"</c:if>  
				            id="subTableTemplate_${tableName}">
				            <input name="${tableName}_subdataId" value="${dataId}" type="hidden"/>                
				                <div class="wh-l-ckbox">
				                    <i class="fa fa-check-circle"></i>
				                </div>
				                <div class="wh-r-tbbox">        
				                    <table class="wh-table-edit">
				                    	<c:set var="index" value="0" />
										<x:forEach select="$ct//field" var="field" >
											<c:set var="showtype"><x:out select="$field/showtype/text()"/></c:set>
											<c:set var="readwrite"><x:out select="$field/readwrite/text()"/></c:set>
											<c:set var="fieldtype"><x:out select="$field/fieldtype/text()"/></c:set>
											<c:set var="mustfilled"><x:out select="$field/mustfilled/text()"/></c:set>
											<c:set var="name"><x:out select="$field/name/text()"/></c:set>
					                        <tr>
					                            <th>${name}<c:if test="${mustfilled eq '1'}"><i class="fa fa-asterisk"></i></c:if>：</th>
					                            <td>
													<c:choose>
														<%--单行文本 101--%>
														<c:when test="${showtype =='101' && readwrite =='1'}">
															<c:if test="${ fieldtype == '1000000'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" maxlength="9" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
															</c:if>
															<c:if test="${ fieldtype == '1000001'   }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" maxlength="18" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
															</c:if>
															<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text"  name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
															</c:if>
														</c:when>
						
														<%--密码输入 102--%>
														<c:when test="${showtype =='102' && readwrite =='1'}">
															<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="password" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
														</c:when>
						
														<%--单选 103--%>
														<c:when test="${showtype =='103' && readwrite =='1'}">
															<c:set var="selectedvalue"><x:out select="$field/hiddenval/text()"/></c:set>
															<div class="examine">
																<a class="edit-select edit-ipt-r">
																	<div class="edit-sel-show">
																		<span>请选择</span>
																	</div>    
																	<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_sub_<x:out select="$field/sysname/text()"/>' prompt='<x:out select="$field/value/text()"/>'>
																		<option value="">请选择</option>
																		<x:forEach select="$field//dataList/val" var="selectvalue" >
																			<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
																			<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
																		</x:forEach>
																	</select>
																</a>
															</div>
														</c:when>
						
														<%--多选 104--%>
														<c:when test="${showtype =='104' && readwrite =='1'}">
															<c:set var="selectedvalue">,<x:out select="$field/hiddenval/text()"/></c:set>
															<ul class="tchose">
																<x:forEach select="$field//dataList/val" var="selectvalue" >
																<c:set var="curvalue">,<x:out select="$selectvalue/hiddenval/text()"/>,</c:set>
																<li>
																	<a>
																		<input type="checkbox" name='_sub_<x:out select="$field/sysname/text()"/>' id='checkIput<x:out select="$field/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>' value='<x:out select="$selectvalue/hiddenval/text()"/>,' <c:if test="${fn:indexOf(selectedvalue, curvalue) > -1}">checked="true"</c:if> />
																		<label for='checkIput<x:out select="$field/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>'><x:out select="$selectvalue/showval/text()"/></label>
																	</a>
																</li>
																</x:forEach>
															</ul>
														</c:when>
						
														<%--下拉框 105--%>
														<c:when test="${showtype =='105' && readwrite =='1'}">
															<c:set var="selectedvalue"><x:out select="$field/hiddenval/text()"/></c:set>
															<div class="examine">
																<a class="edit-select edit-ipt-r">
																	<div class="edit-sel-show">
																		<span>请选择</span>
																	</div>    
																	<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_sub_<x:out select="$field/sysname/text()"/>' prompt='<x:out select="$field/value/text()"/>'>
																		<option value="">请选择</option>
																		<x:forEach select="$field//dataList/val" var="selectvalue" >
																			<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
																			<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
																		</x:forEach>
																	</select>
																</a>
															</div>
														</c:when>
						
														<%--日期 107--%>
														<c:when test="${showtype =='107' && readwrite =='1'}">
															<div class="edit-ipt-a-arrow">
																<input data-dateType="date" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' placeholder="选择日期"/>
																<label class="edit-ipt-label" for="scroller"></label>
															</div>
														</c:when>
						
														<%--时间 108--%>
														<c:when test="${showtype =='108' && readwrite =='1'}">
															<div class="edit-ipt-a-arrow">
																<input data-dateType="time" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' placeholder="选择时间"/>
																<label class="edit-ipt-label" for="scroller"></label>
															</div>
														</c:when>
						
														<%--日期 时间 109--%>
														<c:when test="${showtype =='109' && readwrite =='1'}">
															<div class="edit-ipt-a-arrow">
																<input data-dateType="datetime" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' placeholder="选择日期时间"/>
																<label class="edit-ipt-label" for="scroller"></label>
															</div>
														</c:when>
						
														<%--多行文本 110--%>
														<c:when test="${showtype =='110' && readwrite =='1'}">
															<textarea name='_sub_<x:out select="$field/sysname/text()"/>'  onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"><x:out select="$field/value/text()"/></textarea>
															<span class="edit-txta-num">300</span>
														</c:when>
						
														<%--自动编号 111--%>
														<c:when test="${showtype =='111' && readwrite =='1'}">
															<x:out select="$field/value/text()"/>
														</c:when>
						
														<%--html编辑 113--%>
														<c:when test="${showtype =='113' && readwrite =='1'}">
															<textarea name='_sub_<x:out select="$field/sysname/text()"/>'  onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"><x:out select="$field/value/text()"/></textarea>
															<span class="edit-txta-num">300</span>
														</c:when>
						
														<%--附件上传 115--%>
														<c:when test="${showtype =='115'}">
															<c:if test="${readwrite =='1'}">
																<ul class="edit-upload">
										                            <li class="edit-upload-in" onclick="addImg('<x:out select="$field/sysname/text()"/>');"><span><i class="fa fa-plus"></i></span></li>
										                        </ul>
															</c:if>
															<c:set var="values"><x:out select="$field/value/text()"/></c:set>
															<c:if test="${not empty values}">
																<%
																String realFileNames ="";
																String saveFileNames ="";
																String moduleName ="customform";
																String aValues =(String)pageContext.getAttribute("values");
																String[] aval  = aValues.split(";");
																String[] aval0=new String[0];
																String[] aval1=new String[0];
																if(aval[0] != null && aval[0].endsWith(",")) {
																	saveFileNames =aval[0].substring(0, aval[0].length() -1);
																	saveFileNames =saveFileNames.replaceAll(",","|");
																}
																if(aval[1] != null && aval[1].endsWith(",")) {
																	realFileNames =aval[1].substring(0, aval[1].length() -1);
																	realFileNames =realFileNames.replaceAll(",","|");
																}
																%>
																<jsp:include page="../common/include_download.jsp" flush="true">
																	<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
																	<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
																	<jsp:param name="moduleName" value="<%=moduleName%>" />
																</jsp:include>
																<input name="fileNames<x:out select="$field/sysname/text()"/>" value="${values}" type="hidden"/>
															</c:if>
														</c:when>
						
														<%--Word编辑 116--%>
														<c:when test="${showtype =='116'}">
															<c:set var="filename"><x:out select="$field/value/text()"/></c:set>
															<c:if test="${not empty filename}">
																<%
																String realFileNames ="";
																String saveFileNames ="";
																String moduleName ="information";
																realFileNames =(String)pageContext.getAttribute("filename")+".doc";
																saveFileNames =(String)pageContext.getAttribute("filename")+".doc";
																%>
																<jsp:include page="../common/include_download.jsp" flush="true">
																	<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
																	<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
																	<jsp:param name="moduleName" value="<%=moduleName%>" />
																</jsp:include>
															</c:if>
															<c:if test="${empty filename && readwrite =='1'}">
																该字段暂不支持手机办理，请于电脑端操作。
															</c:if>
														</c:when>
						
														<%--Excel编辑 117--%>
														<c:when test="${showtype =='117'}">
															<c:set var="filename"><x:out select="$field/value/text()"/></c:set>
															<c:if test="${not empty filename}">
																<%
																String realFileNames ="";
																String saveFileNames ="";
																String moduleName ="information";
																realFileNames =(String)pageContext.getAttribute("filename")+".xls";
																saveFileNames =(String)pageContext.getAttribute("filename")+".xls";
																%>
																<jsp:include page="../common/include_download.jsp" flush="true">
																	<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
																	<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
																	<jsp:param name="moduleName" value="<%=moduleName%>" />
																</jsp:include>
															</c:if>
															<c:if test="${empty filename && readwrite =='1'}">
																该字段暂不支持手机办理，请于电脑端操作。
															</c:if>
														</c:when>
						
														<%--WPS编辑 118--%>
														<c:when test="${showtype =='118'}">
															<c:set var="filename"><x:out select="$field/value/text()"/></c:set>
															<c:if test="${not empty filename}">
																<%
																String realFileNames ="";
																String saveFileNames ="";
																String moduleName ="information";
																realFileNames =(String)pageContext.getAttribute("filename")+".wps";
																saveFileNames =(String)pageContext.getAttribute("filename")+".wps";
																%>
																<jsp:include page="../common/include_download.jsp" flush="true">
																	<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
																	<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
																	<jsp:param name="moduleName" value="<%=moduleName%>" />
																</jsp:include>
															</c:if>
															<c:if test="${empty filename && readwrite =='1'}">
																该字段暂不支持手机办理，请于电脑端操作。
															</c:if>
														</c:when>
						
														<%--当前日期 204--%>
														<c:when test="${showtype =='204' && readwrite =='1'}">
															<x:out select="$field/value/text()"/>
															<input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
														</c:when>
						 
														<%--登录人信息 --%>
														<c:when test="${( showtype =='213' || showtype =='215'|| showtype =='406'|| showtype =='601'|| showtype =='602'|| showtype =='603'|| showtype =='604'|| showtype =='605'|| showtype =='607'|| showtype =='701'|| showtype =='702'|| showtype =='201'|| showtype =='202' || showtype =='207'  ) && readwrite =='1'}">
															<x:out select="$field/value/text()"/><input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>'  value='<x:out select="$field/value/text()"/>' />
														</c:when>
						
														<%--单选人 全部 210--%>
														<c:when test="${showtype =='210' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>' name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$field/sysname/text()"/>","_sub_<x:out select="$field/sysname/text()"/>","*0*","user")' placeholder="请选择"/>
														</c:when>
						
														<%--多选人 全部 211--%>
														<c:when test="${showtype =='211' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$field/sysname/text()"/>","_sub_<x:out select="$field/sysname/text()"/>","*0*","user");' placeholder="请选择"/>
														</c:when>
						
														<%--单选组织 212--%>
														<c:when test="${showtype =='212' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$field/sysname/text()"/>","_sub_<x:out select="$field/sysname/text()"/>","*0*","org");' placeholder="请选择"/> 
														</c:when>
						
														<%--多选组织 214--%>
														<c:when test="${showtype =='214' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$field/sysname/text()"/>","_sub_<x:out select="$field/sysname/text()"/>","*0*","org");' placeholder="请选择"/>
														</c:when>
						
														<%--金额 301--%>
														<c:when test="${showtype =='301' && readwrite =='1'}">
															<c:if test="${fieldtype == '1000000' || fieldtype == '1000001'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
															</c:if>
															<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
															</c:if>
														</c:when>
						
														<%--金额大写 302--%>
														<c:when test="${showtype =='302' && readwrite =='1'}">
															<input class="edit-ipt-r" readonly type="text" maxlength="18" id='<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
														</c:when>
						
														<%--批示意见 401--%>
														<c:when test="${showtype =='401' }">
															<c:if test="${readwrite =='1' }">
																<textarea class="edit-txta edit-txta-l" placeholder="请输入" name="comment_input" id="comment_input" maxlength="50"></textarea>
																<div class="examine" style="text-align:right;">
																	<a class="edit-select edit-ipt-r">
																		<div class="edit-sel-show">
																			<span>常用审批语</span>
																		</div>    
																		<select class="btn-bottom-pop" onchange="selectComment(this);">
																			<option value="">常用审批语</option> 
																			<option value="同意">同意</option>
																			<option value="已阅">已阅</option>
																		</select>
																	</a>
																</div>
															</c:if>
															<c:if test="${readwrite =='0' }">
																<x:forEach select="$field//dataList/comment" var="ct" >
																	<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
																</x:forEach>
															</c:if>
														</c:when>
						
														<%--当前日期时间 703--%>
														<c:when test="${showtype =='703' && readwrite =='1'}">
															<x:out select="$field/value/text()"/>
															<input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
														</c:when>
						
														<%--单选人 本组织 704--%>
														<c:when test="${showtype =='704' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
															<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>' name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","_mainShow_<x:out select="$field/sysname/text()"/>","_sub_<x:out select="$field/sysname/text()"/>","*<%=orgId%>*","user");'/>
														</c:when>
														
														<%--多选人 本组织 705--%>
														<c:when test="${showtype =='705' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
															<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","_mainShow_<x:out select="$field/sysname/text()"/>","_sub_<x:out select="$field/sysname/text()"/>","*<%=orgId%>*","user");'/>
														</c:when>
						
														<%--流程发起人 708--%>
														<c:when test="${showtype =='708' && readwrite =='1'}">
															<x:out select="$field/value/text()"/><input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>'  value='<x:out select="$field/value/text()"/>' />
														</c:when>
														<%--日期时间计算 808--%>
														<c:when test="${showtype =='808' && readwrite =='1'}">
															该字段暂不支持手机办理，请于电脑端操作。
														</c:when>
														<c:otherwise>
															<c:set var="index" value="${index+1}"/>
															<x:out select="$field/value/text()"/>
														</c:otherwise>
													</c:choose>
												</td>
					                        </tr>
						                </x:forEach>
				                    </table>
				                </div>
			                </div>
					</x:forEach>
        		</x:if>
			</c:if>
        </div>
    </article>
</section>
<footer class="wh-footer wh-footer-forum" id="subFooter_${tableName}" style="display:none">
    <c:choose>
    	<c:when test="${index eq '0'}">
		    <div class="wh-wrapper">
		        <div class="wh-container">
		            <div class="wh-footer-btn">
		                <a href="javascript:deleteSubTableForm();" class="fbtn-cancel col-xs-4"><i class="fa fa-times"></i>删除</a>
		                <a href="javascript:addSubTableForm();" class="fbtn-matter col-xs-4"><i class="fa fa-plus"></i>添加</a>
		                <a href="javascript:finishSubTableForm();" class="fbtn-matter col-xs-4"><i class="fa fa-check-square"></i>完成<em id="em_num_${tableName}">${empty subFieldsNum ? '1' : subFieldsNum}</em></a>
		            </div>
		        </div>
		    </div>
    	</c:when>
    	<c:otherwise>
		    <div class="wh-wrapper">
		        <div class="wh-container">
		            <div class="wh-footer-btn">
		                <a href="javascript:finishSubTableForm2();" class="fbtn-matter col-xs-12">
		                	<i class="fa fa-check-square"></i>完成
		                </a>
		            </div>
		        </div>
		    </div>
    	</c:otherwise>
    </c:choose>
</footer>
</x:forEach>
</c:if>
<script type="text/javascript">
    function showSubOperate(){
    	//水平滑动
        var infoNavswiper = new Swiper('.wh-info-nav', {
            slidesPerView: 5,
            paginationClickable: true,
            spaceBetween: 0,
            freeMode: true
        });
        //var infoNavli = $('.wh-info-nav .wh-i-n-default li');
        //infoNavli.first().addClass("nav-active");
		bindSelect();
    }
    
    //绑定选择方法
    function bindSelect(){
    	var $ckBoxs = $('.wh-l-ckbox');
    	$ckBoxs.unbind('click');
 	    $ckBoxs.click(function(){
            var $ckBox = $(this);
            if($ckBox.hasClass('ckbox-active')){
	            $ckBox.removeClass('ckbox-active');
            }else{
	            $ckBox.addClass('ckbox-active');
            }
        });
    }
    
    var subTableTemplate;
    var subTableName;
    //添加子表数据
    function addSubTable(subTableNameParam){
    	$('#subTableFlag').val(subTableNameParam);
    	subTableName = subTableNameParam;
    	$('#mainContent').hide();
		$('#footerButton').hide();
		$('[id="subHeader_'+subTableNameParam+'"]').show();
		$('[id="subSection_'+subTableNameParam+'"]').show();
		$('[id="subFooter_'+subTableNameParam+'"]').show();
		showSubOperate();
		var $firstDataId = $('[id="subTableTemplate_'+subTableNameParam+'"] input').eq(0);
		var dataIdVal = $firstDataId.val();
		$firstDataId.val('');
		subTableTemplate = $('[id="subTableTemplate_'+subTableNameParam+'"]').html();
		$firstDataId.val(dataIdVal);
    }
    
    //添加子表表单
    function addSubTableForm(){
    	var $swiperUl = $('[id="swiper_ul_'+subTableName+'"]');
    	var menuIndex = $swiperUl.find('li').length + 1;
    	$('[id="subTableContent_'+subTableName+'"]').append('<span class="wh-place-holder" id="stp'+menuIndex+'_'+subTableName+'"></span>' +
    	'<div class="wh-edit-lists wh-edit-list-d">'+subTableTemplate+'</div>');
    	$('.wh-l-ckbox').unbind('click');
    	//var menuLi = '<li class="col-xs-2 swiper-slide" data-checkbox="check">' +
    				 //'<a href="#stp'+menuIndex+'_'+subTableName+'">' + menuIndex + '</a><em><i class="fa fa-check-circle"></i></em></li>';
    	//$swiperUl.append(menuLi);
    	restructureLi($swiperUl);
    	bindSelect();
    	setNewId();
    	var $emNumber = $('[id="em_num_'+subTableName+'"]');
    	$emNumber.html(parseInt($emNumber.text())+parseInt(1));
    }
    
    //设置新表单域的id
    function setNewId(){
    	var tableIndex = 0;
    	var oldId;
    	var clickContent;
    	var clickConArray;
    	var newClickContent = '';
    	$('[id="subTableContent_'+subTableName+'"] table').each(function(){
    		tableIndex ++;
    		newClickContent = '';
    		$(this).find('input,select,textarea').each(function(){
    			clickContent = $(this).attr('onclick');
    			if(clickContent && clickContent.indexOf('selectUser') != -1){
	    			clickConArray = clickContent.split(',');
	    			for(var i=0,length=clickConArray.length;i<length;i++){
	    				if(i == 1 || i == 2){
		    				newClickContent += clickConArray[i].substring(0,clickConArray[i].length-1)+'_'+tableIndex+'_"';
	    				}else{
	    					newClickContent += clickConArray[i];
	    				}
	    				if(i < length-1){
	    					 newClickContent +=  ','
	    				}
	    			}
	    			$(this).attr('onclick',newClickContent);
    			}
    			oldId = $(this).attr('id');
    			if(oldId){
	    			if(oldId.substring(oldId.length-1) == '_'){
	    				return;
	    			}
	    			$(this).attr('id',oldId+'_'+tableIndex+'_');
    			}
   			});
   		});
    }
    
    //删除子表表单
    function deleteSubTableForm(){
    	var $ckboxActive = $('.wh-l-ckbox.ckbox-active');
    	if($ckboxActive.length <= 0){
    		alert('请选择需要删除的子表表单！');
    		return;
    	}
    	var $ckboxDiv;
    	//var aHrefVal;
    	$ckboxActive.each(function(){
    		$ckboxDiv = $(this);
    		//aHrefVal = '#'+$ckboxDiv.parent().prev().attr('id');
    		$ckboxDiv.parent().prev().remove();
    		$ckboxDiv.parent().remove();
    		//$('a[href="'+aHrefVal +'"]').parent().remove();
    	});
   		restructureLi($('[id="swiper_ul_'+subTableName+'"]'));
    	var $emNumber = $('[id="em_num_'+subTableName+'"]');
    	$emNumber.html($('[id="swiper_ul_'+subTableName+'"] li').length);
    }
    
    //添加完成子表表单
    function finishSubTableForm(){
    	$('#mainContent').show();
		$('#footerButton').show();
		$('[id="subHeader_'+subTableName+'"]').hide();
		$('[id="subSection_'+subTableName+'"]').hide();
		$('[id="subFooter_'+subTableName+'"]').hide();
		$('[id="subTableInput_'+subTableName+'"]').val($('[id="swiper_ul_'+subTableName+'"] li').length+'条子表记录');
    }
        
    function finishSubTableForm2(){
    	$('#mainContent').show();
		$('#footerButton').show();
		$('[id="subHeader_'+subTableName+'"]').hide();
		$('[id="subSection_'+subTableName+'"]').hide();
		$('[id="subFooter_'+subTableName+'"]').hide();
    }
    
    //重构头部li
    function restructureLi($swiperUl){
    	var menuLi = '';
    	$('[id="swiper_ul_'+subTableName+'"] li').remove();
    	$('[id="subTableContent_'+subTableName+'"] span[id^="stp"]').each(function(index){
    		if(index == 0){
	    		menuLi = '<li class="col-xs-2 swiper-slide nav-active" data-checkbox="check">' +
	    				 '<a href="#'+$(this).attr('id')+'">' + parseInt(index+1) + '</a><em><i class="fa fa-check-circle"></i></em></li>';
    		}else{
    			menuLi = '<li class="col-xs-2 swiper-slide" data-checkbox="check">' +
	    				 '<a href="#'+$(this).attr('id')+'">' + parseInt(index+1) + '</a><em><i class="fa fa-check-circle"></i></em></li>';
    		}
    		$swiperUl.append(menuLi);
    	});
   	 	//水平滑动
        var infoNavswiper = new Swiper('.wh-info-nav', {
            slidesPerView: 5,
            paginationClickable: true,
            spaceBetween: 0,
            freeMode: true
        });
    	var $swiperLis = $('[id="swiper_ul_'+subTableName+'"] li');
    	$swiperLis.unbind('click');
    	$swiperLis.click(function(){
    		var $swiperLi = $(this);
    		$swiperLis.not(this).removeClass('nav-active').data("checkbox","uncheck");
            $swiperLi.addClass('nav-active').data("checkbox","check");
    	});
    }
</script>

