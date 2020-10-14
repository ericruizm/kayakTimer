using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.ActivityRecording;
using Toybox.FitContributor;



class SettingPickerView extends Ui.Picker {

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
		dc.setColor( Gfx.COLOR_RED, Gfx.COLOR_BLACK );
    	dc.clear();
    	
  }
  
 
}

class SettingPickerDelegate extends Ui.PickerDelegate {

	var settingsSymbol;
	var next;
	var numero;
	


  function initialize(symbol, callback){
		settingsSymbol = symbol;
		
		next = callback;
    PickerDelegate.initialize();
    
    
  }

	function onAccept(values) {
		settings[settingsSymbol] = values[0];
		next.invoke();
  }

	function onCancel(){
	
	}
	
	function onBack() {
	
		
	}
	
	

}