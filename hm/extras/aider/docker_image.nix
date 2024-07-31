{ pkgs ? import <nixpkgs> { }
,
}:

pkgs.dockerTools.buildImage {
  name = "aider";
  tag = "latest";

  contents = [
    (pkgs.writeScriptBin "aider" ''
      #!${pkgs.bash}/bin/bash
      exec ${pkgs.docker}/bin/docker run --rm -it \
        -v "$(pwd)":/app \
        -v "$HOME/.config/.aider.conf.yaml:/root/.config/.aider.conf.yml:ro" \
        -w /app \
        --network host \
        aider "$@"
    '')
  ];

  config = {
    Cmd = [ "aider" ];
    WorkingDir = "/app";
  };
}
