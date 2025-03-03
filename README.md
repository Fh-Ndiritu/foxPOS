## Introduction

FoxPos is a Rails Point of Sale application built on ViewComponent, Turbo and Stimulus.
This has been tweaked to run locally on production mode.

### Current features

1. Add and manage categories
2. Add and manage products
3. Take orders, send to kitchen
4. Serve orders, take payments
5. Print receipts

## Before you install

Ensure you have [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) installed.

## Installation

1. Clone the git repo <br> `git clone git@github.com:Fh-Ndiritu/foxPOS.git`
2. Navigate to the project folder
3. Run the app in development mode <br> `docker-compose up --build `
4. Run the app in production mode locally <br> `sudo docker-compose -f docker-compose.prod.yml --env-file .env  up --build`

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

### Known Issues

On production solid queue might not be migrated correctly. This is handled by running `rails db:prepare` in docker-compose.prod.yml.
If that fails, run in rails console.

```
ActiveRecord::Base.establish_connection(:queue)
load 'db/queue_schema.rb'

ActiveRecord::Base.establish_connection(:cable)
load 'db/cable_schema.rb'

ActiveRecord::Base.establish_connection(:cache)
load 'db/cache_schema.rb'
```

### Docker tips

1. Perform a fresh Docker build
   `docker-compose -f docker-compose.prod.yml build --no-cache`

#### Credits

The app designs are inspied by [Abubakar Sherazi](https://www.figma.com/design/wprVLQMw1ldIkJkDjXfnsH/Rails-POS)
