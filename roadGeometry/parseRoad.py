import xml.etree.ElementTree as xml
import pyproj
import math
import matplotlib.pyplot as plt
import os
import sys
sys.path.append("D:\\CMUclasses\\18797\\project\\interactionDataset\\interaction-dataset\\python")
import map_vis_without_lanelet1
import pandas as pd

maps_dir = "D:\\CMUclasses\\18797\\project\\interactionDataset\\INTERACTION-Dataset-DR-v1_1\\maps"
outputFolder = "D:\\CMUclasses\\18797\\project\\customDataset\\roadCSV"
scenariosFolder = "D:\\CMUclasses\\18797\\project\\interactionDataset\\INTERACTION-Dataset-DR-v1_1\\recorded_trackfiles"

lat_origin = 0.  # origin is necessary to correctly project the lat lon values in the osm file to the local
lon_origin = 0.  # coordinates in which the tracks are provided; we decided to use (0|0) for every scenario
lanelet_map_ending = ".osm"

scenarios = os.listdir(scenariosFolder)
print(scenarios)
for args_scenario_name in scenarios:
	lanelet_map_file = maps_dir + "/" + args_scenario_name + lanelet_map_ending
	outputCSV = os.path.join(outputFolder, args_scenario_name + ".csv")

	fig, axes = plt.subplots(1, 1)
	xRoad, yRoad = map_vis_without_lanelet1.draw_map_without_lanelet(lanelet_map_file, axes, lat_origin, lon_origin)
	
	df = pd.DataFrame({"x": xRoad, "y": yRoad})
	df.to_csv(outputCSV, index=False)