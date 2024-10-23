%define DICT_BEGIN 0
%macro colon 2
    %2:
        dq DICT_BEGIN ; указывает на предыдущий элемент
        db %1, 0
        %define DICT_BEGIN %2 ; указывает на последний элемент
%endmacro
