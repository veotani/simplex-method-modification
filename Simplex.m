function [answ,table] = Simplex(A,b,x0,c0)
%Измеряем A для дальнейших вычислений
[rows,cols]=size(A); 
%Строим изначальную симплекс-таблицу
table = BuildTable(A,b,x0,c0);
%Записываем индексы переменных по строкам и столбцам в соотв. массивы
RowIndexes = (cols-rows+1):cols;
ColumnIndexes = [(cols-rows+1):cols 1:(cols-rows)];
%Выделяем (n-1)/2 столбцов, с которыми будем работать.
FirstLineOfTable=table(1,:);
C = [];
for i=2:length(FirstLineOfTable)
    if FirstLineOfTable(i)<0 && max(table(:, i))>0
        C = [C; i];
    end
end
%C - массив индексов c0, которые устраивают нас
for i=1:fix(length(C)/2)+1
    rnd = round(rand(1)*(length(C)-1))+1;
    C([i rnd]) = C([rnd i]);
end
C=C(1:fix(length(C)/2)+1);
disp(C);
%Теперь C это только те столбцы, которые мы будем рассматривать
answ=[];
for k=1:length(C)           %ведущий столбец
    s=C(k);
    [newTable, r1] = SimplexByS(table, s, rows,cols); %r1 - первая переменная, которую
                                                      %    мы заносим в базис
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
            disp('Получили следующий набор переменных: ');
            disp(newVar);
            disp(['z0 = ' num2str(c0*x)]);
            answ=[answ; c0*x];            
        end
    end
end
disp(['Минимальное значение целевой функции: ' num2str(min(answ))]);
end