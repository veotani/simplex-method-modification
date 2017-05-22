function table = BuildTable(A,b,x0,c0)
z0 = c0*x0;
[rows,cols]=size(A);
%m = rows; n = cols
table = zeros(rows+1,cols+1);
table(:,1) = [z0;b];
table(:,2:rows+1)=[zeros(1,rows); A(:,cols-rows+1:cols)];
table(:,rows+2:cols+1)=[c0(1:cols-rows); A(:, 1:cols-rows)];
end
