Creation of :ref:`virtual environments <venv-def>` is done by executing the
command ``venv``::

    python -m venv /path/to/new/virtual/environment

Running this command creates the target directory (creating any parent
directories that don't exist already) and places a ``pyvenv.cfg`` file in it
with a ``home`` key pointing to the Python installation from which the command
was run (a common name for the target directory is ``.venv``).  It also creates
a ``bin`` (or ``Scripts`` on Windows) subdirectory containing a copy/symlink
of the Python binary/binaries (as appropriate for the platform or arguments
used at environment creation time). It also creates an (initially empty)
``lib/pythonX.Y/site-packages`` subdirectory (on Windows, this is
``Lib\site-packages``). If an existing directory is specified, it will be
re-used.

.. versionchanged:: 3.5
   The use of ``venv`` is now recommended for creating virtual environments.

.. deprecated:: 3.6
   ``pyvenv`` was the recommended tool for creating virtual environments for
   Python 3.3 and 3.4, and is
   :ref:`deprecated in Python 3.6 <whatsnew36-venv>`.

.. highlight:: none

On Windows, invoke the ``venv`` command as follows::

    c:\>c:\Python35\python -m venv c:\path\to\myenv

Alternatively, if you configured the ``PATH`` and ``PATHEXT`` variables for
your :ref:`Python installation <using-on-windows>`::

    c:\>python -m venv c:\path\to\myenv

The command, if run with ``-h``, will show the available options::

    usage: venv [-h] [--system-site-packages] [--symlinks | --copies] [--clear]
                [--upgrade] [--without-pip] [--prompt PROMPT] [--upgrade-deps]
                ENV_DIR [ENV_DIR ...]

    Creates virtual Python environments in one or more target directories.

    positional arguments:
      ENV_DIR               A directory to create the environment in.

    optional arguments:
      -h, --help            show this help message and exit
      --system-site-packages
                            Give the virtual environment access to the system
                            site-packages dir.
      --symlinks            Try to use symlinks rather than copies, when symlinks
                            are not the default for the platform.
      --copies              Try to use copies rather than symlinks, even when
                            symlinks are the default for the platform.
      --clear               Delete the contents of the environment directory if it
                            already exists, before environment creation.
      --upgrade             Upgrade the environment directory to use this version
                            of Python, assuming Python has been upgraded in-place.
      --without-pip         Skips installing or upgrading pip in the virtual
                            environment (pip is bootstrapped by default)
      --prompt PROMPT       Provides an alternative prompt prefix for this
                            environment.
      --upgrade-deps        Upgrade core dependencies: pip setuptools to the
                            latest version in PyPI

    Once an environment has been created, you may wish to activate it, e.g. by
    sourcing an activate script in its bin directory.

.. versionchanged:: 3.9
   Add ``--upgrade-deps`` option to upgrade pip + setuptools to the latest on PyPI

.. versionchanged:: 3.4
   Installs pip by default, added the ``--without-pip``  and ``--copies``
   options

.. versionchanged:: 3.4
   In earlier versions, if the target directory already existed, an error was
   raised, unless the ``--clear`` or ``--upgrade`` option was provided.

.. note::
   While symlinks are supported on Windows, they are not recommended. Of
   particular note is that double-clicking ``python.exe`` in File Explorer
   will resolve the symlink eagerly and ignore the virtual environment.

.. note::
   On Microsoft Windows, it may be required to enable the ``Activate.ps1``
   script by setting the execution policy for the user. You can do this by
   issuing the following PowerShell command:

   PS C:\> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

   See `About Execution Policies
   <https://go.microsoft.com/fwlink/?LinkID=135170>`_
   for more information.

The created ``pyvenv.cfg`` file also includes the
``include-system-site-packages`` key, set to ``true`` if ``venv`` is
run with the ``--system-site-packages`` option, ``false`` otherwise.

Unless the ``--without-pip`` option is given, :mod:`ensurepip` will be
invoked to bootstrap ``pip`` into the virtual environment.

Multiple paths can be given to ``venv``, in which case an identical virtual
environment will be created, according to the given options, at each provided
path.

