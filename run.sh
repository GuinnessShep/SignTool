apt update
apt full-upgrade -y
apt install unzip
wget https://github.com/oobabooga/text-generation-webui/releases/download/installers/oobabooga_linux.zip
unzip oobabooga_linux.zip
rm -rf oobabooga_linux.zip
cd oobabooga_linux
rm -rf webui.py
wget https://raw.githubusercontent.com/GuinnessShep/SignTool/master/webui.py
bash start_linux.sh
