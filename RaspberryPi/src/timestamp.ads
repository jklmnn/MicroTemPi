with Ada.Calendar;

package Timestamp is

   function Time return Ada.Calendar.Time;

   function Parse (Timestamp : String) return Ada.Calendar.Time
     with
       Pre => Timestamp'Length = 19;

   function Image (Timestamp : Ada.Calendar.Time) return String
     with
       Post => Image'Result'Length = 19;

   function Trim_Precision (T : Ada.Calendar.Time) return Ada.Calendar.Time;

private

   subtype Hour_Number is Integer range 0 .. 23;
   subtype Minute_Number is Integer range 0 .. 59;
   subtype Second_Number is Integer range 0 .. 59;

   function Year_Pad (Y : Ada.Calendar.Year_Number) return String
     with
       Post => Year_Pad'Result'Length = 4;

   function Zero_Pad_Two (N : Integer) return String
     with
       Pre => N < 100 and N >= 0,
     Post => Zero_Pad_Two'Result'Length = 2;

   procedure Split (D : Duration;
                    H : out Hour_Number;
                    M : out Minute_Number;
                    S : out Second_Number)
     with
       Pre => (D <= 86_400.0);

   function Duration_Of (H : Hour_Number;
                         M : Minute_Number;
                         S : Second_Number) return Duration;

end Timestamp;
