package body myMotorDriver is

   protected body MotorMover is
      
      procedure SetDirection (V : Directions) is
      begin
         DriveDirection := V;
      end SetDirection;
      
      
      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;
      
   end MotorMover;

end myMotorDriver;
