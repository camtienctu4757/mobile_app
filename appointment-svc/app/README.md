# Create, running, build fast api on linux ( deb )

# Create new project

## Create virtual env

```sh
sudo apt-get install -y python3-venv
mkdir -p ./venv
cd  ./venv
python3 -m venv venv
source venv/bin/activate
pip install -r ./build/requirements.txt
```