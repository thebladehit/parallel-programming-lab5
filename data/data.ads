-- ПЗВКС
-- Lab 3 (Програмне забезпечення високопродуктивних комп’ютерних систем)
-- A= Z*MS*e + D*(MX*MS)
-- MX, A - 2 thread
-- Z, D - 3 thread
-- MS, e - 8 thread
-- Ярмолка Богдан Ігорович
-- ІМ-22
-- 13.05.2025

package Data is
  N: Integer := 8;
  P: Integer := 8;
  H: Integer := N / P;

  type VectorGeneral is array(Integer range <>) of Integer;
    subtype Vector is VectorGeneral(1..N);
    subtype Vector1H is VectorGeneral(1..H);
    subtype Vector2H is VectorGeneral(1..2*H);
    subtype Vector3H is VectorGeneral(1..3*H);
    subtype Vector4H is VectorGeneral(1..4*H);

  type MatrixGeneral is array(Integer range <>, Integer range <>) of Integer;
    subtype Matrix is MatrixGeneral(1..N, 1..N);
    subtype Matrix1H is MatrixGeneral(1..N, 1..H);
    subtype Matrix2H is MatrixGeneral(1..N, 1..2*H);
    subtype Matrix3H is MatrixGeneral(1..N, 1..3*H);
    subtype Matrix4H is MatrixGeneral(1..N, 1..4*H);

   procedure printNewLineInConsole;
   procedure printTextInConsole(text: String);
   procedure printMatrixInConsole(M: MatrixGeneral);

   procedure fillVectorByNums(V: in out Vector; num: Integer);
   procedure fillMatrixByNums(M: in out Matrix; num: Integer);

   function convertMatrixToMatrix4H(M: in MatrixGeneral; start: Integer) return Matrix4H;
   function convertMatrixToMatrix3H(M: in MatrixGeneral; start: Integer) return Matrix3H;
   function convertMatrixToMatrix2H(M: in MatrixGeneral; start: Integer) return Matrix2H;
   function convertMatrixToMatrix1H(M: in MatrixGeneral; start: Integer) return Matrix1H;
end Data;