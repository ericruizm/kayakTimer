using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;
using Toybox.System;
using Toybox.ActivityRecording;
using Toybox.FitContributor;



class SumatorioPuertas{

	var PUERTAS;
	var TOQUES;
	var GRABAR = 0;
	var toquesField;
	var puertasField;
	
	function postMsg(identifier){
	var time = System.getClockTime();
	if (time != null){
		System.println(Lang.format("$1$:$2$:$3$   $4$",[time.hour.format("%2.2d"),time.min.format("%2.2d"),time.sec.format("%2.2d"),identifier]));
		}
	}
	
	
	function initialize(settings2,toc){
		PUERTAS = settings2[:goTime];	
		TOQUES = toc;
		
	}
	
	function start(){
		GRABAR = 1;
	}
	
	function stop(){
		model.stopSensor();
		model.stopRecording();
	}
	
}