-- ПЗВКС
-- Lab 5 (Програмне забезпечення високопродуктивних комп’ютерних систем)
-- A= Z*MS*e + D*(MX*MS)
-- MX, A - 2 thread
-- Z, D - 3 thread
-- MS, e - 8 thread
-- Ярмолка Богдан Ігорович
-- ІМ-22
-- 13.05.2025

package Data is
  N: Integer := 1000;
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
  procedure printVectorInConsole(V: VectorGeneral);

  procedure fillVectorByNums(V: in out Vector; num: Integer);
  procedure fillMatrixByNums(M: in out Matrix; num: Integer);
  
  function calculateExpression(
    Z: in Vector; 
    MS: in Matrix; 
    e: in Integer;
    D: in Vector;
    MX: in MatrixGeneral;
    taskNum: in Integer
  ) return Vector1H;
  function multiplyMatrices(firstM: Matrix1H; secondM: Matrix) return Matrix1H;
  function multiplyVectorOnMatrix(V: Vector; M: Matrix1H) return Vector1H;
  function multiplyVectorOnScalar(V: Vector1H; scalar: Integer) return Vector1H;
  function sumVectors(firstV: Vector1H; secondV: Vector1H) return Vector1H;

  function convertMatrixToMatrix4H(M: in MatrixGeneral; start: Integer) return Matrix4H;
  function convertMatrixToMatrix3H(M: in MatrixGeneral; start: Integer) return Matrix3H;
  function convertMatrixToMatrix2H(M: in MatrixGeneral; start: Integer) return Matrix2H;
  function convertMatrixToMatrix1H(M: in MatrixGeneral; start: Integer) return Matrix1H;
  function getHColumnFromMatrix(M: in MatrixGeneral; taskNum: Integer) return Matrix1H;

  function groupVectorsTo2HVector(V1: Vector1H; V2: VectorGeneral) return Vector2H;
  function groupVectorsTo3HVector(V1: Vector1H; V2: VectorGeneral) return Vector3H;
  function groupVectorsTo4HVector(V1: Vector1H; V2: VectorGeneral) return Vector4H;
  function groupVectors(V1: VectorGeneral; V2: VectorGeneral; V3: VectorGeneral) return Vector;
end Data;