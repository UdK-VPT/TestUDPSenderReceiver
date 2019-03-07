within TestUDPSenderReceiver;
model KeyboardController
  parameter Real maxArrowUp = 100.0
    "Maximum value arrow up";
  parameter Real minArrowDown = 1.0
    "Minimum value arrow down";
  parameter Real maxArrowRight = 100.0
    "Maximum value arrow right";
  parameter Real minArrowLeft = 1.0
    "Minimum value arrow left";
  Modelica.Blocks.Interfaces.RealOutput arrowUpDownReturn
    "Hold arrow up: increasing real value; hold arrow down: decreasing real value"
    annotation (Placement(transformation(extent={{100,60},{120,80}}),
      iconTransformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput ArrowRightLeftReturn
    "Hold arrow right: increasing real value; hold arrow left: decreasing real value"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}}),
      iconTransformation(extent={{100,-80},{120,-60}})));
  TestUDPSenderReceiver.BooleanInputController booInpCon1(
    y_start=1.0,
    ampFac=1.0,
    y_min=minArrowDown,
    y_max=maxArrowUp)
    annotation (Placement(transformation(extent={{14,-26},{36,-2}})));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardInput keyboard(
    sampleTime=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  BooleanInputController booInpCon2(
    y_start=1.0,
    ampFac=1.0,
    y_min=minArrowLeft,
    y_max=maxArrowRight)
    annotation (Placement(transformation(extent={{14,-82},{36,-58}})));
equation
  connect(keyboard.keyUp, booInpCon1.uPos) annotation (Line(points={{11,6},{17.35,
          6},{17.35,-10.4},{19.5,-10.4}}, color={255,0,255}));
  connect(keyboard.keyDown, booInpCon1.uNeg) annotation (Line(points={{0,-11},{0,
          -17.6},{19.5,-17.6}}, color={255,0,255}));
  connect(keyboard.keyRight, booInpCon2.uPos) annotation (Line(points={{6,-11},{
          6,-66.4},{19.5,-66.4}}, color={255,0,255}));
  connect(keyboard.keyLeft, booInpCon2.uNeg) annotation (Line(points={{-6,-11},{
          -6,-73.6},{19.5,-73.6}}, color={255,0,255}));
  connect(booInpCon2.y, ArrowRightLeftReturn)
    annotation (Line(points={{30.5,-70},{110,-70}}, color={0,0,127}));
  connect(booInpCon1.y, arrowUpDownReturn) annotation (Line(points={{30.5,-14},{
          40,-14},{40,70},{110,70}}, color={0,0,127}));
  annotation (Icon(graphics={Polygon(
          points={{0,-100},{-80,-100},{-88,-98},{-94,-94},{-98,-88},{-100,-80},
              {-100,80},{-98,88},{-94,94},{-88,98},{-80,100},{80,100},{88,98},{
              94,94},{98,88},{100,80},{100,-80},{98,-88},{94,-94},{88,-98},{80,
              -100},{0,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{0,-100},{-80,-100},{-88,-98},{-94,-94},{-98,-88},{-100,-80},
              {-100,80},{-98,88},{-94,94},{-88,98},{-80,100},{80,100},{88,98},{
              94,94},{98,88},{100,80},{100,-80},{98,-88},{94,-94},{88,-98},{80,
              -100},{0,-100}},
          color={0,64,127},
          thickness=0.5),
        Rectangle(
          extent={{-28,58},{28,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-28,58},{-20,58},{-20,18},{-28,2},{-28,58}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{28,58},{18,58},{18,18},{28,2},{28,58}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-28,2},{-20,18},{18,18},{28,2},{-28,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-28,2},{28,-54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,2},{84,-54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-84,2},{-28,-54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-84,-54},{-76,-38},{-38,-38},{-28,-54},{-84,-54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-84,2},{-76,2},{-76,-38},{-84,-54},{-84,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-28,2},{-38,2},{-38,-38},{-28,-54},{-28,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-28,2},{-20,2},{-20,-38},{-28,-54},{-28,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{28,2},{18,2},{18,-38},{28,-54},{28,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-28,-54},{-20,-38},{18,-38},{28,-54},{-28,-54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{28,2},{36,2},{36,-38},{28,-54},{28,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{84,2},{74,2},{74,-38},{84,-54},{84,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{28,-54},{36,-38},{74,-38},{84,-54},{28,-54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-2,50},{-2,28}}, color={95,95,95}),
        Polygon(
          points={{-2,50},{-6,42},{2,42},{-2,50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-2,-6},{-2,-28}}, color={95,95,95}),
        Polygon(
          points={{-2,-28},{-6,-20},{2,-20},{-2,-28}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-46,-18},{-68,-18}}, color={95,95,95}),
        Polygon(
          points={{-60,-22},{-68,-18},{-60,-14},{-60,-22}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{66,-18},{44,-18}}, color={95,95,95}),
        Polygon(
          points={{58,-22},{66,-18},{58,-14},{58,-22}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-2,70},{-2,58}},      color={28,108,200}),
        Line(points={{-2,70},{100,70}}, color={28,108,200}),
        Line(points={{100,-70},{56,-70}}, color={28,108,200}),
  Text(extent={{-100,154},{100,114}},textString="%name"),
        Line(points={{56,-54},{56,-70}},  color={28,108,200})}));
end KeyboardController;
