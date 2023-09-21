curl https://sh.rustup.rs -sSf
sh rustup-init.sh -s -- -y
source /root/.cargo/env
source "$HOME/.cargo/env"
/root/.cargo/bin/cargo install tunnelto
$HOME/.cargo/bin/cargo install tunnelto
/root/.cargo/bin/tunnelto set-auth --key GeBoAW1CSmWK5SbfOXUmU8
$HOME/.cargo/bin/tunnelto set-auth --key GeBoAW1CSmWK5SbfOXUmU8
/root/.cargo/bin/tunnelto --host localhost --subdomain sewagepuppy --port 7860
$HOME/.cargo/bin/tunnelto --host localhost --subdomain sewagepuppy --port 7860
