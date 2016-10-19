/**
 * 
 * @authors Your Name (you@example.org)
 * @date    2013-12-16 14:48:54
 * @version $Id$
 */

(function($){

/*	
* 锚点跟随效果
*
**/ 	
	$.fn.follow = function(options){
		var defaults = {
			sAnchor: null, //特定段落集合
			isAlone: true, //是否单独样式 
			fwActiveClass: "active", //默认选中样式 
			ieFreshFix: true, //ie锚点失效
			sSlipping: true, //平滑滑动
			sTarget:"href", //用以绑定元素的标签属性，可以自定义属性
			sTime:1000 //动画时间
		}
		var setings = $.extend({}, defaults, options || {});
	 	var oAnchor = $(setings.sAnchor);
		var mdHeight;
		var arrMh = [];
		for(var i = 0, len = oAnchor.length;i<len;i++){
			mdHeight = $(oAnchor[i]).offset().top;
			arrMh.push(mdHeight);
		}
		
		// 通过定义父级的样式，来区别不同的样式
		var _boxLi = $(this).parent();
		var timeId =0;
		return this.each(function(z) {
			
			var pluginObj = {

		 		//跟随动作
		 		fnFollow: function(){
					var scrollH = $(window).scrollTop();
					
					for(var k=0; k<arrMh.length; k++){
						if(arrMh[k] <= scrollH){
							this.fnUpdateStyle(k);
						}
					}
		 		},
		 		//更新样式
		 		fnUpdateStyle: function(j){
		 			var index = j +1;
			 		 if(setings.isAlone){
			 		 	_boxLi.removeClass(setings.fwActiveClass)
			 		  	.eq(j).addClass(setings.fwActiveClass);
			 		 }else{
			 		 		var reg = new RegExp(setings.fwActiveClass+"[\\d]","g");
			 		 		_boxLi.attr('class', function(){

			 		 			return $.trim($(this).attr('class').replace(reg,''));
			 		 		});
				 		 	_boxLi.eq(j).addClass(setings.fwActiveClass + index); 
			 		 	
				 	}
		 		 
		 		},
		 		// 初始化
		 		fnInit: function(){
		 			var that = this;
		 			$(window).on('scroll', function(){
		 				that.fnFollow();
		 			});
		 		}
	 		}

	 	pluginObj.fnInit();
	  });

	}

})(jQuery);