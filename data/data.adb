-- ПЗВКС
-- Lab 5 (Програмне забезпечення високопродуктивних комп’ютерних систем)
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

   procedure printVectorInConsole(V: VectorGeneral) is
   begin
      for i in V'Range(1) loop
         Put(Item => Integer'Image(V(i)));
      end loop;
   end printVectorInConsole;

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
            M(i, j) := num;
         end loop;
      end loop;
   end fillMatrixByNums;

   function calculateExpression(
      Z: in Vector; 
      MS: in Matrix; 
      e: in Integer;
      D: in Vector;
      MX: in MatrixGeneral;
      taskNum: in Integer
   ) return Vector1H is
      MXMS: Matrix1H;
      DMXMS: Vector1H;
      ZMS: Vector1H;
      ZMSe: Vector1H;
      A1H: Vector1H;
   begin
      MXMS := multiplyMatrices(getHColumnFromMatrix(MX, 0), MS);
      DMXMS := multiplyVectorOnMatrix(D, MXMS);
      ZMS := multiplyVectorOnMatrix(Z, getHColumnFromMatrix(MS, taskNum));
      ZMSe := multiplyVectorOnScalar(ZMS, e);
      A1H := sumVectors(ZMSe, DMXMS);
      return A1H;
   end calculateExpression;

   function multiplyMatrices(firstM: Matrix1H; secondM: Matrix) return Matrix1H is
      resM: Matrix1H;
   begin
      for i in 1..N loop
         for j in 1..H loop
            resM(i, j) := 0;
            for k in 1..N loop
               resM(i, j) := resM(i, j) + secondM(i, k) * firstM(k, j);
            end loop;
         end loop;
      end loop;
      return resM;
   end multiplyMatrices;

   function multiplyVectorOnMatrix(V: Vector; M: Matrix1H) return Vector1H is
      resV: Vector1H;
   begin
      for i in 1..H loop
         resV(i) := 0;
         for j in 1..N loop
            resV(i) := resV(i) + (V(j) * M(j, i));
         end loop;
      end loop;
      return resV;
   end multiplyVectorOnMatrix;

   function multiplyVectorOnScalar(V: Vector1H; scalar: Integer) return Vector1H is
      resV: Vector1H;
   begin
      for i in 1..H loop
         resV(i) := V(i) * scalar;
      end loop; 
      return resV;
   end multiplyVectorOnScalar;

   function sumVectors(firstV: Vector1H; secondV: Vector1H) return Vector1H is
      resV: Vector1H;
   begin
      for i in 1..H loop
         resV(i) := firstV(i) + secondV(i);
      end loop;
      return resV;
   end sumVectors;

   function convertMatrixToMatrix4H(M: in MatrixGeneral; start: Integer) return Matrix4H is
      colIndex: Integer;
      resM: Matrix4H;
   begin
      for i in 1..N loop
         colIndex := 1;
         for j in start..start+4*H-1 loop
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
         for j in start..start+3*H-1 loop
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
         for j in start..start+2*H-1 loop
            resM(i, colIndex) := M(i, j);
            colIndex := colIndex + 1;
         end loop;
      end loop;
      return resM;
   end convertMatrixToMatrix2H;

   function convertMatrixToMatrix1H(M: in MatrixGeneral; start: Integer) return Matrix1H is
      colIndex: Integer;
      resM: Matrix1H;
   begin
      for i in 1..N loop
         colIndex := 1;
         for j in start..start+H-1 loop
            resM(i, colIndex) := M(i, j);
            colIndex := colIndex + 1;
         end loop;
      end loop;
      return resM;
   end convertMatrixToMatrix1H;

   function getHColumnFromMatrix(M: in MatrixGeneral; taskNum: Integer) return Matrix1H is
      startPos: Integer := taskNum * H + 1;
      endPos: Integer := startPos + H - 1;
      colNumber: Integer;
      resM: Matrix1H; 
   begin
      for i in 1..N loop
         colNumber := 1;
         for j in startPos..endPos loop
            resM(i, colNumber) := M(i, j);
            colNumber := colNumber + 1;
         end loop;
      end loop;
      return resM;
   end getHColumnFromMatrix;

   function groupVectorsTo2HVector(V1: Vector1H; V2: VectorGeneral) return Vector2H is
      resV: Vector2H;
   begin
      for i in 1..H loop
         resV(i) := V1(i);
      end loop;

      for i in V2'Range(1) loop
         resV(i + H) := V2(i);
      end loop;
      return resV;
   end groupVectorsTo2HVector;

   function groupVectorsTo3HVector(V1: Vector1H; V2: VectorGeneral) return Vector3H is
      resV: Vector3H;
   begin
      for i in 1..H loop
         resV(i) := V1(i);
      end loop;

      for i in V2'Range(1) loop
         resV(i + H) := V2(i);
      end loop;
      return resV;
   end groupVectorsTo3HVector;

   function groupVectorsTo4HVector(V1: Vector1H; V2: VectorGeneral) return Vector4H is
      resV: Vector4H;
   begin
      for i in 1..H loop
         resV(i) := V1(i);
      end loop;

      for i in V2'Range(1) loop
         resV(i + H) := V2(i);
      end loop;
      return resV;
   end groupVectorsTo4HVector;

   function groupVectors(V1: VectorGeneral; V2: VectorGeneral; V3: VectorGeneral) return Vector is
      resV: Vector;
   begin
      for i in V1'Range(1) loop
         resV(i) := V1(i);
      end loop;

      for i in V2'Range(1) loop
         resV(i + V1'Length(1)) := V2(i);
      end loop;

      for i in V3'Range(1) loop
         resV(i + V1'Length(1) + V2'Length(1)) := V3(i);
      end loop;
      return resV;
   end groupVectors;
end Data;