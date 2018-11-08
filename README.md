Bootstraps a vultr server with nixos

Be sure to replace the public key with your own when you fork this


```
nix-env -iA nixos.gitMinimal

git clone https://github.com/ravloony/nixos-vultr-bootstrap.git

cd nixos-vultr-bootstrap
./bootstrap.sh
reboot
```
