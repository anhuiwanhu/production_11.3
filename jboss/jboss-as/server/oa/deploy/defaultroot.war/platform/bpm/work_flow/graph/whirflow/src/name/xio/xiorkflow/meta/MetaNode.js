
/**
 * <p>Title: MetaNode</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function MetaNode(model, img, wrapper) {
    this.base = Panel;
    this.base(Toolkit.newLayer());
    this.setClassName("NAME_XIO_UI_FONT NAME_XIO_XIORKFLOW_METANODE");

    //
    this.wrapper = wrapper;

    //bound rectangle
    var rectangleUrl = XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/rectangle.gif";
    //lefttop
    this.lefttopRetangle = new Component(Toolkit.newImage());
    this.lefttopRetangle.getUI().src = rectangleUrl;
    this.lefttopRetangle.setLeft("-5px");
    this.lefttopRetangle.setTop("-5px");
    this.lefttopRetangle.setPosition("absolute");
    this.add(this.lefttopRetangle);
    //righttop
    this.righttopRetangle = new Component(Toolkit.newImage());
    this.righttopRetangle.getUI().src = rectangleUrl;
    this.righttopRetangle.setRight("-5px");
    this.righttopRetangle.setTop("-5px");
    this.righttopRetangle.setPosition("absolute");
    this.add(this.righttopRetangle);
    //leftbottom
    this.leftbottomRetangle = new Component(Toolkit.newImage());
    this.leftbottomRetangle.getUI().src = rectangleUrl;
    this.leftbottomRetangle.setLeft("-5px");
    this.leftbottomRetangle.setBottom("-5px");
    this.leftbottomRetangle.setPosition("absolute");
    this.add(this.leftbottomRetangle);
    //rightbottom
    this.rightbottomRetangle = new Component(Toolkit.newImage());
    this.rightbottomRetangle.getUI().src = rectangleUrl;
    this.rightbottomRetangle.setRight("-5px");
    this.rightbottomRetangle.setBottom("-5px");
    this.rightbottomRetangle.setPosition("absolute");
    this.add(this.rightbottomRetangle);
    this.rightbottomRetangle.setCursor(Cursor.RESIZE_SE);

    //
    this.table = Toolkit.newTable();
    this.table.width = "100%";
    this.table.height = "100%";
    this.table.cellPadding = 0;
    this.table.cellSpacing = 0;
    this.add(this.table);

    //
    var titleRow = this.table.insertRow(-1);
    titleRow.className = "TITLE";

    //
    var titleImgCell = titleRow.insertCell(-1);
    titleImgCell.align = "center";
    titleImgCell.valign = "middle";
    if (!img) {
        img = XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/metanode.gif";
    }
    var titleImg = Toolkit.newLayer();
   
    titleImg.style.background = "url(' " + img + "')";
	titleImg.className = "IMG";
    titleImgCell.appendChild(titleImg);
	

    // 仅显示名
    this.titleTxtCell = titleRow.insertCell(-1);
    this.titleTxtCell.align = "center";
    this.titleTxtCell.valign = "middle";
    this.titleTxtCell.className = "TXT";

    //编辑时的名
    this.titleInputCell = titleRow.insertCell(-1);
    this.titleInputCell.align = "left";
    this.titleInputCell.valign = "middle";
    this.titleInput = Toolkit.newElement("<input type=\"text\">");
    this.titleInput.style.display = "none";
    var _MetaNode = this;
    this.titleInput.onchange = function () {
        _MetaNode.stopEdit();
    };
    this.titleInput.onblur = function () {
        _MetaNode.stopEdit();
    };
    this.titleInputCell.appendChild(this.titleInput);

    //
    this.setModel(model);
    this.rightbottomRetangle.addMouseListener(new MetaNodeResizeMouseListener(this.rightbottomRetangle, model, this.wrapper));
}
MetaNode.prototype = new Panel();

//
MetaNode.prototype.setModel = function (model) {
    if (this.model == model) {
        return;
    }
    if (this.model) {
        this.model.removeObserver(this);
    }
    this.model = model;
    this.model.addObserver(this);

    //
    this._updatePosition();
    this._updateSize();
    this._updateText();
    this._updateBoundRectangle();
};
MetaNode.prototype.getModel = function () {
    return this.model;
};

//
MetaNode.prototype.startEdit = function () {
    this.titleTxtCell.style.display = "none";
    this.titleInput.style.display = "";
    this.titleInputCell.style.display = "";
    this.titleInput.focus();
    this.getModel().setEditing(true);
};
// 当输入值后 失去鼠标焦点后 隐藏文本框
MetaNode.prototype.stopEdit = function () {
    this.titleTxtCell.style.display = "";
    this.titleInput.style.display = "none";
    this.titleInputCell.style.display = "none";
    this.getModel().setText(this.titleInput.value);
    this.getModel().setEditing(false);
};

// 双击弹出活动修改页面 进行活动的修改 并返回 修改后的活动名
MetaNode.prototype.editActivity = function () {
	 
	 	//开始活动 结束活动 不能删
	if(this.getModel().type== MetaNodeModel.TYPE_START_NODE){
		//alert("开始活动不能删除");
		return;
	}
	if(this.getModel().type==MetaNodeModel.TYPE_END_NODE){
		//alert("结束活动不能删除");
		return;
	}
	 var  _xiorkFlowModel=this.wrapper.getModel();
	 var model=this.getModel();
	 var processId=_xiorkFlowModel.getName();
	 var tableId=_xiorkFlowModel.getTableId();
	 var moduleId=_xiorkFlowModel.getModuleId();
	 var id=model.getID();
     var url=CommonJSResource.rootPath+"/ActivityAction.do?action=modify&activityId="+id+"&processId="+processId+"&tableId="+tableId+"&moduleId="+moduleId;
     url+="&isDesigner=1";

	  var url=CommonJSResource.rootPath+"/wfactivity.do!updateActivity.action?wfActivityId="+id+"&processId="+processId+"&tableId="+tableId+"&moduleId="+moduleId;
     url+="&isDesigner=1";

	 //alert(url);
	 //http://localhost:7001/CommonJSResource.rootPath/ActivityAction.do?action=modify&activityId=97834600&processId=97834528&tableId=97829949&moduleId=1
	 //window.open(encodeURI(url),'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=900,height=800');
 
	 Toolkit.openWin({url:url,width:900,height:800,winName:'updateActivity'});
};
//
MetaNode.prototype._updatePosition = function () {
    var point = this.model.getPosition();
    this.setLeft(point.getX() + "px");
    this.setTop(point.getY() + "px");
};
MetaNode.prototype._updateSize = function () {
    var size = this.model.getSize();
    this.setWidth(size.getWidth() + "px");
    this.setHeight(size.getHeight() + "px");
};
MetaNode.prototype._updateText = function () {
    var text = this.model.getText();
    this.titleInput.value = text;
    this.titleTxtCell.innerHTML = text;
};

//改变样式表
MetaNode.prototype._updateClassName = function () {
    var className = this.model.getClassName();
	if(className=="red"){
		this.getUI().style.background="none"; 
	    this.getUI().style.backgroundColor="rgb(255, 89, 89)";
	}
	if(className=="buttonface"){
		this.getUI().style.background="none";  
	   this.getUI().style.backgroundColor="rgb(143,143,143)";  
	}  
	
    //this.setClassName(className);
};

//选中 当
MetaNode.prototype._updateBoundRectangle = function () {
    if (this.model.isSelected()) {
        this.lefttopRetangle.setClassName("BOUND_RECTANGLE");
        this.righttopRetangle.setClassName("BOUND_RECTANGLE");
        this.leftbottomRetangle.setClassName("BOUND_RECTANGLE");
        this.rightbottomRetangle.setClassName("BOUND_RECTANGLE");
    } else {
        this.lefttopRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");
        this.righttopRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");
        this.leftbottomRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");
        this.rightbottomRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");

        //
        this.stopEdit();
    }
};

//
MetaNode.prototype.update = function (observable, arg) {
    this.wrapper.setChanged(true);
    switch (arg) {
      case MetaNodeModel.POSITION_CHANGED:
        this._updatePosition();
        break;
      case MetaNodeModel.SIZE_CHANGED:
        this._updateSize();
        break;
      case MetaModel.TEXT_CHANGED:
        this._updateText();
        break;
      case MetaModel.SELECTED_CHANGED:
        this._updateBoundRectangle();
        break;
      case MetaModel.SUICIDE:
        this._suicide();
        break;
	  case MetaModel.CLASSNAME_CHANGED:
		this._updateClassName();
	    break;
      default:
        break;
    }
};

//
MetaNode.prototype._suicide = function () {
    this.listenerProxy.clear();
    if (!this.wrapper) {
        return;
    }
    this.wrapper.removeMetaNode(this);
};

