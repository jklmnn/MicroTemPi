
with Ada.Text_Io;
with Ada.Calendar;
with Timestamp;

use all type Ada.Calendar.Time;

procedure Time
is
   T : Ada.Calendar.Time := Timestamp.Trim_Precision (Timestamp.Time);
   Check : Boolean :=
     Timestamp.Parse (Timestamp.Image (T)) = T;
begin
   Ada.Text_Io.Put_Line ("Timestamp check: " & Boolean'Image (Check));
   Ada.Text_Io.Put_Line (Timestamp.Image (T));
end Time;
