curl https://sh.rustup.rs -sSf | sh -s -- -y
source ~/.bashrc
cargo install tunnelto
tunnelto set-auth --key GeBoAW1CSmWK5SbfOXUmU8
tunnelto --host localhost --subdomain sewagepuppy --port 7860
