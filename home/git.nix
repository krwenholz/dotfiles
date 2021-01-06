{ config, pkgs, ... }:

{
  home-manager.users.kyle = { pkgs, ...}: {
    programs.git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "Kyle Wenholz";
      userEmail = "kyle@ngrok.com";
      signing = {
        key = "kyle@ngrok.com";
        signByDefault = false;
      };
      extraConfig = {
        core.editor = "vim";
        pager = {
          diff = "diff-so-fancy | less --tabs=1,5 -RFX";
          show = "diff-so-fancy | less --tabs=1,5 -RFX";
        };
        credential = {
          helper = "cache --timeout=36000";
        };
        push = {
          default = "simple";
        };
      };
      ignores = [
        "*~"

        # KDE directory preferences
        ".directory"

        # Linux trash folder which might appear on any partition or disk
        ".Trash-*"

        # Vim #
        #######
        "[._]*.s[a-w][a-z]"
        "[._]s[a-w][a-z]"
        "*.un~"
        "Session.vim"
        ".netrwhist"
        "*~"

        # Compiled source #
        ###################
        "*.com"
        "*.class"
        "*.dll"
        "*.exe"
        "*.o"
        "*.so"

        # Packages #
        ############
        # it's better to unpack these files and commit the raw source
        # git has its own built in compression methods
        "*.7z"
        "*.dmg"
        "*.gz"
        "*.iso"
        "*.jar"
        "*.rar"
        "*.tar"
        "*.zip"
        "Gemfile.lock"

        # Logs and databases #
        ######################
        "*.log"
        "*.sqlite"

        # OS generated files #
        ######################
        ".DS_Store"
        ".DS_Store?"
        "._*"
        ".Spotlight-V100"
        ".Trashes"
        "ehthumbs.db"
        "Thumbs.db"

        # Python #
        ##########
        "venv/"
        ".python-version"
        # Byte-compiled / optimized / DLL files"
        "venv/"
        ".venv/"
        "__pycache__/"
        "*.py[cod]"
        "*$py.class"

        # C extensions
        "*.so"

        # PyInstaller
        #  Usually these files are written by a python script from a template
        #  before PyInstaller builds the exe, so as to inject date/other infos into it.
        "*.manifest"
        "*.spec"

        # Installer logs
        "pip-log.txt"
        "pip-delete-this-directory.txt"

        # Unit test / coverage reports
        "htmlcov/"
        ".tox/"
        ".coverage"
        ".coverage.*"
        ".cache"
        "nosetests.xml"
        "coverage.xml"
        "*,cover"
        ".hypothesis/"

        # Translations
        "*.mo"
        "*.pot"

        # Sphinx documentation
        "docs/_build/"

        # PyBuilder
        "target/"

        # Jetbrains #
        #############
        # Covers JetBrains IDEs: IntelliJ, RubyMine, PhpStorm, AppCode, PyCharm, CLion, Android Studio and Webstorm
        "*.iml"

        ## Directory-based project format:
        ".idea/"
        # if you remove the above rule, at least ignore the following:

        ## File-based project format:
        "*.ipr"
        "*.iws"

        ## Plugin-specific files:

        # Crashlytics plugin (for Android Studio and IntelliJ)
        "com_crashlytics_export_strings.xml"
        "crashlytics.properties"
        "crashlytics-build.properties"
        "fabric.properties"

        # Node #
        ########
        "node_modules"

        # elm #
        ########
        "*elm-stuff/"

        # terraform #
        #############
        "*.terraform/"
        "*.tfstate*"
        "*.tfvars"

        # solargraph #
        ##############
        ".solargraph*"

        # ruby #
        ########
        "bundle/"
        ".bundle"
        ".byebug_history"
      ];
    };
  };
}
