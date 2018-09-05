
with Ada.Command_Line;
with Ada.Text_Io;
with Ada.Calendar;
with Database;
with Database.CSV;
with Timestamp;
with Temperature;

procedure CSV
is
   Unix : Ada.Calendar.Time := Timestamp.Parse ("1970-01-01T00:00:00");
   Current_Time : Ada.Calendar.Time := Timestamp.Time;
   Room_Temp    : Temperature.Temp_Celcius := 20.0;
   package Csv is new Database.CSV (Ada.Command_Line.Argument (1));
begin
   Csv.Put (Current_Time, Room_Temp);
   declare
      Available_Times : Database.Time_Index := Csv.Index (Unix, Current_Time);
   begin
      for T of Available_Times loop
         Ada.Text_Io.Put_Line (Timestamp.Image (T) & " " &
                                 Temperature.Temp_Celcius'Image (Csv.Get (T)));
      end loop;
   end;
end CSV;
