%%
c1 = rgb2ycbcr([0 1 0]);
cy = c1(1);
ccb = linspace(16/255, 240/255, 101);
[y, cb, cr] = meshgrid(cy, ccb, ccb);
cycbcr = [y(:) cb(:) cr(:)];
crgb = ycbcr2rgb2(cycbcr);
crgb = crgb(all(crgb<=1&crgb>=0, 2), :);
crgb2 = crgb(any(abs(crgb-1)<0.016|abs(crgb)<0.016, 2), :);
chsv2 = rgb2hsv(crgb2);

%%
figure; 
scatter3(crgb(:, 1), crgb(:, 2), crgb(:, 3), 30, crgb, 'filled', 'MarkerEdgeColor', 'k'); 
xlabel('R'); ylabel('G'); zlabel('B');
axis equal

%%
h = chsv2(:, 1);
s = chsv2(:, 2);
v = chsv2(:, 3);
x = cos(2*pi*h).*s.*v;
y = sin(2*pi*h).*s.*v;
z = v;
figure; scatter3(x, y, z, 30, crgb2, 'filled', 'MarkerEdgeColor', 'k');

%% Main
n = 368;
c1 = rgb2ycbcr([0 1 0]);
cy = c1(1);
scale = [65.481 128.553 24.966]/255;
offset = 16/255;
f = @(r, b) (cy-offset-scale(1).*r-scale(3).*b)./scale(2);
cv = [0 1 0;...
    1 f(1, 0) 0;...
    1 f(1, 1) 1;...
    0 f(0, 1) 1;...
    0 1 0];
vq = (0:n-1)/n;
cq = interp1(linspace(0, 1, 5)', cv, vq, 'linear');

%%
figure;
scatter(cos(2*pi*vq), sin(2*pi*vq), 10, cq, 'filled', 'MarkerEdgeColor', 'k');



