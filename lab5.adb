-- ПЗВКС
-- Lab 3 (Програмне забезпечення високопродуктивних комп’ютерних систем)
-- A= Z*MS*e + D*(MX*MS)
-- MX, A - 2 thread
-- Z, D - 3 thread
-- MS, e - 8 thread
-- Ярмолка Богдан Ігорович
-- ІМ-22
-- 13.05.2025

with Data; use Data;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

procedure Lab5 is
  procedure runTasks is
    task T1 is
      entry Data21(Z: in Vector; D: in Vector; MX3h: in Matrix3H);
      entry Data81(MS: in Matrix; e: in Integer);
      entry Res81(A2h: in Vector2H);
    end T1;

    task T2 is
      entry Data12(MS: in Matrix; e: in Integer);
      entry Data32(Z: in Vector; D: in Vector);
      entry Res12(A3h: in Vector3H);
      entry Res32(A4h: in Vector4H);
    end T2;

    task T3 is
      entry Data23(MS: in Matrix; e: in Integer; MX4h: in Matrix4H);
      entry Res43(A3h: in Vector3H);
    end T3;

    task T4 is
      entry Data34(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX3h: in Matrix3H);
      entry Res54(A2h: in Vector2H);
    end T4;

    task T5 is
      entry Data45(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX2h: in Matrix2H);
      entry Res65(A1h: in Vector1H);
    end T5;

    task T6 is
      entry Data56(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX1h: in Matrix1H);
    end T6;

    task T7 is
      entry Data87(MS: in Matrix; e: in Integer; Z: in Vector; D: in Vector; MX1h: in Matrix1H);
    end T7;

    task T8 is
      entry Data18(Z: in Vector; D: in Vector; MX2h: in Matrix2H);
      entry Res78(A1h: in Vector1H);
    end T8;

    task body T1 is
      ZLocal, DLocal: Vector;
      Res3h: Vector3H;
      MSLocal: Matrix;
      MX3hLocal: Matrix3H;
      eLocal: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T1 started");
      printNewLineInConsole;

      -- receive data from T2
      accept Data21(Z: in Vector; D: in Vector; MX3h: in Matrix3H) do
        ZLocal := Z;
        DLocal := D;
        MX3hLocal := MX3h;
      end Data21;

      -- send data to T8
      T8.Data18(ZLocal, DLocal, convertMatrixToMatrix2H(MX3hLocal, H+1));

      -- receive data from T8
      accept Data81(MS: in Matrix; e: in Integer) do
        MSLocal := MS;
        eLocal := e;
      end Data81;

      -- send data to T2
      T2.Data12(MSLocal, eLocal);

      -- calculate expression
      A1H := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, MX3hLocal, 0);

    exception
      when E: others => 
        Put_Line("Error in thread 1: " & Exception_Information(E));
    end T1;

    task body T2 is
      ZLocal, DLocal, A: Vector;
      Res3h: Vector3H;
      Res4h: Vector4H;
      MX, MSLocal: Matrix;
      eLocal: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T2 started");
      printNewLineInConsole;

      -- fill data
      fillMatrixByNums(MX, 1);

      -- receive data from T3
      accept Data32(Z: in Vector; D: in Vector) do
        ZLocal := Z;
        DLocal := D;
      end Data32;

      -- send data to T1
      T1.Data21(ZLocal, DLocal, convertMatrixToMatrix3H(MX, 1));

      -- receive data from T1
      accept Data12(MS: in Matrix; e : in Integer) do
        MSLocal := MS;
        eLocal := e;
      end Data12;

      -- send data to T3
      T3.Data23(MSLocal, eLocal, convertMatrixToMatrix4H(MX, 4*H + 1));

      -- calculate expression
      A1H := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, MX, 3);
    
    exception
      when E: others => 
        Put_Line("Error in thread 2: " & Exception_Information(E));
    end T2;

    task body T3 is
      Z, D: Vector;
      Res4h: Vector4H;
      MSLocal: Matrix;
      MX4hLocal: Matrix4H;
      eLocal: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T3 started");
      printNewLineInConsole;

      -- fill data
      fillVectorByNums(Z, 1);
      fillVectorByNums(D, 1);

      -- send data to T2
      T2.Data32(Z, D);

      -- receive data from T2
      accept Data23 (MS: in Matrix; e: in Integer; MX4h: in Matrix4H) do
        MSLocal := MS;
        eLocal := e;
        MX4hLocal := MX4h;
      end Data23;

      -- send data to T4
      T4.Data34(Z, D, MSLocal, eLocal, convertMatrixToMatrix3H(MX4hLocal, H+1));

      -- calculate expression
      A1H := calculateExpression(Z, MSLocal, eLocal, D, MX4hLocal, 4);

    exception
      when E: others => 
        Put_Line("Error in thread 3: " & Exception_Information(E));
    end T3;

    task body T4 is
      ZLocal, DLocal: Vector;
      Res3h: Vector3H;
      MSLocal: Matrix;
      MX3hLocal: Matrix3H;
      eLocal: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T4 started");
      printNewLineInConsole;

      -- receive data from T4
      accept Data34(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX3h: in Matrix3H) do
        ZLocal := Z;
        DLocal := D;
        MSLocal := MS;
        eLocal := e;
        MX3hLocal := MX3h;
      end Data34;

      -- send data to T5
      T5.Data45(ZLocal, DLocal, MSLocal, eLocal, convertMatrixToMatrix2H(MX3hLocal, H+1));

      -- calculate expression
      A1H := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, MX3hLocal, 5);

    exception
      when E: others => 
        Put_Line("Error in thread 4: " & Exception_Information(E));
    end T4;

    task body T5 is
      ZLocal, DLocal: Vector;
      Res2h: Vector2H;
      MSLocal: Matrix;
      MX2hLocal: Matrix2H;
      eLocal: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T5 started");
      printNewLineInConsole;

      -- receive data from T4
      accept Data45(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX2h: in Matrix2H) do
        ZLocal := Z;
        DLocal := D;
        MSLocal := MS;
        eLocal := e;
        MX2hLocal := MX2h;
      end Data45;

      -- sent data to T6
      T6.Data56(ZLocal, DLocal, MSLocal, eLocal, convertMatrixToMatrix1H(MX2hLocal, H+1));

      -- calculate expression
      A1H := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, MX2hLocal, 6);

    exception
      when E: others => 
        Put_Line("Error in thread 5: " & Exception_Information(E));
    end T5;

    task body T6 is
      ZLocal, DLocal: Vector;
      Res1h: Vector1H;
      MSLocal: Matrix;
      MX1hLocal: Matrix1H;
      eLocal: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T6 started");
      printNewLineInConsole;

      -- receive data from T5
      accept Data56(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX1h: in Matrix1H) do
        ZLocal := Z;
        DLocal := D;
        MSLocal := MS;
        eLocal := e;
        MX1hLocal := MX1h;
      end Data56;

      -- calculate expression
      A1H := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, MX1hLocal, 7);

    exception
      when E: others => 
        Put_Line("Error in thread 6: " & Exception_Information(E));
    end T6;

    task body T7 is
      ZLocal, DLocal: Vector;
      Res1h: Vector1H;
      MSLocal: Matrix;
      MX1hLocal: Matrix1H;
      eLocal: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T7 started");
      printNewLineInConsole;

      -- receive data from T8
      accept Data87(MS: in Matrix; e: in Integer; Z: in Vector; D: in Vector; MX1h: in Matrix1H) do
        MSLocal := MS;
        eLocal := e;
        ZLocal := Z;
        DLocal := D;
        MX1hLocal := MX1h;
      end Data87;

      -- calculate expression
      A1H := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, MX1hLocal, 2);

    exception
      when E: others => 
        Put_Line("Error in thread 7: " & Exception_Information(E));
    end T7;

    task body T8 is
      ZLocal, DLocal: Vector;
      Res2h: Vector2H;
      MS: Matrix;
      MX2hLocal: Matrix2H;
      e: Integer;

      A1H: Vector1H;
    begin
      printTextInConsole("T8 started");
      printNewLineInConsole;

      -- fill data
      fillMatrixByNums(MS, 1);
      e := 1;

      -- receive data from T1
      accept Data18(Z: in Vector; D: in Vector; MX2h: in Matrix2H) do
        ZLocal := Z;
        DLocal := D;
        MX2hLocal := MX2h;
      end Data18;

      -- send data to T1
      T1.Data81(MS, e);

      -- send data to T7
      T7.Data87(MS, e, ZLocal, DLocal, convertMatrixToMatrix1H(MX2hLocal, H+1));

      -- calculate expression
      A1H := calculateExpression(ZLocal, MS, e, DLocal, MX2hLocal, 1);
      
    exception
      when E: others => 
        Put_Line("Error in thread 8: " & Exception_Information(E));
    end T8;
  begin
    null;
  end runTasks;
begin
  -- start program
  printTextInConsole("Main started");
  printNewLineInConsole;

  -- run tasks
  runTasks;

  -- end program
  printTextInConsole("Main finished");
end Lab5;