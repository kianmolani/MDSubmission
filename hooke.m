function [F,v,d] = hooke(k, x, x_0, m, delta_t, v)

F = k * ( x - x_0 ) .^ 2;

for i = 1:length(x)
    if x(i) > x_0(i)
        F(i) = -F(i);
    end
end

a = F / m;
v = v + a * delta_t;
d = v * delta_t + ( 1 / 2 ) * a * ( delta_t ^ 2 );

end

