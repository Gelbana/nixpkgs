{ lib
, buildPythonPackage
, fetchPypi
, funcsigs
, setuptools-scm
, pytestCheckHook
, pythonOlder
, testfixtures
}:

buildPythonPackage rec {
  pname = "logfury";
  version = "1.0.1";

  disabled = pythonOlder "3.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-EwpdrOq5rVNJJCUt33BIKqLJZmKzo4JafTCYHQO3aiY=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    funcsigs
  ];

  checkInputs = [
    pytestCheckHook
    testfixtures
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "'setuptools_scm<6.0'" "'setuptools_scm'"
  '';

  pythonImportsCheck = [
    "logfury"
  ];

  meta = with lib; {
    description = "Python module that allows for responsible, low-boilerplate logging of method calls";
    homepage = "https://github.com/ppolewicz/logfury";
    license = licenses.bsd3;
    maintainers = with maintainers; [ jwiegley ];
  };
}
