function [table, r] = SimplexByS(table, s,rows,cols)
%Находим ведущую строку
a = table(2:rows+1, s);
b = table(2:rows+1, 1);
temp=inf;
for i=1:length(a)
    if a(i)>0
        if b(i)/a(i)<temp
            temp=b(i)/a(i);
            r=i;                %r - ведущая строка
        end
    end
end
    
%Ведущую строку записываем в индексы в нужное место
r=r+1;
%Приводим таблицу по методу гаусса
table(r,:)=table(r,:)./table(r,s);
for i=1:rows+1
    if (i ~= r)
        table(i,:)=table(i,:)-table(r,:).*table(i,s);
    end
end
end

