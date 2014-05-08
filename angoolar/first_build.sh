#!/bin/bash

echo
read -p $"Do you have NVM installed (y/n)?" -n 1 hasNVM

if  [ "$hasNVM" == 'n' ]; then
	echo
	echo $"Installing NVM"
	curl https://raw.github.com/creationix/nvm/master/install.sh | sh

	if [ $? -ne 0 ]; then
		echo
		echo $"That didn't work, so trying with sudo..."
		sudo curl https://raw.github.com/creationix/nvm/master/install.sh | sh
	fi
fi

echo
read -p $"Do you have Node installed (this is different than NVM) (y/n)?" -n 1 hasNode

if  [ "$hasNode" == 'n' ]; then
	echo
	echo $"Installing Node (via NVM)"
	nvm install 0.11
	nvm use 0.11

	if [ $? -ne 0 ]; then
		echo
		echo $"That didn't work, so trying with sudo..."
		sudo nvm install 0.11
		sudo nvm use 0.11
	fi
fi

echo
read -p $"Do you have Coffeescript for Node (y/n)?" -n 1 hasCoffee

if  [ "$hasCoffee" == 'n' ]; then
	echo
	echo $"Installing Coffee for Node"
	npm install -g coffee-script

	if [ $? -ne 0 ]; then
		echo
		echo $"That didn't work, so trying with sudo..."
		sudo npm install -g coffee-script
	fi
fi

echo
read -p $"Do you have SASS, Compass and the Animation Library for Ruby (y/n)?" -n 1 isSassy

if [ "$isSassy" == 'n' ]; then
	echo
	echo $"Installing Compass for Ruby (and therefore also SASS)"
	gem install compass -v 1.0.0.alpha.18

	if [ $? -ne 0 ]; then
		echo
		echo $"That didn't work, so trying with sudo..."
		sudo gem install compass -v 1.0.0.alpha.18
	fi

	echo
	echo $"Installing Animation for Ruby (or for Compass really - it's a library for Compass/SASS)"
	gem install animation -v 0.1.alpha.3

	if [ $? -ne 0 ]; then
		echo
		echo $"That didn't work, so trying with sudo..."
		sudo gem install animation -v 0.1.alpha.3
	fi
fi

echo
read -p $"Do you have Grunt for Node (y/n)?" -n 1 canGrunt

if [ "$canGrunt" == 'n' ]; then
	echo
	echo $"Installing Grunt"
	npm install -g grunt-cli

	if [ $? -ne 0 ]; then
		echo
		echo $"That didn't work, so trying with sudo..."
		sudo npm install -g grunt-cli
	fi
fi

echo $"Making sure you have Bower."
npm install -g bower

./clean_build.sh