#K.BALEM
#IFREMER LOPS 2017
#
#READ SERIE OF NC FILES AND MAKE A MOVIE FROM IT
#
#READING
from netCDF4 import Dataset
import numpy as np
import glob, os, sys
#PLOTTING
import matplotlib.pyplot as plt
import matplotlib as mpl
from mpl_toolkits.basemap import Basemap
#PLOT CONST
cmap = mpl.cm.cool
vmin=0
vmax=30
norm = mpl.colors.Normalize(vmin=vmin, vmax=vmax)
#ANNNND ACTION
i=1;
#The file pattern defines what you want to plot, here all sst of february
for ncfile in sorted(glob.glob("/home5/pharos/REFERENCE_DATA/OCEAN_REP/ORAP5/global-reanalysis-phys-001-017-ran-uk-orap5.0-sst/sosstsst_ORAP5.0_1m_*02_grid_T_02.nc")):
    #READ
    print(ncfile)
    fh = Dataset(ncfile, mode='r')
    LON=fh.variables['nav_lat'][:]
    LAT=fh.variables['nav_lon'][:]
    TEMP=fh.variables['sosstsst'][:]
    fh.close()
    #PLOT
    m = Basemap(projection='mill',llcrnrlon=-180,llcrnrlat=-75,urcrnrlon=180,urcrnrlat=75)
    lolo=m.scatter(LAT,LON,latlon='True',s=10,c=TEMP,linewidth=0.0)
    m.drawcoastlines()
    m.drawmapboundary(fill_color='white')
    m.fillcontinents(color='grey',lake_color='white')
    plt.title(ncfile[95:])
    #COLORBAR
    plt.clim(vmin,vmax)
    cbar = m.colorbar(lolo,cmap=cmap,norm=norm)
    #SHOW RESULT
    #plt.show()
    #ANIMATION
    plt.savefig('PNG/_tmp%05d.png'%i)
    plt.clf()
    i=i+1
#PNG TO MOVIE
#DELETE ANY PREVIOUS
os.system("rm movie.mp4")
#8 images per second
os.system("ffmpeg -framerate 8 -i PNG/_tmp%05d.png movie.mp4")
#Clear PNG
os.system("rm PNG/_tmp*.png")
