with Ada.Text_Io;
with Timestamp;
with Temperature;
with Ada.Calendar;

use all type Ada.Calendar.Time;

generic
   File_Name : String;
package Database.CSV is


   function Index (From : Ada.Calendar.Time;
                   To   : Ada.Calendar.Time) return Time_Index;

   function Get (Time : Ada.Calendar.Time) return Temperature.Temp_Celcius;

   Procedure Put (Time : Ada.Calendar.Time;
                  Temp : Temperature.Temp_Celcius);

private

   procedure Read_Enable (F : in out Ada.Text_Io.File_Type);

   procedure Write_Enable (F : in out Ada.Text_Io.File_Type);

   procedure Disable (F : in out Ada.Text_Io.File_Type);

   procedure Parse_Line (Line : String;
                         Time : out Ada.Calendar.Time;
                         Temp : out Temperature.Temp_Celcius);

   function Produce_Line (Time : Ada.Calendar.Time;
                          Temp : Temperature.Temp_Celcius) return String;

end Database.CSV;
