-- Soft Access Point
cfg={}
cfg.ssid="PORTAIL";
cfg.pwd="192Portail!!"
wifi.ap.config(cfg)

-- IP configuration
cfg={}
cfg.ip="192.168.1.1";
cfg.netmask="255.255.255.0";
cfg.gateway="192.168.1.1";
wifi.ap.setip(cfg);
wifi.setmode(wifi.SOFTAP)

collectgarbage();

-- Log IP
print("AP started")
print("MAC:"..wifi.ap.getmac())
print("IP:"..wifi.ap.getip());

-- Setting up GPIO
gpio0 = 3
gpio2 = 4
gpio.mode(gpio0, gpio.OUTPUT)
gpio.mode(gpio2, gpio.OUTPUT)

-- HTTP server
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        if(request == "1")then
            gpio.write(gpio2, gpio.HIGH);
        elseif(request == "0")then
            gpio.write(gpio2, gpio.LOW);
        end
        -- Close session
        local response = "HTTP/1.1 200 OK\r\n\r\nOK"
        conn:send(response, function()
            conn:close()
        end)
        collectgarbage();
    end)
end)
