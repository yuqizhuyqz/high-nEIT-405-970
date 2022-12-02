# EIT

### related work
 Y. Zhu, S. Ghosh, S.B. Cahn, M.J. Jewell, D. H. Speller, R.H. Maruyama, "EIT spectroscopy of high-lying Rydberg states in <sup>39</sup>K", [Phys. Rev. A 105, 042808, 2022](https://journals.aps.org/pra/abstract/10.1103/PhysRevA.105.042808)

## data acquisition code
`copyscanPZT-YZ`
- used for EIT spectroscopy
- scan the 970-ecdl via its piezo while recording wavemeter's reading
- software timed via `sleep()`
  - sets delay between data points--changing PZT and reading wavemeter
  -  min ~ 10 ms according to rumors
- typically, when starting from scratch, `mean_voltage` in the main function is to be found manually
  
## analysis code

### workflow
data file `scan%d.mat`[^0] &rarr; intermediate results `scan%danalysis.mat` &rarr; line data files [^1] (e.g., `nSnD7090.mat`) &rarr; make paper plots

[^0]:`%d` is the scan index. see lab notes on labarchives for which scan is which. 
[^1]: depending on what's analyzed/saved

### file locations
- data files @
  - Google Drive/Shared drives/RAY/data/August2021/0823 
  - Google Drive/Shared drives/RAY/data/August2021/0825
  - Google Drive/Shared drives/RAY/data/August2021/0830

- intermediate results of each scan saved in the same dir [^2]
[^2]: not ideal but assumed in some parts of the code. 

### functions
fitting functions
- `doublegaussianfit`
- `quadruplegaussianfit`
- `fitRylevels`

plot function for an individual spectrum
- `plotandlabel`

wrappers
- `analysisfitandsave`
  - fit to gaussians
  - then `scan%d.mat`&rarr;`scan%danalysis.mat`
- `spectroscopy` 
  - need `scan%danalysis.mat` files
  - label scans based on notes (attached below)
  - save lines (IR trans freq. and state energies) to nSnD???.mat
- `opticalpumping` 
  - need `scan%danalysis.mat` files
  - generate optical pumping plots
- `QDfects`
  - need line data files, e.g., `nSnD7090.mat`
  - generates fit to energy levels and plot
- `convertstuff2table` 
  - convert stuff to latex tables as .txt

