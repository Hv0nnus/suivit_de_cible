function [speed3D] = compute_speed(positionk, positionk_1,T_e)
  speed3D = (positionk - positionk_1)/T_e;
end
