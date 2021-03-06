using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.FitContributor;

var settings = {};
var settings2 = {};
var model;
var sumatorio;
var sumatorio2;
var goTimePicker;
var roundsPicker;
var roundsPickerDelegate;
var goTimePickerDelegate;
var min;
var sec;
var mili;
var toques;
var puertas;
var finish;
var sumatorioView;
var sumatorioDelegate;

class KayakTimer extends App.AppBase {

  function initialize() {
    AppBase.initialize();
  }

  function getInitialView() {
    return [ new StartView() ];
  }

}

class StartView extends Ui.View {

  function initialize() {
    View.initialize();
  }

  function onShow() {
    switchToTimer();
    return true;
  }

 function switchToTimer(){
    model = new TimerModel();
    var timerView = new TimerView(model);
    var timerDelegate = new TimerDelegate(model, self.method(:switchToRoundsSelect));
    Ui.pushView(timerView, timerDelegate, Ui.SLIDE_IMMEDIATE );
  }

  function switchToRoundsSelect(){
    roundsPicker = new SettingPickerView("TOUCHES", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]);
    roundsPickerDelegate = new SettingPickerDelegate(:rounds, self.method(:addToques));
    Ui.pushView(roundsPicker, roundsPickerDelegate, Ui.SLIDE_IMMEDIATE );
    
  }
  
  function addToques(){
  	min = model.min;
  	sec = model.sec;
  	mili = model.mili;
  	sumatorio = new Sumatorio(settings);
  	toques = sumatorio.TOQUES;
  	model.toquesField.setData(toques);
  	sumatorioView = new SumatorioView(sumatorio, min, sec, mili);
  	sumatorioDelegate = new SumatorioDelegate(sumatorio, self.method(:switchToGoTimeSelect));
  	Ui.pushView(sumatorioView, sumatorioDelegate, Ui.SLIDE_IMMEDIATE );
  	
  }
  
  function switchToGoTimeSelect(){
    goTimePicker = new SettingPickerViewPuertas("GATES", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    goTimePickerDelegate = new SettingPickerDelegatePuertas(:goTime, self.method(:addPuertas));
    Ui.pushView(goTimePicker, goTimePickerDelegate, Ui.SLIDE_IMMEDIATE );
    
     
  }
  
  function addPuertas(){
  	toques = sumatorio.TOQUES;
  	min = sumatorioView.minutos;
  	sec = sumatorioView.segundos;
  	mili = sumatorioView.milisegundos;
  	sumatorio2 = new SumatorioPuertas(settings2,toques);
  	var sumatorioView2 = new SumatorioViewPuertas(sumatorio2, min, sec, mili, toques);
  	var sumatorioDelegate2 = new SumatorioDelegatePuertas(sumatorio2, self.method(:finish));
  	Ui.pushView(sumatorioView2, sumatorioDelegate2, Ui.SLIDE_IMMEDIATE );
  	
  }
  
  function finish(){
  	model.stopRecording();
  	model.stopSensor();
  	Toybox.System.exit();
  }
  
 
   
  
  function getInitialView() {
        return [new StartView()];
    }
 
}