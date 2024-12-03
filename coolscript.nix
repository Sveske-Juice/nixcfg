{config, pkgs}:

pkgs.writeShellScriptBin "cols" ''
    echo ${config.lib.stylix.colors}
''
