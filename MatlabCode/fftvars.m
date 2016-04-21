function [ t, f ] = fftvars( fs, Ns )

% Function FFTVARS ( Variables for FFT computations )
%
% Abstract
%
%    Computes vectors containing the correct time and frequency values for
%    FFT computations.
%
% Brief I/O
%
%    Variable  I/O  Description
%    --------  ---  --------------------------------------------------
%    fs         I   Sampling frequency of values for FFT computations.
%    Ns         I   Number of samples used in FFT computations.
%    t          O   Times of acquisition of values in FFT computations.
%    f          O   Frequency spectrum for FFT computations.
%
% Detailed Input
%
%    fs          is the frequency at which values in the vector of values
%                to be processed using the discrete Fourier transform were
%                sampled.
%
%    Ns          is the number of samples contained in the vector of values
%                to be processed using the discrete Fourier transform.
%
% Detailed Output
%
%    t           is a vector containing time values for each sample of the
%                vector to be processed using the discrete Fourier
%                transform.
%
%    f           is a vector containing frequency values for each sample of
%                the vector produced applying the discrete Fourier
%                transform.
%
% Parameters
%
%    None.
%
% Exceptions
%
%    1) The function checks if the sampling frequency provided in input is
%       a positive number, issuing the error message
%       'Fftvars:NegativeSamplingFrequency' if this is not true.
%
%    2) The function checks if the number of samples provided in input is a
%       positive integer, issuing the error message
%       'Fftvars:NonIntegerNumberOfSamples' if this is not true.
%
% Files
%
%    None.
%
% Particulars
%
%    A vector of samples to be processed through FFT operations can be
%    characterized through the frequency at which samples were acquired and
%    through the number of samples contained in the vector: given these two
%    parameters, there exist a single set of values describing the time of
%    acquisition of the samples and the frequencies of the FFT spectrum in
%    their correct order.
%
%    Although deriving a set of time values corresponding to the vector of
%    discrete samples is trivial, providing the correct frequency values
%    for the FFT spectrum of the vector is not. In particular, the FFT
%    spectrum produced by MATLAB has the first element corresponding to
%    zero frequency. Further care must be taken if the number of samples is
%    even or odd: if there is an even number of samples, the first element
%    of the second half of the spectrum corresponds to the negative Nyquist
%    frequency; if the number of samples is odd, the median element of the
%    spectrum corresponds to the positive Nyquist frequency, and is
%    followed by the negative Nyquist frequency.
%
% Examples
%
%    1) The following script demonstrates the correspondence between the
%       frequencies in the spectra of two vectors having the same
%       information content, but a different number of elements.
%
%       clear all
%       close all
%       clc
%
%       %
%       % Two vectors are defined, containing respectively an odd number and an
%       % even number of elements. Both vectors are sampled at the same frequency,
%       % but the vector with an even number of elements is twice as long as the
%       % vector with an odd number of elements.
%
%       fs_odd  = 1.e2;
%       fs_even = fs_odd;
%
%       Ns_odd  = 45;
%       Ns_even = 2 * Ns_odd;
%
%       [ t_odd , f_odd  ] = fftvars( fs_odd,  Ns_odd  );
%       [ t_even, f_even ] = fftvars( fs_even, Ns_even );
%
%       %
%       % The vectors themselves contain the same information: the longer vector is
%       % padded with zeros in its second half.
%
%       x_odd  = ones( size( t_odd ) );
%       x_even = [ x_odd, zeros( size( t_odd ) ) ];
%
%       %
%       % The Fourier spectra of the two vectors are computed and displayed.
%
%       S_even = fft( x_even );
%       S_odd  = fft( x_odd  );
%
%       plot( ...
%           fftshift( f_even ), fftshift( real( S_even ) ), 'b-.', ...
%           fftshift( f_even ), fftshift( imag( S_even ) ), 'b*', ...
%           fftshift( f_odd  ), fftshift( real( S_odd  ) ), 'r:', ...
%           fftshift( f_odd  ), fftshift( imag( S_odd  ) ), 'r.' )
%
% Restrictions
%
%    None.
%
% Literature References
%
%    None.
%
% Author and Institution
%
%    R. Orosei   (INAF)
%
% Version
%
%    Version 1.0.0, 03-OCT-2005 (RO)
%
%       First release.
%
% Index Entries
%
%    None at this time.
%
% Revisions
%
%    None.
%

%
% Checks are performed to ensure that the input parameters are meaningful
% for computations, namely that the sampling frequency is positive, and
% that the number of samples is a positive integer.

if fs <= 0
    error( 'Fftvars:NegativeSamplingFrequency', ...
           'The sampling frequency for the FFT vector must be a positive number.' )
end

if round( Ns ) ~= Ns || Ns <= 0
    error( 'Fftvars:NonIntegerNumberOfSamples', ...
           'The number of samples for the FFT is not a positive integer.' )
end

%
% Numerical parameters:
%
%    dt          Sampling interval in the time domain.
%    df          Sampling interval in the frequency domain.

dt = 1 / fs;
% df = fs / Ns; This formula is correct only for even values of Ns

%
% The vector of time values is created

t = dt * ( ( 1 : Ns ) - 1 );

%
% Preallocation of memory space results in faster execution

f = zeros( 1, Ns );

% Order of frequencies is determined according to even or odd

if rem( Ns, 2 ) == 0
    df = fs / Ns;
    i = 1 : Ns/2;
    f( i ) = df .* ( i - 1 );
    i = Ns/2 + 1 : Ns;
    f( i ) = df .* ( i - Ns - 1 );
else
    df = fs / ( Ns - 1 );
    i = 1 : ceil( Ns/2 );
    f( i ) = df .* ( i - 1 );
    i = ceil( Ns/2 ) + 1 : Ns;
    f( i ) = df .* ( i - Ns );
end