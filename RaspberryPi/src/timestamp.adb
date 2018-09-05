pragma Ada_2012;
with Ada.Strings;
with Ada.Strings.Fixed;

package body Timestamp is

   ----------
   -- Time --
   ----------

   function Time return Ada.Calendar.Time
   is
   begin
      return Ada.Calendar.Clock;
   end Time;

   -----------
   -- Parse --
   -----------

   function Parse (Timestamp : String) return Ada.Calendar.Time
   is
      Year : Ada.Calendar.Year_Number :=
               Integer'Value (Timestamp (Timestamp'First ..
                                Timestamp'First + 3));
      Month : Ada.Calendar.Month_Number :=
                Integer'Value (Timestamp (Timestamp'First + 5 ..
                                 Timestamp'First + 6));
      Day   : Ada.Calendar.Day_Number :=
                Integer'Value (Timestamp (Timestamp'First + 8 ..
                                 Timestamp'First + 9));
      Hour  : Hour_Number :=
                Integer'Value (Timestamp (Timestamp'First + 11 ..
                                 Timestamp'First + 12));
      Minute : Minute_Number :=
                 Integer'Value (Timestamp (Timestamp'First + 14 ..
                                  Timestamp'First + 15));
      Second : Second_Number :=
                 Integer'Value (Timestamp (Timestamp'First + 17 ..
                                  Timestamp'First + 18));
   begin
      return Ada.Calendar.Time_Of (Year,
                                   Month,
                                   Day,
                                   Duration_Of (
                                     Hour,
                                     Minute,
                                     Second));
   end Parse;

   -----------
   -- Image --
   -----------

   function Image (Timestamp : Ada.Calendar.Time) return String
   is
      Year   : Ada.Calendar.Year_Number;
      Month  : Ada.Calendar.Month_Number;
      Day    : Ada.Calendar.Day_Number;
      Time   : Duration;
      Hour   : Hour_Number;
      Minute : Minute_Number;
      Second : Second_Number;
   begin
      Ada.Calendar.Split (Timestamp, Year, Month, Day, Time);
      Split (Time, Hour, Minute, Second);
      return
        Year_Pad (Year) & "-" &
        Zero_Pad_Two (Month) & "-" &
        Zero_Pad_Two (Day) & "T" &
        Zero_Pad_Two (Hour) & ":" &
        Zero_Pad_Two (Minute) & ":" &
        Zero_Pad_Two (Second);
   end Image;

   function Trim_Precision (T : Ada.Calendar.Time) return Ada.Calendar.Time
   is
      Year : Ada.Calendar.Year_Number;
      Month : Ada.Calendar.Month_Number;
      Day   : Ada.Calendar.Day_Number;
      Seconds : Duration;
   begin
      Ada.Calendar.Split (T, Year, Month, Day, Seconds);
      Seconds := Duration (Integer (Seconds));
      return Ada.Calendar.TIme_Of (Year, Month, Day, Seconds);
   end Trim_Precision;

   function Year_Pad (Y : Ada.Calendar.Year_Number) return String
   is
   begin
      return Ada.Strings.Fixed.Trim (Integer'Image (Y), Ada.Strings.Left);
   end Year_Pad;

   function Zero_Pad_Two (N : Integer) return String
   is
      Number : String := Ada.Strings.Fixed.Trim (Integer'Image (N),
                                                  Ada.Strings.Left);
   begin
      return (if Number'Length = 2 then Number else "0" & Number);
   end Zero_Pad_Two;

   procedure Split (D : Duration;
                    H : out Hour_Number;
                    M : out Minute_Number;
                    S : out Second_Number)
   is
      DI : Integer := Integer (D);
   begin
      H := DI / 3600;
      DI := DI mod 3600;
      M := DI / 60;
      DI := DI mod 60;
      S := DI;
   end Split;

   function Duration_Of (H : Hour_Number;
                         M : Minute_Number;
                         S : Second_Number) return Duration
   is
   begin
      return Duration (3600 * H + 60 * M + S);
   end Duration_Of;

end Timestamp;
