execute_process(COMMAND "/home/kjm/Vzense_SDK_Linux/Ubuntu18.04/catkin_ws/build/vzense_camera/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/kjm/Vzense_SDK_Linux/Ubuntu18.04/catkin_ws/build/vzense_camera/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
