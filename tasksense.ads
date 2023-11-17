with mySensor; use mySensor;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Ultrasonic;
with Ada.Execution_Time; use Ada.Execution_Time;
with DFR0548;
use MicroBit;

package taskSense is
   
   task LineReading with Priority => 3;
   
   task UltrasonicReading with Priority => 4; 
   
   function LineTrackerRead(pin : Pin_Id) return Boolean;

end taskSense;
