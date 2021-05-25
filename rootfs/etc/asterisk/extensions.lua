extensions = {
---------------- outgoing calls -------------
	["intra"] = {
                ["_2XX"] = function(c,e)
			app.Dial('pjsip/'..e..',60')
		end,
	},
	["local"] = {
		["_10X"] = function(c,e)
			app.Dial('pjsip/trunk1/'..e..',65')
		end,
		["_1ZXX"] = function(c,e)
                        app.Dial('pjsip/trunk1/'..e..',65')
		end,
		["_7XXXXXX"] = function(c,e)
			app.Dial('pjsip/trunk1/'..e..',65')
		end,
		["_[2-6]XXXXX"] = function(c,e)
                        app.Dial('pjsip/trunk1/'..e..',65')
                end,
	},

	["national"] = {
		["_0XXXXXXXXX"] = function(c,e)
			app.Dial('pjsip/trunk1'..e..',65')
		end,
	},
	["international"] = {
		["_X."] = function(c,e)
			app.Dial('pjsip/trunk1'..e..',65')
		end,
        },

	["from-internal"] = {
		include = {"service","intra","local","national","international"}
	},
--------------- incoming calls -----------
    ["from-pstn"] = {
        ["_X."] = function(c,e)
            app.Dial('pjsip/200,90')
        end,
    },
}
