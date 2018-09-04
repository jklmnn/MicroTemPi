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
      Year : Integer := Integer'Value (Timestamp (Timestamp'First ..
                                         Timestamp'First + 3));
      Month : Integer := Integer'Value (Timestamp (Timestamp'First + 5 ..
                                          Timestamp'First + 6));
      Day : Integer := Integer'Value (Timestamp (Timestamp'First + 8 ..
                                        Timestamp'First + 9));
      Seconds : Duration := Duration'Value (Timestamp (Timestamp'First + 11 ..
                                              Timestamp'Last));
   begin
      return Ada.Calendar.Time_Of (Year, Month, Day, Seconds);
   end Parse;

   -----------
   -- Image --
   -----------

   function Image (Timestamp : Ada.Calendar.Time) return String
   is
      Year : String :=
        Ada.Strings.FIxed.Trim (Integer'Image (Ada.Calendar.Year (Timestamp)),
                                               Ada.Strings.Left);
      Month : String :=
        Ada.Strings.Fixed.Trim (Integer'Image (Ada.Calendar.Month (Timestamp)),
                                                Ada.Strings.Left);
      Month_Padded : String :=
        (if Month'Length = 2 then Month else "0" & Month);
      Day : String :=
        Ada.Strings.Fixed.Trim (Integer'Image (Ada.Calendar.Day (Timestamp)),
                                              Ada.Strings.Left);
      Day_Padded : String :=
        (if Day'Length = 2 then Day else "0" & Day);
      Seconds : String :=
        Ada.Strings.Fixed.Trim (Duration'Image (Ada.Calendar.Seconds (Timestamp)),
                                              Ada.Strings.Left);
   begin
      return Year & "-" & Month_Padded & "-" & Day_Padded & "-" & Seconds;
   end Image;

end Timestamp;
