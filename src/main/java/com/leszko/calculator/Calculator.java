package com.leszko.calculator;
import org.springframework.stereotype.Service;

@Service
class Calculator {
    int sum(int a, int b) {
        return a + b;
    }
}

