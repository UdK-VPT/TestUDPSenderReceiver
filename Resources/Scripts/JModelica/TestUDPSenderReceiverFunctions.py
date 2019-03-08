# paths and info
import os, sys
homeDir = os.environ['HOMEPATH']
jmodDir = os.environ['JMODELICA_HOME']
workDir = "../../GitRepos" # has to be adapted by the user !!!
moLiDir = os.path.join(homeDir, workDir,"TestUDPSenderReceiver")

# give the path to directory where package.mo is stored
moLibs = [os.path.join(jmodDir,"ThirdParty\MSL\Modelica"),
          os.path.join(moLiDir,"Modelica_DeviceDrivers\Modelica_DeviceDrivers"),
          os.path.join(moLiDir,"TestUDPSenderReceiver"),
         ]

print(sys.version)
print(all(os.path.isfile(os.path.join(moLib, "package.mo")) for moLib in moLibs))
print(os.getcwd())

# <codecell> compile model to fmu
from pymodelica import compile_fmu
model_name = 'TestUDPSenderReceiver.ExampleUDPSenderReceiverFunctions'
my_fmu = compile_fmu(model_name, moLibs)

# simulate the fmu and store results
from pyfmi import load_fmu

myModel = load_fmu(my_fmu)

opts = myModel.simulate_options()
opts['solver'] = "CVode"
opts['ncp'] = 100
opts['result_handling']="file"
opts["CVode_options"]['discr'] = 'BDF'
opts['CVode_options']['iter'] = 'Newton'
opts['CVode_options']['maxord'] = 5
opts['CVode_options']['atol'] = 1e-5
opts['CVode_options']['rtol'] = 1e-5

res = myModel.simulate(start_time=0.0, final_time=120, options=opts)

# plotting of the results
import pylab as P
fig = P.figure(1)
P.clf()
# input signals
y1 = res['sine.y']
y2 = res['integer.y']
t = res['time']
P.subplot(1,1,1)
P.plot(t, y1, t, y2)
P.legend(['sine.y','integer.y'])
P.ylabel('-')
P.xlabel('Time (s)')
P.show()
