
if { [info exist ::env(MAGIC_EXT_USE_GDS)] && $::env(MAGIC_EXT_USE_GDS) } {
	gds read $::env(CURRENT_GDS)
} else {
	lef read /home/fatihgulakar/638_proje/pdks/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
	if {  [info exist ::env(EXTRA_LEFS)] } {
		set lefs_in $::env(EXTRA_LEFS)
		foreach lef_file $lefs_in {
			lef read $lef_file
		}
	}
	def read /home/fatihgulakar/638_proje/shooting_game_verilog/openlane/user_project_wrapper/runs/user_project_wrapper/results/routing/user_project_wrapper.def
}
load user_project_wrapper -dereference
cd /home/fatihgulakar/638_proje/shooting_game_verilog/openlane/user_project_wrapper/runs/user_project_wrapper/results/finishing/
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
if { ! 0 } {
	extract unique
}
# extract warn all
extract

ext2spice lvs
ext2spice -o /home/fatihgulakar/638_proje/shooting_game_verilog/openlane/user_project_wrapper/runs/user_project_wrapper/results/finishing/user_project_wrapper.spice user_project_wrapper.ext
feedback save /home/fatihgulakar/638_proje/shooting_game_verilog/openlane/user_project_wrapper/runs/user_project_wrapper/logs/finishing/26-ext2spice.feedback.txt
# exec cp user_project_wrapper.spice /home/fatihgulakar/638_proje/shooting_game_verilog/openlane/user_project_wrapper/runs/user_project_wrapper/results/finishing/user_project_wrapper.spice

