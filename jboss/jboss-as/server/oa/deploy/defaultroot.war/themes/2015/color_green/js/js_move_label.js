function setMoveButton(){	
	var m=document.getElementById("whir_mainMenuBar");
	var mW=document.getElementById("whir_mainMenuBarBox2").offsetWidth-m.offsetWidth;
	var sW=m.scrollLeft;
	if(sW<=0){
		document.all.whir_moveLeftSpan.className="whir_scrollArrowLeftDisabled";
	}else{
		document.all.whir_moveLeftSpan.className="whir_scrollArrowLeft";
	}
	if(sW<mW){
		document.all.whir_moveRightSpan.className="whir_scrollArrowRight";
	}else{
		document.all.whir_moveRightSpan.className="whir_scrollArrowRightDisabled";
	}
} 

function whir_menuMoveRight(){
	var m=document.getElementById("whir_mainMenuBar");
	var mW=document.getElementById("whir_mainMenuBarBox2").offsetWidth-m.offsetWidth;
	var sW=m.scrollLeft;
	if(sW<mW){
        sW+=150;
	}
    if(sW>mW){
		sW=mW
	}
	m.scrollLeft=sW;
	setMoveButton();
}
function whir_menuMoveLeft(){
	var m=document.getElementById("whir_mainMenuBar");
	var mW=0;
	var sW=m.scrollLeft;
	if(sW>mW){
        sW-=150;
	}
    if(sW<mW){sW=mW}
	m.scrollLeft=sW;
	setMoveButton();
}

function loadMenu(){
	var w=document.body.offsetWidth;
	var m=document.getElementById("whir_mainMenuBar");
	m.style.width=(w-220)+"px";
	setMoveButton();
}

function checkMenuImg(){
	if(btnMod){
		var menuLength=btnMod.length;
		if(menuLength>0){
			if(btnMod[0].style.display=='none'){
				//moveLeftSpan.style.display='';
				document.all.whir_moveLeftSpan.className="whir_scrollArrowLeft";
				//document.all.menuMoveLeft.src="/defaultroot/skin/blue/ico/moveLeft.gif";
			}else{
				//moveLeftSpan.style.display='none';
				//alert(document.all.menuMoveLeft.src);
				document.all.whir_moveLeftSpan.className="whir_scrollArrowLeftDisabled";
				//document.all.menuMoveLeft.src="/defaultroot/skin/blue/ico/moveLeftDisabled.gif";
			}

			if(btnMod[menuLength-1].style.display=='none'){
				//moveRightSpan.style.display='';
				document.all.whir_moveRightSpan.className="whir_scrollArrowRight";
				//document.all.menuMoveRight.src="/defaultroot/skin/blue/ico/moveRight.gif";
			}else{
				//moveRightSpan.style.display='none';
				document.all.whir_moveRightSpan.className="whir_scrollArrowRightDisabled";
				//document.all.menuMoveRight.src="/defaultroot/skin/blue/ico/moveRightDisabled.gif";
			}
		}
	}
}

