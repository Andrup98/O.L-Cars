with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package mySensor is

   type LineState is (On_Line, Left_Of_Line, Right_Of_Line, Off_Line);
   
   protected LineTracker is
      function GetLineState return LineState;
      
      procedure SetLineState (L : LineState);
      
      private 
      LineTrackerState : LineState := Off_Line;
   
   end LineTracker;
   
   
   type UltraState is (Path_Clear, Path_Blocked);
   
   protected UltrasonicSensor is
      function GetUltrasonicState return UltraState;
      
      procedure SetUltrasonicState (U : UltraState);
      
      private
      UltrasonicState : UltraState := Path_Blocked;
   
   end UltrasonicSensor;
end mySensor;
