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
wifi.setmode(wifi.SOFTAP);

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
server = net.createServer(net.TCP, 30)

function receiver(client, payload)
    if(payload == "1") then
        gpio.write(gpio2, gpio.LOW)
        print("LOW")
    elseif(payload == "0") then
        gpio.write(gpio2, gpio.HIGH);
        print("HIGH")
    end
    client:close()
end

if server then
  server:listen(80, function(conn)
    conn:on("receive", receiver)
    local response = "HTTP/1.1 200 OK\r\n\r\nOK"
    conn:send(response)
  end)
end
