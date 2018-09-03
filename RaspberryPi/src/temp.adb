with Ada.Text_Io;
with Temperature;

procedure Temp
is
   T : Temperature.Temp_Celcius := Temperature.Read;
begin
   Ada.Text_Io.Put_Line (Temperature.Temp_Celcius'Image (T));
end Temp;
