clear all;
close all;

FILE1 = fopen('radio_en.txt');
FILE2 = fopen('radio_es.txt');
FILE3 = fopen('radio_al.txt');
formatSpec = '%c'; %Especificamos que sera caracter por caracter

VECTOR_EN = fscanf(FILE1, formatSpec); %Introducimos en un vector todos los caracteres del .txt
VECTOR_ES = fscanf(FILE2, formatSpec);
VECTOR_AL = fscanf(FILE3, formatSpec);

LONGITUD_EN = length(VECTOR_EN);
LONGITUD_ES = length(VECTOR_ES);
LONGITUD_AL = length(VECTOR_AL);

fclose(FILE1);
fclose(FILE2);
fclose(FILE3);

ABECEDARIO_EN = ones(1,LONGITUD_EN);
ABECEDARIO_ES = ones(1, LONGITUD_ES);
ABECEDARIO_AL = ones(1, LONGITUD_AL);

CONTADOR_EN = zeros(1, LONGITUD_EN);
CONTADOR_ES = zeros(1, LONGITUD_ES);
CONTADOR_AL = zeros(1,LONGITUD_AL);

bandera = 0;

posicion_en = 1;
posicion_es = 1;
posicion_al = 1;

%Funcion para obtener abecedario y el numero de apariciciones de los
%caracteres

for i=1:1:LONGITUD_EN
    bandera = 0;
    for j=1:1:LONGITUD_EN
        if(VECTOR_EN(i) == ABECEDARIO_EN(j)) %Se incrementa en 1 el numero de apariciones del caracter
            CONTADOR_EN(j) = CONTADOR_EN(j) + 1;
            bandera = 1;
            break    
        end
    end
    if(bandera == 0) %Se guarda en el abecedario el caracter
        ABECEDARIO_EN(posicion_en) = VECTOR_EN(i);
        CONTADOR_EN(posicion_en) = 1;
        posicion_en = posicion_en + 1;
    end
end

%SEGUNDO ABECEDARIO_EN

for i=1:1:LONGITUD_ES
    bandera = 0;
    for j=1:1:LONGITUD_ES
        if(VECTOR_ES(i) == ABECEDARIO_ES(j)) %Se incrementa en 1 el numero de apariciones del caracter
            CONTADOR_ES(j) = CONTADOR_ES(j) + 1;
            bandera = 1;
            break    
        end
    end
    if(bandera == 0) %Se guarda en el abecedario el caracter
        ABECEDARIO_ES(posicion_es) = VECTOR_ES(i);
        CONTADOR_ES(posicion_es) = 1;
        posicion_es = posicion_es + 1;
    end
end

%Tercer ABECEDARIO_AL

for i=1:1:LONGITUD_AL
    bandera = 0;
    for j=1:1:LONGITUD_AL
        if(VECTOR_AL(i) == ABECEDARIO_AL(j)) %Se incrementa en 1 el numero de apariciones del caracter
            CONTADOR_AL(j) = CONTADOR_AL(j) + 1;
            bandera = 1;
            break    
        end
    end
    if(bandera == 0) %Se guarda en el abecedario el caracter
        ABECEDARIO_AL(posicion_al) = VECTOR_AL(i);
        CONTADOR_AL(posicion_al) = 1;
        posicion_al = posicion_al + 1;
    end
end

%Suma y obtencion de probabilidades

SUMA_EN = sum(CONTADOR_EN, "all");
SUMA_ES = sum(CONTADOR_ES, "all");
SUMA_AL = sum(CONTADOR_AL, "all");

PROBS_EN = zeros(1,posicion_en);
PROBS_ES = zeros(1, posicion_es);
PROBS_AL = zeros(1, posicion_al);

for i=1:1:posicion_en-1 %Primero
    PROBS_EN(i) = CONTADOR_EN(i)/SUMA_EN;
end

for i=1:1:posicion_es-1 %Segundo
    PROBS_ES(i) = CONTADOR_ES(i)/SUMA_ES;
end

for i=1:1:posicion_al-1 % Tercero
    PROBS_AL(i) = CONTADOR_AL(i)/SUMA_AL;
end

%Calculamos la cantidad de informacion por simbolo del sistema
I = zeros(1, posicion_en);
I2 = zeros(1, posicion_es);
I3= zeros(1, posicion_al);

for i=1:1:posicion_en-1 %Primero
    I(i) = log2(1/PROBS_EN(i));
end

for i=1:1:posicion_es-1 %Segundo
    I2(i) = log2(1/PROBS_ES(i));
end

for i=1:1:posicion_al-1 %Tercero
    I3(i) = log2(1/PROBS_AL(i));
end

%Calculamos la entropia

H = 0;
H2 = 0; 
H3 = 0;

for i=1:1:posicion_en-1 %Primero
    H = H + (PROBS_EN(i) * I(i));
end

for i=1:1:posicion_es-1 %Segundo
    H2 = H2 + (PROBS_ES(i) * I2(i));
end

for i=1:1:posicion_al-1 %Tercero
    H3 = H3 + (PROBS_AL(i) * I3(i));
end

%Funcion para imprimir cada caracter asi como el numero de apariciones del
%mismo

fprintf('******************INGLES******************\n\n');

fprintf('Total de caracteres en el archivo = %d\n\n', SUMA_EN);

for i=1:1:posicion_en-1
    if(ABECEDARIO_EN(i) ~= 10 && ABECEDARIO_EN(i) ~= 13 && ABECEDARIO_EN(i) ~= 32)
        fprintf('%c = %d - probabilidad = %f - I(%c) = %f bits\n', ABECEDARIO_EN(i), CONTADOR_EN(i), PROBS_EN(i), ABECEDARIO_EN(i), I(i))
    end
    if(ABECEDARIO_EN(i) == 13)
        fprintf('CR = %d - probabilidad = %f - I(CR) = %f bits\n', CONTADOR_EN(i), PROBS_EN(i), I(i))
    elseif(ABECEDARIO_EN(i) == 10)
        fprintf('NL = %d - probabilidad = %f - I(NL) = %f bits\n', CONTADOR_EN(i), PROBS_EN(i), I(i))
    elseif(ABECEDARIO_EN(i) == 32)
        fprintf('ESPACIO = %d - probabilidad = %f - I(%c) = %f bits\n', CONTADOR_EN(i), PROBS_EN(i), ABECEDARIO_EN(i), I(i))
    end
end

fprintf('\nProbabilidad total = %d\n', sum(PROBS_EN));

fprintf('q = %d\n', posicion_en-1);

fprintf('Entropia del sistema = %f bits/simbolo\n', H);

%Segundo

fprintf('\n\n******************ESPAÑOL******************\n\n');

fprintf('Total de caracteres en el archivo = %d\n\n', SUMA_ES);

for i=1:1:posicion_es-1
    if(ABECEDARIO_ES(i) ~= 10 && ABECEDARIO_ES(i) ~= 13 && ABECEDARIO_ES(i) ~= 32)
        fprintf('%c = %d - probabilidad = %f - I(%c) = %f bits\n', ABECEDARIO_ES(i), CONTADOR_ES(i), PROBS_ES(i), ABECEDARIO_ES(i), I2(i))
    end
    if(ABECEDARIO_ES(i) == 13)
        fprintf('CR = %d - probabilidad = %f - I(CR) = %f bits\n', CONTADOR_ES(i), PROBS_ES(i), I2(i))
    elseif(ABECEDARIO_ES(i) == 10)
        fprintf('NL = %d - probabilidad = %f - I(NL) = %f bits\n', CONTADOR_ES(i), PROBS_ES(i), I2(i))
    elseif(ABECEDARIO_ES(i) == 32)
        fprintf('ESPACIO = %d - probabilidad = %f - I(%c) = %f bits\n', CONTADOR_ES(i), PROBS_ES(i), ABECEDARIO_ES(i), I2(i))
    end
end

fprintf('\nProbabilidad total = %d\n', sum(PROBS_ES));

fprintf('q = %d\n', posicion_es-1);

fprintf('Entropia del sistema = %f bits/simbolo\n', H2);

%Tercero

fprintf('\n\n******************ALEMAN******************\n\n');

fprintf('Total de caracteres en el archivo = %d\n\n', SUMA_AL);

for i=1:1:posicion_al-1
    if(ABECEDARIO_AL(i) ~= 10 && ABECEDARIO_AL(i) ~= 13 && ABECEDARIO_AL(i) ~= 32)
        fprintf('%c = %d - probabilidad = %f - I(%c) = %f bits\n', ABECEDARIO_AL(i), CONTADOR_AL(i), PROBS_AL(i), ABECEDARIO_AL(i), I3(i))
    end
    if(ABECEDARIO_AL(i) == 13)
        fprintf('CR = %d - probabilidad = %f - I(CR) = %f bits\n', CONTADOR_AL(i), PROBS_AL(i), I3(i))
    elseif(ABECEDARIO_AL(i) == 10)
        fprintf('NL = %d - probabilidad = %f - I(NL) = %f bits\n', CONTADOR_AL(i), PROBS_AL(i), I3(i))
    elseif(ABECEDARIO_AL(i) == 32)
        fprintf('ESPACIO = %d - probabilidad = %f - I(%c) = %f bits\n', CONTADOR_AL(i), PROBS_AL(i), ABECEDARIO_AL(i), I3(i))
    end
end

fprintf('\nProbabilidad total = %d\n', sum(PROBS_AL));

fprintf('q = %d\n', posicion_al-1);

fprintf('Entropia del sistema = %f bits/simbolo\n', H3);
