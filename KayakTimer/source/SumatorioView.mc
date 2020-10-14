using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SumatorioView extends Ui.View {

  var sumatorio;
  var minutos;
  var segundos;
  var milisegundos;
  var toques;
  var puertas;
  var sectoques;
  var sumtoques;
  var min;
  var sec;
  var mili;
  var toquesCont;
  
  function initialize(sum, mi, se, mil ) {
  	sumatorio = sum;
  	minutos = mi;
  	segundos = se;
  	milisegundos = mil;
  	min = mi;
  	sec = se;
  	mili = mil;
  	toques = sumatorio.TOQUES;
  	toquesCont = sumatorio.TOQUES;
  
  	sumtoques = toques * 2;
  	
    View.initialize();
  }
  
  function onUpdate(dc) {
  	setupDisplay(dc);
  	
  	if ( toques == null){
  	largeText(timerString(), dc);
  	}
  	
    
    if (toques == 0) {
    	largeText(timerString(), dc);
    } else {
    	sectoques = (toques * 2) + segundos;
    	
    	if(sectoques > 119){
    		minutos = minutos + 2;
    		segundos = sectoques - 120;
    		largeText(timerString(), dc);
    		toques = 0;
    		
    	} else if (sectoques > 59){
    		minutos = minutos + 1;
    		segundos = sectoques - 60;
    		toques = 0;
    		largeText(timerString(), dc);
    		
    	} else {
    		segundos = sectoques;
    		largeText(timerString(), dc);
    		toques = 0;
    	}
    	
    }
    
    if(toquesCont == 0){
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    topText(toquesString30(), dc);
    dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    topText(toquesString20(), dc);
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    topText(toquesString10(), dc);
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    bottomText(timerLastString(), dc);
    } else {
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    topText(toquesString3(), dc);
    dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
    topText(toquesString2(), dc);
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    topText(toquesString1(), dc);
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    bottomText(timerLastString(), dc);
    
    
    }
    
  	}
  	
  function setupDisplay(dc){
  	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
    dc.clear();
  }
  
  function bottomText(text,dc){
  dc.drawText(dc.getWidth()/2, dc.getHeight()*0.78, Gfx.FONT_SMALL, text, Gfx.TEXT_JUSTIFY_CENTER);
  //dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
  }

  function topText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.1, Gfx.FONT_MEDIUM, text, Gfx.TEXT_JUSTIFY_CENTER);
  	//dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_BLACK);
  }
  
function largeText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.35, Gfx.FONT_SYSTEM_NUMBER_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function timerString(){
    return minutos.format("%02d") + ":" + segundos.format("%02d") + ":" + milisegundos.format("%d");
  }
  
    function timerLastString(){
    return "Prev: " + min.format("%02d") + ":" + sec.format("%02d") + ":" + mili.format("%d");
  }
  
  function toquesString3(){
  	return "         " + "seconds";
  }
  
  function toquesString2(){
  	return sumtoques.format("%02d") + "            ";
  }
  
  
  function toquesString1(){
  	return "+                    ";
  }
  
   function toquesString30(){
  	return "       " + "seconds";
  }
  
  function toquesString20(){
  	return sumtoques.format("%d") + "            ";
  }
  
  
  function toquesString10(){
  	return "+                  ";
  }
  


  
  }