
platformAlias = {
    ["windows"] = "win32",
    ["linux"] = "linux",
    ["macos"] = "osx" --todo: test this with xcode
}

workspace "genv"
    configurations {"Debug", "Release"}

project "gEnv"
    kind "SharedLib"
    language "C++"

    files { "src/*.cpp" }

    includedirs { "../gmodheaders/include" }
    targetname ("gmsv_genv_" .. platformAlias[os.target()])
    

    filter { "configurations:Debug" }
        defines { "DEBUG", "_CRT_SECURE_NO_WARNINGS" }
        symbols "On"
        targetdir "bin/debug/"
        objdir "bin/debug/"


    filter { "configurations:Release" }
        defines { "NDEBUG", "_CRT_SECURE_NO_WARNINGS" }
        optimize "On"
        targetdir "bin/release/"
        objdir "bin/release/"
        symbols "off"
        
