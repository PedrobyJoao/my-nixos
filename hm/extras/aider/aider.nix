{ lib
, buildPythonApplication
, fetchFromGitHub
, pip
, setuptools
, wheel
, # Dependencies from requirements.txt
  aiohttp
, annotated-types
, anyio
, attrs
, backoff
, beautifulsoup4
, certifi
, cffi
, charset-normalizer
, click
, configargparse
, diff-match-patch
, diskcache
, distro
, filelock
, flake8
, frozenlist
, fsspec
, gitdb
, gitpython
, grep-ast
, h11
, httpcore
, httpx
, huggingface-hub
, idna
, importlib-metadata
, importlib-resources
, jinja2
, jsonschema
, litellm
, markdown-it-py
, markupsafe
, mccabe
, mdurl
, multidict
, networkx
, numpy
, openai
, packaging
, pathspec
, pillow
, prompt-toolkit
, pycodestyle
, pycparser
, pydantic
, pydantic-core
, pyflakes
, pygments
, pypandoc
, python-dotenv
, pyyaml
, regex
, requests
, rich
, rpds-py
, scipy
, smmap
, sniffio
, sounddevice
, soundfile
, soupsieve
, tiktoken
, tokenizers
, tqdm
, tree-sitter
, tree-sitter-languages
, typing-extensions
, urllib3
, wcwidth
, yarl
, zipp
,
}:

buildPythonApplication rec {
  pname = "aider-chat";
  version = "0.18.1"; # Update this to the latest version of aider

  src = fetchFromGitHub {
    owner = "paul-gauthier";
    repo = "aider";
    rev = "v${version}";
    sha256 = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"; # Replace with the actual sha256
  };

  nativeBuildInputs = [
    pip
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    (aiohttp.overridePythonAttrs (oldAttrs: {
      version = "3.9.5";
    }))
    (annotated-types.overridePythonAttrs (oldAttrs: {
      version = "0.7.0";
    }))
    (anyio.overridePythonAttrs (oldAttrs: {
      version = "4.4.0";
    }))
    (attrs.overridePythonAttrs (oldAttrs: {
      version = "23.2.0";
    }))
    (backoff.overridePythonAttrs (oldAttrs: {
      version = "2.2.1";
    }))
    (beautifulsoup4.overridePythonAttrs (oldAttrs: {
      version = "4.12.3";
    }))
    (certifi.overridePythonAttrs (oldAttrs: {
      version = "2024.7.4";
    }))
    (cffi.overridePythonAttrs (oldAttrs: {
      version = "1.16.0";
    }))
    (charset-normalizer.overridePythonAttrs (oldAttrs: {
      version = "3.3.2";
    }))
    (click.overridePythonAttrs (oldAttrs: {
      version = "8.1.7";
    }))
    (configargparse.overridePythonAttrs (oldAttrs: {
      version = "1.7";
    }))
    (diff-match-patch.overridePythonAttrs (oldAttrs: {
      version = "20230430";
    }))
    (diskcache.overridePythonAttrs (oldAttrs: {
      version = "5.6.3";
    }))
    (distro.overridePythonAttrs (oldAttrs: {
      version = "1.9.0";
    }))
    (filelock.overridePythonAttrs (oldAttrs: {
      version = "3.15.4";
    }))
    (flake8.overridePythonAttrs (oldAttrs: {
      version = "7.1.0";
    }))
    (frozenlist.overridePythonAttrs (oldAttrs: {
      version = "1.4.1";
    }))
    (fsspec.overridePythonAttrs (oldAttrs: {
      version = "2024.6.1";
    }))
    (gitdb.overridePythonAttrs (oldAttrs: {
      version = "4.0.11";
    }))
    (gitpython.overridePythonAttrs (oldAttrs: {
      version = "3.1.43";
    }))
    (grep-ast.overridePythonAttrs (oldAttrs: {
      version = "0.3.2";
    }))
    (h11.overridePythonAttrs (oldAttrs: {
      version = "0.14.0";
    }))
    (httpcore.overridePythonAttrs (oldAttrs: {
      version = "1.0.5";
    }))
    (httpx.overridePythonAttrs (oldAttrs: {
      version = "0.27.0";
    }))
    (huggingface-hub.overridePythonAttrs (oldAttrs: {
      version = "0.24.0";
    }))
    (idna.overridePythonAttrs (oldAttrs: {
      version = "3.7";
    }))
    (importlib-metadata.overridePythonAttrs (oldAttrs: {
      version = "7.2.1";
    }))
    (importlib-resources.overridePythonAttrs (oldAttrs: {
      version = "6.4.0";
    }))
    (jinja2.overridePythonAttrs (oldAttrs: {
      version = "3.1.4";
    }))
    (jsonschema.overridePythonAttrs (oldAttrs: {
      version = "4.23.0";
    }))
    (litellm.overridePythonAttrs (oldAttrs: {
      version = "1.41.27";
    }))
    (markdown-it-py.overridePythonAttrs (oldAttrs: {
      version = "3.0.0";
    }))
    (markupsafe.overridePythonAttrs (oldAttrs: {
      version = "2.1.5";
    }))
    (mccabe.overridePythonAttrs (oldAttrs: {
      version = "0.7.0";
    }))
    (mdurl.overridePythonAttrs (oldAttrs: {
      version = "0.1.2";
    }))
    (multidict.overridePythonAttrs (oldAttrs: {
      version = "6.0.5";
    }))
    (networkx.overridePythonAttrs (oldAttrs: {
      version = "3.2.1";
    }))
    (numpy.overridePythonAttrs (oldAttrs: {
      version = "1.26.4";
    }))
    (openai.overridePythonAttrs (oldAttrs: {
      version = "1.37.0";
    }))
    (packaging.overridePythonAttrs (oldAttrs: {
      version = "24.1";
    }))
    (pathspec.overridePythonAttrs (oldAttrs: {
      version = "0.12.1";
    }))
    (pillow.overridePythonAttrs (oldAttrs: {
      version = "10.4.0";
    }))
    (prompt-toolkit.overridePythonAttrs (oldAttrs: {
      version = "3.0.47";
    }))
    (pycodestyle.overridePythonAttrs (oldAttrs: {
      version = "2.12.0";
    }))
    (pycparser.overridePythonAttrs (oldAttrs: {
      version = "2.22";
    }))
    (pydantic.overridePythonAttrs (oldAttrs: {
      version = "2.8.2";
    }))
    (pydantic-core.overridePythonAttrs (oldAttrs: {
      version = "2.20.1";
    }))
    (pyflakes.overridePythonAttrs (oldAttrs: {
      version = "3.2.0";
    }))
    (pygments.overridePythonAttrs (oldAttrs: {
      version = "2.18.0";
    }))
    (pypandoc.overridePythonAttrs (oldAttrs: {
      version = "1.13";
    }))
    (python-dotenv.overridePythonAttrs (oldAttrs: {
      version = "1.0.1";
    }))
    (pyyaml.overridePythonAttrs (oldAttrs: {
      version = "6.0.1";
    }))
    (regex.overridePythonAttrs (oldAttrs: {
      version = "2024.5.15";
    }))
    (requests.overridePythonAttrs (oldAttrs: {
      version = "2.32.3";
    }))
    (rich.overridePythonAttrs (oldAttrs: {
      version = "13.7.1";
    }))
    (rpds-py.overridePythonAttrs (oldAttrs: {
      version = "0.19.0";
    }))
    (scipy.overridePythonAttrs (oldAttrs: {
      version = "1.13.1";
    }))
    (smmap.overridePythonAttrs (oldAttrs: {
      version = "5.0.1";
    }))
    (sniffio.overridePythonAttrs (oldAttrs: {
      version = "1.3.1";
    }))
    (sounddevice.overridePythonAttrs (oldAttrs: {
      version = "0.4.7";
    }))
    (soundfile.overridePythonAttrs (oldAttrs: {
      version = "0.12.1";
    }))
    (soupsieve.overridePythonAttrs (oldAttrs: {
      version = "2.5";
    }))
    (tiktoken.overridePythonAttrs (oldAttrs: {
      version = "0.7.0";
    }))
    (tokenizers.overridePythonAttrs (oldAttrs: {
      version = "0.19.1";
    }))
    (tqdm.overridePythonAttrs (oldAttrs: {
      version = "4.66.4";
    }))
    (tree-sitter.overridePythonAttrs (oldAttrs: {
      version = "0.21.3";
    }))
    (tree-sitter-languages.overridePythonAttrs (oldAttrs: {
      version = "1.10.2";
    }))
    (typing-extensions.overridePythonAttrs (oldAttrs: {
      version = "4.12.2";
    }))
    (urllib3.overridePythonAttrs (oldAttrs: {
      version = "2.2.2";
    }))
    (wcwidth.overridePythonAttrs (oldAttrs: {
      version = "0.2.13";
    }))
    (yarl.overridePythonAttrs (oldAttrs: {
      version = "1.9.4";
    }))
    (zipp.overridePythonAttrs (oldAttrs: {
      version = "3.19.2";
    }))
  ];

  # Disable the tests for now, as they might require additional setup
  doCheck = false;

  meta = with lib; {
    description = "Aider is AI pair programming in your terminal";
    homepage = "https://github.com/paul-gauthier/aider";
    license = licenses.asl20;
  };
}
