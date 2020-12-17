CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

PROJECT(Tests)

# If need
# AUX_SOURCE_DIRECTORY(${TESTS_DIR} SRC_TESTS)

# If need
INCLUDE_DIRECTORIES(.
                    ${LOG_DIR}
                    ${UTILS_DIR})

# If need
LINK_DIRECTORIES(${LOG_DIR}
                 ${OUT_STATIC_LIB_DIR}
                 ${OUT_SHARE_LIB_DIR})

FILE(GLOB APP_SOURCES *.cpp)
FOREACH(testsourcefile ${APP_SOURCES})
    STRING(REGEX MATCH "[^/]+$" testsourcefilewithoutpath ${testsourcefile})
    STRING(REPLACE ".cpp" "" testname ${testsourcefilewithoutpath})
    ADD_EXECUTABLE( ${testname} ${testsourcefile})
    SET(EXECUTABLE_OUTPUT_PATH ${OUT_TESTS_DIR})
    TARGET_LINK_LIBRARIES(${testname}
                            module_utils
                            module_log)

    INSTALL(TARGETS ${testname}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin)
ENDFOREACH(testsourcefile ${APP_SOURCES})