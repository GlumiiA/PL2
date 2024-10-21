%define last_mark 0
%macro colon 2
    %2:
        dq last_mark ; указывает на предыдущий элемент
        db %1, 0
        %define last_mark %2 ; указывает на последний элемент
%endmacro