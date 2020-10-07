using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TimerView extends Ui.View {

  var model;


  function initialize(mdl) {
  	model = mdl;
  	
    View.initialize();
  }

  function onUpdate(dc) {
  	setupDisplay(dc);
  	
  	
  	
  	if(model.usecback == 3) {
  	 	largeText(timerBack(), dc);
  	    topText("KAYAK TIMER", dc);
  	    bottomText("Press Start/Stop", dc);
  	} else if(model.usecback >= 2){
  	    largeText(timerBack(), dc);
  	    topText("READY", dc);
  	} else if(model.usecback >= 1){
  	    largeText(timerBack(), dc);
  	    topText("SET", dc);
  	}else if (model.siguiente == false) {
  		largeText(timerString(), dc);
  		topText("FINISH", dc);
  		bottomText("GO!", dc);
  	}
  	
  	if(model.siguiente == true){
      	topText("NEXT", dc);
      	largeText(timerString(), dc);
      	bottomText("Done!", dc);
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
    return model.min.format("%02d") + ":" + model.sec.format("%02d") + ":" + model.mili.format("%d");
   
  }
  function timerBack(){
    return model.usecback.format("%d") ;
   
  }
  function elapsedTime(){
   return model.elapsedTime;
  }
}