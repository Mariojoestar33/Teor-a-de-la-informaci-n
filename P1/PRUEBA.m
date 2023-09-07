clear all;
close all;

FILE = fopen('prueba.txt');
formatSpec = '%c'; %Especificamos que sera caracter por caracter
VECTOR = fscanf(FILE, formatSpec); %Introducimos en un vector todos los caracteres del .txt
LONGITUD = length(VECTOR);
fclose(FILE);
ABECEDARIO = ones(2,LONGITUD);
CONTADOR = zeros(1, LONGITUD);
bandera = 0;
posicion = 1;
%disp (ABECEDARIO);

for i=1:1:LONGITUD
    bandera = 0;
    for j=1:1:LONGITUD
        if(VECTOR(i) == ABECEDARIO(1,j))
            ABECEDARIO(2,j) = ABECEDARIO(2,j) + 1;
            CONTADOR(j) = CONTADOR(j) + 1;
            bandera = 1;
            %disp(char(ABECEDARIO))
            %disp(CONTADOR)
            break    
        end
    end
    if(bandera == 0)
        ABECEDARIO(1, posicion) = VECTOR(i);
        ABECEDARIO(2, posicion) = 1;
        CONTADOR(posicion) = 1;
        posicion = posicion + 1;
        %disp(char(ABECEDARIO))
        %disp(CONTADOR)
    end
end

%Funcion npara imprimir cada caracter asi como el numero de apariciones del
%mismo

for i=1:1:posicion-1
    if(ABECEDARIO(1,i) ~= 10 && ABECEDARIO(1,i) ~= 13 && ABECEDARIO(1,i) ~= 32)
        fprintf('%c = %d\n', ABECEDARIO(1,i), CONTADOR(i))
    end
    if(ABECEDARIO(1,i) == 13)
        fprintf('CR = %d\n', CONTADOR(i))
    elseif(ABECEDARIO(1,i) == 10)
        fprintf('NL = %d\n', CONTADOR(i))
    elseif(ABECEDARIO(1,i) == 32)
        fprintf('ESPACIO = %d\n', CONTADOR(i))
    end
end

%disp(char(ABECEDARIO(2)));
%disp(char(ABECEDARIO(3)));

%disp (char(ABECEDARIO));
%disp (CONTADOR);
%disp (VECTOR);