-- license:BSD-3-Clause
-- copyright-holders:MAMEdev Team

---------------------------------------------------------------------------
--
--   modules.lua
--
--   Rules for the building of modules
--
---------------------------------------------------------------------------

function string.starts(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

function addlibfromstring(str)
	if (str==nil) then return  end
	for w in str:gmatch("%S+") do
		if string.starts(w,"-l")==true then
			links {
				string.sub(w,3)
			}
		end
	end
end

function addoptionsfromstring(str)
	if (str==nil) then return  end
	for w in str:gmatch("%S+") do
		if string.starts(w,"-l")==false then
			linkoptions {
				w
			}
		end
	end
end

function pkgconfigcmd()
	local pkgconfig = os.getenv("PKG_CONFIG")
	if pkgconfig == nil then
		return "pkg-config"
	end
	return pkgconfig
end

function osdmodulesbuild()

	removeflags {
		"SingleOutputDir",
	}

	files {
		MAME_DIR .. "src/osd/osdnet.cpp",
		MAME_DIR .. "src/osd/osdnet.h",
		MAME_DIR .. "src/osd/watchdog.cpp",
		MAME_DIR .. "src/osd/watchdog.h",
		MAME_DIR .. "src/osd/modules/debugger/debug_module.h",
		MAME_DIR .. "src/osd/modules/font/font_module.h",
		MAME_DIR .. "src/osd/modules/midi/midi_module.h",
		MAME_DIR .. "src/osd/modules/netdev/netdev_module.h",
		MAME_DIR .. "src/osd/modules/sound/sound_module.h",
		MAME_DIR .. "src/osd/modules/diagnostics/diagnostics_module.h",
		MAME_DIR .. "src/osd/modules/monitor/monitor_module.h",
		MAME_DIR .. "src/osd/modules/lib/osdobj_common.cpp",
		MAME_DIR .. "src/osd/modules/lib/osdobj_common.h",
		MAME_DIR .. "src/osd/modules/diagnostics/none.cpp",
		MAME_DIR .. "src/osd/modules/debugger/none.cpp",
		MAME_DIR .. "src/osd/modules/font/font_none.cpp",
		MAME_DIR .. "src/osd/modules/netdev/taptun.cpp",
		MAME_DIR .. "src/osd/modules/netdev/pcap.cpp",
		MAME_DIR .. "src/osd/modules/netdev/none.cpp",
		MAME_DIR .. "src/osd/modules/midi/none.cpp",
		MAME_DIR .. "src/osd/modules/sound/none.cpp",
		MAME_DIR .. "src/osd/modules/input/input_module.h",
		MAME_DIR .. "src/osd/modules/input/input_common.cpp",
		MAME_DIR .. "src/osd/modules/input/input_common.h",
		MAME_DIR .. "src/osd/modules/input/input_none.cpp",
		MAME_DIR .. "src/osd/modules/input/input_retro.cpp",
		MAME_DIR .. "src/osd/modules/input/input_retro.h",
		MAME_DIR .. "src/osd/modules/output/output_module.h",
		MAME_DIR .. "src/osd/modules/output/none.cpp",
		MAME_DIR .. "src/osd/modules/monitor/monitor_common.h",
		MAME_DIR .. "src/osd/modules/monitor/monitor_common.cpp",
		MAME_DIR .. "src/osd/modules/monitor/monitor_retro.cpp",
	}
	includedirs {
		MAME_DIR .. "3rdparty/asio/include",
	}

	if _OPTIONS["targetos"]=="windows" then
		includedirs {
			MAME_DIR .. "3rdparty/winpcap/Include",
			MAME_DIR .. "3rdparty/compat/mingw",
		}

		includedirs {
			MAME_DIR .. "3rdparty/compat/winsdk-override",
		}
	end

	defines {
		"__STDC_LIMIT_MACROS",
		"__STDC_FORMAT_MACROS",
		"__STDC_CONSTANT_MACROS",
		"IMGUI_DISABLE_OBSOLETE_FUNCTIONS",
	}

	includedirs {
		MAME_DIR .. "3rdparty/bx/include",
		MAME_DIR .. "3rdparty/rapidjson/include",
	}

	defines {
			"NO_USE_MIDI",
		}
end


function osdmodulestargetconf()


	if _OPTIONS["targetos"]=="windows" then
		links {
			"oleaut32",
		}
	elseif _OPTIONS["targetos"]=="macosx" then
		if _OPTIONS["LIBRETRO_IOS"]=="1" or _OPTIONS["LIBRETRO_TVOS"]=="1" then
			links {
				"AudioToolbox.framework",
				"CoreServices.framework",
			}
		else
			links {
				"AudioUnit.framework",
				"AudioToolbox.framework",
				"CoreServices.framework",
			}
		end
	end

end


newoption {
	trigger = "DONT_USE_NETWORK",
	description = "Disable network access",
}

newoption {
	trigger = "NO_USE_MIDI",
	description = "Disable MIDI I/O",
	allowed = {
		{ "0",  "Enable MIDI"  },
		{ "1",  "Disable MIDI" },
	},
}

if not _OPTIONS["NO_USE_MIDI"] then
	if _OPTIONS["targetos"]=="freebsd" or _OPTIONS["targetos"]=="openbsd" or _OPTIONS["targetos"]=="netbsd" or _OPTIONS["targetos"]=="solaris" or _OPTIONS["targetos"]=="haiku" or _OPTIONS["targetos"] == "asmjs" then
		_OPTIONS["NO_USE_MIDI"] = "1"
	else
		_OPTIONS["NO_USE_MIDI"] = "0"
	end
end

newoption {
	trigger = "MODERN_WIN_API",
	description = "Use Modern Windows APIs",
	allowed = {
		{ "0",  "Use classic Windows APIs - allows support for XP and later"   },
		{ "1",  "Use Modern Windows APIs - support for Windows 8.1 and later"  },
	},
}

newoption {
	trigger = "LIBRETRO_IOS",
	description = "Specify iOS target when building using libretro"
}

newoption {
	trigger = "LIBRETRO_TVOS",
	description = "Specify tvOS target when building using libretro"
}
