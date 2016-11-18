function [list row] = mergeSort(list,row)
    if numel(list) <= 1
        return
    else
        middle = ceil(numel(list) / 2);
        left = list(1:middle);
        right = list(middle+1:end);
        left_row = row(1:middle);
        right_row = row(middle+1:end);
 
        [left left_row] = mergeSort(left,left_row);
        [right right_row] = mergeSort(right,right_row);
 
        if left(end) <= right(1)
            list = [left right];
            row = [left_row right_row];
            return
        end
 
        %merge(left,right)
        counter = 1;
        while (numel(left) > 0) && (numel(right) > 0)
            if(left(1) <= right(1))
                list(counter) = left(1);
                row(counter) = left_row(1);
                left(1) = [];
                left_row(1) = [];
            else
                list(counter) = right(1);
                row(counter) = right_row(1);
                right(1) = [];
                right_row(1) = [];
            end           
            counter = counter + 1;   
        end
 
        if numel(left) > 0
            list(counter:end) = left;
            row(counter:end) = left_row;
        elseif numel(right) > 0
            list(counter:end) = right;
            row(counter:end) = right_row;
        end
        %end merge        
    end %if
end %mergeSort