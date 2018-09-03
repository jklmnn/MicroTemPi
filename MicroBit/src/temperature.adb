pragma Ada_2012;

with MicroBit.Display;
with MicroBit.IOs;
with MicroBit.Time;

package body Temperature is

   ----------
   -- Send --
   ----------

   procedure Send
   is
      S_Temp : Serial := Serialize (NRF51.Temperature.Read);
   begin
      MicroBit.Display.Set (0, 1);
      for Bit of S_Temp loop
         if Bit then
            MicroBit.Display.Set (0, 1);
         else
            MicroBit.Display.Clear (0, 1);
         end if;
         MicroBit.IOs.Set (8, Bit);
         MicroBit.IOs.Set (16, True);
         MicroBit.Display.Set (0, 0);
         MicroBit.Time.Delay_Ms (10);
         MicroBit.IOs.Set (16, False);
         MicroBit.Display.Clear (0, 0);
         MicroBit.Time.Delay_Ms (10);
      end loop;
      MicroBit.Display.Clear(0, 1);
   end Send;

   function Serialize (Value : NRF51.Temperature.Temp_Celcius) return Serial
   is
      S : Serial := (others => False);
      T : Integer
        with Address => Value'Address;
      V : Integer := T;
   begin
      for I in Serial'Range loop
         S (I) := V mod 2 = 1;
         V := V / 2;
      end loop;
      return S;
   end Serialize;

end Temperature;
