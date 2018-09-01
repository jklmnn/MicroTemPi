pragma Ada_2012;

with NRF51.Temperature;
with MicroBit.Display;
with MicroBit.IOs;
with MicroBit.Time;

package body Temperature is

   ----------
   -- Send --
   ----------

   procedure Send
   is
      Temp : Integer := Integer (NRF51.Temperature.Read);
      S_Temp : Serial := Serialize (Temp);
   begin
      --  MicroBit.Display.Display (Integer'Image (Temp));
      for Bit of S_Temp loop
         MicroBit.IOs.Set (8, Bit);
         MicroBit.IOs.Set (16, True);
         MicroBit.Time.Delay_Ms (10);
         MicroBit.IOs.Set (16, False);
         MicroBit.Time.Delay_Ms (10);
      end loop;
   end Send;

   function Serialize (Value : Integer) return Serial
   is
      S : Serial := (others => False);
      V : Integer := Value;
   begin
      for I in Serial'Range loop
         S (I) := V mod 2 = 1;
         V := V / 2;
      end loop;
      return S;
   end Serialize;

end Temperature;
