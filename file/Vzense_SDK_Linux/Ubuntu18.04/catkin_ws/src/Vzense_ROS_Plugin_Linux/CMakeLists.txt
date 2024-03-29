cmake_minimum_required(VERSION 2.8.3)
project(Vzense_ROS_Plugin_Linux)

find_package(catkin REQUIRED
	rviz
	serial
)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  sensor_msgs
  message_generation
  dynamic_reconfigure
  camera_info_manager
  image_transport
  tf2
  tf2_ros
  tf2_geometry_msgs
  cv_bridge
)

# ==============================================
# Python scripts setup
# ==============================================
catkin_python_setup()


# ==============================================
# Setup
# ==============================================
catkin_package(CATKIN_DEPENDS camera_info_manager image_transport tf2 tf2_ros geometry_msgs message_runtime roscpp rospy cv_bridge)

# ==============================================
# Vzense setup
# ==============================================
find_package(OpenCV REQUIRED)
find_library(libvzense_api NAMES libvzense_api.so PATHS dependencies/Lib/)
include_directories(include ${catkin_INCLUDE_DIRS} ${GAZEBO_INCLUDE_DIRS} ${SDFormat_INCLUDE_DIRS})

add_executable(vzense_camera src/vzense_driver.cpp
                                 src/vzense_manager.cpp
                                 include/vzense_manager.hpp)
target_link_libraries(vzense_camera ${catkin_LIBRARIES} ${libvzense_api} ${OpenCV_LIBRARIES})
add_dependencies(vzense_camera ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

# ==============================================
# Install
# ==============================================
install(DIRECTORY launch DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

file(GLOB python_scripts_DIR "scripts/*.py")
catkin_install_python(PROGRAMS ${python_scripts_DIR} DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

catkin_package(
	DEPENDS
	rviz
	serial
  CATKIN_DEPENDS
  INCLUDE_DIRS
  LIBRARIES
)

find_package(roslaunch)


foreach(dir dependencies include launch)
	install(DIRECTORY ${dir}/
		DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/${dir})
endforeach(dir)

