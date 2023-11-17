with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package myMotorDriver is
   
   protected MotorMover is
      function GetDirection return Directions;
      
      procedure SetDirection (V : Directions);
      
      private
      DriveDirection : Directions := Stop;
      
   end MotorMover;
end myMotorDriver;
