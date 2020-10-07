using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.Activity;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;
using Toybox.System;
using Toybox.ActivityRecording;
using Toybox.FitContributor;



class TimerModel{

	enum
    {  
    	OFF,
        STOPPED,
        PAUSED,
        ON
    }

	const HAS_TONES = Attention has :playTone;
	
	var started = false;
	var siguiente = false;
	var min = 0;
	var sec = 0;
	var mili = 0;
	var done = false;
	var activityInfo = null;
	var elaTime = null; //ms
	var hr = 0;
	var Kcal = null;
	var sensorInfo = null;
	var timerState = OFF;
	var elapsedTime = 0;
	var secback = 3;
	var usecback = 3;
	var averageHeartRate = null;
	var heartRate = null;
	var puertas = null;
	var toques = null;
	var toquesField;
	
	

	hidden var refreshTimer = new Timer.Timer();
	hidden var backTimer = new Timer.Timer();
	
	
	function postMsg(identifier){
	var time = System.getClockTime();
	if (time != null){
		System.println(Lang.format("$1$:$2$:$3$   $4$",[time.hour.format("%2.2d"),time.min.format("%2.2d"),time.sec.format("%2.2d"),identifier]));
		}
	}


	 function startSensor() {
    	postMsg("Start Sensor");
        Sensor.enableSensorEvents(method(:onSensor));
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE,Sensor.SENSOR_TEMPERATURE,Sensor.SENSOR_FOOTPOD, Sensor.SENSOR_BIKECADENCE, Sensor.SENSOR_BIKESPEED, Sensor.SENSOR_BIKEPOWER]); 
    }
    
      function stopSensor() {
    	postMsg("Stop Sensor");
    	Sensor.enableSensorEvents(null);
    	Sensor.setEnabledSensors([]);
    }
    
    function initialize(){
    
    	
    }
    
     function getInitialView() {
  
    }
    

	function start(){
		refreshTimer.start(method(:timer), 100, true);
		startBuzz();
		Ui.requestUpdate();
		startSensor(); 		
		startRecording(); 
	}
	
	function stop(){
		refreshTimer.stop();
		stopBuzz();
		Ui.requestUpdate();
		//stopSensor();
		done = true;
	}

	
	function timer(){

		if ( mili < 9 ) {
			mili++;
		} else {
			if (sec < 59){
				sec++;
				mili = 0;
			} else if (sec == 59) {
				sec = 0;
				min++;
				mili=0;
			}
		}
		
		Ui.requestUpdate();
	}
	
	 function getValues() {
    
        activityInfo = Activity.getActivityInfo(); 
          	
        if (activityInfo != null){
        	
        	hr = activityInfo.currentHeartRate;
        	averageHeartRate = activityInfo.averageHeartRate;
        	}
        	  	
       	return true;
      }
      
	  function onSensor(info) {
    	sensorInfo = info;
    	getValues();
    }
    
    
	function startRecording(){
	 	session = ActivityRecording.createSession({          // set up recording session
                 :name=>"Kayak Slalom",                              // set session name
                 :sport=>ActivityRecording.SPORT_PADDLING,       // set sport type
                 :subSport=>ActivityRecording.SUB_SPORT_GENERIC // set sub sport type
           });
        
        session.start(); 
     	toquesField = session.createField("Touch",0, FitContributor.DATA_TYPE_UINT8, {:mesgType=>FitContributor.MESG_TYPE_LAP, :units=>"touches" });
   		
   		
        postMsg("Activity recording");          
          
	}
	
	function vuelta(){
	
	session.addLap();
	postMsg("Lap added"); 
	
	}
	
	
	function stopRecording(){
	
		if(session != null){
		   session.stop();                                      // stop the session
           session.save();                                      // save the session
           session = null;  
           timerState= OFF;
											// set session control variable to null
           postMsg("Recording was stopped");  
           
        }                    
	}
	
	function startBack(){
	  backTimer.start(method(:timerBackwards), 1000, true);
	  startBuzz();
	}
	
	function stopBack(){
	   backTimer.stop();
	}
	function timerBackwards(){
	
		if (secback > 1){
			secback = secback - 1;
			usecback = usecback - 1;
		} else {
			start();
			stopBack();
			usecback = 0;
		}
		Ui.requestUpdate();
	}	
	function startBuzz(){
		//var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(600);
	}

	function stopBuzz(){
		//var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(600);
	}

	function intervalBuzz(){
		//var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(600);
	}

	function vibrate(duration){
		var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
		Attention.vibrate( vibrateData );
	}

	function beep(tone){
		Attention.playTone(tone);
		return true;
	}
	
	
}