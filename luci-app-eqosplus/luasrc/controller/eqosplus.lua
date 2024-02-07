module("luci.controller.eqosplus", package.seeall)
-- Copyright 2022-2023 sirpdboy <herboy2008@gmail.com>
function index()
    if not nixio.fs.access("/etc/config/eqosplus") then return end
    entry({"admin", "network"}, firstchild(), "Network", 44).dependent = false
    entry({"admin", "network", "eqosplus"}, cbi("eqosplus"), _("Eqosplus"), 99).dependent =true
    entry({"admin", "network", "eqosplus", "status"}, call("act_status")).leaf = true
end

function act_status()
    local sys  = require "luci.sys"
    local e = {} 
     e.status = sys.call(" tc qdisc show  | grep 'default' >/dev/null ") == 0  
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
