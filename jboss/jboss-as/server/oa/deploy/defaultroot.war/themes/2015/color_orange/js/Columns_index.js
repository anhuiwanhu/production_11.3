function killerrors() { 
return true; 
} 
window.onerror = killerrors; 



function isShowIndex(tab_id,div_id,who,aId,aHref,num){
   for(var i = 0;i < num;i++){
      document.getElementById("dt"+who+i).style.display="none";
      document.getElementById("sp"+who+i).className="aoff";
   }
   document.getElementById(div_id).style.display="block";
   document.getElementById(tab_id).className="aon";
 document.getElementById(aId).href = aHref;
}


