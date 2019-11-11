# Maratona-animeitor

Animated scoreboard for BOCA judging system

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

Use with Python 2.7 and Pygame 1.9.4

```
sudo apt install python2.7 python-pip
python2.7 -m pip install -r requirements.txt
```

### Configuring webcast on server

To make webcast files being acessible, you should paste the `webcast1984` folder on path
```
/var/www/boca/src/
```
And configure the file `config.php` inside the folder

## Running

To start the scoreboard animation, run
```
sh roda_webcasting.sh IPBOCA -s PREFIX
```
> IPBOCA: ip address
> PREFIX: prefix to select team to show

## Scoreboard Usage

Tap spacebar once to fast-forward to the end of the contest, then tap the spacebar to advance through the contest teams.

Team photos must be inside the directory images/team_photos/ and named with the username.

## Disclaimer

We are not the authors of the base code, so we do not guarantee it will work properly!
We only adapt for our local use.
