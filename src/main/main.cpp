#include <iostream>

#include "types.h"
#include "plog.h"

#include "thread_manager.h"

int main(int argc, char** argv)
{
    Log::Plog* g_PlogObj = Log::Plog::Create();
    PResult result = PResultSuccess;
    ThreadManager threadManager;

    std::cout << "Success!!! result:" << result << std::endl;

    PLOG_ERROR(PLogGroupApp, "Success!!!");

    g_PlogObj->Destroy();
    return 0;
}