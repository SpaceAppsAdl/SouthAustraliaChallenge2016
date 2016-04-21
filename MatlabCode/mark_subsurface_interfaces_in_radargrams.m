clc
clearvars
close all

% This script is used to mark the position of subsurface interfaces in
% MARSIS radargrams, read from a set of files prepared by the user. Data
% files are read one at the time, and both real and simulated radargrams
% are displayed on screen. After visual inspection of the radargrams, the
% user can choose to mark with a series of mouse clicks the position of a
% subsurface interface, in either of the radargrams acquired simultaneously
% by MARSIS at two different frequencies. Points acquired on the screen are
% then saved in an output file.

% A few parameters:

R_m = 3389.95e3; % Mars mean radius [m]
c   = 299792458; % Speed of light in vacuo [m/s]
fs  =     1.4e6; % MARSIS A/D converter sampling frequency (Hz)
dnr =        55; % Dynamic range of simulated radargrams [dB]


%% Display radargrams for the area of interest

% List all files in the directory and open only those that contain MARSIS
% data, based on their naming scheme

filenames = dir;

for i = 1 : length( filenames )

    CdrFile = filenames( i ).name;

    if ~isempty( strfind( CdrFile, 'C_' ) ) && ~isempty( strfind( CdrFile, '_SS3_TRK_CMP_M.DAT' ) )

% Read only the input data that are needed in subsequent computations

        [ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ...
          FOOTPRINT_CENTER_LONGITUDE, ...
          FOOTPRINT_CENTER_LATITUDE, ...
          ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ...
          ECHO_MODULUS_ZERO_F1_IONO, ...
          ~, ~, ...
          ECHO_MODULUS_ZERO_F2_IONO, ...
          ~, ~, ...
          ECHO_MODULUS_ZERO_F1_SIM, ...
          ~, ~, ...
          ECHO_MODULUS_ZERO_F2_SIM, ...
          ~ ] = readmarsiscdr( CdrFile );

% Detect beginning of surface echo

        iedgef1 = findedge( ECHO_MODULUS_ZERO_F1_IONO );
        iedgef2 = findedge( ECHO_MODULUS_ZERO_F2_IONO );

% Compute noise-normalized radargrams

        radargrmf1 = 20 .* log10( ECHO_MODULUS_ZERO_F1_IONO ); 
        radargrmf2 = 20 .* log10( ECHO_MODULUS_ZERO_F2_IONO );

        radargrmf1 = max( radargrmf1, ones( 512, 1 ) * median( radargrmf1 ) );
        radargrmf2 = max( radargrmf2, ones( 512, 1 ) * median( radargrmf2 ) );

        radarsimf1 = 20 .* log10( ECHO_MODULUS_ZERO_F1_SIM ); 
        radarsimf2 = 20 .* log10( ECHO_MODULUS_ZERO_F2_SIM );

        maxradarsimf1 = max( max( radarsimf1 ) );
        maxradarsimf2 = max( max( radarsimf2 ) );

        radarsimf1( radarsimf1 < maxradarsimf1 - dnr ) = maxradarsimf1 - dnr;
        radarsimf2( radarsimf2 < maxradarsimf2 - dnr ) = maxradarsimf2 - dnr;

% Display radargrams and ask the operator to acquire the position of
% subsurface interfaces after comparison with simulations

        markinterface = 1;
        interfacenumber = 1;

        while markinterface == 1

            [ samples, echoes ] = size( radargrmf1 );
            [ t, ~ ] = fftvars( fs, samples );

            subplot( 2, 2, 1 ), imagesc( radargrmf1 ), colormap gray, axis off equal, hold on, plot( 1: echoes, iedgef1, 'b' ), hold off
            title( [ 'Radargram for orbit ', CdrFile( 3 : 7 ), ', Band 1' ] )
            subplot( 2, 2, 2 ), imagesc( radargrmf2 ), colormap gray, axis off equal, hold on, plot( 1: echoes, iedgef2, 'b' ), hold off
            title( [ 'Radargram for orbit ', CdrFile( 3 : 7 ), ', Band 2' ] )
            subplot( 2, 2, 3 ), imagesc( radarsimf1 ), colormap gray, axis off equal
            title( [ 'Simulation for orbit ', CdrFile( 3 : 7 ), ', Band 1' ] )
            subplot( 2, 2, 4 ), imagesc( radarsimf2 ), colormap gray, axis off equal
            title( [ 'Simulation for orbit ', CdrFile( 3 : 7 ), ', Band 2' ] )

            action = menu( 'Choose action', 'Mark subsurface interface', 'Skip' );

            switch action

                case 1
% Acquire on the screen the points outlining the subsurface interface
                    [x, y] = ginput;
% Interpolate between interface points and display result on screen
                    interf = csapi( x, y );
                    hold on
                    fnplt( interf, 'r' )
                    hold off 
% If the interface has been traced correctly, save it to file
                    choice = menu( 'Accept marked subsurface interface?', 'Yes, Band 1', 'Yes, Band 2', 'No' );

                    switch choice

                        case 1
% Convert coordinates on screen to indexes of elements within the echo matrix
                            ix = ceil( min( x ) ) : floor(max( x ) );
                            iy = fnval( interf, ix );
% Associate the coordinates of the corresponding footprint
                            lon = FOOTPRINT_CENTER_LONGITUDE( ix );
                            lat = FOOTPRINT_CENTER_LATITUDE(  ix );
                            z = c/2 * ( iy - iedgef1( ix ) ) / fs;
% Write output file
                            csvwrite( ['subsurface_interface_', '_', CdrFile( 3 : 7 ), '_', num2str( interfacenumber ), '.csv' ], [ lon', lat', z' ] )

                            interfacenumber = interfacenumber + 1;

                        case 2
% Convert coordinates on screen to indexes of elements within the echo matrix
                            ix = ceil( min( x ) ) : floor(max( x ) );
                            iy = fnval( interf, ix );
% Associate the coordinates of the corresponding footprint
                            lon = FOOTPRINT_CENTER_LONGITUDE( ix );
                            lat = FOOTPRINT_CENTER_LATITUDE(  ix );
                            z = c/2 * ( iy - iedgef2( ix ) ) / fs;
% Write output file
                            csvwrite( ['subsurface_interface_', CdrFile( 3 : 7 ), '_', num2str( interfacenumber ), '.csv' ], [ lon', lat', z' ] )

                            interfacenumber = interfacenumber + 1;

                        case 3

                            continue

                    end

                case 2

                    markinterface = 0;

            end

        end

    end
    
end
