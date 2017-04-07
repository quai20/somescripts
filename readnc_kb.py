#READING
from netCDF4 import Dataset
import numpy as np

my_nc_file = 'GL_TS_TS_FNCM_2016.nc'
fh = Dataset(my_nc_file, mode='r')

LON=fh.variables['LONGITUDE'][:]
LAT=fh.variables['LATITUDE'][:]
TEMP=fh.variables['TEMP'][:]
TIME=fh.variables['TIME'][:]

fh.close()

#PLOTTING
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

#m = Basemap(projection='mill',llcrnrlon=-10,llcrnrlat=-75,urcrnrlon=90,urcrnrlat=50)

#m.scatter(LAT,LON,latlon='True',s=10,c=TEMP,linewidth=0.0)
#m.drawcoastlines()
#m.drawmapboundary(fill_color='white')
#m.fillcontinents(color='grey',lake_color='white')

plt.plot(TIME,TEMP)
plt.show()
