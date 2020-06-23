workspace "genv"
    configurations {"Debug", "Release"}
    platforms {"x64", "x32"}  

project "gEnv"
    kind "SharedLib"
    language "C++"

    files { "src/*.cpp" }

    includedirs { "../gmodheaders/include", os.getenv("GMODHEADERS")}
    targetprefix ""
    targetextension ".dll"
    targetname "gmsv_genv"
     
    -- At some point we'll want to split these dirs out to be arch specific, probably
    filter "configurations:Debug"
        defines { "DEBUG", "_CRT_SECURE_NO_WARNINGS" }
        symbols "On"
        targetdir "bin/debug/"
        objdir "bin/debug/"

    filter "configurations:Release"
        defines { "NDEBUG", "_CRT_SECURE_NO_WARNINGS" }
        optimize "On"
        symbols "off"
        targetdir "bin/release/"
        objdir "bin/release/"
      
    filter {"platforms:*32" }
        architecture "x86"

    filter {"platforms:*64" }
        architecture "x86_64"

    -- ty danielga (https://github.com/danielga), shamelessly nicking part of this from the gmod common stuff   
    filter({"system:windows", "platforms:*32"})
        targetsuffix("_win32")

    filter({"system:windows", "platforms:*64"})
        targetsuffix("_win64")

    filter({"system:linux", "platforms:*32"})
        targetsuffix("_linux")

    filter({"system:linux", "platforms:*64"})
        targetsuffix("_linux64")

    filter({"system:macosx", "platforms:*32"})
        targetsuffix("_osx")

    filter({"system:macosx", "platforms:*64"})
        targetsuffix("_osx64")

    filter {}