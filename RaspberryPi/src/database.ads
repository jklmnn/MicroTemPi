with Ada.Calendar;

package Database is

   type Time_Index is array (Integer range <>) of Ada.Calendar.Time;

   type File_Handle is access String;

end Database;
