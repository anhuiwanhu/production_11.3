/*-------------------------------------------------------*/
//股票
/*-------------------------------------------------------*/
/*--------------------portlet---------start--------------*/
var stock = {
	options: {},
	portletAdd: function(opts){
		var portletSettingId = opts.portletSettingId;
		var isNew = opts.isNew?opts.isNew:false;
		var flag = opts.flag;
		var refreshTime = '';
		if(!isNew){
			var result = ajaxResponseXML(portletSettingId);
			if($('portletSettings', result).length > 0){
				var ps = $('portletSettings', result).eq(0);
				opts = Portlet.getCommonOpts(ps, opts);

				var stockCode = $(ps).find('stockCode:first').text();
				refreshTime = $(ps).find('refreshTime:first').text();

				var stock_price = $(ps).find('stock_price:first').text();
				var stock_zdl = $(ps).find('stock_zdl:first').text();
				var stock_cjl = $(ps).find('stock_cjl:first').text();
				var stock_cje = $(ps).find('stock_cje:first').text();
				
				opts = $.extend(opts, {stockCode:stockCode, stock_price:stock_price, stock_zdl:stock_zdl, stock_cjl:stock_cjl, stock_cje:stock_cje});
			}
		}

		var p = Portlet.addPortlet(opts);

		if(flag == 0){
			if(refreshTime!=''&&!isNaN(refreshTime)){
				var pid = p.attr('id');
				window.setInterval(function(){stock.refresh($('#content_'+pid), opts);}, parseInt(refreshTime)*1000);
			}
		}

		return p;
	},
	refresh: function(target, opts){
		var data = '';//'sh600010,sh600016,sh601899,sz000002';
		if(opts.stockCode){
			data = opts.stockCode;
			var code="";
			$.each(data.split(','), function(i, stockCode){
				if(stockCode!="" && null!=stockCode){
					var upper=/[A-Z]+[0-9]+/g; 
					var lower=/[a-z]+[0-9]+/g;
					if(upper.test(stockCode)){
						code+=stockCode.toLocaleLowerCase()+",";
					}else if(lower.test(stockCode)){
						code+=stockCode+",";
					}else{
						code+="sh"+stockCode+",";
					}
				}
			});
			data = code.substring(0, code.length-1);
		}
		var htmlContent = '<div class="wh-portal-shares"><ul id="stockTable_'+opts.portletSettingId+'" class="wh-p-shares-list">';

		if(data!=''){
			Portlet.updating(target);
			$.ajax({
				type: 'GET',
                cache: true,
				url: 'http://hq.sinajs.cn/list='+data,
				dataType: 'script',
				scriptCharset: 'gb2312',
				success: function(response) {
					var innerHTML = '';
					$.each(data.split(','), function(i, stockCode){
						var str = eval('hq_str_'+stockCode);
						var code = stockCode;//.substring(2);
						var d = str.split(',');
						var length = d.length;
						
						var linkurl = 'http://finance.sina.com.cn/realstock/company/'+code+'/nc.shtml';

						innerHTML += '<li><div class="wh-p-shares-title clearfix"><h3><i class="fa fa-line-chart"></i><a href="'+linkurl+'" title="'+d[0].replace(/\"/g,"&quot;")+'" target="_blank">'+d[0]+'&nbsp;'+code+'</a></h3></div>';
						innerHTML += '<div class="wh-p-shares-detail"><table cellspacing="0" cellpadding="0" border="0">';
						innerHTML += '<tr><td>当前价格：</td><td><i>'+d[3]+'</i></td></tr>';
						innerHTML += '<tr><td>今日开盘价：</td><td><i>'+d[1]+'</i></td></tr>';
						innerHTML += '<tr><td>昨日收盘价：</td><td><i>'+d[2]+'</i></td></tr>';
						innerHTML += '<tr><td>当前时间：</td><td><i>'+d[length-3]+'&nbsp;'+d[length-2]+'</i></td></tr>';
						innerHTML += '</table></div></li>';
					});
					if(innerHTML!=''){
						$('#stockTable_'+opts.portletSettingId).html('');
						$(innerHTML).appendTo($('#stockTable_'+opts.portletSettingId));
						Portlet.setPortletTitle(target,opts.title);
					}
				}
			});
		}
		htmlContent += '</ul></div>';

		target.html(htmlContent);
	},
	getSettingsXml: function(target, opts){
		var result = "";

		var title = $('input[name=title]').val();
		result += '<title>'+title+'</title>';
		
		var stockCode = $('input[name=stockCode]').val();

		result += '<stockCode>'+stockCode+'</stockCode>';	

		opts = $.extend(opts, {title:title,stockCode:stockCode});

		return result;
	}
};
/*--------------------portlet---------end--------------*/