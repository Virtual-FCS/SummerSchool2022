model Tutorial "The first tutortial"

  parameter Real R0(unit="Ohm") = 0.02 "Resistance of the first series resistor";
  parameter Real R1(unit="Ohm") = 0.01 "Resistance of the first RC resistor";
  parameter Real R2(unit="Ohm") = 0.005 "Resistance of the second RC resistor";
  parameter Real C1(unit="F") = 5000 "Capacitance of the first RC capacitor";
  parameter Real C2(unit="F") = 20000 "Capacitance of the second RC capacitor";
  
  Real a1 = 3.25;
  Real b1 = -1e-4;
  Real c1 = -0.08;
  Real d1 = 0.07;
  Real e1 = -0.02;
  Real f1 = -0.01;
  Real g1 = -0.06;
  Real h1 = -0.02;
  Real i1 = -0.002;
   
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = R0, alpha = 0.005)  annotation(
    Placement(visible = true, transformation(origin = {-40, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-68, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = R1, alpha = 0.005) annotation(
    Placement(visible = true, transformation(origin = {0, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R = R2, alpha = 0.005) annotation(
    Placement(visible = true, transformation(origin = {40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = C1, v(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {2, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = C2, v(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {40, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
    Placement(visible = true, transformation(origin = {50, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 2 * 3600)  annotation(
    Placement(visible = true, transformation(origin = {70, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = 0.95) annotation(
    Placement(visible = true, transformation(origin = {70, -82}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation(
    Placement(visible = true, transformation(origin = {25, -55}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator annotation(
    Placement(visible = true, transformation(origin = {-1, -55}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-32, -60}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput SOC annotation(
    Placement(visible = true, transformation(origin = {-60, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-60, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.StepCurrent stepCurrent(I = 1, startTime = 200)  annotation(
    Placement(visible = true, transformation(origin = {76, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SignalVoltage ocv annotation(
    Placement(visible = true, transformation(origin = {-68, 10}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
equation

  ocv.v = a1 + b1 * (20) * 1 / SOC + c1 / sqrt(SOC) + d1 * SOC + e1 * log(SOC) + f1 * log(1.01 - SOC) + g1 * log(1.001 - SOC) + h1 * exp(i1 * (0));

  connect(capacitor.p, resistor.n) annotation(
    Line(points = {{-8, 84}, {-30, 84}, {-30, 62}}, color = {0, 0, 255}));
  connect(resistor.n, resistor1.p) annotation(
    Line(points = {{-30, 62}, {-30, 44}, {-10, 44}}, color = {0, 0, 255}));
  connect(capacitor.n, capacitor1.p) annotation(
    Line(points = {{12, 84}, {30, 84}}, color = {0, 0, 255}));
  connect(resistor1.n, resistor2.p) annotation(
    Line(points = {{10, 44}, {30, 44}}, color = {0, 0, 255}));
  connect(capacitor1.n, resistor2.n) annotation(
    Line(points = {{50, 84}, {60, 84}, {60, 44}, {50, 44}}, color = {0, 0, 255}));
  connect(currentSensor.i, division.u1) annotation(
    Line(points = {{50, -31}, {50, -52}, {34, -52}, {34, -50}}, color = {0, 0, 127}));
  connect(realExpression.y, division.u2) annotation(
    Line(points = {{58, -60}, {34, -60}, {34, -60}, {34, -60}}, color = {0, 0, 127}));
  connect(integrator.u, division.y) annotation(
    Line(points = {{8, -54}, {16, -54}, {16, -54}, {18, -54}}, color = {0, 0, 127}));
  connect(add.u1, integrator.y) annotation(
    Line(points = {{-22, -56}, {-10, -56}, {-10, -54}, {-8, -54}}, color = {0, 0, 127}));
  connect(add.u2, realExpression1.y) annotation(
    Line(points = {{-22, -64}, {-20, -64}, {-20, -82}, {60, -82}, {60, -82}}, color = {0, 0, 127}));
  connect(SOC, add.y) annotation(
    Line(points = {{-60, -60}, {-42, -60}, {-42, -60}, {-40, -60}}, color = {0, 0, 127}));
  connect(resistor2.n, stepCurrent.p) annotation(
    Line(points = {{50, 44}, {76, 44}, {76, 20}}, color = {0, 0, 255}));
  connect(resistor.p, ocv.p) annotation(
    Line(points = {{-50, 62}, {-68, 62}, {-68, 20}}, color = {0, 0, 255}));
  connect(ocv.n, ground.p) annotation(
    Line(points = {{-68, 0}, {-68, -80}}, color = {0, 0, 255}));
  connect(currentSensor.n, ocv.n) annotation(
    Line(points = {{40, -20}, {-68, -20}, {-68, 0}}, color = {0, 0, 255}));
  connect(currentSensor.p, stepCurrent.n) annotation(
    Line(points = {{60, -20}, {76, -20}, {76, 0}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3")),
    Documentation(info = "<html><head></head><body>This is a cool first tutorial to demonstrate some basic concepts.</body></html>"));
end Tutorial;
