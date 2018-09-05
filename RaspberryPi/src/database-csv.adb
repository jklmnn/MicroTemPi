pragma Ada_2012;
with Ada.Text_Io;
use all type Ada.Text_Io.File_Mode;

package body Database.CSV is

   -----------
   -- Index --
   -----------

   function Index
     (From : Ada.Calendar.Time;
      To   : Ada.Calendar.Time)
      return Time_Index
   is
      Start : Integer := 0;
      Count : Integer := 0;
      Line_Time : Ada.Calendar.Time;
      Line_Temp : Temperature.Temp_Celcius;
      Db_File : Ada.Text_Io.File_Type;
   begin
      Read_Enable (Db_File);
      Ada.Text_Io.Set_Line (Db_File, 1);
      loop
         exit when Ada.Text_Io.End_Of_File (Db_File);
         declare
            Line : String := Ada.Text_Io.Get_Line (Db_File);
            Current_Line : Integer := Integer (Ada.Text_Io.Line (Db_File));
         begin
            Parse_Line (Line, Line_Time, Line_Temp);
            if Line_Time >= From and then Line_Time <= To then
               if Start = 0 then
                  Start := Current_Line;
               end if;
               Count := Count + 1;
            end if;
         end;
      end loop;

      Disable (Db_File);
      Read_Enable (Db_File);

      declare
         T_Index : Time_Index (1 .. Count);
      begin
         if Start > 1 then
            Ada.Text_Io.Set_Line (Db_File, Ada.Text_Io.Count (Start - 1));
         end if;
         for TI in T_Index'Range loop
            exit when Ada.Text_Io.End_Of_File (Db_File);
            declare
               Line : String := Ada.Text_Io.Get_Line (Db_File);
            begin
               Parse_Line (Line, Line_Time, Line_Temp);
               T_Index (TI) := Line_Time;
            end;
         end loop;
         Disable (Db_File);
         return T_Index;
      end;
   end Index;

   ---------
   -- Get --
   ---------

   function Get
     (Time : Ada.Calendar.Time)
      return Temperature.Temp_Celcius
   is
      Line_Time : Ada.Calendar.Time;
      Line_Temp : Temperature.Temp_Celcius;
      Db_File : Ada.Text_Io.File_Type;
   begin
      Read_Enable (Db_File);
      loop
         exit when Ada.Text_Io.End_Of_File (Db_File);
         declare
            Line : String := Ada.Text_Io.Get_Line (Db_File);
         begin
            Parse_Line (Line, Line_Time, Line_Temp);
            if Line_Time = Time then
               Disable (Db_File);
               return Line_Temp;
            end if;
         end;
      end loop;
      return 0.0;
   end Get;

   ---------
   -- Put --
   ---------

   procedure Put
     (Time : Ada.Calendar.Time;
      Temp : Temperature.Temp_Celcius)
   is
      Line : String := Produce_Line (Time, Temp);
      Db_File : Ada.Text_Io.File_Type;
   begin
      Write_Enable (Db_File);
      Ada.Text_Io.Put_Line (Db_File, Line);
      Disable (Db_File);
   end Put;

   -----------
   -- Close --
   -----------

   procedure Read_Enable (F : in out Ada.Text_Io.File_Type)
   is
   begin
      Ada.Text_Io.Open (F, Ada.Text_Io.In_File, File_Name);
   exception
      when Ada.Text_Io.Name_Error =>
         Ada.Text_Io.Create (F, Ada.Text_Io.In_File, File_Name);
   end Read_Enable;

   procedure Write_Enable (F : in out Ada.Text_IO.File_Type)
   is
   begin
      Ada.Text_Io.Open (F, Ada.Text_Io.Append_File, File_Name);
   exception
      when Ada.Text_Io.Name_Error =>
         Ada.Text_Io.Create (F, Ada.Text_Io.Append_File, File_Name);
   end Write_Enable;

   procedure Disable (F : in out Ada.Text_Io.File_Type)
   is
   begin
      if Ada.Text_Io.Mode (F) = Ada.Text_Io.Append_File then
         Ada.Text_Io.Flush (F);
      end if;
      Ada.Text_Io.Close (F);
   end Disable;

   procedure Parse_Line (Line : String;
                         Time : out Ada.Calendar.Time;
                         Temp : out Temperature.Temp_Celcius)
   is
   begin
      Time := Timestamp.Parse (Line (Line'First .. Line'First + 18));
      Temp := Temperature.Temp_Celcius'Value (Line (Line'First + 20 .. Line'Last));
   end Parse_Line;

   function Produce_Line (Time : Ada.Calendar.Time;
                          Temp : Temperature.Temp_Celcius) return String
   is
   begin
      return Timestamp.Image (Time) & "," & Temperature.Temp_Celcius'Image (Temp);
   end Produce_Line;

end Database.CSV;
