package body taskact is
   
   task body Act is
      MyClock : Time;  
      Decision : Directions;-- := Forward;
      Time_now_stopwatch : Time;
      Elapsed_stopwatch : Time_Span;
      AmountOfMeasurement : Integer := 10;
   begin
      Set_Analog_Period_Us(20_000); 
      
      
      loop
         Put_Line("");
         Put_Line("Act called.");
         MyClock := Clock;
         Elapsed_stopwatch := Time_Span_Zero;
         Time_now_stopwatch := Clock;
         
         Decision := MotorMover.GetDirection;
         
         Control_motor(Decision);
         
         Elapsed_stopwatch := Elapsed_stopwatch + (Clock - Time_now_stopwatch);
         Elapsed_stopwatch := Elapsed_stopwatch / AmountOfMeasurement;
         Put_Line("");
         Put_Line("Average Stopwatch time for Act: " & To_Duration(Elapsed_stopwatch)'Image & " seconds");
                        
         delay until MyClock + Milliseconds(50);  --random period, but faster than 20 ms is no use because Set_Analog_Period_Us(20000) !
                                                  --faster is better but note the weakest link: if decisions in the thinking task come at 100ms and acting come at 20ms 
                                                  --then no change is set in the acting task for at least 5x (and is wasting power to wake up and execute task!)
      end loop;
   end Act;
   
   procedure Control_motor (C : Directions) is
   begin
      case C is 
         when Stop => 
           Drive(Stop);
            
         when Forward =>
            Drive(Forward,(4095,4095,4095,4095));
            
         when Rotate_Left =>
            Drive(Rotate_Left,(4095,4095,4095,4095));
            
         when Rotate_Right =>
            Drive(Rotate_Right,(4095,4095,4095,4095));
            
         when Turning =>
            Drive(Turning,(4095,4095,2050,2050));
            
         when others =>
             Drive(Stop);
            
        end case;
   end Control_motor;
         
   task body Move is
      MyClock       : Time;
      Line          : Linestate := Off_Line;
      CurrentState  : Directions := Stop;
      CurrentPath   : PathState := Turn;
      --Ultra         : UltraState := Path_Blocked;
      Time_now_stopwatch : Time;
      Elapsed_stopwatch : Time_Span;
      AmountOfMeasurement : Integer := 10;
   begin
      --Set_Analog_Period_Us(20_000); 
      loop
         Put_Line("");
         Put_Line("Move called.");
         MyClock := Clock;
         CurrentState := MotorMover.GetDirection;
         Line := LineTracker.GetLineState;
         CurrentPath := Path.GetPath;
         Elapsed_stopwatch := Time_Span_Zero;
         Time_now_stopwatch := Clock;
         
         --Ultra := UltrasonicSensor.GetUltrasonicState;
         case CurrentPath is
            when Follow =>
               case CurrentState is
         
               when Stop =>
                  case Line is
                  when Off_line =>
                     Currentstate := Stop;
                  when On_Line =>
                     CurrentState := Forward;
                  when Right_Of_Line =>
                     CurrentState := Rotate_Left;
                  when Left_Of_Line =>
                     CurrentState := Rotate_Right;
                  end case;
               CurrentPath := Turn;   
               
               when Forward | Rotate_Left | Rotate_Right =>
                  case Line is --and then Ultra is
                  when Off_Line => --and then Path_Clear =>
                     CurrentState := Stop;
                     --when On_Line and then Path_Blocked =>
                     --Currentstate := Stop;
                  when On_Line => --and then Path_Clear =>
                     CurrentState := Forward;
                  when Right_Of_Line => --and then Path_Clear =>
                     CurrentState := Rotate_Left;
                  when Left_Of_Line => --and then Path_Clear =>
                     CurrentState := Rotate_Right;
                  end case;
               CurrentPath := Follow;
              
               when others =>
                  Null;
                  --MotorMover.SetDirection(CurrentState);
                  --Put_Line("CurrentState: " & Directions'Image(CurrentState));
               end case;
            
            when Turn =>
               case CurrentState is
                  
               when Turning | Stop =>
                  case Line is
                     when Off_Line =>
                        CurrentState := Turning;
                     when On_Line =>
                        CurrentState := Forward;
                     when Right_Of_Line =>
                        CurrentState := Rotate_Left;
                     when Left_Of_Line =>
                        CurrentState := Rotate_Right;
                  end case;
               CurrentPath := Turn;
               
               when Forward | Rotate_Left | Rotate_Right =>
                  case Line is
                     when Off_Line =>
                        CurrentState := Turning;
                     when On_Line =>
                        CurrentState := Forward;
                     when Right_Of_Line =>
                        CurrentState := Rotate_Left;
                     when Left_Of_Line =>
                        CurrentState := Rotate_Right;
                  end case;
               CurrentPath := Follow;
                  
               when others =>
                  null;
                  
                        
                  
                  --MotorMover.SetDirection(CurrentState);
                  --Put_Line("CurrentState: " & Directions'Image(CurrentState));
                  --delay until MyClock + Milliseconds(3500);
               end case; 
     
               MotorMover.SetDirection(CurrentState);
               Put_Line("CurrentState: " & Directions'Image(CurrentState));
               -- Path.SetPath(CurrentPath);
               --Put_Line("CurrentPath: " & PathState'Image(CurrentPath));
         end case;
         Path.SetPath(CurrentPath);
         Put_Line("CurrentPath: " & PathState'Image(CurrentPath));
         Elapsed_stopwatch := Elapsed_stopwatch + (Clock - Time_now_stopwatch);
         Elapsed_stopwatch := Elapsed_stopwatch / AmountOfMeasurement;
         Put_Line("");
         Put_Line("Average Stopwatch time for Move: " & To_Duration(Elapsed_stopwatch)'Image & " seconds");
         delay until MyClock + Milliseconds(50);
      end loop;
   end Move;
   
end taskact;
