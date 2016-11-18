function QAP

run =30;                         %run   
iteration=2000;     %generation
pop_no=50;
f=dlmread('f_nug30.dat'); 
d=dlmread('d_nug30.dat');     %read from text file
N = 30 ;
x=1:iteration ;
crossover_rate=[0.1 0.3 0.5 0.7 0.9];
mutation_rate=[0.1 0.3 0.5 0.7 0.9];
coding_method=1;
crossover_type=1;
selection_type=1;
beta=0;
z_temp=[];
size_crossover_rate=size(crossover_rate);
size_mutation_rate=size(mutation_rate);
for jj=1:size_crossover_rate(2)
    for w=1:size_mutation_rate(2)
        filename=['temp data\cr_' int2str(crossover_rate(jj)) ' mu_' int2str(mutation_rate(w)) '.mat'];
        if exist(filename)==2
            load(filename);
        else
            for i=1:run
                mean_tempdec(i,:)=GA_find(pop_no,iteration,crossover_rate(jj),mutation_rate(w),coding_method,crossover_type,selection_type,beta,f,d);
                disp(['End of run ',num2str(i),' th.']) ;
            end
            y=mean(mean_tempdec,1);
            z_temp=[z_temp,y(iteration)];
            filename=['temp data\cr_' int2str(crossover_rate(jj)) ' mu_' int2str(mutation_rate(w)) '.mat'];
            save(filename,'z_temp');
        end
    end
end
z_fitness=zeros(size_crossover_rate(2),size_mutation_rate(2));    % (x,y)
z_fitness(:)=z_temp; 
[max_z I_z]=min(z_temp);
size_x=size_crossover_rate(2);
size_y=size_mutation_rate(2);
crossover_rate_max=crossover_rate(ceil(I_z/size_y));
ceil(I_z/size_y)
mod(I_z,size_y)
if mod(I_z,size_x)~=0
    mutation_rate_max=mutation_rate(mod(I_z,size_y));
else
    mutation_rate_max=mutation_rate(size_y);
end
h= figure;
surf(mutation_rate,crossover_rate,z_fitness);  %(x,y,z)
colormap gray;
alpha(0.4);
axis auto ;
dlm_str=[max_z mutation_rate_max crossover_rate_max];
dlmwrite('new\res 3d.txt',dlm_str);
dlmwrite('new\res 3d z.txt',z_fitness);
hgsave(h,'new\fig 3d');

end