# Soft Access Point & Web Server

This LUA script is for ESP8266 hardware.

## Principle

1. Sart a soft access point
2. Start a web server waiting for request
3. If request received, get request value (1 or 0)
4. If value is 1, GPI0_2 set to HIGH, if value is 0, GPIO_2 set to LOW

## Scheme

![scheme](https://github.com/Wifsimster/SoftAP/blob/master/scheme.png)
