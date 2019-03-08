within TestUDPSenderReceiver;
model UDPSenderReceiverFunctions
  "Component for sending and receiving Real and Integer data over the UDP protocol"
  extends TestUDPSenderReceiver.UDPSenderReceiverGeneral;
  import SI = Modelica.SIunits;
  parameter SI.Period sampleTime = 0.1 "Sample period of component"
    annotation(Dialog(group="Activation"));
  parameter SI.Time startTime = 0 "First sample time instant"
    annotation(Dialog(group="Activation"));
  final parameter Integer recvBufferSize = nRealOut*8 + nIntegerOut*4;
  final parameter Integer sendBufferSize = nRealIn*8 + nIntegerIn*4;
  Modelica_DeviceDrivers.Communication.UDPSocket udprecv = Modelica_DeviceDrivers.Communication.UDPSocket(port_recv, recvBufferSize, true);
  Modelica_DeviceDrivers.Packaging.SerialPackager pkgrecv = Modelica_DeviceDrivers.Packaging.SerialPackager(recvBufferSize);
  Modelica_DeviceDrivers.Communication.UDPSocket udpsend = Modelica_DeviceDrivers.Communication.UDPSocket(0,0);
  Modelica_DeviceDrivers.Packaging.SerialPackager pkgsend = Modelica_DeviceDrivers.Packaging.SerialPackager(sendBufferSize);

  output Integer nRecvBytes(start=0,fixed=true);
  output Integer nRecvbufOverwrites(start=0,fixed=true);
protected
  parameter  Modelica_DeviceDrivers.Utilities.Types.ByteOrder byteOrder = Modelica_DeviceDrivers.Utilities.Types.ByteOrder.LE;
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
