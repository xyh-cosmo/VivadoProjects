-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
-- Date        : Mon Mar  1 20:57:53 2021
-- Host        : apple running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top my_clk_generator -prefix
--               my_clk_generator_ my_clk_generator_stub.vhdl
-- Design      : my_clk_generator
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z035ffg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_clk_generator is
  Port ( 
    clk_20M : out STD_LOGIC;
    clk_150M : out STD_LOGIC;
    clk_450M : out STD_LOGIC;
    clk_10M : out STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end my_clk_generator;

architecture stub of my_clk_generator is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_20M,clk_150M,clk_450M,clk_10M,locked,clk_in";
begin
end;
