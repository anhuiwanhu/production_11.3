<%
 int  _desktop_menu_jeduanInt=30;

 if(whir_locale!=null&&(whir_locale.toLowerCase().equals("zh_cn")||whir_locale.toLowerCase().equals("zh_tw"))){
	 _desktop_menu_jeduanInt=7;
 }
%>
<dl class="wh-hd-l-nav  fl clearfix"  id="show_menu_top_dl">
	<dd class="wh-hd-l-gateway"   id="desktop_choosegateway_dd">
		<a href="javascript:void(0)" class="wh-hd-la"  onclick="openDesktopNew();"  id="desktop_choosegateway_a"><i class="fa fa-home fa-color"></i><span><%=Resource.getValue(local,"common","comm.homepage")%></span><i class="fa fa-angle-down fa-color fa-gateway"></i></a>
		<div class="wh-hd-l-gateway-info" id="gateway_div">
		   <div class="clearfix">
<% 
  if(layoutList!=null&&layoutList.size()>0){
	 for(int i=0;i<layoutList.size();i++){
		 Object[] lobj = (Object[])layoutList.get(i);
		 if(lobj[3]!=null&&"个人首页".equals(lobj[3].toString())){					 
		 }else{
%>
		 <a href="javascript:void(0);" id="Layout<%=lobj[0]%>"  onClick="javascript:selectLayout('<%=lobj[0]%>');" title="<%=lobj[2]%>" ><i class="fa fa-home-select"></i><span class="wh-hd-lspan"  title="<%=lobj[2]%>"><%=lobj[2]%></span></a>
<%		 } 
	 }           
  }
%>
			<!-- <a href="javascript:void(0);" class="current"><i class="fa fa-home fa-color"></i><span class="wh-hd-lspan">万户集团门户</span><i class="fa fa-home-select"></i></a>
			<a href="javascript:void(0);"><i class="fa fa-home fa-color"></i><span class="wh-hd-lspan">行政服务门户</span><i class="fa fa-home-select"></i></a>
			<a href="javascript:void(0);"><i class="fa fa-home fa-color"></i><span class="wh-hd-lspan">营销中心门户</span><i class="fa fa-home-select"></i></a> -->
		    </div>
			<div class="hr-personal-gateway"> 
				<span><%=Resource.getValue(local,"common","comm.mylayout")%></span>
			</div>
			<div class="clearfix"> 
			    <% 
				  String defaultMyLayoutId="";
				  if(layoutList!=null&&layoutList.size()>0){
					 String  nowClass="";
					 for(int i=0;i<layoutList.size();i++){
						 Object[] lobj = (Object[])layoutList.get(i);
						 if(lobj[3]!=null&&"个人首页".equals(lobj[3].toString())){
							 if(defaultMyLayoutId.equals("")){
								 defaultMyLayoutId=""+lobj[0];
							 }
							 //判断是否是默认
							 if(lobj.length>5&&lobj[6]!=null&&"1".equals(lobj[6].toString())){
								 // nowClass="class=\"current\"";
								  nowClass=" fa-home-select";
								  defaultMyLayoutId=""+lobj[0];
							 }else{
								 nowClass="";
							 }  
							
				%>   
						  <a href="javascript:void(0);" id="Layout<%=lobj[0]%>"  onClick="javascript:selectLayout('<%=lobj[0]%>');" title="<%=lobj[2]%>" ><i class="fa fa-home-select"></i><span class="wh-hd-lspan"  title="<%=lobj[2]%>"><%=lobj[2]%></span></a>  

				<%		 } 
					 }           
				  }
				%>  
				<input type="hidden" name="desktop_hidden_defaultMyLayoutId" id="desktop_hidden_defaultMyLayoutId" value="<%=defaultMyLayoutId%>">
				<input type="hidden" name="desktop_hidden_isfirstClick" id="desktop_hidden_isfirstClick" value="<%=_isfirstClick%>"> 			
			 </div> 
		</div>
	</dd>
<%
  if(outMenuList!=null && outMenuList.size()>0){
      for(int i=0;i<outMenuList.size();i++){
		  Object[] menuObj = (Object[])outMenuList.get(i);
		  String _leftUrl = menuObj[1] + "";
		  if(isPad&&_leftUrl.indexOf("/GovDoc!menu.action")>-1){//Pad版屏蔽 公文管理 菜单
			  continue;
		  }

		  //右边连接地址
		  String _rightUrl = menuObj[2] + "";
		  String modulePortalID = null;
          
		  //菜单code
		  String menuCode=menuObj[6]+"";
		  //菜单信息   ｛模块的门户code,  图片,  模块门户的其它信息（layoutType）｝
	      String []menuInfoobj=menubaseMape.get(menuCode);

		  //菜单显示名
		  String menuName=menuObj[0].toString();

		  //打开主地址的 类型    iframe :主iframe打开     new:新窗口打开
		  String openMainType="iframe";

		  String layoutType = "";
		  
		  //样式 
		  String menuClass="fa-custom-mod";
		  if(menuInfoobj!=null){
			  menuClass=menuInfoobj[1];
		  }


		  if("1".equals(menuObj[3].toString())){
			  //获取模块门户url
			
			  if(menuInfoobj!=null){
                  modulePortalID=""+modulePortal.get(menuInfoobj[0]);
				  layoutType = menuInfoobj[2];
			  }  
			  if(modulePortalID!=null&&!"".equals(modulePortalID)&&!"null".equals(modulePortalID)){
				  _rightUrl = "platform/portal/portal_main.jsp?preview=1&id="+modulePortalID+layoutType;
			  }

			  if(menuObj[6].toString().toUpperCase().indexOf("CHANNEL")>=0){
				  menuName=menuObj[0].toString();
			  }else{
				  menuName=Resource.getValue(local,"common","comm."+menuObj[6].toString());
			  }
						
		  }else{
			   if(menuObj[6]!=null&&menuObj[6].toString().toUpperCase().indexOf("CHANNEL")>=0){
				   //
				   if(modulePortal.get(menuObj[4]+"")!=null){
					   modulePortalID = ""+modulePortal.get(menuObj[4]+"");
				   }
				   if(modulePortalID!=null&&!"".equals(modulePortalID)&&!"null".equals(modulePortalID)){
					   _rightUrl = "platform/portal/portal_main.jsp?preview=1&id="+modulePortalID;
				   }
			   }else{
				    if(menuObj.length>7&&menuObj[7]!=null){
						  String action = new CustomerMenuDB().getTopMenuAction(menuObj[4]+"",request);
						  if ("1".equals(menuObj[7]+"")) {
							  openMainType="new";
							  _rightUrl=action; 
						  }else{
							  if(action.indexOf("custormerbiz!goRightMenu")==-1){
								  action = rootPath+"/custormerbiz!ssoLink.action?menuId="+menuObj[4];
							  }
							  _leftUrl=rootPath+"/custormerbiz!goLeftMenu.action?menuId="+menuObj[4]+"&menuName="+menuName;
							  _rightUrl=action; 
						  } 
					}else{
						menuName="";
					}
			   }
							 
		  }

          if(menuCode!=null&&(menuCode.indexOf("workflowChannel")>=0||menuCode.indexOf("userChannel")>=0)){
		      _leftUrl+="&menuName="+menuName; 
		  }

		  if(_leftUrl.indexOf("&leftNeedIframe=1")>=0||_leftUrl.indexOf("http:")==0||_leftUrl.indexOf("/platform/system/transcenter/loginCheck.jsp")>=0||_leftUrl.indexOf("jump.jsp")>=0){ 
			  if(_leftUrl.indexOf("?")>=0){
				  _leftUrl+="&menuName="+menuName; 
			  }else{
				  _leftUrl+="?menuName="+menuName; 
			  } 
		  }

		  if(menuName!=null&&!menuName.equals("")&&!menuName.equals("null")){
			  String shortMenuName=menuName;
			  if(menuName.length()>_desktop_menu_jeduanInt){
				  shortMenuName=menuName.substring(0,_desktop_menu_jeduanInt);
			  }
	  %>  
		   <dd id="dd_menu_<%=menuCode%>"><a href="#"   onclick="<%if(openMainType.equals("iframe")){%>jumpnew('<%=_leftUrl%>','<%=_rightUrl%>');<%}else{%>window.open('<%=_rightUrl%>');<%}%>return false;" id="menu_<%=menuCode%>" menuId="<%=menuObj[4]%>" title="<%=menuName%>"><i class="fa <%=menuClass%> fa-color"></i><span><%=shortMenuName%></span></a></dd>
	  <%
		  }
	  }
  }	 
%>
	 
	 <dd class="wh-hd-menu-btn wh-hd-menu-btn-se"  id="menu_hidden_dd" >
		<a href="javascript: void(0);" class="wh-hd-menu-btn-a wh-hd-la"><i class="fa fa-th-large fa-color"></i></a>
		<!-- 自定义菜单-->
		<div class="wh-hd-custom-switch">
			<div class="wh-hd-custom-menu clearfix">
			  <div class="wh-hd-cmcontainer" id="menu_hidden_div"> 
				<ul id="menu_hidden_ul">
				 <% //
				 if(inboxMenuList!=null && inboxMenuList.size()>0){
					 //菜单
					 for(int i=0;i<inboxMenuList.size();i++){
						 Object[] menuObj = (Object[])inboxMenuList.get(i);
						 String _leftUrl = menuObj[1] + "";
						 if(isPad&&_leftUrl.indexOf("/GovDoc!menu.action")>-1){//Pad版屏蔽 公文管理 菜单
							continue;
						 }
						  //右边连接地址
						 String _rightUrl = menuObj[2] + "";
						 String modulePortalID = null;//模块门户
	 
						 //菜单code
						 String menuCode=menuObj[6]+"";
						 //菜单信息   ｛模块的门户code,  图片,  模块门户的其它信息（layoutType）｝
						 String []menuInfoobj=(String[])menubaseMape.get(menuCode);

						 //菜单显示名
						 String menuName=menuObj[0].toString();

						 //打开主地址的 类型    iframe :主iframe打开     new:新窗口打开
						 String openMainType="iframe";

						 String layoutType = "";
						  
						 //样式 
						 String menuClass="fa-custom-mod";
						 if(menuInfoobj!=null){
							 menuClass=menuInfoobj[1];
						 }
						 if("1".equals(menuObj[3].toString())){
						  //获取模块门户url
						
						  if(menuInfoobj!=null){
							  modulePortalID=""+modulePortal.get(menuInfoobj[0]);
							  layoutType = menuInfoobj[2];
						  }  
						  if(modulePortalID!=null&&!"".equals(modulePortalID)&&!"null".equals(modulePortalID)){
							  _rightUrl = "platform/portal/portal_main.jsp?preview=1&id="+modulePortalID+layoutType;
						  }

						  if(menuObj[6].toString().toUpperCase().indexOf("CHANNEL")>=0){
							  menuName=menuObj[0].toString();
						  }else{
							  menuName=Resource.getValue(local,"common","comm."+menuObj[6].toString());
						  }
									
					  }else{
						   if(menuObj[6]!=null&&menuObj[6].toString().toUpperCase().indexOf("CHANNEL")>=0){
							   //
							   if(modulePortal.get(menuObj[4]+"")!=null){
								   modulePortalID = ""+modulePortal.get(menuObj[4]+"");
							   }
							   if(modulePortalID!=null&&!"".equals(modulePortalID)&&!"null".equals(modulePortalID)){
								   _rightUrl = "platform/portal/portal_main.jsp?preview=1&id="+modulePortalID;
							   }
						   }else{
								if(menuObj.length>7&&menuObj[7]!=null){
									  String action = new CustomerMenuDB().getTopMenuAction(menuObj[4]+"",request);
									  if ("1".equals(menuObj[7]+"")) {
										  openMainType="new";
										  _rightUrl=action; 
									  }else{
										  if(action.indexOf("custormerbiz!goRightMenu")==-1){
											  action = rootPath+"/custormerbiz!ssoLink.action?menuId="+menuObj[4];
										  }
										  _leftUrl=rootPath+"/custormerbiz!goLeftMenu.action?menuId="+menuObj[4]+"&menuName="+menuName;
										  _rightUrl=action; 
									  } 
								}else{
									menuName="";
								}
						   }
										 
					  }
                    

					  if(menuCode!=null&&(menuCode.indexOf("workflowChannel")>=0||menuCode.indexOf("userChannel")>=0)){
						  _leftUrl+="&menuName="+menuName; 
					  }

					  if(_leftUrl.indexOf("&leftNeedIframe=1")>=0||_leftUrl.indexOf("http:")==0||_leftUrl.indexOf("/platform/system/transcenter/loginCheck.jsp")>=0||_leftUrl.indexOf("jump.jsp")>=0){ 
						  if(_leftUrl.indexOf("?")>=0){
							  _leftUrl+="&menuName="+menuName; 
						  }else{
							  _leftUrl+="?menuName="+menuName; 
						  } 
					  }
					  if(menuName!=null&&!menuName.equals("")&&!menuName.equals("null")){

						  String shortMenuName=menuName;
						  if(menuName.length()>_desktop_menu_jeduanInt){
							  shortMenuName=menuName.substring(0,_desktop_menu_jeduanInt);
						  }
	%>  
					  <li><div class="wh-hd-custom-menu-d"><a href="#" onclick="<%if(openMainType.equals("iframe")){%>jumpnew('<%=_leftUrl%>','<%=_rightUrl%>');<%}else{%>window.open('<%=_rightUrl%>');<%}%>return false;" id="menu_<%=menuCode%>"  menuId="<%=menuObj[4]%>" title="<%=menuName%>"><i class="fa <%=menuClass%> fa-color"></i><span><%=shortMenuName%></span></a></div></li>
					  
	<%              }
				  }
			   }
							 
	%> 
				 </ul>
			   </div>
			   <a href="javascript:void(0)" class="wh-hd-custom-menu-btn"><i class="fa fa-circle-o"></i><span><%=Resource.getValue(local,"common","comm.customMenu")%></span></a>
			</div>

			<!-- <div class="wh-hd-menu-add-cut"  id="desktop_edit_menu_div" >
				<div class="wh-hd-menu-cut clearfix">
					<a href="javascript:void(0)" class="prev"><i class="fa fa-angle-left"></i></a>
					<div class="wh-hd-menu-cut-slide" id="edit_menu_top_div">
						<ul id="edit_menu_top_ul"></ul>
					</div>
				</div>
				<div class="wh-hd-menu-add" id="edit_menu_bottom_div">
					<ul class="wh-hd-menu-list" id="edit_menu_bottom_ul"></ul>
				</div>
			</div>
             -->


			<div class="wh-hd-menu-add-cut" > 
				<div class="wh-hd-menu-add">
					<a href="javascript:void(0)" class="prev"><i class="fa fa-angle-left"></i></a>
					<ul class="clearfix wh-hd-menu-list"  id="desktop_edit_ul"></ul>
				</div>
			</div>   
		</div>
		<!-- end-->
	</dd>
</dl>