using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.ActivityRecording;
using Toybox.System;
var session = null;


class TimerDelegate extends Ui.BehaviorDelegate {

	hidden var model;
	hidden var started = false;
	var count = 0;
	var next;

  function initialize(mdl, callback) {
  	model = mdl;
  	next = callback;
    BehaviorDelegate.initialize();
  }
  
  	


  function onSelect() {
  
 
  
  		if(count == 2){
			next.invoke();
		
		}
		if (count == 1){
			model.stop();
			//model.stopRecording();
			model.vuelta();
			count = 2;
			model.siguiente = true;
		}
		
		if(count == 0){
			model.startBack();
			count = 1;
			
		} 	
		
	}
	
	function onBack() {
		//model.stopRecording();
	 	//count = 0;
	 	//model.stopBack();
	 	//model.stop();
	 	Toybox.System.exit();
	}

}
		
		
	
