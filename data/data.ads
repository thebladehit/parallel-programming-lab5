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

  type VGeneral is array(Integer range <>) of Integer;
    subtype V is VGeneral(1..N);
    subtype V1H is VGeneral(1..H);
    subtype V2H is VGeneral(1..2*H);
    subtype V3H is VGeneral(1..3*H);
    subtype V4H is VGeneral(1..4*H);

  type MGeneral is array(Integer range <>, Integer range <>) of Integer;
    subtype M is MGeneral(1..N);
    subtype M1H is MGeneral(1..H);
    subtype M2H is MGeneral(1..2*H);
    subtype M3H is MGeneral(1..3*H);
    subtype M4H is MGeneral(1..4*H);
end Data;