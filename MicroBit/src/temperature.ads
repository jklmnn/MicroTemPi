with MicroBit.Buttons;

package Temperature is

   procedure Send;

private

   type Serial is array (Integer range 0 .. 31) of Boolean;

   function Serialize (Value : Integer) return Serial;

end Temperature;
