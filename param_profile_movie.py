#K.BALEM
#IFREMER LOPS 2017
#
#READ SERIE OF NC FILES AND EXTRACT PROFILES IN DEFINED AREA
#THE AVERAGE OF THOSE PROFILES ARE PLOTTED
#
#READING
from netCDF4 import Dataset
import numpy as np
import glob, os, sys
#PLOTTING
import matplotlib.pyplot as plt
import matplotlib as mpl
from mpl_toolkits.basemap import Basemap
#ZONE D'ETUDE
LaMIN=52.0
LaMAX=59.0
LoMIN=-38
LoMAX=-22
month=2
#PLOTTING VARS
cmap = mpl.cm.cool
vmin=31
vmax=38
norm = mpl.colors.Normalize(vmin=vmin, vmax=vmax)
#ANNNND ACTION
gpath="/home5/pharos/REFERENCE_DATA/OCEAN_REP/CGLORS/"
dire="dataset-global-reanalysis-phys-001-011-ran-it-cglors-monthly-s/"
patte="global-reanalysis-phys-001-011-ran-it-cglors-grids_*.nc"
#
rgm=1;
for ncfile in sorted(glob.glob(gpath+dire+patte)):
    #READ
    print(ncfile[147:])
    fh = Dataset(ncfile, mode='r')
    LON=fh.variables['lat'][:]
    LAT=fh.variables['lon'][:]
    PSAL=fh.variables['Salinity'][:]
    PSAL_surf=fh.variables['Salinity'][month,0,:,:]
    DEPTH=fh.variables['depth'][:]
    fh.close()
    #CALCULATION
    MEAN=np.zeros(50)
    suk=0
    #SELECTION DES PROFILS CONTENUS DANS LA ZONE LaMIN, LaMAX, LoMIN, LoMAX
    #CALCUL POUR FEVRIER SEULEMENT
    for i in xrange(0,1020):
        for j in xrange(0,1441):
            if((LON[i,j])>=LoMIN and (LON[i,j])<=LoMAX and (LAT[i,j])>=LaMIN and (LAT[i,j])<=LaMAX):
                for k in xrange(0,49):
                    MEAN[k]=MEAN[k]+PSAL[month,k,i,j]
                suk=suk+1
    MEAN=MEAN/suk
    #
    #SUBPLOT 1
    fig = plt.figure(figsize=(14,11))
    ax = fig.add_subplot(211)
    m = Basemap(projection='mill',llcrnrlon=-180,llcrnrlat=-75,urcrnrlon=180,urcrnrlat=75)
    lolo=m.scatter(LAT,LON,latlon='True',s=10,c=PSAL_surf,linewidth=0.0)
    m.drawcoastlines()
    m.drawmapboundary(fill_color='white')
    m.fillcontinents(color='grey',lake_color='white')
    xs = [LoMIN,LoMAX,LoMAX,LoMIN,LoMIN]
    ys = [LaMIN,LaMIN,LaMAX,LaMAX,LaMIN]
    m.plot(xs, ys,latlon = True)
    plt.title(ncfile[147:])
    #COLORBAR
    plt.clim(vmin,vmax)
    cbar = m.colorbar(lolo,cmap=cmap,norm=norm)
    #SUBPLOT 2
    ax = fig.add_subplot(212)
    plt.plot(MEAN,DEPTH)
    plt.xlim(34,35.5)
    plt.ylim(0,4000)
    plt.xlabel('Salinity')
    plt.ylabel('Depth')
    plt.gca().invert_yaxis()
    plt.grid()
    #SHOW RESULT
    #plt.show()
    plt.savefig('PNG/_tmp%03d.png'%rgm)
    plt.close(fig)
    rgm=rgm+1
