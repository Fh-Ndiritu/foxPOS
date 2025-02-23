## Introduction

FoxPos is a Rails Point of Sale application built on ViewComponent, Turbo and Stimulus.
This has been tweaked to run locally on production mode.

## Before you install

Ensure you have [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) installed.

## Installation

1. Clone the git repo <br> `git clone git@github.com:Fh-Ndiritu/foxPOS.git`
2. Navigate to the project folder
3. Run the app in development mode <br> `docker-compose up --build `
4. Run the app in production mode locally <br> `docke-compose -f docker-compose.prod.yml up --build`

## PWA on Linux

To run the app as a native application, this relies on the start_foxpos.sh script and a desktop file to launch the PWA.

1. Copy the .desktop file to Applications Folder  
   `cp FoxPos.desktop ~/.local/share/applications/`
2. Make the .desktop File Executable  
   `chmod +x ~/.local/share/applications/FoxPos.desktop`

3. Copy the .desktop File to the Desktop (Optional)  

```
  cp ~/.local/share/applications/FoxPos.desktop ~/Desktop/
  chmod +x ~/Desktop/FoxPos.desktop
```

4. Ensure start_foxpos.sh is Executable  
   `chmod +x start_foxpos.sh`

5. Trust & Run the Desktop Shortcut  
   `gio set ~/.local/share/applications/FoxPos.desktop metadata::trusted true`

6. You can now launch the app by searching `FoxPos` in your apps

## Running PWA on Windows

Script coming soon

## Running PWA on WSL

Script coming soon

#### Credits

The app designs are inspied by [Abubakar Sherazi](https://www.figma.com/design/wprVLQMw1ldIkJkDjXfnsH/Rails-POS)
