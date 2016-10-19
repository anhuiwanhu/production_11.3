  <s:hidden value="%{#request.mySkin}" id="mySkinOld" />
  <s:hidden name="mySkin" id="mySkin"  value="%{#request.mySkin}" /> 
	<!--换肤专用-->
	<div class="wh-sys-skin-dialog">
		<div class="wh-sys-skin-model clearfix" >
			<div id="whSkinImg" class="wh-skin-model-img wh-skin-default"></div>
			<div class="wh-sys-setting-skin-section ">
				<div class="wh-sys-setting-skinlist clearfix" id="personal_skinchoose_div">
					<p class="current" data-color="default" skinValue="2015/color_default">
						<span class="skin-color-style skin-default"><i class="fa fa-check-circle"></i></span>
						<em>简蓝</em>
					</p>
					<p data-color="orange" skinValue="2015/color_orange">
						<span class="skin-color-style skin-orange"><i class="fa fa-check-circle"></i></span>
						<em>简橙</em>
					</p>
					<p data-color="green"  skinValue="2015/color_green">
						<span class="skin-color-style skin-green"><i class="fa fa-check-circle"></i></span>
						<em>简绿</em>
					</p>
					<p data-color="linepurple" skinValue="2015/color_linepurple">
						<span class="skin-line-style skin-linepurple"><i class="fa fa-check-circle"></i></span>
						<em>线紫</em>
					</p>
					<p data-color="lineorange" skinValue="2015/color_lineorange">
						<span class="skin-line-style skin-lineorange"><i class="fa fa-check-circle"></i></span>
						<em>线橙</em>
					</p>
					<p data-color="linered"  skinValue="2015/color_linered">
						<span class="skin-line-style skin-linered"><i class="fa fa-check-circle"></i></span>
						<em>线红</em>
					</p>
					<p data-color="pureblue"   skinValue="2015/color_pureblue">
						<span class="skin-pure-style skin-pureblue"><i class="fa fa-check-circle"></i></span>
						<em>纯蓝</em>
					</p>
					<p data-color="puregreen"  skinValue="2015/color_puregreen">
						<span class="skin-pure-style skin-puregreen"><i class="fa fa-check-circle"></i></span>
						<em>纯绿</em>
					</p>
					<p data-color="seablue"  skinValue="2015/color_seablue">
						<span class="skin-pure-style skin-seablue"><i class="fa fa-check-circle"></i></span>
						<em>海蓝</em>
					</p> 
				</div>
			</div> 
		</div>
		<div class="skin-ok-button clearfix" onClick="ok(0,this);" ><span><s:text name="comm.save"/></span></div>
	</div>  