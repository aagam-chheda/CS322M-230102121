module four_bit_equality_comparator(
    input[3:0] A,B,
    output out
);
    assign out=(A==B)?1:0; 
endmodule