# Developing an application for the mapping of subsurface interfaces in MARSIS data
R. Orosei, F. Cantini
(Italian Osservatorio di Radioastronomia Istituto Nazionale di Astrofisica)

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">Developing an application for the mapping of subsurface interfaces in MARSIS data</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">R. Orosei, F. Cantini</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

## Background
Mars is today a cold, dry and sterile world with a thin atmosphere made of CO2. The geologic and compositional record of the surface reveals however that in the past Mars had a thicker atmosphere and liquid water flowing on its surface. For this reason, it has been postulated that life could have developed and that some primitive life forms may be existing even today. This possibility has led to the growth of an enormous interest in the red planet, and its exploration now involves all major space agencies in the world. To discover the possibilities for life on Mars - past or present - the NASA Mars Exploration Program has developed an exploration strategy known as "Follow the Water". Following the water requires searching for water or ice reservoirs on the surface or in the subsurface of Mars.

Ground Penetrating Radar (GPR) is a well-established geophysical technique employed for more than five decades to investigate the terrestrial subsurface. It is based on the transmission of radar pulses at frequencies in the MF, HF and VHF portions of the electromagnetic spectrum into the surface, to detect reflected signals from subsurface structures. Orbiting GPR have been successfully employed in planetary exploration, and are often called subsurface radar sounders. By detecting dielectric discontinuities associated with compositional and/or structural discontinuities, radar sounders are the only remote sensing instruments allowing the study of the subsurface of a planet from orbit.

MARSIS is a synthetic-aperture, orbital sounding radar carried by the European Space Agency spacecraft Mars Express. MARSIS is optimized for deep penetration, having detected echoes down to a depth of 3.7 km over the South Polar Layered Deposits. MARSIS transmits through a dipole, which has negligible directivity, with the consequence that the radar pulse illuminates the entire surface beneath the spacecraft and not only the near-nadir portion from which subsurface echoes are expected. The electromagnetic wave can then be scattered by any roughness of the surface.

If the surface of the body being sounded is not smooth at the wavelength scale, i.e. if the r.m.s. of topographic heights is greater than a fraction of the wavelength, then part of the incident radiation will be scattered in directions different from the specular one. This means that areas of the surface that are not directly beneath the radar can scatter part of the incident radiation back towards it, and thus produce surface echoes that will reach the radar after the echo coming from nadir, which can mask, or be mistaken for, subsurface echoes. This surface backscattering from off-nadir directions is called "clutter".
To validate the detection of subsurface interfaces, numerical electromagnetic models of surface scattering have been used to produce simulations of surface echoes, which are then compared to real echoes detected by the radar. An example of the use of simulated radar data is shown in Fig. 1, in which a radargram is compared with a simulated surface echo. A radargram is a representation of radar echoes acquired continuously during the movement of the spacecraft as a grey-scale image, in which the horizontal dimension is distance along the ground track, the vertical dimension is the round trip time of the echo, and the brightness of the pixel is a function of the strength of the echo.

![Figure 1](/fig1.png)

_**Fig. 1:**_ *Map of ground track (top) and comparison between real (middle) and simulated (bottom) radargram for MARSIS data acquired during orbit 4011. The simulation reproduces echoes from surface topography only, while real data contain both surface and subsurface echoes. The red arrow points at weak subsurface reflections.*

MARSIS radargrams are available from the public archive of the European Space Agency, the Planetary Science Achive (PSA). In the PSA, data are organized and documented according to the Planetary Data System archiving standard. A single MARSIS data file usually contains more than one radargram, as the radar is capable of acquiring data at two frequencies simultaneously. The data file contains also auxiliary information such as spacecraft position and altitude. Simulated radargrams aren't available for public access yet: although it is planned to provide them as a separate dataset, the method of distribution and the archiving standard have not been defined yet.

## Detecting and validating subsurface interfaces
As shown in Fig. 1, the detection of a subsurface interface in MARSIS radargrams requires a comparison with a simulated radargram accounting for surface scattering only. Automatization of this procedure is complex because of the weakness of subsurface echoes and the many artefacts affecting the data (from internal noise sources to ionospheric disturbance). Until now, the most reliable detection method has been the use of human eye and brain.

As there are currently more than 7000 MARSIS radargrams available, their close inspection for subsurface detection is an unsurmountable task for any research group. Furthermore, MARSIS data cannot be manipulated with any existing off-the-shelf data analysis software package, because of their three-dimensional nature. Detecting subsurface interfaces in radargrams and recording their position and depth for quantitative analysis thus requires the development of a specific software application, and its use by at least a few hundred competent operators.

The requirements for such software could be the following:

* Load a MARSIS radargram from a file list, and automatically load also the corresponding simulation;
* Display radargrams at both frequencies, if present, and the corresponding simulations in an arrangement making visual comparison easy;
* Allow the zooming in of any of the four radargrams (two real, two simulated), and automatically perform the corresponding zooming in for the other radargrams;
Implement the automatic detection of the position of the surface echo in the real radargrams, and display such position on the radargram itself;
* Provide a menu allowing the user a choice of actions on the radargram: quit (data quality is too low), or mark interface;
If the user chooses the second option, he can record the position of several points on the radargram with a click of the mouse, outlining the subsurface interface;
* Once the user is satisfied with the acquisition of the position of subsurface echoes on the radargram, allow a visual inspection of the result and require authorization to proceed;
* If the user confirms the interface, convert its points on the radargram to depth by counting the pixels between surface and subsurface echo positions, and acquire the corresponding longitude and latitude;
* Provide a menu allowing the choice between acquiring another interface in the same radargram or quitting the program.
A demonstration software satisfying most of the above requirements has been developed in Matlab and can be made available if needed. A typical screenshot is shown in Figure 2.

Dr. Caprarelli will also give a keynote about the project on the Saturday (first) morning of the hackathon.

![Figure 2](/fig2.png)

_**Fig. 2:**_ *Screenshot of a Matlab tool demonstrating a possible implementation of the proposed application.*

The two top panels show radargrams acquired simultaneously at two different frequencies above an area of interest, while the bottom ones display the corresponding radar echo simulations.

The thin blue lines in the top panels outline the position of the surface echo according to an automated detection algorithm, while the thick red line in the upper left panel has been traced by the user through the use of a mouse, and marks the position of the subsurface interface, which is faintly visible also in the upper right panel.

Once the detection has been confirmed by the user, the longitude, latitude and depth of all data points in the radargram belonging to the subsurface interface will be recorded in a file.


## Additional reading

* [mars express - the search for water](http://sci.esa.int/mars-express/31033-objectives/?fobjectid=31033&fbodylongid=658)
* [mars express - instrument design](http://sci.esa.int/mars-express/34826-design/?fbodylongid=1601)
