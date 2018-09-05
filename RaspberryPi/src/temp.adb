with Ada.Text_Io;
with Temperature;
with Temperature.MicroBit;

procedure Temp
is
   T : Temperature.Temp_Celcius := Temperature.MicroBit.Read;
begin
   Ada.Text_Io.Put_Line (Temperature.Temp_Celcius'Image (T));
end Temp;
