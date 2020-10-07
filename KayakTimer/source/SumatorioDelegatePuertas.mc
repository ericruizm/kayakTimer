using Toybox.WatchUi as Ui;
using Toybox.System;

class SumatorioDelegatePuertas extends Ui.BehaviorDelegate {

	hidden var sumatorio;
	var next;
	var count = 0;

  function initialize(suma, callback) {
  	sumatorio = suma;
  	next = callback;
  	
    BehaviorDelegate.initialize();
  }

  function onSelect() {
  
  		next.invoke();
		
	}


	
}