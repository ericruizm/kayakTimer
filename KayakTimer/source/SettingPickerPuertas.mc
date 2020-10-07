using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;



class SettingPickerViewPuertas extends Ui.Picker {

	var numero;
	var solucion = [];

	
	function initialize(titleText, options	){
		var title = new Ui.Text({:text => titleText, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_TOP, :color=>Gfx.COLOR_WHITE});
		Ui.Picker.initialize({:title => title,:pattern => createNumberPattern(options)});
	}

	function createNumberPattern(options) {
	
		solucion = new DigitFactory(options);
		
		
		return [solucion];
	}
	
	
	function onUpdate(dc) {
		dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
    	dc.clear();
    	
  }
}

class SettingPickerDelegatePuertas extends Ui.PickerDelegate {

	var settingsSymbol;
	var next;
	var numero;

  function initialize(symbol, callback){
		settingsSymbol = symbol;
		
		next = callback;
    PickerDelegate.initialize();
  }

	function onAccept(values) {
		settings2[settingsSymbol] = values[0];
		System.println(settings2[settingsSymbol]);
		next.invoke();
  }

	function onCancel(){
	
	}
	
	function onBack() {
	
		
	}

}