-- ПЗВКС
-- Lab 3 (Програмне забезпечення високопродуктивних комп’ютерних систем)
-- A= Z*MS*e + D*(MX*MS)
-- MX, A - 2 thread
-- Z, D - 3 thread
-- MS, e - 8 thread
-- Ярмолка Богдан Ігорович
-- ІМ-22
-- 13.05.2025

with Ada.Text_IO; use Ada.Text_IO;
with Data;

package body Data is
   procedure printNewLineInConsole is
   begin
      New_Line;
   end printNewLineInConsole;

   procedure printTextInConsole(text: String) is
   begin
      Put(text);
   end printTextInConsole;

   procedure printMatrixInConsole(M: MatrixGeneral) is
   begin
      for i in M'Range(1) loop
         for j in M'Range(2) loop
            Put(Item => Integer'Image(M(i, j)));
         end loop;
         New_Line;
      end loop;
   end printMatrixInConsole;


   procedure fillVectorByNums(V: in out Vector; num: Integer) is
   begin
      for i in 1..N loop
         V(i) := num;
      end loop;
   end fillVectorByNums;

   procedure fillMatrixByNums(M: in out Matrix; num: Integer) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            M(i, j) := j;
         end loop;
      end loop;
   end fillMatrixByNums;

   function convertMatrixToMatrix4H(M: in MatrixGeneral; start: Integer) return Matrix4H is
      colIndex: Integer;
      resM: Matrix4H;
   begin
      for i in 1..N loop
         colIndex := 1;
         for j in start..start+3*H loop
            resM(i, colIndex) := M(i, j);
            colIndex := colIndex + 1;
         end loop;
      end loop;
      return resM;
   end convertMatrixToMatrix4H;

   function convertMatrixToMatrix3H(M: in MatrixGeneral; start: Integer) return Matrix3H is
      colIndex: Integer;
      resM: Matrix3H;
   begin
      for i in 1..N loop
         colIndex := 1;
         for j in start..start+2*H loop
            resM(i, colIndex) := M(i, j);
            colIndex := colIndex + 1;
         end loop;
      end loop;
      return resM;
   end convertMatrixToMatrix3H;

   function convertMatrixToMatrix2H(M: in MatrixGeneral; start: Integer) return Matrix2H is
      colIndex: Integer;
      resM: Matrix2H;
   begin
      for i in 1..N loop
         colIndex := 1;
         for j in start..start+1*H loop
            resM(i, colIndex) := M(i, j);
            colIndex := colIndex + 1;
         end loop;
      end loop;
      return resM;
   end convertMatrixToMatrix2H;

   function convertMatrixToMatrix1H(M: in MatrixGeneral; start: Integer) return Matrix1H is
      resM: Matrix1H;
   begin
      for i in 1..N loop
         for j in start..start loop
            resM(i, 1) := M(i, j);
         end loop;
      end loop;
      return resM;
   end convertMatrixToMatrix1H;
end Data;