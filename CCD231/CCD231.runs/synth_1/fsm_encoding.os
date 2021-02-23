
 add_fsm_encoding \
       {aq_axi_master.wr_state} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} {101 101} {110 110} }

 add_fsm_encoding \
       {aq_axi_master.rd_state} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} {101 101} }

 add_fsm_encoding \
       {SPI4ADC.state} \
       { }  \
       {{0000 00} {0001 01} {0010 10} {0011 11} }
