
function product(a : integer ; b : integer) : integer
begin
    result : integer := a * b ;
    return result ;
end

procedure print(input : integer)
begin
    write("the number is : ") ;
    write(input) ;
    write("\n") ;
end


// this is a comment
<-- hi
i am a comment -->

function main() : integer
begin

    arr : array [10] of integer ;
    index : integer := 0 ;

    while index < 10 do
    begin
        arr[index] := power(index, array[index]) ;
        print(arr[index]) ;
    end



    return 0 ;
end 
