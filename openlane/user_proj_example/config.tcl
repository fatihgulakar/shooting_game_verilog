# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_proj_example

set ::env(VERILOG_FILES) "\
	$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_proj_example.v \
	$script_dir/../../verilog/rtl/shooting_game/obj_b.v \
	$script_dir/../../verilog/rtl/shooting_game/obj_p.v \
	$script_dir/../../verilog/rtl/shooting_game/obj_heart.v \
	$script_dir/../../verilog/rtl/shooting_game/kb.v \
	$script_dir/../../verilog/rtl/shooting_game/kb2game.v
	$script_dir/../../verilog/rtl/shooting_game/dff.v \
	$script_dir/../../verilog/rtl/shooting_game/debouncer.v \
	$script_dir/../../verilog/rtl/shooting_game/freq_divider.v \
	$script_dir/../../verilog/rtl/shooting_game/color_generator.v \
	$script_dir/../../verilog/rtl/shooting_game/sync_generator.v \
	$script_dir/../../verilog/rtl/shooting_game/main.v"

set ::env(DESIGN_IS_CORE) 0

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "game.board_clk"
set ::env(CLOCK_PERIOD) "10"


# Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 1250 1250"
set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

# Placement
set ::env(PL_BASIC_PLACEMENT) 0
set ::env(PL_TARGET_DENSITY) 0.15
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 0.55
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.5
set ::env(PL_RESIZER_HOLD_MAX_BUFFER_PERCENT) 65

# CTS
set ::env(CTS_TOLERANCE) 25
set ::env(CTS_TARGET_SKEW) 135
set ::env(CTS_CLK_BUFFER_LIST) "sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8"
set ::env(CTS_SINK_CLUSTERING_SIZE) "16"
set ::env(CTS_CLK_MAX_WIRE_LENGTH) 135
set ::env(CLOCK_BUFFER_FANOUT) "8"

# Routing
set ::env(GLB_RT_OVERFLOW_ITERS) 70
set ::env(ROUTING_CORES) 4
set ::env(GLB_RESIZER_SETUP_SLACK_MARGIN) 0.8
set ::env(GLB_RT_MAX_DIODE_INS_ITERS) 10
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 110

# Maximum layer used for routing is metal 4.
# This is because this macro will be inserted in a top level (user_project_wrapper) 
# where the PDN is planned on metal 5. So, to avoid having shorts between routes
# in this macro and the top level metal 5 stripes, we have to restrict routes to metal4.  
# 
# set ::env(GLB_RT_MAXLAYER) 5

set ::env(RT_MAX_LAYER) {met4}
# You can draw more power domains if you need to 
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]

set ::env(DIODE_INSERTION_STRATEGY) 4
# If you're going to use multiple power domains, then disable cvc run.
set ::env(RUN_CVC) 1
