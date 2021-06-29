import numpy as np
import S4
import matplotlib.pyplot as plt
import time
import argparse

##########################

parser = argparse.ArgumentParser()

parser.add_argument('--nG', default=100, help="diffraction order", type=int)
parser.add_argument('--wl', default=1250, help = "wavelength", type=float)
parser.add_argument('--ang', default=55, help ="angle", type=float)
parser.add_argument('--ncells', default=64, help ="number of cells", type=int)

args = parser.parse_args()

#variables setting
nG = args.nG
wl = args.wl
ang = args.ang
ncells = args.ncells
period = abs(wl/np.sin(ang/180*np.pi))
freq = 1/wl
S = S4.New(Lattice=((period,0),(0,period/2)), NumBasis=nG)


# Permittivities & thickness[um]
eps_SiO2 = 1.4504**2
eps_Si = 3.5750**2
grating_thickness = 0.325

#import & save the structure
gratingMatrix = np.load('struct.npy')
np.savetxt('gratingMatrix.csv',gratingMatrix,delimiter=",")
