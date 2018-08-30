For Falcon to work, you need to have a working copy of Matlab installed on the machine.
You also need to install the MATLAB API for Python, as described in:
https://uk.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html
Briefly, to install the MATLAB API for Python:
```
cd "<matlabroot>/extern/engines/python"
python setup.py install
```
where <matlabroot> is the installation directory of your copy of MATLAB.


