--with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
--with DFR0548;  -- using the types defined here
--with MicroBit.Ultrasonic;
--with MicroBit.Types; use MicroBit.Types;
--with MicroBit.Console; use MicroBit.Console; -- for serial port communication
--with Microbit.TimeHighspeed; use Microbit.TimeHighspeed;
--with MicroBit.Linetracker; Use MicroBit.Linetracker;
--with Ada.Real_Time; use Ada.Real_Time;
--use MicroBit; --for pin names
with taskSense;
with taskact;

procedure Main with Priority => 0 is
begin
   loop
      null;
   end loop;
end Main;
