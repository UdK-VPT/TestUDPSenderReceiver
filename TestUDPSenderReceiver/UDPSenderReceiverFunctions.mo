within TestUDPSenderReceiver;
model UDPSenderReceiverFunctions
  "Component for sending and receiving Real and Integer data over the UDP protocol"
  parameter Integer nRealIn(min=1) = 1
    "Number of input signals";
  parameter Integer nIntegerIn(min=1) = 1
    "Number of input signals";
  parameter Integer nRealOut(min=1) = 1
    "Number of output signals";
  parameter Integer nIntegerOut(min=1) = 1
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
  Modelica.Blocks.Interfaces.RealInput uReal[nRealIn]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={-90,0}),
      iconTransformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Interfaces.RealOutput yReal[nRealOut]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={90,0}),
      iconTransformation(extent={{-10,-10},{10,10}},rotation=0,origin={70,10})));
  Modelica.Blocks.Interfaces.IntegerInput uInteger[nIntegerIn]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={-90,-26}),
      iconTransformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Interfaces.IntegerOutput yInteger[nIntegerOut]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0,origin={90,-26}),
      iconTransformation(extent={{60,-20},{80,0}})));
  Modelica.Blocks.Interfaces.RealInput reaTimFac if useReaTimFac == true
    "Real time factor: 1.0 -> equal to real time; 2.0 -> two times faster than than real time"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={-90,50}),
      iconTransformation(extent={{-80,40},{-60,60}})));

  parameter Modelica.SIunits.Period sampleTime = 0.1 "Sample period of component"
    annotation(Dialog(group="Activation"));
  parameter Modelica.SIunits.Time startTime = 0 "First sample time instant"
    annotation(Dialog(group="Activation"));
  final parameter Integer recvBufferSize = nRealOut*8 + nIntegerOut*4;
  final parameter Integer sendBufferSize = nRealIn*8 + nIntegerIn*4;
  Modelica_DeviceDrivers.Communication.UDPSocket udprecv =
    Modelica_DeviceDrivers.Communication.UDPSocket(port_recv, recvBufferSize, true);
  Modelica_DeviceDrivers.Packaging.SerialPackager pkgrecv =
    Modelica_DeviceDrivers.Packaging.SerialPackager(recvBufferSize);
  Modelica_DeviceDrivers.Communication.UDPSocket udpsend =
    Modelica_DeviceDrivers.Communication.UDPSocket(0,0);
  Modelica_DeviceDrivers.Packaging.SerialPackager pkgsend =
    Modelica_DeviceDrivers.Packaging.SerialPackager(sendBufferSize);
  Modelica_DeviceDrivers.Blocks.OperatingSystem.SynchronizeRealtime synchronizeRealtime(
   enableRealTimeScaling=if useReaTimFac == true then true else false)
   annotation (Placement(transformation(extent={{-16,40},{4,60}})));
  output Integer nRecvBytes(start=0,fixed=true);
  output Integer nRecvbufOverwrites(start=0,fixed=true);
protected
  parameter Modelica_DeviceDrivers.Utilities.Types.ByteOrder byteOrder =
    Modelica_DeviceDrivers.Utilities.Types.ByteOrder.LE;
algorithm
  when sample(startTime,sampleTime) then
    (nRecvBytes,nRecvbufOverwrites) := Modelica_DeviceDrivers.Communication.UDPSocket_.read(udprecv, pkgrecv);
    yReal := Modelica_DeviceDrivers.Packaging.SerialPackager_.getReal(pkgrecv, nRealOut, byteOrder);
    yInteger := Modelica_DeviceDrivers.Packaging.SerialPackager_.getInteger(pkgrecv, nIntegerOut, byteOrder);
    Modelica_DeviceDrivers.Packaging.SerialPackager_.clear(pkgsend);
    Modelica_DeviceDrivers.Packaging.SerialPackager_.addReal(pkgsend,uReal,byteOrder);
    Modelica_DeviceDrivers.Packaging.SerialPackager_.addInteger(pkgsend,uInteger,byteOrder);
    Modelica_DeviceDrivers.Communication.UDPSocket_.sendTo(udpsend, IPAddress, port_send, pkgsend, sendBufferSize);
  end when;
equation
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
Component for sending and receiving data over the UDP protocol, modelled with functions calls of the Modelica_DeviceDriver library.
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
end UDPSenderReceiverFunctions;
