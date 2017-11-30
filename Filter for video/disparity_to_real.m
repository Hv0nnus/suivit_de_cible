## Copyright (C) 2017 Tanguy
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} disparity_to_real (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Tanguy <Tanguy@DESKTOP-323V8B4>
## Created: 2017-11-20

function [ x_kalm_mean_real ] = disparity_to_real(x_kalm_mean, f_d, b,dPP)


K = [f_d(1) 0 dPP(1);
     0 f_d(2) dPP(2);
     0 0 1];
% Matrice de projection sur la camera gauche
P_l = [K, [0,0,0]'];

t = [f_d(1)*b,0,0];
% Matrice de projection sur la camera droite
P_r = [K, t'];

% Matrice de projection sur l'espace de disparité 
P_d = [ P_l(1,:);
        P_l(2,:);
        P_r(1,:) - P_l(1,:);
        P_l(3,:)];

inv_P_d = inv(P_d);
x_kalm_mean_real = inv_P_d*x_kalm_mean;
x_kalm_mean_real = x_kalm_mean_real./x_kalm_mean_real(4,:);    


end