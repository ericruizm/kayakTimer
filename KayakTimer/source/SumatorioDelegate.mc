using Toybox.WatchUi as Ui;

class SumatorioDelegate extends Ui.BehaviorDelegate {

	hidden var sumatorio;
	var next;

  function initialize(suma, callback) {
  	sumatorio = suma;
  	next = callback;
  	
    BehaviorDelegate.initialize();
  }

  function onSelect() {
  
	next.invoke();
	}

	
}