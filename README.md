# EIT

## data acquisition
`copyscanPZT-YZ`
- used for EIT spectroscopy
- scan the 970-ecdl via its piezo while recording wavemeter's reading
- software timed via `sleep()`. min ~ 10 ms according to rumors
- typically, when starting from scratch, `mean_voltage` in the main function is to be found manually
  
## analysis 
workflow: data file `scan%d.mat`[^0]-> analysis file `scan%danalysis.mat` -> line data files [^1] (e.g., `nSnD7090.mat`) -> make paper plots

[^0]:`%d` is the scan index. see lab notes for which scan is which.
[^1]: depending on what's analyzed/saved

fitting functions
- `doublegaussianfit`
- `quadruplegaussianfit`
- `fitRylevels`

plot function for an individual spectrum
- `plotandlabel`

wrappers
- `analysisfitandsave`
  - fit to gaussians
  - `scan%d.mat`->`scan%danalysis.mat`
- `spectroscopy` 
  - need `scan%danalysis.mat` files
  - label scans based on notes (attached below)
  - save lines (IR trans freq. and state energies) to nSnD???.mat
- `opticalpumping` 
  - need `scan%danalysis.mat` files
  -generate optical pumping plots
- `QDfects`
  - need line data files, e.g., `nSnD7090.mat`
  - generates fit to energy levels and plot
- `convertstuff2table` 
  - convert stuff to latex tables

