#!/bin/bash
CALCULATOR_PORT=`docker-compose -H $@ port calculator 8080 | cut -d: -f2`
./gradlew acceptanceTest -Dcalculator.url=http://$@:@CALCULATOR_PORT
