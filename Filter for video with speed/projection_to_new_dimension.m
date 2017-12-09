% projection_to_camera take two 2D images and give back a 3D observation in the new dimension
function [vecteur_y] = projection_to_new_dimension (cl_observation, cr_observation)
  Hl = [ 1 0 ;0 1 ; -1 0 ];
  Hr = [ 0 0 ; 0 0 ; 1 0 ];
  vecteur_y = Hl*cl_observation + Hr*cr_observation;
endfunction
