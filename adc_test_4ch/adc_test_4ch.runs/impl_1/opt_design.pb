
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0352default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0352default:defaultZ17-349h px� 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px� 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC2D
 ".
adc1_spi_ioadc1_spi_io2default:default2default:default2A
 )DRC|Netlist|Port|Required Buf|IO Instance2default:default8ZRPBF-3h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC2D
 ".
adc2_spi_ioadc2_spi_io2default:default2default:default2A
 )DRC|Netlist|Port|Required Buf|IO Instance2default:default8ZRPBF-3h px� 
a
DRC finished with %s
272*project2(
0 Errors, 2 Warnings2default:defaultZ1-461h px� 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.80 . Memory (MB): peak = 2226.293 ; gain = 64.031 ; free physical = 15325 ; free virtual = 247432default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px� 
�

Phase %s%s
101*constraints2
1 2default:default27
#Generate And Synthesize Debug Cores2default:defaultZ18-101h px� 
_
Generating core instance : %s205*	chipscope2
dbg_hub2default:defaultZ16-318h px� 
�
Generating IP %s for %s.
1712*coregen2+
xilinx.com:ip:xsdbm:3.02default:default2

dbg_hub_CV2default:defaultZ19-3806h px� 
�
NRe-using generated and synthesized IP, "%s", from Vivado IP cache entry "%s".
146*	chipscope2+
xilinx.com:ip:xsdbm:3.02default:default2$
ff036e1f69d049d12default:defaultZ16-220h px� 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
1842default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
_
Generating core instance : %s205*	chipscope2
u_ila_02default:defaultZ16-318h px� 
�
Generating IP %s for %s.
1712*coregen2)
xilinx.com:ip:ila:6.22default:default2

u_ila_0_CV2default:defaultZ19-3806h px� 
�
NRe-using generated and synthesized IP, "%s", from Vivado IP cache entry "%s".
146*	chipscope2)
xilinx.com:ip:ila:6.22default:default2$
326b9958770f47e32default:defaultZ16-220h px� 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
2162default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
_
Generating core instance : %s205*	chipscope2
u_ila_12default:defaultZ16-318h px� 
�
Generating IP %s for %s.
1712*coregen2)
xilinx.com:ip:ila:6.22default:default2

u_ila_1_CV2default:defaultZ19-3806h px� 
�
NRe-using generated and synthesized IP, "%s", from Vivado IP cache entry "%s".
146*	chipscope2)
xilinx.com:ip:ila:6.22default:default2$
326b9958770f47e32default:defaultZ16-220h px� 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
2482default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
_
Generating core instance : %s205*	chipscope2
u_ila_22default:defaultZ16-318h px� 
�
Generating IP %s for %s.
1712*coregen2)
xilinx.com:ip:ila:6.22default:default2

u_ila_2_CV2default:defaultZ19-3806h px� 
�
NRe-using generated and synthesized IP, "%s", from Vivado IP cache entry "%s".
146*	chipscope2)
xilinx.com:ip:ila:6.22default:default2$
017c86b16d9b1c632default:defaultZ16-220h px� 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
4182default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.022default:default2
00:00:00.012default:default2
2256.4182default:default2
0.0002default:default2
151802default:default2
246232default:defaultZ17-722h px� 
W
BPhase 1 Generate And Synthesize Debug Cores | Checksum: 20018be8d
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:16 ; elapsed = 00:03:25 . Memory (MB): peak = 2256.418 ; gain = 30.125 ; free physical = 15180 ; free virtual = 246232default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
i

Phase %s%s
101*constraints2
2 2default:default2
Retarget2default:defaultZ18-101h px� 
v
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
12default:default2
152default:defaultZ31-138h px� 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px� 
<
'Phase 2 Retarget | Checksum: 14c01b076
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:18 ; elapsed = 00:03:25 . Memory (MB): peak = 2331.418 ; gain = 105.125 ; free physical = 15176 ; free virtual = 246202default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
1132default:default2
3042default:defaultZ31-389h px� 
u

Phase %s%s
101*constraints2
3 2default:default2(
Constant propagation2default:defaultZ18-101h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
12default:default2
32default:defaultZ31-138h px� 
H
3Phase 3 Constant propagation | Checksum: 20f3f7695
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:18 ; elapsed = 00:03:26 . Memory (MB): peak = 2331.418 ; gain = 105.125 ; free physical = 15176 ; free virtual = 246202default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
1202default:default2
3902default:defaultZ31-389h px� 
f

Phase %s%s
101*constraints2
4 2default:default2
Sweep2default:defaultZ18-101h px� 
9
$Phase 4 Sweep | Checksum: 1a45ff7b4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:19 ; elapsed = 00:03:26 . Memory (MB): peak = 2331.418 ; gain = 105.125 ; free physical = 15172 ; free virtual = 246192default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
22default:default2
2612default:defaultZ31-389h px� 
r

Phase %s%s
101*constraints2
5 2default:default2%
BUFG optimization2default:defaultZ18-101h px� 
E
0Phase 5 BUFG optimization | Checksum: 1a45ff7b4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:19 ; elapsed = 00:03:27 . Memory (MB): peak = 2331.418 ; gain = 105.125 ; free physical = 15172 ; free virtual = 246192default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2%
BUFG optimization2default:default2
02default:default2
02default:defaultZ31-389h px� 
|

Phase %s%s
101*constraints2
6 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px� 
O
:Phase 6 Shift Register Optimization | Checksum: 1a45ff7b4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:19 ; elapsed = 00:03:27 . Memory (MB): peak = 2331.418 ; gain = 105.125 ; free physical = 15172 ; free virtual = 246192default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px� 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.02 ; elapsed = 00:00:00.02 . Memory (MB): peak = 2331.418 ; gain = 0.000 ; free physical = 15172 ; free virtual = 246192default:defaulth px� 
J
5Ending Logic Optimization Task | Checksum: 20d8ee368
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:19 ; elapsed = 00:03:27 . Memory (MB): peak = 2331.418 ; gain = 105.125 ; free physical = 15172 ; free virtual = 246192default:defaulth px� 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px� 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2default:default2
 2default:default2
3.5432default:default2
0.0002default:defaultZ32-619h px� 
=
Applying IDT optimizations ...
9*pwroptZ34-9h px� 
?
Applying ODC optimizations ...
10*pwroptZ34-10h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 


*pwropth px� 
e

Starting %s Task
103*constraints2*
PowerOpt Patch Enables2default:defaultZ18-103h px� 
�
�WRITE_MODE attribute of %s BRAM(s) out of a total of %s has been updated to save power.
    Run report_power_opt to get a complete listing of the BRAMs updated.
129*pwropt2
62default:default2
302default:defaultZ34-162h px� 
d
+Structural ODC has moved %s WE to EN ports
155*pwropt2
02default:defaultZ34-201h px� 
�
CNumber of BRAM Ports augmented: %s newly gated: %s Total Ports: %s
65*pwropt2
302default:default2
02default:default2
602default:defaultZ34-65h px� 
N
9Ending PowerOpt Patch Enables Task | Checksum: 213b7ee8f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.12 ; elapsed = 00:00:00.13 . Memory (MB): peak = 2734.922 ; gain = 0.000 ; free physical = 15134 ; free virtual = 245782default:defaulth px� 
J
5Ending Power Optimization Task | Checksum: 213b7ee8f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:05 . Memory (MB): peak = 2734.922 ; gain = 403.504 ; free physical = 15146 ; free virtual = 245902default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
722default:default2
32default:default2
02default:default2
02default:defaultZ4-41h px� 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
opt_design: 2default:default2
00:02:302default:default2
00:03:332default:default2
2734.9222default:default2
580.6602default:default2
151462default:default2
245902default:defaultZ17-722h px� 
�
4The following parameters have non-default value.
%s
395*common24
 tcl.collectionResultDisplayLimit2default:defaultZ17-600h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:00.062default:default2
00:00:00.022default:default2
2734.9222default:default2
0.0002default:default2
151452default:default2
245912default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2Y
E/home/xyh/NFS_Alinx/adc_test_4ch/adc_test_4ch.runs/impl_1/top_opt.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2o
[Executing : report_drc -file top_drc_opted.rpt -pb top_drc_opted.pb -rpx top_drc_opted.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2b
Nreport_drc -file top_drc_opted.rpt -pb top_drc_opted.pb -rpx top_drc_opted.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
K/home/xyh/NFS_Alinx/adc_test_4ch/adc_test_4ch.runs/impl_1/top_drc_opted.rptK/home/xyh/NFS_Alinx/adc_test_4ch/adc_test_4ch.runs/impl_1/top_drc_opted.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 


End Record