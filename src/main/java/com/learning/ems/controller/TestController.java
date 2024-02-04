package com.learning.ems.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(path = "/testing", produces = MediaType.APPLICATION_JSON_VALUE)
public class TestController {

    @GetMapping("/endpoint/1")
    @ResponseStatus(HttpStatus.OK)
    public String testEndPoint() {
        log.info("My logs");
        return "testing-done";
    }
}
