within TestUDPSenderReceiver;
model UDPSenderReceiverGeneral
  "Component for sending and receiving Real and Integer data over the UDP protocol"
  parameter Integer nRealIn = 1
    "Number of input signals";
  parameter Integer nIntegerIn = 1
    "Number of input signals";
  parameter Integer nRealOut = 1
    "Number of output signals";
  parameter Integer nIntegerOut = 1
    "Number of output signals";
  parameter Boolean useReaTimFac = false
    "Use real time factor as an input";
  parameter String IPAddress="127.0.0.1" "IP address of remote UDP server"
    annotation (Dialog(group="Outgoing data"));
  parameter Integer port_send=10003 "Target port of the receiving UDP server"
    annotation (Dialog(group="Outgoing data"));
  parameter Integer port_recv=10002
      "Listening port number of the server. Must be unique on the system"
      annotation (Dialog(group="Incoming data"));
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
  Modelica.Blocks.Interfaces.RealInput reaTimFac if useReaTimFac == true
    "Real time factor: 1.0 -> equal to real time; 2.0 -> two times faster than than real time"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={-90,50}),
      iconTransformation(extent={{-80,40},{-60,60}})));

  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},{80,80}},  initialScale=0.1)),
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-80,-80},{80,80}}, initialScale=0.1),graphics={
    Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,0}),
    Text(extent={{-54,42},{58,-38}},lineColor={0,0,255},textString="UDP"),
    Text(extent={{-80,84},{84,60}},textString="%name",lineColor={0,0,255}),
    Line(points={{-40,-40},{40,-40}},color={0,0,255},thickness=1),
    Polygon(points={{-40,-40},{-20,-30},{-20,-50},{-40,-40}},lineColor={0,0,255},
      lineThickness=1,fillColor={255,255,255},fillPattern=FillPattern.Solid),
    Polygon(points={{40,-40},{20,-50},{20,-30},{40,-40}},lineColor={0,0,255},
      lineThickness=1,fillColor={255,255,255},fillPattern=FillPattern.Solid)}),
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
end UDPSenderReceiverGeneral;
