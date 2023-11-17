with myMotorDriver; use myMotorDriver;
with mySensor; use mySensor;
with myPath; use myPath;
With Ada.Real_Time; use Ada.Real_Time;
With MicroBit.Console; use MicroBit.Console;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
--with taskSense; use taskSense;
With MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ada.Execution_Time; use Ada.Execution_Time;


package taskact is

   task Act with Priority=> 1;
   
   procedure Control_motor(C : Directions);
 
   task Move with Priority=> 2;
  
end taskact;
