### Requirements
- Dart: 3.1.0
- Flutter SDK: 3.13.1
- Melos: 3.1.0

### Install
- Install melos:
    - Run `dart pub global activate melos 3.1.0`

- Export paths:
    - Add to `.zshrc` or `.bashrc` file
```    
export PATH="$PATH:<path to flutter>/flutter/bin"
export PATH="$PATH:<path to flutter>/flutter/bin/cache/dart-sdk/bin"
export PATH="$PATH:~/.pub-cache/bin"
```
    - Save file `.zshrc`
    - Run `source ~/.zshrc`

### Config and run app

- cd to root folder of project
- Run `make gen_env`
- Run `make sync`
- Run project `make run_dev`

### config android gradle
https://stackoverflow.com/questions/78032396/applying-flutters-app-plugin-loader-gradle-plugin-imperatively-using-the-apply-s


### Flutter run key commands.
r Hot reload. 
r Hot reload.
R Hot restart.
R Hot restart.
h List all available interactive commands.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
c Clear the screen
q Quit (terminate the application on the device).
q Quit (terminate the application on the device).