using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class finishView extends Ui.View {

  var minutos;
  var segundos;
  var milisegundos;

	function initialize(mi, se, mil ) {
	minutos = mi;
  	segundos = se;
  	milisegundos = mil;
  	
  	View.initialize();
  	
  	}
  	function onUpdate(dc) {
  		setupDisplay(dc);
  		largeText(timerString(), dc);
  		}
  	
  function largeText(text, dc){
  	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.35, Gfx.FONT_SYSTEM_NUMBER_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
  }
  
  function timerString(){
    return minutos.format("%02d") + ":" + segundos.format("%02d") + ":" + milisegundos.format("%d");
  }

}