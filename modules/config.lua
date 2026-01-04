local Config = {
    ["Gameplay"] = {
        ["Server Type"] = "Private",
        ["Collect Cash Cap"] = "10B",
        ["Max Auctioning Multiplier"] = 10,
        ["Lock Base Extra Time"] = 5,
    },

    ["Misc"] = {
        ["Auto Buy"] = {
            ["Enable"] = true,
            ["Min Income Per Second"] = 1e7, -- 10M/s
            ["Buy When Brainrot Near"] = true,
            ["Brainrot Radius"] = 25,
        },

        -- CHỈ ghi tên Brainrot SECRET KHÔNG muốn mua
        ["Ignore Secret"] = {},
        ["Kick if Ping above"] = 750,
        ["Kick if FPS below"] = 5,
        ["Max Rebirth"] = 0,
    },

    ["Performance"] = {
        ["FPS Cap"] = 10, ----chỉnh fps tối đa
        ["Black Screen"] = true,
    },

    ["Webhook"] = {
        ["Url"] = "",
        ["Ignore Notify"] = {},
    },
}

return Config
