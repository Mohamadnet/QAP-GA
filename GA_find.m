function result=GA_find(pop_no,iteration,crossover_rate,mutation_rate,coding_method,crossover_type,selection_type,beta,f,d)
size_f=size(f);
R=2;
m=size_f(1);
point_lenghth=ceil(log2(R));
if coding_method==1
    for ii=1:pop_no
        pop(ii).indi=round(R*rand(1,m)-R/2);
    end
else
    for ii=1:pop_no
        pop(ii).indi=round(rand(1,point_lenghth*point_no));
    end
end

best_fitness=inf;
for ii=1:iteration
    fitness=genetic_fractal_real_fitness(pop_no,pop,d,f);
    [Max I]=max(fitness);
    STD=std(fitness);
     
    Min=min(fitness);
    fitness=(fitness-Min)/Max-Min;  
    if sum(fitness-min(fitness))==0
        fitness=fitness+rand(1,pop_no);
    end
    if Min<best_fitness
        best_fitness=Min;
        best_indi=pop(I).indi;
    end   
    
    if selection_type==1
        Sum=sum(fitness);
        fitness=fitness/Sum;
        fitness=round(fitness*100);
    else
        Mean=mean(fitness);
        fitness=exp((beta*(fitness-Mean))/STD);
        Sum=sum(fitness);
        fitness=fitness/Sum;
        fitness=round(fitness*100);
    end
    
    counter=1;
    for jj=1:pop_no
        select(counter:counter+fitness(jj))=jj;
        counter=counter+fitness(jj);
    end
    
    [del Size]=size(select);
    for jj=1:round(pop_no/2)
        i1=select(ceil(Size*rand));
        i2=select(ceil(Size*rand));
        if rand<crossover_rate
            help=conventional_genetic_crossover(pop(i1).indi,pop(i2).indi,coding_method,crossover_type,R);
            pop1(2*jj-1).indi=help.off1;
            pop1(2*jj).indi=help.off2;
        else
            pop1(2*jj-1).indi=pop(i1).indi;
            pop1(2*jj).indi=pop(i2).indi;
        end
        
        
        pop1(2*jj-1).indi=conventional_genetic_mutation(pop1(2*jj-1).indi,mutation_rate,coding_method,R);
        pop1(2*jj).indi=conventional_genetic_mutation(pop1(2*jj).indi,mutation_rate,coding_method,R);        
    end
    
    pop=pop1;
    pop(1).indi=best_indi;
%     fitnesses(ii)=genetic_fractal_fitness(best_indi,Domain_pool,range_block,domain_horizontal,domain_vertical);
result(ii)=best_fitness;
end