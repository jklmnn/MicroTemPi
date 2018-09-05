package Temperature.MicroBit is

      function Read return Temp_Celcius;

private

   type Temp_Raw is mod 2**32;

   procedure Receive;

end Temperature.MicroBit;
