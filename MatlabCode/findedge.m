function iedge = findedge( echo )

% This function detects the position of the edge of the echo, that is the
% beginning of a radar reflection, presumably from the surface beneath the
% spacecraft. The algorithm used has been taken from the PhD thesis of
% Jeremie Mouginot (jmougino@uci.edu)

% echo  = array containing a single radar echo for every column, and a
% complex echo sample for every element of a column.
%
% iedge = index of echo edge, the beginning of an echo. This is a line
% vector of integers, whose value is the position of the beginning of the
% radar reflection within the corresponding echo.

nbox = 30; % parameter, number of echo samples to be used in edge detection

[ samples, echoes ] = size( echo );

box = zeros( samples, 1 );
box( 2 : nbox + 1 ) = 1 / nbox;

absecho2 = abs( echo ).^2;

criterion = ifft( fft( absecho2 ) .* fft( box * ones( 1, echoes ) ) );
criterion = absecho2 ./ criterion;

[ ~, iedge ] = max( criterion );
