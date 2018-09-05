pragma Ada_2012;
with Wiring.Pi;
with System;

package body Temperature.MicroBit is

   Status : Integer;
   Received_Count : Integer;
   Received_Data : Temp_Raw;

   ----------
   -- Read --
   ----------

   function Read return Temp_Celcius
   is
   begin
      Received_Count := 0;
      Received_Data := 0;
      Wiring.Pi.Pin_Mode (23, Wiring.Pi.Output);
      Wiring.Pi.Pin_Mode (24, Wiring.Pi.Input);
      Wiring.Pi.Digital_Write (23, Wiring.Pi.High);
      delay Duration (0.1);
      Wiring.Pi.Digital_Write (23, Wiring.Pi.Low);
      loop
         delay Duration (0.05);
         exit when Received_Count = 32;
      end loop;
      declare
         Temp : Temp_Celcius
           with Address => Received_Data'Address;
      begin
         return Temp;
      end;
   end Read;

   -------------
   -- Receive --
   -------------

   procedure Receive is
      Data : Wiring.Pi.Value_Type := Wiring.Pi.Digital_Read (24);
   begin
      Received_Count := Received_Count + 1;
      if Received_Count < 32 then
         case Data is
         when Wiring.Pi.Low =>
            Received_Data := Received_Data / 2;
         when Wiring.Pi.High =>
            Received_Data := (Received_Data + 16#8000_0000#) / 2;
         end case;
      end if;
   end Receive;

begin

   Status := Wiring.Pi.Setup_Gpio;
   Status := Wiring.Pi.Register_Interrupt (18, Wiring.Pi.Edge_Rising, Receive'Address);
   Received_Data := 0;
   Received_Count := 0;

end Temperature.MicroBit;
