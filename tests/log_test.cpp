#include <iostream>

#include "plog.h"

int main()
{
    Log::Plog* g_PlogObj = Log::Plog::Create();
    
    PLOG_ERROR(PLogGroupApp, "Success!!!");

    g_PlogObj->Destroy();
    return 0;
}