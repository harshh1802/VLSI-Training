onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB TOP} /ram_tb_top/clk
add wave -noupdate -expand -group {TB TOP} /ram_tb_top/ram_test
add wave -noupdate -expand -group {TB TOP} {/ram_tb_top/DUT/ram[15]}
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/clk
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/rst
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/we
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/re
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/wr_addr
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/wr_din
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/rd_addr
add wave -noupdate -expand -group RIF -radix decimal /ram_tb_top/rif/rd_dout
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/clk
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/rst
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/we
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/re
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/wr_addr
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/wr_din
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/rd_dout
add wave -noupdate -expand -group DUT -radix decimal /ram_tb_top/DUT/rd_addr
add wave -noupdate -expand -group DUT -radix decimal -childformat {{{/ram_tb_top/DUT/ram[0]} -radix decimal} {{/ram_tb_top/DUT/ram[1]} -radix decimal} {{/ram_tb_top/DUT/ram[2]} -radix decimal} {{/ram_tb_top/DUT/ram[3]} -radix decimal} {{/ram_tb_top/DUT/ram[4]} -radix decimal} {{/ram_tb_top/DUT/ram[5]} -radix decimal} {{/ram_tb_top/DUT/ram[6]} -radix decimal} {{/ram_tb_top/DUT/ram[7]} -radix decimal} {{/ram_tb_top/DUT/ram[8]} -radix decimal} {{/ram_tb_top/DUT/ram[9]} -radix decimal} {{/ram_tb_top/DUT/ram[10]} -radix decimal} {{/ram_tb_top/DUT/ram[11]} -radix decimal} {{/ram_tb_top/DUT/ram[12]} -radix decimal} {{/ram_tb_top/DUT/ram[13]} -radix decimal} {{/ram_tb_top/DUT/ram[14]} -radix decimal} {{/ram_tb_top/DUT/ram[15]} -radix decimal}} -subitemconfig {{/ram_tb_top/DUT/ram[0]} {-radix decimal} {/ram_tb_top/DUT/ram[1]} {-radix decimal} {/ram_tb_top/DUT/ram[2]} {-radix decimal} {/ram_tb_top/DUT/ram[3]} {-radix decimal} {/ram_tb_top/DUT/ram[4]} {-radix decimal} {/ram_tb_top/DUT/ram[5]} {-radix decimal} {/ram_tb_top/DUT/ram[6]} {-radix decimal} {/ram_tb_top/DUT/ram[7]} {-radix decimal} {/ram_tb_top/DUT/ram[8]} {-radix decimal} {/ram_tb_top/DUT/ram[9]} {-radix decimal} {/ram_tb_top/DUT/ram[10]} {-radix decimal} {/ram_tb_top/DUT/ram[11]} {-radix decimal} {/ram_tb_top/DUT/ram[12]} {-radix decimal} {/ram_tb_top/DUT/ram[13]} {-radix decimal} {/ram_tb_top/DUT/ram[14]} {-radix decimal} {/ram_tb_top/DUT/ram[15]} {-radix decimal}} /ram_tb_top/DUT/ram
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/drv_cb_event
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/rst
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/we
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/re
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/wr_addr
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/wr_din
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/rd_addr
add wave -noupdate -expand -group {Driver CB} -radix decimal /ram_tb_top/rif/drv_cb/rd_dout
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/mntr_cb_event
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/rst
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/we
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/re
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/wr_addr
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/wr_din
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/rd_addr
add wave -noupdate -expand -group {Monitor CB} -radix decimal /ram_tb_top/rif/mntr_cb/rd_dout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {176 ns} 0}
configure wave -namecolwidth 270
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {203 ns}
