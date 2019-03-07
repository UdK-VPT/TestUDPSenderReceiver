within TestUDPSenderReceiver;
model UDPSenderReceiverFunctions
  "Component for sending and receiving Real and Integer data over the UDP protocol"
  extends TestUDPSenderReceiver.UDPSenderReceiverGeneral;

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
