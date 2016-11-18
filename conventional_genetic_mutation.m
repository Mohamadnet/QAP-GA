function result=conventional_genetic_mutation(indi,mutation_rate,coding_method,R)
if coding_method==1
    result=min(max(indi+(rand(size(indi))<mutation_rate/10).*(R*rand(size(indi))-R/2),-R/2),R/2);
else
    result=xor((rand(size(indi))<mutation_rate),indi);
end