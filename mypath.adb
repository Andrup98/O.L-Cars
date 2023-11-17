package body myPath is
   
   protected body Path is
      
      procedure SetPath (P : PathState) is
      begin
         ThisPath := P;
      end SetPath;
      
      function GetPath return Pathstate is
      begin
         return ThisPath;
      end GetPath;
         
   end Path;
end myPath;
