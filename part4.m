clear all;

x1 = -5:0.05:5;
i = 1;

while i < 202
    x2(i) = (1/4) * sqrt(20 - x1(i)^2);
    i = i + 1;
end

x3 = -5:0.05:5;
j = 1;

while j < 202
    x4(j) = x3(j)^4 - 10;
    j = j + 1;
end

plot(x1, x2, x3, x4)
