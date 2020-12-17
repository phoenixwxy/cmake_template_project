CMAKE_MINIMUM_REQUIRED(VERSION 3.1)


# If need
AUX_SOURCE_DIRECTORY(${THREAD_DIR} SRC_THREAD)

# If need
INCLUDE_DIRECTORIES(.
                    ${UTILS_DIR}
                    ${LOG_DIR})


# TARGET_INCLUDE_DIRECTORIES(module_utils PUBLIC ${UTILS_DIR})

# If need
# Doesn't used at here
LINK_DIRECTORIES(${UTILS_DIR}
                 ${LOG_DIR})

ADD_LIBRARY(module_thread ${SRC_THREAD})

SET(LIBRARY_OUTPUT_PATH ${OUT_STATIC_LIB_DIR})

TARGET_LINK_LIBRARIES(module_thread 
                        module_log module_utils)

INSTALL(TARGETS module_thread
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin)
