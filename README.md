# Shooting game in Verilog
An ASIC implementation of a game. Course project of EE 638 - Advanced VLSI Design at Bogazici University

# Contributors

* Mehmet Alp Şarkışla
* Mehmet Fatih Gülakar

# A brief tutorial on how to run this flow

* First, make sure you have Python & Docker installed. Also install KLayout for GDS visualization.
* On your home directory, create a folder like `openlane_projects`.
* Now enter in this folder, and follow the first 4 steps in [README](docs/source/quickstart.rst). You should create a Github repository before that.
* If you have not encountered any problem, you should have OpenLane and Sky130 PDK installed. 
* Put your Verilog files in `verilog/rtl`. Add names of these files to `verilog/rtl/uprj_netlists.v` & `openlane/user_proj_example/config.tcl`. This will make sure tools can read your Verilog successfully.
* Instantiate your top-level module in `user_proj_example` file. Make the connections properly. 
* Before starting the flow, modify `openlane/user_proj_example/config.tcl`. For instance, you can set your clock period, or area of the project. There is no .sdc file needed, all handled by Openlane flow. There are several variables to change in Openlane flow, all of them are listed in [Openlane Variables](https://github.com/The-OpenROAD-Project/OpenLane/blob/master/configuration/README.md). This link is very useful.
* Now, you can harden your project. In the main folder, type `make user_proj_example`. It runs complete flow (synthesis, place and route, DRC&LVS) with a single command.
* When flow is completed, you can check `/openlane/user_proj_example/runs` for all reports and resulting files. For example, reports folder has all timing & area and power checks. While results folder includes gate-level netlist, def and GDS files. You can open these files using Klayout.
* Hardening your project can take a few iteration, you can increase area, put setup/hold slack margins, maximum wire lengths in case there are violations.
* After finalizing your project, run `make user_project_wrapper`. This will put your hardened macro inside the wrapper, run routing, power network, CTS, and DRC & LVS. But it will ignore timing violations of your module. So a non-negative slack in this stage does not mean there is no negative slack in whole chip.
* After that, type `make precheck`. This will install precheck program
* Then, type `make run-precheck` to perform precheck on final GDS. This will check some design rules (Magic DRC, BEOL, FEOL, metal density). Also the pin names. Finally, it will check README and License (you need a valid license, but comes with cloned template repository), so you need to change README.md file of cloned repository. You can explain how your design works and who worked on it.
* If you want to submit your design in Google's Open MPW shuttle, sign up to [Efabless](https://efabless.com/). When there is an open MPW call, submit your project. You can easily do thay by giving the link of your Github project. Now, Efabless will pull this repo, and perform a final precheck and tapeout checks in your GDS. If everything goes well, tapeout will be shown as succeded on your project. You just have to wait until deadline, and hope you are selected as one of 40 projects.
* While debugging problems about Openlane and Caravel, [the official Slack of Efabless](https://invite.skywater.tools/) is an invaluable source.








# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

| :exclamation: Important Note            |
|-----------------------------------------|

## Please fill in your project documentation in this README.md file 

Refer to [README](docs/source/quickstart.rst) for a quick start of how to use caravel_user_project

Refer to [README](docs/source/index.rst) for this sample project documentation. 
