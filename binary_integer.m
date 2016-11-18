function result=binary_integer(x);
[height width]=size(x);
result=0;
for ii=1:width
    result=result+x(ii)*2^(width-ii);
end