within TestUDPSenderReceiver;
model ExampleUDPSenderReceiverClocked
  "Example that illustrates the control of a idealised heated building by openHAB"
  extends Modelica.Icons.Example;
  UDPSenderReceiverClocked UDPSenRec(
    nRealOut=1,
    useReaTimFac=true,
    nRealIn=1,
    nIntegerIn=1,
    nIntegerOut=1)
    annotation (Placement(transformation(extent={{14,4},{26,16}})));
  KeyboardController keyCon
    annotation (Placement(transformation(extent={{-16,12},{-6,22}})));
  Modelica.Blocks.Sources.Constant constq(k=1)
    annotation (Placement(transformation(extent={{-6,26},{-2,30}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{2,12},{10,20}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1,
    freqHz=0.2,
    phase=0,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-16,-2},{-6,8}})));
  Modelica.Blocks.Sources.IntegerStep integerStep(
    height=1,
    offset=0,
    startTime=10)
    annotation (Placement(transformation(extent={{-16,-20},{-6,-10}})));
equation
  // UDP data exchange

  connect(keyCon.arrowUpDownReturn, division.u2) annotation (Line(points={{-5.5,
          20.5},{-2.75,20.5},{-2.75,13.6},{1.2,13.6}},color={0,0,127}));
  connect(division.y, UDPSenRec.reaTimFac) annotation (Line(points={{10.4,16},{12.15,
          16},{12.15,13.75},{14.75,13.75}},
                                         color={0,0,127}));
  connect(constq.y, division.u1) annotation (Line(points={{-1.8,28},{1.2,28},{1.2,
          18.4}},color={0,0,127}));

  connect(sine.y, UDPSenRec.uReal[1]) annotation (Line(points={{-5.5,3},{10,3},{
          10,10.75},{14.75,10.75}}, color={0,0,127}));
  connect(integerStep.y, UDPSenRec.uInteger[1]) annotation (Line(points={{-5.5,-15},
          {12,-15},{12,9.25},{14.75,9.25}}, color={255,127,0}));
  annotation(experiment(StartTime=0, StopTime=120),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-40,-40},{40,40}},  initialScale=0.1)),
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-40,-40},{40,40}},  initialScale=0.1)),
Documentation(info="<html>
<p>
Example that test the component UDPSenderReceiver.
</p>
</html>",
revisions="<html>
<ul>
<li>
March 7, 2019, by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
end ExampleUDPSenderReceiverClocked;
