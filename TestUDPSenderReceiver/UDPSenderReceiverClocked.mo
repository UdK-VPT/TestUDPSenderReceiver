within TestUDPSenderReceiver;
model UDPSenderReceiverClocked
  "Component for sending and receiving Real and Integer data over the UDP protocol"
  extends TestUDPSenderReceiver.UDPSenderReceiverGeneral;
  parameter Modelica.SIunits.Time period = 2.0
    "Period of clock (defined as Real number)";
  Modelica_DeviceDrivers.ClockedBlocks.OperatingSystem.SynchronizeRealtime synchronizeRealtime(
   enableRealTimeScaling=if useReaTimFac == true then true else false)
   annotation (Placement(transformation(extent={{-16,40},{4,60}})));
  Modelica_DeviceDrivers.ClockedBlocks.Packaging.SerialPackager.Packager packager
   annotation (Placement(transformation(extent={{-16,16},{4,36}})));
  Modelica_DeviceDrivers.ClockedBlocks.Packaging.SerialPackager.AddReal addReal(
   n=nRealIn,
   nu=1) if nRealIn > 0
   annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
  Modelica_DeviceDrivers.ClockedBlocks.Communication.UDPSend uDPSend(
   port_send=port_send,
   IPAddress=IPAddress)
  annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={-6,-52})));
  Modelica_Synchronous.RealSignals.Sampler.SampleVectorizedAndClocked sampleReal(
   n=nRealIn) if nRealIn > 0
   annotation (Placement(transformation(extent={{-36,-6},{-24,6}})));
  Modelica_Synchronous.ClockSignals.Clocks.PeriodicRealClock clock(
   period=period)
   annotation (Placement(transformation(extent={{-70,-74},{-50,-54}})));
  Modelica_DeviceDrivers.ClockedBlocks.Communication.UDPReceive uDPReceive(
    port_recv=port_recv)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={24,50})));
  Modelica_DeviceDrivers.ClockedBlocks.Packaging.SerialPackager.GetReal getReal(
    n=nRealOut,
    nu= if nIntegerOut > 0 then 1 else 0) if nRealOut > 0
    annotation (Placement(transformation(extent={{14,-10},{34,10}})));
  Modelica_Synchronous.RealSignals.Sampler.AssignClockVectorized assignClockReal(
    n=nRealOut) if nRealOut > 0
    annotation (Placement(transformation(extent={{44,-6},{56,6}})));
  Modelica_Synchronous.RealSignals.Sampler.Hold holdReal[nRealOut] if nRealOut > 0
    annotation (Placement(transformation(extent={{62,-6},{74,6}})));
  Modelica.Blocks.Interfaces.RealInput uReal[nRealIn] if nRealIn > 0
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={-90,0}),
      iconTransformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Interfaces.RealOutput yReal[nRealOut] if nRealOut > 0
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={90,0}),
      iconTransformation(extent={{-10,-10},{10,10}},rotation=0,origin={70,10})));
  Modelica.Blocks.Interfaces.IntegerInput uInteger[nIntegerIn] if nIntegerIn > 0
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={-90,-26}),
      iconTransformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Interfaces.IntegerOutput yInteger[nIntegerOut] if nIntegerOut > 0
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0,origin={90,-26}),
      iconTransformation(extent={{60,-20},{80,0}})));
  Modelica_DeviceDrivers.ClockedBlocks.Packaging.SerialPackager.AddInteger addInteger(
    n=nIntegerIn,
    nu=1) if nIntegerIn > 0
    annotation (Placement(transformation(extent={{-16,-36},{4,-16}})));
  Modelica_DeviceDrivers.ClockedBlocks.Packaging.SerialPackager.GetInteger getInteger(
    n=nIntegerOut) if nIntegerOut > 0
    annotation (Placement(transformation(extent={{14,-36},{34,-16}})));
  Modelica_Synchronous.IntegerSignals.Sampler.AssignClockVectorized assignClockInteger(
    n=nIntegerOut) if nIntegerOut > 0
    annotation (Placement(transformation(extent={{40,-32},{52,-20}})));
  Modelica_Synchronous.IntegerSignals.Sampler.Hold holdInteger[nIntegerOut] if nIntegerOut > 0
    annotation (Placement(transformation(extent={{60,-32},{72,-20}})));
  Modelica_Synchronous.IntegerSignals.Sampler.SampleVectorizedAndClocked sampleInteger(
   n=nIntegerIn) if nIntegerIn > 0
    annotation (Placement(transformation(extent={{-48,-32},{-36,-20}})));
equation
  // UDP data exchange
  // Inputs
  if nRealIn > 0 then
    connect(packager.pkgOut,addReal.pkgIn) annotation (Line(
      points={{-6,15.2},{-6,10.8}}));
  end if;

  if nRealIn == 0 and nRealIn > 0 then
    connect(packager.pkgOut, addInteger.pkgIn) annotation (Line(
      points={{-6,15.2},{-6,-15.2}}));
  end if;

  if nRealIn > 0 and nIntegerIn > 0 then
    connect(addReal.pkgOut[1], addInteger.pkgIn)
      annotation (Line(points={{-6,-10.8},{-6,-15.2}}, color={0,0,0}));
  end if;

  if nIntegerIn > 0 then
    connect(uDPSend.pkgIn, addInteger.pkgOut[1])
      annotation (Line(points={{-6,-41.2},{-6,-36.8}}, color={0,0,0}));
  end if;

  if nIntegerIn == 0 and nRealIn > 0 then
    connect(uDPSend.pkgIn, addReal.pkgOut[1])
      annotation (Line(points={{-6,-41.2},{-6,-10.8}}, color={0,0,0}));
  end if;

  // Outputs
  if nRealOut > 0 then
    connect(uDPReceive.pkgOut,getReal.pkgIn) annotation (Line(
      points={{24,39.2},{24,10.8}}));
  end if;

  if nRealOut > 0 and nIntegerOut > 0 then
  connect(getReal.pkgOut[1], getInteger.pkgIn)
    annotation (Line(points={{24,-10.8},{24,-15.2}}, color={0,0,0}));
  end if;

  if nRealOut == 0 and nIntegerOut > 0 then
    connect(uDPReceive.pkgOut,getInteger.pkgIn) annotation (Line(
      points={{24,39.2},{24,-15.2}}));
  end if;

  connect(sampleReal.y, addReal.u)
    annotation (Line(points={{-23.4,0},{-18,0}},color={0,0,127}));
  connect(clock.y, sampleReal.clock) annotation (Line(
    points={{-49,-64},{-30,-64},{-30,-7.2}},color={175,175,175},
    pattern=LinePattern.Dot,thickness=0.5));
  connect(getReal.y,assignClockReal.u) annotation (Line(
    points={{35,0},{42.8,0}},  color={0,0,127}));
  connect(clock.y, assignClockReal.clock) annotation (Line(
    points={{-49,-64},{50,-64},{50,-7.2}},
    color={175,175,175},pattern=LinePattern.Dot,thickness=0.5));
  connect(assignClockReal.y, holdReal.u)
    annotation (Line(points={{56.6,0},{60.8,0}}, color={0,0,127}));
  connect(clock.y, assignClockReal.clock) annotation (Line(
    points={{-49,-64},{50,-64},{50,-7.2}},
    color={175,175,175},pattern=LinePattern.Dot,thickness=0.5));
  connect(uReal, sampleReal.u)
    annotation (Line(points={{-90,0},{-37.2,0}}, color={0,0,127}));
  connect(holdReal.y, yReal)
    annotation (Line(points={{74.6,0},{90,0}}, color={0,0,127}));
  connect(holdInteger.y, yInteger)
    annotation (Line(points={{72.6,-26},{90,-26}}, color={255,127,0}));
  connect(assignClockInteger.y, holdInteger.u)
    annotation (Line(points={{52.6,-26},{58.8,-26}}, color={255,127,0}));
  connect(getInteger.y, assignClockInteger.u)
    annotation (Line(points={{35,-26},{38.8,-26}}, color={255,127,0}));
  connect(assignClockInteger.clock, clock.y)
    annotation (Line(points={{46,-33.2},{46,-64},{-49,-64}},color={175,175,175},
      pattern=LinePattern.Dot,thickness=0.5));
  connect(sampleInteger.y, addInteger.u)
    annotation (Line(points={{-35.4,-26},{-18,-26}}, color={255,127,0}));
  connect(uInteger, sampleInteger.u)
    annotation (Line(points={{-90,-26},{-49.2,-26}}, color={255,127,0}));
  connect(sampleInteger.clock, clock.y)
    annotation (Line(points={{-42,-33.2},{-42,-64},{-49,-64}},
      color={175,175,175},pattern=LinePattern.Dot,thickness=0.5));
  if useReaTimFac == true then
  connect(reaTimFac, synchronizeRealtime.scaling)
    annotation (Line(points={{-90,50},{-18,50}}, color={0,0,127}));
  end if;

  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},{80,80}},  initialScale=0.1)),
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-80,-80},{80,80}}, initialScale=0.1),graphics={
    Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,0}),
    Text(extent={{-54,42},{58,-38}},lineColor={0,0,255},textString="UDP"),
    Text(extent={{-80,84},{84,60}},textString="%name",lineColor={0,0,255})}),
Documentation(info="<html>
<p>
Component for sending and receiving data over the UDP protocol.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 6, 2019, by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
end UDPSenderReceiverClocked;
