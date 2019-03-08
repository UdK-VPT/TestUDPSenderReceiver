within TestUDPSenderReceiver;
model UDPSenderReceiver
  "Component for sending and receiving Real and Integer data over the UDP protocol"
  extends TestUDPSenderReceiver.UDPSenderReceiverGeneral;
  Modelica_DeviceDrivers.Blocks.OperatingSystem.SynchronizeRealtime synchronizeRealtime(
   enableRealTimeScaling=if useReaTimFac == true then true else false)
   annotation (Placement(transformation(extent={{-16,40},{4,60}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.Packager packager
   annotation (Placement(transformation(extent={{-16,16},{4,36}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddReal addReal(
   n=nRealIn,
   nu=1) if nRealIn > 0
   annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
  Modelica_DeviceDrivers.Blocks.Communication.UDPSend uDPSend(
   port_send=port_send,
   IPAddress=IPAddress)
  annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={-6,-52})));
  Modelica_DeviceDrivers.Blocks.Communication.UDPReceive uDPReceive(
    port_recv=port_recv)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={24,50})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetReal getReal(
    n=nRealOut,
    nu= if nIntegerOut > 0 then 1 else 0) if nRealOut > 0
    annotation (Placement(transformation(extent={{14,-10},{34,10}})));
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
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger
    addInteger(n=nIntegerIn,
    nu=1) if nIntegerIn > 0
    annotation (Placement(transformation(extent={{-16,-36},{4,-16}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getInteger(
    n=nIntegerOut) if nIntegerOut > 0
    annotation (Placement(transformation(extent={{14,-56},{34,-36}})));
equation
  // UDP data exchange
  // Inputs
  if nRealIn > 0 then
    connect(packager.pkgOut,addReal.pkgIn) annotation (Line(
      points={{-6,15.2},{-6,10.8}}));
    connect(uReal, addReal.u)
    annotation (Line(points={{-90,0},{-18,0}}, color={0,0,127}));
  end if;

  if nRealIn == 0 and nIntegerIn > 0 then
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
    connect(uInteger, addInteger.u)
      annotation (Line(points={{-90,-26},{-18,-26}}, color={255,127,0}));
  end if;

  if nIntegerIn == 0 and nRealIn > 0 then
    connect(uDPSend.pkgIn, addReal.pkgOut[1])
      annotation (Line(points={{-6,-41.2},{-6,-10.8}}, color={0,0,0}));
  end if;

  // Outputs
  if nRealOut > 0 then
    connect(uDPReceive.pkgOut,getReal.pkgIn) annotation (Line(
      points={{24,39.2},{24,10.8}}));
    connect(getReal.y, yReal)
      annotation (Line(points={{35,0},{90,0}}, color={0,0,127}));
  end if;

  if nRealOut > 0 and nIntegerOut > 0 then
    connect(getReal.pkgOut[1], getInteger.pkgIn)
      annotation (Line(points={{24,-10.8},{24,-35.2}}, color={0,0,0}));
    connect(getInteger.y, yInteger)
      annotation (Line(points={{35,-46},{62,-46},{62,-26},{90,-26}},color={255,127,0}));
  end if;
  if nRealOut == 0 and nIntegerOut > 0 then
    connect(uDPReceive.pkgOut,getInteger.pkgIn)
      annotation (Line(points={{24,39.2},{24,-15.2}}));
    connect(getInteger.y, yInteger)
      annotation (Line(points={{35,-46},{62,-46},{62,-26},{90,-26}},color={255,127,0}));
  end if;

  if useReaTimFac == true then
  connect(reaTimFac, synchronizeRealtime.scaling)
    annotation (Line(points={{-90,50},{-18,50}}, color={0,0,127}));
  end if;

  annotation (
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
end UDPSenderReceiver;
