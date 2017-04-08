#!/bin/bash
CALCULATOR_PORT=$(ssh ubuntu@$@ "docker-compose port calculator 8080 | cut -d: -f2")
./gradlew acceptanceTest -Dcalculator.url=http://$@:$CALCULATOR_PORT
