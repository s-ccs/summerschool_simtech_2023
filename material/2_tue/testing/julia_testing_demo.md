# Notes for Demos of Python Testing Frameworks

Example code is in [05_testing_and_ci/examples/python_testing](https://github.com/Simulation-Software-Engineering/Lecture-Material/blob/main/05_testing_and_ci/examples/python_testing)

## Software Code Used

- The package `MyTestPackage` has a two functions `find_max` and `find_mean` which calculate the maximum or mean of all elements of a `::AbstractVector`.
- An assertion was added to check for any `NaN` values
- Assertion statements are the most basic way of testing code and are also used in unit and integration testing.
- Tests are written in the file `./test/find_max.jl`. Which is loaded via `runtests.jl` and we included for completeness a `setup.jl` to facilitate local testing
- In all there are two unit tests, one integration test and one regression test.
- The unit tests test the individual functions `find_max`
- The integration test triggers both the functions `find_max` and `find_mean` and checks that the mean is less than the maximum, something that should always be true for a set of numbers.
- The regression test first reads an old data set and a mean value from a CSV file. Then the function `find_mean` is run with the old data set and the new mean value is compared to the old one.

## 
- All tests can be run using the package manager `]test` (if you are in the `MyTestPackage` environment).
- One test is expected to fail. XXX DOESNT FAIL IN JULIA :/ Reading the error message we understand that the failure occurs because floating-point variable comparison is not handled correctly.
- We need to tell `@test` that while comparing two floating-point variables the value needs to be correct only up to a certain tolerance limit. To do this the expected mean value needs to be changed by uncommenting the line in the following part of the code:

```python
# Expected result
    expected_mean = 78.33
    # expected_result = pytest.approx(78.3, abs=0.01)
```

- **Comparing floating point variables** needs to be handled in functions like `find_mean` and is done using `@ŧest approx(valueA,valueB;atol=0.01)` or `@ŧest valueA ≈ valueB` (`\approx` + TAB). The `abs` value is the tolerance up to which the floating-point value will be checked, that is `78.33 +/- 0.01`.

XXX


- pytest not only points to the assertion but also prints out the test which has failed.
- It is worth noting that pytest is also able to detect tests from other files and run them even if they are not in the conventional test formats.
- pytest is able to detect tests in several forms of folder structures, and the folder structures have advantages and disadvantages. More information on this is in the [documentation](https://docs.pytest.org/en/6.2.x/goodpractices.html#choosing-a-test-layout-import-rules). In this demo we use the simplest folder structure where the source file and the test files are at the same directory level. Very often this is not the case. A more organized folder structure can be generated:

```bash
operations.py
tests/
    test_operations.py
    test_operations_unittests.py
        ...
```

- Putting the tests in a folder `tests/` does not affect the behavior of pytest. When pytest is run from the original directory, the tests are found and run.

## coverage

- Installing coverage using pip:

```bash
pip install -U coverage
```

- Testing frameworks can be run via coverage. Lets take our first example and run pytest via coverage:

```bash
coverage run -m pytest
```

- coverage does not generate any output immediately as it would interfere with the test output.
- Code coverage information is stored in a file `.coverage` in the working directory. This information can be viewed using:

```bash
coverage report -m
```

- A more fancier report can be viewed by generating HTML output using

```bash
coverage html
```

- The file `htmlcov/index.html` can be opened in a browser to view the test coverage report.

## tox

- Automation for Python testing (and much more)
- Virtual environments are created for each task, and tox takes care of installing dependencies and the package itself inside of the environment.
- Order of preference for files that tox tries to read: `pyproject.toml`, `tox.ini`, `setup.cfg`
- `tox.ini` file

```ini
[tox]
envlist = my_env
skipsdist = true

[testenv]
deps = pytest
commands = pytest
```

- Global settings defined under section `[tox]` in the INI file.
- Start tox by running the command `tox` in the directory where the `tox.ini` exists.
- tox takes more time the first time it is run as it creates the necessary virtual environments. Virtual environment setup can be found in the `.tox` repository.
- Observe that tox starts a virtual environment, installs the dependency (here `pytest`) and runs `pytest`.
