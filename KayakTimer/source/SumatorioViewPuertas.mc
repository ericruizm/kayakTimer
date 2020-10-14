using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SumatorioViewPuertas extends Ui.View {

  var sumatorio;
  var sumatorio2;
  var minutos;
  var segundos;
  var milisegundos;
  var toques;
  var puertas;
  var sectoques;
  var secpuertas;
  var sumtoques;
  var sumpuertas;
  var min;
  var sec;
  var mili;
  var puertas2;
  
   function postMsg(identifier){
	var time = System.getClockTime();
	if (time != null){
		System.println(Lang.format("$1$:$2$:$3$   $4$",[time.hour.format("%2.2d"),time.min.format("%2.2d"),time.sec.format("%2.2d"),identifier]));
		}
	}
  
 
  
  function initialize(sum, mi, se, mil, toc ) {
  	sumatorio2 = sum;
  	minutos = mi;
  	segundos = se;
  	milisegundos = mil;
  	min = mi;
  	sec = se;
  	mili = mil;
  	puertas = sumatorio2.PUERTAS;
  	puertas2 = sumatorio2.PUERTAS;
  	toques = toc;
  	
  	
  
  	
  	if(puertas == null){
  	 sumpuertas = 0;
  	 puertas = 0;
  	} else{
  	
  
  	sumpuertas = puertas * 50;
  	}
  	
    View.initialize();
  }
  
 function onUpdate(dc) {
  setupDisplay(dc);
  	
  	if ( puertas == null){
  	largeText(timerString(), dc);
  	}
  	
    if (puertas == 0) {
    	largeText(timerString(), dc);
    } else {
    	secpuertas = (puertas * 50) + segundos;
    	
    	if(secpuertas > 299){
    		minutos = minutos + 5;
    		segundos = secpuertas - 300;
    		largeText(timerString(), dc);
    		puertas = 0;
    	
    	} else if(secpuertas > 239){
    		minutos = minutos + 4;
    		segundos = secpuertas - 240;
    		largeText(timerString(), dc);
    		puertas = 0;
    	
    	} else if(secpuertas > 179){
    		minutos = minutos + 3;
    		segundos = secpuertas - 180;
    		largeText(timerString(), dc);
    		puertas = 0;
    		
    	} else if(secpuertas > 119){
    		minutos = minutos + 2;
    		segundos = secpuertas - 120;
    		largeText(timerString(), dc);
    		puertas = 0;
    
    	} else if (secpuertas > 59){
    		minutos = minutos + 1;
    		segundos = secpuertas - 60;
    		puertas = 0;
    		largeText(timerString(), dc);
    	
    	} else {
    		segundos = secpuertas;
    		largeText(timerString(), dc);
    		puertas = 0;
    	}
    	
    }
    	
    if( sumatorio2.seguir == false){
    
    	 topText(puertasString(), dc);
  	 	bottomText(timerLastString(), dc);
  	 	postMsg(sumatorio2.seguir);
    
    } else if(sumatorio2.seguir == true){
    
   		 topText(pressString(), dc);
  		 bottomText(puertocLastString(), dc);
  		 postMsg(sumatorio2.seguir);
    
    }
    	
   
}
  	
  function setupDisplay(dc){
  	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
    dc.clear();
  }
  
  function bottomText(text,dc){
  dc.drawText(dc.getWidth()/2, dc.getHeight()*0.78, Gfx.FONT_SMALL, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function topText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.1, Gfx.FONT_MEDIUM, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

function largeText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.35, Gfx.FONT_SYSTEM_NUMBER_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function timerString(){
    return minutos.format("%02d") + ":" + segundos.format("%02d") + ":" + milisegundos.format("%d");
  }
  
  function toquesString(){
  	return "+ " + sumtoques.format("%02d") + " seconds";
  }
    function timerLastString(){
    return "Prev: " + min.format("%02d") + ":" + sec.format("%02d") + ":" + mili.format("%d");
  }
  
      function puertocLastString(){
    return "T:" + toques + " " +  "G:" + puertas2;
  }
  
  function puertasString(){
  	return "+ " + sumpuertas.format("%02d") + " seconds";
  }
  
   function grabarString(){
  	return "Data saved";
  }
  function pressString(){
  	return "Finish!";
  }
  
  }