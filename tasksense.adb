package body taskSense is
   

   task body LineReading is --(L : in out LineState) is
      MyClock          : Time;
      LineTrackerLeft  : Boolean    := False;
      LineTrackerCenter: Boolean    := False;
      LineTrackerRight : Boolean    := False;
      Decision         : LineState  := On_Line;
      Time_now_stopwatch : Time;
      Elapsed_stopwatch : Time_Span;
      AmountOfMeasurement : Integer := 10;
   begin 
      --Set_Analog_Period_Us(20_000); 
      loop
         MyClock := Clock;
         Elapsed_stopwatch := Time_Span_Zero;
         Time_now_stopwatch := Clock;
         
         LineTrackerLeft  := LineTrackerRead(2);
         LinetrackerCenter:= LineTrackerRead (12);
         LineTrackerRight := LineTrackerRead (13);
         
         if LineTrackerLeft = True and then LineTrackerCenter = True and then LineTrackerRight = True then --Distance1 in 16..400 then
            Put_Line("");
            Put_Line("Linetracker: On line");
            Decision := On_Line;
         end if;
         
         if LineTrackerLeft = True and then LineTrackerCenter = True and then LineTrackerRight = False then --Distance1 in 16..400 then
            Put_Line("");
            Put_Line("Linetracker: Right of line");
            Decision := Right_Of_Line;
         end if;
         
         if LineTrackerLeft = False and then LineTrackerCenter = True and then LineTrackerRight = True then --Distance1 in 16..400 then
            Put_Line("");
            Put_Line("Linetracker: Left of line");
            Decision := Left_Of_Line;
         end if;
         
         if LineTrackerLeft = False and then LineTrackerCenter = False and then LineTrackerRight = False then --Distance1 in 16..400 then
            Put_Line("");
            Put_Line("Linetracker: Off line");
            Decision := Off_Line;
         end if;
         
         
         LineTracker.SetLineState(Decision);
         Elapsed_stopwatch := Elapsed_stopwatch + (Clock - Time_now_stopwatch);
         Elapsed_stopwatch := Elapsed_stopwatch / AmountOfMeasurement;
         Put_Line("Average Stopwatch time for LineReading: " & To_Duration(Elapsed_stopwatch)'Image & " seconds"); 
         
         
         delay until MyClock + Milliseconds (50);
      end loop;
   end LineReading;
   
   function LineTrackerRead (pin : Pin_Id) return Boolean is
   begin
      return Set (pin);
   end LineTrackerRead;
   
   task body UltrasonicReading is  --(U : in out UltraState) is
      MyClock          : Time;
      Decision         : UltraState := Path_Blocked;
      
      package sensor1 is new Ultrasonic(MB_P16, MB_P0);
      --package sensor2 is new Ultrasonic(MB_P15, MB_P1);
      --package sensor3 is new Ultrasonic(MB_P14, MB_P8);

      Distance1 : Distance_cm := 0;
      --Distance2 : Distance_cm := 0;
      --Distance3 : Distance_cm := 0;
   begin
      loop
         MyClock := Clock;
         --Put_Line("");
         Distance1 := sensor1.Read;
         --Put_Line ("Front: " & Distance_cm'Image(Distance1)); -- a console line delay the loop significantly
         --Distance2 := sensor2.Read;
         --Distance3 := sensor3.Read;
         
         if Distance1 in 1..15 then
            Decision := Path_Blocked;
         end if;
         
         if Distance1 in 0 | 16..400 then
            Decision := Path_Clear;
         end if;
         
         UltrasonicSensor.SetUltrasonicState(Decision);
         
         delay until MyClock + Milliseconds (50);
      end loop;
   end UltrasonicReading;
         

end taskSense;
