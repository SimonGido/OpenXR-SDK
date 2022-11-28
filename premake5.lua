project "OpenXR-SDK"	
	kind "StaticLib"	
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


    includedirs
    {
        "include"
    }

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++17"
		staticruntime "Off"
        
        prebuildcommands
        {
            'cmake -G "Visual Studio 17 2022" -A x64'
        }
    

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++17"
		staticruntime "Off"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

        prebuildcommands
        {
            "msbuild OPENXR.sln /property:Configuration=Debug"
        }
        links
        {
            "src/loader/Debug/openxr_loaderd.lib"
        }

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
        prebuildcommands
        {
            "msbuild OPENXR.sln /property:Configuration=Release"
        }
        links
        {
            "src/loader/Release/openxr_loader.lib"
        }
