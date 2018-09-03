with Temperature;
with MicroBit.IOs;
with MicroBit.Time;

procedure Main is
begin
   loop
      if MicroBit.IOs.Set (1)
      then
         Temperature.Send;
      end if;
      MicroBit.Time.Delay_Ms (100);
   end loop;
end Main;
