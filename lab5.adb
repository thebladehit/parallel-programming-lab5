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
with Ada.Real_Time; use Ada.Real_Time;

procedure Lab5 is
  procedure runTasks is
    task T1 is
      pragma Storage_Size(20_000_000);
      entry Data21(Z: in Vector; D: in Vector; MX3h: in Matrix3H);
      entry Data81(MS: in Matrix; e: in Integer);
      entry Res81(A2h: in Vector2H);
    end T1;

    task T2 is
      pragma Storage_Size(20_000_000);
      entry Data12(MS: in Matrix; e: in Integer);
      entry Data32(Z: in Vector; D: in Vector);
      entry Res12(A3h: in Vector3H);
      entry Res32(A4h: in Vector4H);
    end T2;

    task T3 is
      pragma Storage_Size(20_000_000);
      entry Data23(MS: in Matrix; e: in Integer; MX4h: in Matrix4H);
      entry Res43(A3h: in Vector3H);
    end T3;

    task T4 is
      pragma Storage_Size(20_000_000);
      entry Data34(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX3h: in Matrix3H);
      entry Res54(A2h: in Vector2H);
    end T4;

    task T5 is
      pragma Storage_Size(20_000_000);
      entry Data45(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX2h: in Matrix2H);
      entry Res65(A1h: in Vector1H);
    end T5;

    task T6 is
      pragma Storage_Size(20_000_000);
      entry Data56(Z: in Vector; D: in Vector; MS: in Matrix; e: in Integer; MX1h: in Matrix1H);
    end T6;

    task T7 is
      pragma Storage_Size(20_000_000);
      entry Data87(MS: in Matrix; e: in Integer; Z: in Vector; D: in Vector; MX1h: in Matrix1H);
    end T7;

    task T8 is
      pragma Storage_Size(20_000_000);
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
      A87H: Vector2H;
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

      -- receive res from T8
      accept Res81(A2h: in Vector2H) do
        A87H := A2h;
      end Res81;

      -- group data
      Res3h := Data.groupVectorsTo3HVector(A1H, A87H);

      -- send res to T2
      T2.Res12(Res3h);

      printNewLineInConsole;
      printTextInConsole("T1 finished");
    exception
      when E: others => 
        Put_Line("Error in thread 1: " & Exception_Information(E));
    end T1;

    task body T2 is
      ZLocal, DLocal, A: Vector;
      MX, MSLocal: Matrix;
      eLocal: Integer;

      A1H: Vector1H;
      A187: Vector3H;
      A3456H: Vector4H;
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
      A1H := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, getHColumnFromMatrix(MX, 3), 3);

      -- reveive res from T1 and T3
      for i in 1..2 loop
        select 
          accept Res12(A3h: in Vector3H) do
            A187 := A3h;
          end Res12;
        or 
          accept Res32(A4h: in Vector4H) do
            A3456H := A4h;
          end Res32;
        end select;
      end loop;

      -- group data
      A := groupVectors(A187, A1H, A3456H);

      -- print A vector
      --  printNewLineInConsole;
      --  printVectorInConsole(A);
    
      printNewLineInConsole;
      printTextInConsole("T2 finished");
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
      A456H: Vector3H;
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

      -- receive res from T4
      accept Res43(A3h: in Vector3H) do
        A456H := A3h;
      end Res43;

      -- group data
      Res4h := groupVectorsTo4HVector(A1H, A456H);

      -- send res to T2
      T2.Res32(Res4h);

      printNewLineInConsole;
      printTextInConsole("T3 finished");
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
      A56H: Vector2H;
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

      -- receive res from T5
      accept Res54(A2h: Vector2H) do
        A56H := A2h;
      end Res54;

      -- group data
      Res3h := groupVectorsTo3HVector(A1H, A56H);

      -- send res to T3
      T3.Res43 (Res3h);

      printNewLineInConsole;
      printTextInConsole("T4 finished");
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
      A6H: Vector1H;
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

      -- receive res from T6
      accept Res65(A1h: in Vector1H) do
        A6H := A1h;
      end Res65;

      -- group data
      Res2h := groupVectorsTo2HVector(A1H, A6H);

      -- send res to T4
      T4.Res54(Res2h);

      printNewLineInConsole;
      printTextInConsole("T5 finished");
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
      Res1h := calculateExpression(ZLocal, MSLocal, eLocal, DLocal, MX1hLocal, 7);

      -- send res to T5
      T5.Res65(Res1h);

      printNewLineInConsole;
      printTextInConsole("T6 finished");
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

      -- send res to T8
      T8.Res78(A1h);

      printNewLineInConsole;
      printTextInConsole("T7 finished");
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
      A71H: Vector1H;
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

      -- receive res from T7
      accept Res78(A1h: in Vector1H) do
        A71H := A1h;
      end Res78;

      -- group data
      Res2h := Data.groupVectorsTo2HVector(A1H, A71H);

      -- send res to T1
      T1.Res81(Res2h);

      printNewLineInConsole;
      printTextInConsole("T8 finished");
    exception
      when E: others => 
        Put_Line("Error in thread 8: " & Exception_Information(E));
    end T8;
  begin
    null;
  end runTasks;

  Start_Time: Time;
  End_Time: Time;
  Elapsed: Time_Span;
begin
  -- start program
  printTextInConsole("Main started");
  printNewLineInConsole;

  Start_Time := Ada.Real_Time.Clock;

  -- run tasks
  runTasks;

  -- measure time execution
  End_Time := Ada.Real_Time.Clock;
  Elapsed := End_Time - Start_Time;
  Put_Line("Execution time: " & Duration'Image(To_Duration(Elapsed)) & " seconds");

  -- end program
  printTextInConsole("Main finished");
end Lab5;