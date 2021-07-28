# 
[m1, Fs1] = audioread('mixed1.wav');
[m2, Fs2] = audioread('mixed2.wav');

m = [m1, m2];

xx = m';

yy = sqrtm(inv(cov(xx')))*(xx-repmat(mean(xx,2),1,size(xx,2)));
[W,s,v] = svd((repmat(sum(yy.*yy,1),size(yy,1),1).*yy)*yy');

ss = W * yy; 

# Scale down by an empiric value
s = ss .* 0.01;

# s Nx2 contains separated signals 
s = s';

audiowrite('separated1.wav', s(:, 1), Fs1);
audiowrite('separated2.wav', s(:, 2), Fs1);