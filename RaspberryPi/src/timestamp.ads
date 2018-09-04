with Ada.Calendar;

package Timestamp is

   function Time return Ada.Calendar.Time;

   function Parse (Timestamp : String) return Ada.Calendar.Time;

   function Image (Timestamp : Ada.Calendar.Time) return String;

end Timestamp;
