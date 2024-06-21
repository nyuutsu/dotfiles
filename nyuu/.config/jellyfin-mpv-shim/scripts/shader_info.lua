local assdraw = require "mp.assdraw"
local options = require "mp.options"

local info_active = false
local o = {
    font_size = 20,
    font_color = "FFFFFF",
    border_size = 1.0,
    border_color = "000000",
}
options.read_options(o)

function get_formatting(isShader)
    if isShader then
        return "{\\fs20}{\\1c&H00A5FF&}{\\bord1.0}{\\3c&H000000&}\\h\\h"
    else
        return string.format(
            "{\\fs%d}{\\1c&H%s&}{\\bord%f}{\\3c&H%s&}",
            o.font_size, o.font_color,
            o.border_size, o.border_color
        )
    end   
end

function timestamp(duration)
    if not duration then return "" end
    local hours = duration / 3600
    local minutes = duration % 3600 / 60
    local seconds = duration % 60
    return string.format("%02d:%02d:%06.03f", hours, minutes, seconds)
end

function shader_info()
    local shaders = mp.get_property("glsl-shaders") or "None"
    local shaders_info = ""
    local shaders_entries = {}

    for shader in string.gmatch(shaders, "[^,]+") do
        local shader_filename = shader:match("^.+/(.+)$")
        table.insert(shaders_entries, shader_filename)
    end

    for i, v in ipairs(shaders_entries) do
        shaders_info = shaders_info .. (i ~= 1 and "\\N" or "") .. get_formatting(true) .. v
    end
    return shaders ~= "" and shaders_info or "None"
end

function get_deinterlace_status()
    local is_deinterlacing = mp.get_property("deinterlace")
    return is_deinterlacing == 'yes' and 'Deinterlacing: Yes' or 'Deinterlacing: No'
end

--"vf-append=yadif" variant
--function get_deinterlace_status()
--    local vf = mp.get_property_native('vf')
--
--    for i, filter in ipairs(vf) do
--        if filter['name'] == 'yadif' then
--            return 'Deinterlacing: Yes'
--        end
--    end
--
--    return 'Deinterlacing: No'
--end

function get_info()
    return string.format(
        "%sTime: %s\\N%s\\NActive Shaders:\\N%s",
        get_formatting(),
        timestamp(mp.get_property_native("time-pos")),
        get_deinterlace_status(),
        shader_info()
    )
end

function render_info()
    local ass = assdraw.ass_new()
    ass:pos(20, 40)
    ass:append(get_info())
    mp.set_osd_ass(0, 0, ass.text)
end

function clear_info()
    mp.set_osd_ass(0, 0, "")
end

function toggle_info()
    if info_active then
        mp.unregister_event(render_info)
        clear_info()
    else
        mp.register_event("tick", render_info)
        render_info()
    end
    info_active = not info_active
end

mp.add_key_binding("F1", mp.get_script_name(), toggle_info)