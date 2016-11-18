function result=conventional_genetic_crossover(indi1,indi2,coding_method,crossover_type,R)
if coding_method==1
    result.off1=max(min((indi2+indi1)/2+(indi2-indi1).*(R*rand(size(indi1))-R/2),R/2),-R/2);
    result.off2=max(min((indi2+indi1)/2+(indi2-indi1).*(R*rand(size(indi1))-R/2),R/2),-R/2);
else
    if crossover_type==1
        [H W]=size(indi1);
        result.off1=indi1;
        result.off2=indi2;
        y=sort(ceil(H*rand(1,2)));
        result.off1(y(1):y(2),:)=indi2(y(1):y(2),:);
        result.off2(y(1):y(2),:)=indi1(y(1):y(2),:);
    end
    if crossover_type==2
        Mask=round(rand(size(indi1)));
        result.off1=or(and(indi1,Mask),and(indi2,1-Mask));
        result.off2=or(and(indi1,1-Mask),and(indi2,Mask));
    end
end