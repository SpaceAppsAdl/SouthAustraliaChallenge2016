function [ ORBIT_NUMBER, ...
           OST_LINE_NUMBER, ...
           FRAME_ID, ...
           SCET_FRAME_WHOLE, ...
           SCET_FRAME_FRAC, ...
           CENTRAL_FREQUENCY, ...
           MARS_SOLAR_LONGITUDE, ...
           SPACECRAFT_ALTITUDE, ...
           SUB_SC_LONGITUDE, ...
           SUB_SC_LATITUDE, ...
           LOCAL_TRUE_SOLAR_TIME, ...
           SOLAR_ZENITH_ANGLE, ...
           FOOTPRINT_CENTER_LONGITUDE, ...
           FOOTPRINT_CENTER_LATITUDE, ...
           FOOTPRINT_VERTEX_LONGITUDE, ...
           FOOTPRINT_VERTEX_LATITUDE, ...
           ROUGHNESS_WITHIN_FOOTPRINT, ...
           INCIDENCE_ANGLE, ...
           FRESNEL_RADIUS, ...
           ECHO_MODULUS_MINUS1_F1_NO_IONO, ...
           ECHO_MODULUS_ZERO_F1_NO_IONO, ...
           ECHO_MODULUS_PLUS1_F1_NO_IONO, ...
           ECHO_MODULUS_MINUS1_F2_NO_IONO, ...
           ECHO_MODULUS_ZERO_F2_NO_IONO, ...
           ECHO_MODULUS_PLUS1_F2_NO_IONO, ...
           ECHO_MODULUS_MINUS1_F1_IONO, ...
           ECHO_MODULUS_ZERO_F1_IONO, ...
           ECHO_MODULUS_PLUS1_F1_IONO, ...
           ECHO_MODULUS_MINUS1_F2_IONO, ...
           ECHO_MODULUS_ZERO_F2_IONO, ...
           ECHO_MODULUS_PLUS1_F2_IONO, ...
           ECHO_MODULUS_MINUS1_F1_SIM, ...
           ECHO_MODULUS_ZERO_F1_SIM, ...
           ECHO_MODULUS_PLUS1_F1_SIM, ...
           ECHO_MODULUS_MINUS1_F2_SIM, ...
           ECHO_MODULUS_ZERO_F2_SIM, ...
           ECHO_MODULUS_PLUS1_F2_SIM ] = readmarsiscdr( CdrFile )

% This function reads a file containing MARSIS data acquired during an
% orbit, plus a number of instrument and geometric parameters:
% 
% ORBIT_NUMBER                   = Number of the orbit in which data were
% acquired
% 
% OST_LINE_NUMBER                = Identification number of the line of the
% Operations Sequence Table containing the instrument parameters used
% during observations
% 
% FRAME_ID   = Identification number of the echo acquired with a given OST
% line
% 
% SCET_FRAME_WHOLE               = Spacecraft clock count at the time of
% data acquisition, integer part
% 
% SCET_FRAME_FRAC                = Spacecraft clock count at the time of
% data acquisition, fractional part
% 
% CENTRAL_FREQUENCY              = Frequency at which the radar was
% operating during data acquisition
% 
% MARS_SOLAR_LONGITUDE           = The Mars solar longitude is the Mars-Sun
% angle, measured from the Northern Hemisphere spring equinox where its
% value is set to be 0
% 
% SPACECRAFT_ALTITUDE            = Altitude of the spacecraft above the
% Martian ellipsoid, in km
% 
% SUB_SC_LONGITUDE               = Longitude of the point of the Martian
% ellipsoid closest to the spacecraft
% 
% SUB_SC_LATITUDE                = Latitude of the point of the Martian
% ellipsoid closest to the spacecraft
% 
% LOCAL_TRUE_SOLAR_TIME          = Angle between the extension of the
% vector from the Sun to Mars and the projection on Mars' ecliptic plane of
% a vector from the center of Mars and the point on Mars surface that lies
% directly beneath the spacecraft
% 
% SOLAR_ZENITH_ANGLE             = Angle between the zenith and the
% apparent position of the Sun measured at the point on the Martian
% ellipsoid that lies directly beneath the spacecraft
% 
% FOOTPRINT_CENTER_LONGITUDE     = Longitude of the center of the radar
% footprint, the projection of the antenna beam on the Martian topography
% 
% FOOTPRINT_CENTER_LATITUDE      = Latitude of the center of the radar
% footprint, the projection of the antenna beam on the Martian topography
% 
% FOOTPRINT_VERTEX_LONGITUDE     = Longitude of the vertexes of the radar
% footprint, the projection of the antenna beam on the Martian topography
% 
% FOOTPRINT_VERTEX_LATITUDE      = Latitude of the vertexes of the radar
% footprint, the projection of the antenna beam on the Martian topography
% 
% ROUGHNESS_WITHIN_FOOTPRINT     = R.M.S. height of the topography within
% the radar footprint
% 
% INCIDENCE_ANGLE                = Angle between the perpendicular at the
% Martian surface in the footprint center and the line connecting the
% footprint center and the radar
% 
% FRESNEL_RADIUS                 = Radius of the first Fresnel zone at the
% frequencies of the radar
% 
% ECHO_MODULUS_MINUS1_F1_NO_IONO = Modulus of the complex radar echo for
% beam -1 at the first frequency, before any correction for ionospheric
% dispersion is applied
% 
% ECHO_MODULUS_ZERO_F1_NO_IONO   = Modulus of the complex radar echo for
% beam 0 at the first frequency, before any correction for ionospheric
% dispersion is applied
% 
% ECHO_MODULUS_PLUS1_F1_NO_IONO  = Modulus of the complex radar echo for
% beam +1 at the first frequency, before any correction for ionospheric
% dispersion is applied
% 
% ECHO_MODULUS_MINUS1_F2_NO_IONO = Modulus of the complex radar echo for
% beam -1 at the second frequency, before any correction for ionospheric
% dispersion is applied
% 
% ECHO_MODULUS_ZERO_F2_NO_IONO   = Modulus of the complex radar echo for
% beam 0 at the second frequency, before any correction for ionospheric
% dispersion is applied
% 
% ECHO_MODULUS_PLUS1_F2_NO_IONO  = Modulus of the complex radar echo for
% beam +1 at the second frequency, before any correction for ionospheric
% dispersion is applied
% 
% ECHO_MODULUS_MINUS1_F1_IONO    = Modulus of the complex radar echo for
% beam -1 at the first frequency, after the correction for ionospheric
% dispersion has been applied
% 
% ECHO_MODULUS_ZERO_F1_IONO      = Modulus of the complex radar echo for
% beam 0 at the first frequency, after the correction for ionospheric
% dispersion has been applied
% 
% ECHO_MODULUS_PLUS1_F1_IONO     = Modulus of the complex radar echo for
% beam +1 at the first frequency, after the correction for ionospheric
% dispersion has been applied
% 
% ECHO_MODULUS_MINUS1_F2_IONO    = Modulus of the complex radar echo for
% beam -1 at the second frequency, after the correction for ionospheric
% dispersion has been applied
% 
% ECHO_MODULUS_ZERO_F2_IONO      = Modulus of the complex radar echo for
% beam 0 at the second frequency, after the correction for ionospheric
% dispersion has been applied
% 
% ECHO_MODULUS_PLUS1_F2_IONO     = Modulus of the complex radar echo for
% beam +1 at the second frequency, after the correction for ionospheric
% dispersion has been applied
% 
% ECHO_MODULUS_MINUS1_F1_SIM     = Modulus of the complex radar echo for
% beam -1 at the first frequency, simulated using the MOLA Martian
% topographic dataset
% 
% ECHO_MODULUS_ZERO_F1_SIM       = Modulus of the complex radar echo for
% beam 0 at the first frequency, simulated using the MOLA Martian
% topographic dataset
% 
% ECHO_MODULUS_PLUS1_F1_SIM      = Modulus of the complex radar echo for
% beam +1 at the first frequency, simulated using the MOLA Martian
% topographic dataset
% 
% ECHO_MODULUS_MINUS1_F2_SIM     = Modulus of the complex radar echo for
% beam -1 at the second frequency, simulated using the MOLA Martian
% topographic dataset
% 
% ECHO_MODULUS_ZERO_F2_SIM       = Modulus of the complex radar echo for
% beam 0 at the second frequency, simulated using the MOLA Martian
% topographic dataset
% 
% ECHO_MODULUS_PLUS1_F2_SIM      = Modulus of the complex radar echo for
% beam +1 at the second frequency, simulated using the MOLA Martian
% topographic dataset
% 


RecordBytes = 73952;

% The compiled data file is opened.

fid = fopen( CdrFile, 'r', 'ieee-le' );

if fid < 0
    error( 'ReadMarsisCdr:MissingInputFile', ...
           'The required compiled data file %s could not be opened.', ...
           CdrFile )
end

% The length in bytes of the compiled data file is retrieved, and divided by
% the length of a file record in bytes to obtain the number of records in
% the file.

fseek( fid, 0, 'eof' );
FileBytes = ftell( fid );
FileRecords = FileBytes / RecordBytes;

if round( FileRecords ) ~= FileRecords
    fclose( fid );
    error( 'ReadMarsisCdr:FractionalNumberOfRecords', ...
           'The compiled data file %s contains %f records, a non integer number of records.', ...
            CdrFile, FileRecords )
end

% Instrument and geometric parameters, and real and simulated echo moduli are read

fseek( fid,     0, 'bof' ); ORBIT_NUMBER                   = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,     8, 'bof' ); OST_LINE_NUMBER                = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    16, 'bof' ); FRAME_ID                       = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    24, 'bof' ); SCET_FRAME_WHOLE               = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    32, 'bof' ); SCET_FRAME_FRAC                = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    40, 'bof' ); CENTRAL_FREQUENCY              = fread( fid, [   2, FileRecords ],   '2*double', RecordBytes -   16 );
fseek( fid,    56, 'bof' ); MARS_SOLAR_LONGITUDE           = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    64, 'bof' ); SPACECRAFT_ALTITUDE            = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    72, 'bof' ); SUB_SC_LONGITUDE               = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    80, 'bof' ); SUB_SC_LATITUDE                = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    88, 'bof' ); LOCAL_TRUE_SOLAR_TIME          = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,    96, 'bof' ); SOLAR_ZENITH_ANGLE             = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,   104, 'bof' ); FOOTPRINT_CENTER_LONGITUDE     = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,   112, 'bof' ); FOOTPRINT_CENTER_LATITUDE      = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,   120, 'bof' ); FOOTPRINT_VERTEX_LONGITUDE     = fread( fid, [   4, FileRecords ],   '4*double', RecordBytes -   32 );
fseek( fid,   152, 'bof' ); FOOTPRINT_VERTEX_LATITUDE      = fread( fid, [   4, FileRecords ],   '4*double', RecordBytes -   32 );
fseek( fid,   184, 'bof' ); ROUGHNESS_WITHIN_FOOTPRINT     = fread( fid, [   2, FileRecords ],   '2*double', RecordBytes -   16 );
fseek( fid,   200, 'bof' ); INCIDENCE_ANGLE                = fread( fid, [   1, FileRecords ],     'double', RecordBytes -    8 );
fseek( fid,   208, 'bof' ); FRESNEL_RADIUS                 = fread( fid, [   2, FileRecords ],   '2*double', RecordBytes -   16 );
fseek( fid,   224, 'bof' ); ECHO_MODULUS_MINUS1_F1_NO_IONO = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid,  4320, 'bof' ); ECHO_MODULUS_ZERO_F1_NO_IONO   = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid,  8416, 'bof' ); ECHO_MODULUS_PLUS1_F1_NO_IONO  = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 12512, 'bof' ); ECHO_MODULUS_MINUS1_F2_NO_IONO = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 16608, 'bof' ); ECHO_MODULUS_ZERO_F2_NO_IONO   = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 20704, 'bof' ); ECHO_MODULUS_PLUS1_F2_NO_IONO  = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 24800, 'bof' ); ECHO_MODULUS_MINUS1_F1_IONO    = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 28896, 'bof' ); ECHO_MODULUS_ZERO_F1_IONO      = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 32992, 'bof' ); ECHO_MODULUS_PLUS1_F1_IONO     = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 37088, 'bof' ); ECHO_MODULUS_MINUS1_F2_IONO    = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 41184, 'bof' ); ECHO_MODULUS_ZERO_F2_IONO      = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 45280, 'bof' ); ECHO_MODULUS_PLUS1_F2_IONO     = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 49376, 'bof' ); ECHO_MODULUS_MINUS1_F1_SIM     = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 53472, 'bof' ); ECHO_MODULUS_ZERO_F1_SIM       = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 57568, 'bof' ); ECHO_MODULUS_PLUS1_F1_SIM      = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 61664, 'bof' ); ECHO_MODULUS_MINUS1_F2_SIM     = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 65760, 'bof' ); ECHO_MODULUS_ZERO_F2_SIM       = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );
fseek( fid, 69856, 'bof' ); ECHO_MODULUS_PLUS1_F2_SIM      = fread( fid, [ 512, FileRecords ], '512*double', RecordBytes - 4096 );

fclose( fid );