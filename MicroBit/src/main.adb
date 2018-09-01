with Temperature;
with MicroBit.Buttons;
with MicroBit.Time;

use all type MicroBit.Buttons.Button_State;

procedure Main is
begin
   loop
      if MicroBit.Buttons.State (MicroBit.Buttons.Button_A) =
        MicroBit.Buttons.Pressed
      then
         Temperature.Send;
      end if;
      MicroBit.Time.Delay_Ms (100);
   end loop;
end Main;
