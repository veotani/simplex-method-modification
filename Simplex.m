function [answ,table] = Simplex(A,b,x0,c0)
%�������� A ��� ���������� ����������
[rows,cols]=size(A); 
%������ ����������� ��������-�������
table = BuildTable(A,b,x0,c0);
%���������� ������� ���������� �� ������� � �������� � �����. �������
RowIndexes = (cols-rows+1):cols;
ColumnIndexes = [(cols-rows+1):cols 1:(cols-rows)];
%�������� (n-1)/2 ��������, � �������� ����� ��������.
FirstLineOfTable=table(1,:);
C = [];
for i=2:length(FirstLineOfTable)
    if FirstLineOfTable(i)<0 && max(table(:, i))>0
        C = [C; i];
    end
end
%C - ������ �������� c0, ������� ���������� ���
for i=1:fix(length(C)/2)+1
    rnd = round(rand(1)*(length(C)-1))+1;
    C([i rnd]) = C([rnd i]);
end
C=C(1:fix(length(C)/2)+1);
disp(C);
%������ C ��� ������ �� �������, ������� �� ����� �������������
answ=[];
for k=1:length(C)           %������� �������
    s=C(k);
    [newTable, r1] = SimplexByS(table, s, rows,cols); %r1 - ������ ����������, �������
                                                      %    �� ������� � �����
    for m=[1:k-1 k+1:length(C)]
        s1=C(m);
        if newTable(1, s1)<0 && max(newTable(:, s1))>0 
            [newTable1, r2] = SimplexByS(newTable, s1,rows,cols);
            newVar = RowIndexes;
            newVar(r1-1)=ColumnIndexes(s-1);
            newVar(r2-1)=ColumnIndexes(s1-1);
            newVar=[newVar; newTable1(2:end, 1)'];
            x=zeros(length(c0), 1);
            for i=1:length(x)
                for j=1:length(newVar(1, :))
                    if i==newVar(1, j)
                        x(i)=newVar(2,j);
                    end
                end
            end
            disp('�������� ��������� ����� ����������: ');
            disp(newVar);
            disp(['z0 = ' num2str(c0*x)]);
            answ=[answ; c0*x];            
        end
    end
end
disp(['����������� �������� ������� �������: ' num2str(min(answ))]);
end