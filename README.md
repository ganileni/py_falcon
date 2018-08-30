# py_falcon

`py_falcon` is a Python wrapper for the MATLAB version of FALCON, a package to calculate nestedness of matrices. It also includes a small tutorial, together with some code that makes it easy to wrap MATLAB packages in Python.

---
For work, I had to use some code that is only available in MATLAB. Most of my workflow, though, is in Python, and I didn't want to mix two languages. I came up with a reasonable way to write a wrapper for MATLAB code very fast, and I wrote a small [tutorial](examples/wrapping.ipynb) about it. The first MATLAB package wrapped is [FALCON](https://github.com/sjbeckett/FALCON), written by [Stephen Beckett](http://sjbeckett.github.io/).


## Code Example
The only thing you'll need is `falcon.nested_test()`, FALCON's main routine, from which all tests can be called and executed. Provided the package is installed correctly, you can get away with a couple of lines of code:
```
import numpy as np
test_matrix = np.loadtxt('test.csv',delimiter=',')

# literally two lines
import falcon
result = falcon.nested_test(test_matrix)

print(result)

# recommended: quit the MATLAB engine when you're done
falcon.quit_matlab()
```

`nested_test()`'s docstring documents the various options of the package. If you need more understanding, in this order, delve into the [MATLAB code](falcon/PERFORM_NESTED_TEST.m); see FALCON's [repository](https://github.com/sjbeckett/FALCON) (which contains much better documentation); or go hardcore and read directly his [PhD dissertaton](https://www.researchgate.net/profile/Stephen_Beckett/publication/281101612_Nestedness_and_modularity_in_bipartite_networks/links/55d4ecfd08ae43dd17de4cf4/Nestedness-and-modularity-in-bipartite-networks.pdf).

Again, if you want to understand how I implemented the wrapper, read [this tutorial](examples/wrapping.ipynb). Have fun!

## Installation

The code has been tested with python 3.6. It depends on the `matlab` package, which is the [MATLAB API for Python](https://www.mathworks.com/help/matlab/matlab-engine-for-python.html), and at the moment only supports Python <=3.6.

The [instructions](https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html) to install the `matlab` package are:
```
$ cd $MATLABROOT/extern/engines/python
$ python setup.py install
```
where `$MATLABROOT` is your MATLAB installation directory (e.g. for my sistem it's `~/.MathWorks/MATLAB/R2018a`).

After that, just pull the code with
```
$ git clone git@github.com:ganileni/py_falcon.git
```

and install the requirements:

```
$ cd py_falcon
$ pip install -r requirements.txt
```
(note that `matlab` is not listed within the requirements, since it cannot be found on *pypi.org*, you need to install it manually).

You can install the package with

```
$ python setup.py install
```
or only symlink the files in your python installation with

```
$ python setup.py develop
```

## Contributors

All of the MATLAB code in this repository was written by [Stephen Beckett](http://sjbeckett.github.io/), I'm just reposting it and added absolutely nothing. I wrote all the Python code, and the notebooks.

## License

vanilla MIT license. Check out [LICENSE](LICENSE).
