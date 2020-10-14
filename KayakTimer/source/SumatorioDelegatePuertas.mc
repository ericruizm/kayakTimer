using Toybox.WatchUi as Ui;
using Toybox.System;

class SumatorioDelegatePuertas extends Ui.BehaviorDelegate {

	hidden var sumatorio2;
	var next;
	var count = 0;

  function initialize(suma, callback) {
  	sumatorio2 = suma;
  	next = callback;
  	
    BehaviorDelegate.initialize();
  }
  
  function postMsg(identifier){
	var time = System.getClockTime();
	if (time != null){
		System.println(Lang.format("$1$:$2$:$3$   $4$",[time.hour.format("%2.2d"),time.min.format("%2.2d"),time.sec.format("%2.2d"),identifier]));
		}
	}
  

  function onSelect() {
  
  		if (count ==2){
  		
  			next.invoke();
  		}
  
  		if(count == 1){
  		
  			sumatorio2.seguir = null;
  
  			sumatorio2.otravuelta = true;
  			count = 2;
  			sumatorio2.update();
  		}
  		
  		if(count == 0){
  			
  			sumatorio2.seguir = true;
  			count = 1;
  			sumatorio2.update();
  			
  		}
		
	}

	function onBack(){
	
		if(count == 2){
		model.stopRecording();
  		model.stopSensor();
  		Toybox.System.exit();
  		}
	}
	
}