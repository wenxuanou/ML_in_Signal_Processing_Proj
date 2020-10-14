import xml.etree.ElementTree as xml
import pyproj
import math
import matplotlib.pyplot as plt

import sys
sys.path.append("D:\\CMUclasses\\18797\\interactionDataset\\interaction-dataset\\python")
import map_vis_without_lanelet1

maps_dir = "D:\\CMUclasses\\18797\\interactionDataset\\INTERACTION-Dataset-DR-v1_1\\maps"

args_scenario_name = "DR_USA_Intersection_EP0"

lat_origin = 0.  # origin is necessary to correctly project the lat lon values in the osm file to the local
lon_origin = 0.  # coordinates in which the tracks are provided; we decided to use (0|0) for every scenario
lanelet_map_ending = ".osm"
lanelet_map_file = maps_dir + "/" + args_scenario_name + lanelet_map_ending

fig, axes = plt.subplots(1, 1)
map_vis_without_lanelet1.draw_map_without_lanelet(lanelet_map_file, axes, lat_origin, lon_origin)