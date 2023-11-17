with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package myPath is

   type PathState is (Follow, Turn);
   
   protected Path is
      function GetPath return PathState;
      
      procedure SetPath (P : PathState);
      
      private 
      ThisPath : PathState := Turn;
   
   end Path;
end myPath;
