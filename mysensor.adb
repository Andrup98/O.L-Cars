package body mySensor is

   protected body LineTracker is 
      
      procedure SetLineState (L : LineState) is
      begin
         LineTrackerState := L;
      end SetLineState;
      
      function GetLineState return LineState is
      begin
         return LineTrackerState;
      end GetLineState;
      
   end LineTracker;

   protected body UltrasonicSensor is
      
      procedure SetUltrasonicState (U : UltraState) is
      begin
         UltrasonicState := U;
      end SetUltrasonicState;
      
      function GetUltrasonicState return UltraState is
      begin
         return UltrasonicState;
      end GetUltrasonicState;
      
   end UltrasonicSensor;
end mySensor;
