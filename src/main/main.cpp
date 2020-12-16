#include <iostream>

#include "types.h"
#include "plog.h"

int main(int argc, char** argv)
{
    PResult result = PResultSuccess;
    std::cout << "Success!!! result:" << result << std::endl;

    PLOG_ERROR(PLogGroupApp, "Success!!!");

    Log::g_PlogObj->Destroy();
    return 0;
}