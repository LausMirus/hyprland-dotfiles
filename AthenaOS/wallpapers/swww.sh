#!/bin/bash

killall -9 swww-daemon

swww-daemon & disown
