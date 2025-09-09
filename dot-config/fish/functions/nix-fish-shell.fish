function nix-fish-shell --wraps="nix-shell"
    nix-shell $argv --command fish
end
