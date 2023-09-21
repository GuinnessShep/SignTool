curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
cargo install tunnelto
tunnelto set-auth --key GeBoAW1CSmWK5SbfOXUmU8
tunnelto --host localhost --subdomain sewagepuppy --port 7860
