#include "GarrysMod/Lua/Interface.h"
#include <stdlib.h>
#include <stdio.h>

using namespace GarrysMod::Lua;

LUA_FUNCTION(GetVariable)
{
	if (LUA->IsType(1, Type::String))
	{
		char* envValue = getenv(LUA->GetString(1));
		LUA->PushString(envValue);
		return 1;
	}

	LUA->ArgError(1, "expected string");
	return 0;
}

// Under the windows API, _putenv_s won't actually set anything at a user / system level, only an application level.
// However better to have people explicitly enable + compile.
#ifdef SETVARIABLE_ENABLED_FLAG
	LUA_FUNCTION(SetVariable)
	{
		#ifdef _WIN32
			errno_t returnValue =_putenv_s(LUA->GetString(1), LUA->GetString(2));
		#elif __linux__ || __APPLE__
			int returnValue = setenv(LUA->GetString(1), LUA->GetString(2), 0);
		#endif

		if (returnValue != 0)
		{
			LUA->ThrowError("Failed to set environment variable.");
			return 0;
		}
		return 0;
	}
#endif

GMOD_MODULE_OPEN()
{
	LUA->PushSpecial(SPECIAL_GLOB);
	LUA->CreateTable();

	LUA->PushCFunction(GetVariable);
	LUA->SetField(-2, "GetVariable");

	#ifdef SETVARIABLE_ENABLED_FLAG
		LUA->PushCFunction(SetVariable);
		LUA->SetField(-2, "SetVariable");
	#endif

	LUA->SetField(-2, "genv");

	LUA->GetField(-1, "print");
	LUA->PushString("gEnv v1 loaded.");
	LUA->Call(1, 0);

	return 0;
}

GMOD_MODULE_CLOSE()
{
	return 0;
}
