function [T,Varj] = Pascual_marqui(leadfield, a)
H = eye(16,16)-ones(16,1)*ones(1,16)/(ones(1,16)*ones(16,1));

Kt = leadfield'*H;
K = H*leadfield;


T = Kt*pinv(K*Kt+a*H);

Vard = K*Kt+a*H;
Varj = Kt*pinv(K*Kt+a*H)*K;

end
