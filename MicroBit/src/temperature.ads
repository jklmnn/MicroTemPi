with MicroBit.Buttons;
with NRF51.Temperature;

package Temperature is

   procedure Send;

private

   type Serial is array (Integer range 0 .. 31) of Boolean;

   function Serialize (Value : NRF51.Temperature.Temp_Celcius) return Serial;

end Temperature;
