within TestUDPSenderReceiver;
model BooleanInputController
  parameter Real y_max = 1.0;
  parameter Real y_min = 0.0;
  parameter Real y_start = 0.0;
  parameter Real ampFac = 1.0;
  Modelica.Blocks.Math.BooleanToReal booToReaPos(
    realTrue=1.0,
    realFalse=0.0)
    annotation (Placement(transformation(extent={{-48,2},{-34,16}})));
  Modelica.Blocks.Math.Gain gain(
    k=ampFac)
    annotation (Placement(transformation(extent={{-12,-4},{-4,4}})));
  Modelica.Blocks.Math.BooleanToReal booToReaNeg(
    realTrue=-1.0,
    realFalse=0.0)
    annotation (Placement(transformation(extent={{-48,-18},{-34,-4}})));
  Modelica.Blocks.Math.Sum sum(
    nin=2)
    annotation (Placement(transformation(extent={{-24,-4},{-16,4}})));
  Modelica.Blocks.Continuous.Integrator int(
    y_start=y_start)
    annotation (Placement(transformation(extent={{0,-4},{8,4}})));
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{28,-4},{36,4}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{14,-2},{22,6}})));
  Modelica.Blocks.Sources.Constant maxOut(
    k=y_max)
    annotation (Placement(transformation(extent={{0,-20},{8,-12}})));
  Modelica.Blocks.Sources.Constant minOut(
    k=y_min)
    annotation (Placement(transformation(extent={{0,10},{8,18}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{40,-10},{60,10}}), iconTransformation(extent={{-10,-10},{10,10}},rotation=0,origin={50,0})));
  Modelica.Blocks.Interfaces.BooleanInput uPos
    annotation (Placement(transformation(extent={{-90,-6},{-60,24}}), iconTransformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Interfaces.BooleanInput uNeg
    annotation (Placement(transformation(extent={{-90,-26},{-60,4}}), iconTransformation(extent={{-60,-40},{-40,-20}})));
equation
  connect(booToReaPos.y, sum.u[1]) annotation (Line(points={{-33.3,9},{-30,9},{-30,
          -0.4},{-24.8,-0.4}}, color={0,0,127}));
  connect(booToReaNeg.y, sum.u[2]) annotation (Line(points={{-33.3,-11},{-30,-11},
          {-30,0.4},{-24.8,0.4}}, color={0,0,127}));
  connect(sum.y,gain. u) annotation (Line(points={{-15.6,0},{-15.6,0},{-12.8,0}},
             color={0,0,127}));
  connect(gain.y,int. u) annotation (Line(points={{-3.6,0},{-3.6,0},{-0.8,0}},
       color={0,0,127}));
  connect(int.y,max. u2) annotation (Line(points={{8.4,0},{13.2,0},{13.2,-0.4}},
      color={0,0,127}));
  connect(minOut.y,max. u1) annotation (Line(points={{8.4,14},{10,14},{10,4.4},
          {13.2,4.4}},color={0,0,127}));
  connect(max.y,min. u1) annotation (Line(points={{22.4,2},{27.2,2},{27.2,2.4}},
      color={0,0,127}));
  connect(maxOut.y,min. u2) annotation (Line(points={{8.4,-16},{24,-16},{24,-2.4},
          {27.2,-2.4}},color={0,0,127}));
  connect(min.y, y)
    annotation (Line(points={{36.4,0},{50,0}}, color={0,0,127}));
  connect(uPos, booToReaPos.u)
    annotation (Line(points={{-75,9},{-75,9},{-49.4,9}}, color={255,0,255}));
  connect(uNeg, booToReaNeg.u) annotation (Line(points={{-75,-11},{-75,-11},{-49.4,
          -11}}, color={255,0,255}));

annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
  Rectangle(extent={{-40,40},{40,-40}}, lineColor={28,108,200}),
  Text(extent={{-100,-36},{100,-76}},textString="%name"),
  Text(extent={{-26,30},{28,-30}},lineColor={28,108,200},textString="BIC")}),
  Diagram(coordinateSystem(preserveAspectRatio=false, initialScale=0.1)),
  uses(BuildingSystems(version="0.1"),Modelica(version="3.2.2")));
end BooleanInputController;
