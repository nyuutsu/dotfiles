local assdraw = require "mp.assdraw"
local options = require "mp.options"

local info_active = false
local o = {
    font_size = 12,
    font_color = "FFFFFF",
    border_size = 1.0,
    border_color = "000000",
}
options.read_options(o)

function get_formatting(is_active)
    if is_active then
        return string.format("{\\fs%d}{\\1c&H00A5FF&}{\\bord%f}{\\3c&H%s&}", o.font_size, o.border_size, o.border_color)
    else
        return string.format("{\\fs%d}{\\1c&H%s&}{\\bord%f}{\\3c&H%s&}", o.font_size, o.font_color, o.border_size, o.border_color)
    end
end

function get_tracks_info()
    local tracks = mp.get_property_native('track-list')
    local audio_info = ""
    local subtitle_info = ""
    
    local audIndex = 1
    local subIndex = 1

    local active_audio = mp.get_property_native('aid')
    local active_subs = mp.get_property_native('sid')

    for _, track in pairs(tracks) do
        if track['type'] == 'audio' then
            local is_active_audio = (active_audio == audIndex)
            audio_info = audio_info .. (audio_info ~= "" and "\\N" or "") .. get_formatting(is_active_audio) .. 'Audio ' .. audIndex .. ': ' .. (track['lang'] or 'unknown') .. ' (' .. (track['title'] or track['codec'] or 'unknown') .. ')'
            audIndex = audIndex + 1
        elseif track['type'] == 'sub' then
            local is_active_subs = (active_subs == subIndex)
            subtitle_info = subtitle_info .. (subtitle_info ~= "" and "\\N" or "") .. get_formatting(is_active_subs) .. 'Subtitle ' .. subIndex .. ': ' .. (track['lang'] or 'unknown') .. ' (' .. (track['title'] or track['codec'] or 'unknown') .. ')'
            subIndex = subIndex + 1
        end
    end
    
    return string.format(
        "%s\\N%s",
        audio_info ~= "" and audio_info or 'No Audio Tracks',
        subtitle_info ~= "" and subtitle_info or 'No Subtitle Tracks'
    )
end

function render_info()
    local ass = assdraw.ass_new()
    ass:pos(20, 40)
    ass:append(get_tracks_info())
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

mp.add_key_binding("F2", mp.get_script_name(), toggle_info)
