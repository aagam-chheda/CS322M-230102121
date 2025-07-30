module one_bit_comparator(
    input A,B,
    output o1,o2,o3
);
    assign o1=(A>B)?1:0;
    assign o2=(A==B)?1:0;
    assign o3=(A<B)?1:0;
endmodule
