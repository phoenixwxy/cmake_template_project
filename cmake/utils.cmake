FUNCTION(project_extract_version)
    IF(EXISTS ${CONF_DIR}/config.h.in)
        configure_file (
            "${CONF_DIR}/config.h.in"
            "${COMMON_DIR}/config.h"
            )
        INCLUDE_DIRECTORIES(${COMMON_DIR})
        MESSAGE(INFO "Set Config.h Success")
    ELSE()
        MESSAGE(FATAL_ERROR "Set Config.h Failed")
    ENDIF()

    SET(PRO_VER_MAJ PROJECT_VERSION_MAJOR)
    SET(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}" PARENT_SCOPE)
ENDFUNCTION()

FUNCTION(set_env_prop)
    # Set Local path use ${CMAKE_SOURCE_DIR}
    # set somt path for project
    SET(SRC_DIR "${CMAKE_SOURCE_DIR}/src" PARENT_SCOPE)
    SET(COMMON_DIR "${CMAKE_SOURCE_DIR}/src/common" PARENT_SCOPE)
    SET(MAIN_DIR "${CMAKE_SOURCE_DIR}/src/main" PARENT_SCOPE)
    SET(UTILS_DIR "${CMAKE_SOURCE_DIR}/src/utils" PARENT_SCOPE)
    SET(LOG_DIR "${CMAKE_SOURCE_DIR}/src/log" PARENT_SCOPE)
    SET(TESTS_DIR "${CMAKE_SOURCE_DIR}/tests" PARENT_SCOPE)
    SET(THREAD_DIR "${CMAKE_SOURCE_DIR}/src/threadpool" PARENT_SCOPE)

    # set output path
    SET(OUT_DIR "${CMAKE_SOURCE_DIR}/out" PARENT_SCOPE)
    SET(OUT_BIN_DIR "${CMAKE_SOURCE_DIR}/out/bin" PARENT_SCOPE)
    SET(OUT_STATIC_LIB_DIR "${CMAKE_SOURCE_DIR}/out/lib-static" PARENT_SCOPE)
    SET(OUT_SHARE_LIB_DIR "${CMAKE_SOURCE_DIR}/out/lib-share" PARENT_SCOPE)
    SET(OUT_TESTS_DIR "${CMAKE_SOURCE_DIR}/out/tests" PARENT_SCOPE)

    # set configured path
    SET(CONF_DIR "${CMAKE_SOURCE_DIR}/conf" PARENT_SCOPE)

    # set scripts path
    SET(SCRIPTS_DIR "${CMAKE_SOURCE_DIR}/scripts" PARENT_SCOPE)
ENDFUNCTION()
