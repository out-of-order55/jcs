
1c102_demo.elf:     file format elf32-loongarch
1c102_demo.elf


Disassembly of section .text:

1c000000 <_start>:
_start():
1c000000:	0015000d 	move	$r13,$r0
1c000004:	50002000 	b	32(0x20) # 1c000024 <LoopCopyDataInit>

1c000008 <CopyDataInit>:
CopyDataInit():
1c000008:	1438004f 	lu12i.w	$r15,114690(0x1c002)
1c00000c:	03b951ef 	ori	$r15,$r15,0xe54
1c000010:	001035f0 	add.w	$r16,$r15,$r13
1c000014:	2880020f 	ld.w	$r15,$r16,0
1c000018:	00103590 	add.w	$r16,$r12,$r13
1c00001c:	2980020f 	st.w	$r15,$r16,0
1c000020:	028011ad 	addi.w	$r13,$r13,4(0x4)

1c000024 <LoopCopyDataInit>:
LoopCopyDataInit():
1c000024:	1500002c 	lu12i.w	$r12,-524287(0x80001)
1c000028:	0380018c 	ori	$r12,$r12,0x0
1c00002c:	1500002f 	lu12i.w	$r15,-524287(0x80001)
1c000030:	038001ef 	ori	$r15,$r15,0x0
1c000034:	0010358e 	add.w	$r14,$r12,$r13
1c000038:	5fffd1cf 	bne	$r14,$r15,-48(0x3ffd0) # 1c000008 <CopyDataInit>
1c00003c:	1500000c 	lu12i.w	$r12,-524288(0x80000)
1c000040:	0380018c 	ori	$r12,$r12,0x0
1c000044:	1500000d 	lu12i.w	$r13,-524288(0x80000)
1c000048:	038001ad 	ori	$r13,$r13,0x0
1c00004c:	580011ac 	beq	$r13,$r12,16(0x10) # 1c00005c <cpu_init_start>

1c000050 <LoopFillZerobss>:
LoopFillZerobss():
1c000050:	29800180 	st.w	$r0,$r12,0
1c000054:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c000058:	5ffff9ac 	bne	$r13,$r12,-8(0x3fff8) # 1c000050 <LoopFillZerobss>

1c00005c <cpu_init_start>:
cpu_init_start():
1c00005c:	1438002c 	lu12i.w	$r12,114689(0x1c001)
1c000060:	0400302c 	csrwr	$r12,0xc
1c000064:	0015000c 	move	$r12,$r0
1c000068:	0400102c 	csrwr	$r12,0x4
1c00006c:	1400002c 	lu12i.w	$r12,1(0x1)
1c000070:	03bffd8c 	ori	$r12,$r12,0xfff
1c000074:	0400118c 	csrxchg	$r12,$r12,0x4
1c000078:	15ffe3ec 	lu12i.w	$r12,-225(0xfff1f)
1c00007c:	03bffd8c 	ori	$r12,$r12,0xfff
1c000080:	0406442c 	csrwr	$r12,0x191
1c000084:	14eca06c 	lu12i.w	$r12,484611(0x76503)
1c000088:	0388418c 	ori	$r12,$r12,0x210
1c00008c:	0406402c 	csrwr	$r12,0x190
1c000090:	0380200c 	ori	$r12,$r0,0x8
1c000094:	04000180 	csrxchg	$r0,$r12,0x0
1c000098:	15000023 	lu12i.w	$r3,-524287(0x80001)
1c00009c:	03bdf063 	ori	$r3,$r3,0xf7c
1c0000a0:	54192800 	bl	6440(0x1928) # 1c0019c8 <main>
1c0000a4:	4c000020 	jirl	$r0,$r1,0

1c0000a8 <cpu_wait>:
cpu_wait():
1c0000a8:	06488000 	idle	0x0
1c0000ac:	4c000020 	jirl	$r0,$r1,0
	...

1c001000 <DEFAULT_INT_HANDLER>:
DEFAULT_INT_HANDLER():
1c001000:	0400c435 	csrwr	$r21,0x31
1c001004:	15000055 	lu12i.w	$r21,-524286(0x80002)
1c001008:	29bff2ac 	st.w	$r12,$r21,-4(0xffc)
1c00100c:	29bfe2ad 	st.w	$r13,$r21,-8(0xff8)
1c001010:	29bfd2ae 	st.w	$r14,$r21,-12(0xff4)
1c001014:	29bfc2af 	st.w	$r15,$r21,-16(0xff0)
1c001018:	29bfb2b0 	st.w	$r16,$r21,-20(0xfec)
1c00101c:	29bfa2b1 	st.w	$r17,$r21,-24(0xfe8)
1c001020:	29bf92b2 	st.w	$r18,$r21,-28(0xfe4)
1c001024:	29bf82b3 	st.w	$r19,$r21,-32(0xfe0)
1c001028:	29bf72b4 	st.w	$r20,$r21,-36(0xfdc)
1c00102c:	29bed2a4 	st.w	$r4,$r21,-76(0xfb4)
1c001030:	29bec2a5 	st.w	$r5,$r21,-80(0xfb0)
1c001034:	29beb2a6 	st.w	$r6,$r21,-84(0xfac)
1c001038:	29bea2a7 	st.w	$r7,$r21,-88(0xfa8)
1c00103c:	29be92a8 	st.w	$r8,$r21,-92(0xfa4)
1c001040:	29be82a9 	st.w	$r9,$r21,-96(0xfa0)
1c001044:	29be72aa 	st.w	$r10,$r21,-100(0xf9c)
1c001048:	29be62ab 	st.w	$r11,$r21,-104(0xf98)
1c00104c:	29be52a1 	st.w	$r1,$r21,-108(0xf94)
1c001050:	29be42a3 	st.w	$r3,$r21,-112(0xf90)
1c001054:	0400140c 	csrrd	$r12,0x5
1c001058:	036ef18d 	andi	$r13,$r12,0xbbc
1c00105c:	400065a0 	beqz	$r13,100(0x64) # 1c0010c0 <exception_core_check>

1c001060 <exception_pmu>:
exception_pmu():
1c001060:	0340118d 	andi	$r13,$r12,0x4
1c001064:	44002da0 	bnez	$r13,44(0x2c) # 1c001090 <wake_label>
1c001068:	0340218d 	andi	$r13,$r12,0x8
1c00106c:	44002da0 	bnez	$r13,44(0x2c) # 1c001098 <touch_label>
1c001070:	0340418d 	andi	$r13,$r12,0x10
1c001074:	44002da0 	bnez	$r13,44(0x2c) # 1c0010a0 <uart2_label>
1c001078:	0340818d 	andi	$r13,$r12,0x20
1c00107c:	44002da0 	bnez	$r13,44(0x2c) # 1c0010a8 <bcc_label>
1c001080:	0342018d 	andi	$r13,$r12,0x80
1c001084:	44002da0 	bnez	$r13,44(0x2c) # 1c0010b0 <exint_label>
1c001088:	0360018d 	andi	$r13,$r12,0x800
1c00108c:	44002da0 	bnez	$r13,44(0x2c) # 1c0010b8 <timer_label>

1c001090 <wake_label>:
wake_label():
1c001090:	54149000 	bl	5264(0x1490) # 1c002520 <TIMER_WAKE_INT>
1c001094:	50003c00 	b	60(0x3c) # 1c0010d0 <exception_exit>

1c001098 <touch_label>:
touch_label():
1c001098:	5414d000 	bl	5328(0x14d0) # 1c002568 <TOUCH>
1c00109c:	50003400 	b	52(0x34) # 1c0010d0 <exception_exit>

1c0010a0 <uart2_label>:
uart2_label():
1c0010a0:	54155400 	bl	5460(0x1554) # 1c0025f4 <UART2_INT>
1c0010a4:	50002c00 	b	44(0x2c) # 1c0010d0 <exception_exit>

1c0010a8 <bcc_label>:
bcc_label():
1c0010a8:	54158800 	bl	5512(0x1588) # 1c002630 <BAT_FAIL>
1c0010ac:	50002400 	b	36(0x24) # 1c0010d0 <exception_exit>

1c0010b0 <exint_label>:
exint_label():
1c0010b0:	5413a000 	bl	5024(0x13a0) # 1c002450 <ext_handler>
1c0010b4:	50001c00 	b	28(0x1c) # 1c0010d0 <exception_exit>

1c0010b8 <timer_label>:
timer_label():
1c0010b8:	54173400 	bl	5940(0x1734) # 1c0027ec <TIMER_HANDLER>
1c0010bc:	50001400 	b	20(0x14) # 1c0010d0 <exception_exit>

1c0010c0 <exception_core_check>:
exception_core_check():
1c0010c0:	0341018d 	andi	$r13,$r12,0x40
1c0010c4:	40000da0 	beqz	$r13,12(0xc) # 1c0010d0 <exception_exit>
1c0010c8:	54164000 	bl	5696(0x1640) # 1c002708 <intc_handler>
1c0010cc:	50000400 	b	4(0x4) # 1c0010d0 <exception_exit>

1c0010d0 <exception_exit>:
exception_exit():
1c0010d0:	15000055 	lu12i.w	$r21,-524286(0x80002)
1c0010d4:	28bff2ac 	ld.w	$r12,$r21,-4(0xffc)
1c0010d8:	28bfe2ad 	ld.w	$r13,$r21,-8(0xff8)
1c0010dc:	28bfd2ae 	ld.w	$r14,$r21,-12(0xff4)
1c0010e0:	28bfc2af 	ld.w	$r15,$r21,-16(0xff0)
1c0010e4:	28bfb2b0 	ld.w	$r16,$r21,-20(0xfec)
1c0010e8:	28bfa2b1 	ld.w	$r17,$r21,-24(0xfe8)
1c0010ec:	28bf92b2 	ld.w	$r18,$r21,-28(0xfe4)
1c0010f0:	28bf82b3 	ld.w	$r19,$r21,-32(0xfe0)
1c0010f4:	28bf72b4 	ld.w	$r20,$r21,-36(0xfdc)
1c0010f8:	28bed2a4 	ld.w	$r4,$r21,-76(0xfb4)
1c0010fc:	28bec2a5 	ld.w	$r5,$r21,-80(0xfb0)
1c001100:	28beb2a6 	ld.w	$r6,$r21,-84(0xfac)
1c001104:	28bea2a7 	ld.w	$r7,$r21,-88(0xfa8)
1c001108:	28be92a8 	ld.w	$r8,$r21,-92(0xfa4)
1c00110c:	28be82a9 	ld.w	$r9,$r21,-96(0xfa0)
1c001110:	28be72aa 	ld.w	$r10,$r21,-100(0xf9c)
1c001114:	28be62ab 	ld.w	$r11,$r21,-104(0xf98)
1c001118:	28be52a1 	ld.w	$r1,$r21,-108(0xf94)
1c00111c:	28be42a3 	ld.w	$r3,$r21,-112(0xf90)
1c001120:	0400c415 	csrrd	$r21,0x31
1c001124:	06483800 	ertn

1c001128 <myputchar>:
myputchar():
1c001128:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c00112c:	29807061 	st.w	$r1,$r3,28(0x1c)
1c001130:	29806076 	st.w	$r22,$r3,24(0x18)
1c001134:	02808076 	addi.w	$r22,$r3,32(0x20)
1c001138:	0015008c 	move	$r12,$r4
1c00113c:	293fbecc 	st.b	$r12,$r22,-17(0xfef)
1c001140:	2a3fbecc 	ld.bu	$r12,$r22,-17(0xfef)
1c001144:	00150185 	move	$r5,$r12
1c001148:	157fd004 	lu12i.w	$r4,-262528(0xbfe80)
1c00114c:	54058c00 	bl	1420(0x58c) # 1c0016d8 <UART_SendData>
1c001150:	03400000 	andi	$r0,$r0,0x0
1c001154:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c001158:	28806076 	ld.w	$r22,$r3,24(0x18)
1c00115c:	02808063 	addi.w	$r3,$r3,32(0x20)
1c001160:	4c000020 	jirl	$r0,$r1,0

1c001164 <printbase>:
printbase():
1c001164:	02be4063 	addi.w	$r3,$r3,-112(0xf90)
1c001168:	2981b061 	st.w	$r1,$r3,108(0x6c)
1c00116c:	2981a076 	st.w	$r22,$r3,104(0x68)
1c001170:	0281c076 	addi.w	$r22,$r3,112(0x70)
1c001174:	29be72c4 	st.w	$r4,$r22,-100(0xf9c)
1c001178:	29be62c5 	st.w	$r5,$r22,-104(0xf98)
1c00117c:	29be52c6 	st.w	$r6,$r22,-108(0xf94)
1c001180:	29be42c7 	st.w	$r7,$r22,-112(0xf90)
1c001184:	28be42cc 	ld.w	$r12,$r22,-112(0xf90)
1c001188:	40002580 	beqz	$r12,36(0x24) # 1c0011ac <printbase+0x48>
1c00118c:	28be72cc 	ld.w	$r12,$r22,-100(0xf9c)
1c001190:	64001d80 	bge	$r12,$r0,28(0x1c) # 1c0011ac <printbase+0x48>
1c001194:	28be72cc 	ld.w	$r12,$r22,-100(0xf9c)
1c001198:	0011300c 	sub.w	$r12,$r0,$r12
1c00119c:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c0011a0:	0280b404 	addi.w	$r4,$r0,45(0x2d)
1c0011a4:	57ff87ff 	bl	-124(0xfffff84) # 1c001128 <myputchar>
1c0011a8:	50000c00 	b	12(0xc) # 1c0011b4 <printbase+0x50>
1c0011ac:	28be72cc 	ld.w	$r12,$r22,-100(0xf9c)
1c0011b0:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c0011b4:	29bfb2c0 	st.w	$r0,$r22,-20(0xfec)
1c0011b8:	50005000 	b	80(0x50) # 1c001208 <printbase+0xa4>
1c0011bc:	28be52cc 	ld.w	$r12,$r22,-108(0xf94)
1c0011c0:	28bf92cd 	ld.w	$r13,$r22,-28(0xfe4)
1c0011c4:	0021b1ae 	mod.wu	$r14,$r13,$r12
1c0011c8:	5c000980 	bne	$r12,$r0,8(0x8) # 1c0011d0 <printbase+0x6c>
1c0011cc:	002a0007 	break	0x7
1c0011d0:	00005dcc 	ext.w.b	$r12,$r14
1c0011d4:	28bfb2cd 	ld.w	$r13,$r22,-20(0xfec)
1c0011d8:	02bfc2ce 	addi.w	$r14,$r22,-16(0xff0)
1c0011dc:	001035cd 	add.w	$r13,$r14,$r13
1c0011e0:	293ec1ac 	st.b	$r12,$r13,-80(0xfb0)
1c0011e4:	28be52cd 	ld.w	$r13,$r22,-108(0xf94)
1c0011e8:	28bf92ce 	ld.w	$r14,$r22,-28(0xfe4)
1c0011ec:	002135cc 	div.wu	$r12,$r14,$r13
1c0011f0:	5c0009a0 	bne	$r13,$r0,8(0x8) # 1c0011f8 <printbase+0x94>
1c0011f4:	002a0007 	break	0x7
1c0011f8:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c0011fc:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001200:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001204:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001208:	28bf92cc 	ld.w	$r12,$r22,-28(0xfe4)
1c00120c:	47ffb19f 	bnez	$r12,-80(0x7fffb0) # 1c0011bc <printbase+0x58>
1c001210:	28be62cc 	ld.w	$r12,$r22,-104(0xf98)
1c001214:	28bfb2cd 	ld.w	$r13,$r22,-20(0xfec)
1c001218:	28bfb2ce 	ld.w	$r14,$r22,-20(0xfec)
1c00121c:	001231ad 	slt	$r13,$r13,$r12
1c001220:	0013b5ce 	masknez	$r14,$r14,$r13
1c001224:	0013358c 	maskeqz	$r12,$r12,$r13
1c001228:	001531cc 	or	$r12,$r14,$r12
1c00122c:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c001230:	50007400 	b	116(0x74) # 1c0012a4 <printbase+0x140>
1c001234:	28bfa2cd 	ld.w	$r13,$r22,-24(0xfe8)
1c001238:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c00123c:	60001d8d 	blt	$r12,$r13,28(0x1c) # 1c001258 <printbase+0xf4>
1c001240:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001244:	02bffd8c 	addi.w	$r12,$r12,-1(0xfff)
1c001248:	02bfc2cd 	addi.w	$r13,$r22,-16(0xff0)
1c00124c:	001031ac 	add.w	$r12,$r13,$r12
1c001250:	283ec18c 	ld.b	$r12,$r12,-80(0xfb0)
1c001254:	50000800 	b	8(0x8) # 1c00125c <printbase+0xf8>
1c001258:	0015000c 	move	$r12,$r0
1c00125c:	29bf82cc 	st.w	$r12,$r22,-32(0xfe0)
1c001260:	28bf82cd 	ld.w	$r13,$r22,-32(0xfe0)
1c001264:	0280240c 	addi.w	$r12,$r0,9(0x9)
1c001268:	6000198d 	blt	$r12,$r13,24(0x18) # 1c001280 <printbase+0x11c>
1c00126c:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001270:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001274:	0280c18c 	addi.w	$r12,$r12,48(0x30)
1c001278:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c00127c:	50001400 	b	20(0x14) # 1c001290 <printbase+0x12c>
1c001280:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001284:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001288:	02815d8c 	addi.w	$r12,$r12,87(0x57)
1c00128c:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001290:	00150184 	move	$r4,$r12
1c001294:	57fe97ff 	bl	-364(0xffffe94) # 1c001128 <myputchar>
1c001298:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c00129c:	02bffd8c 	addi.w	$r12,$r12,-1(0xfff)
1c0012a0:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c0012a4:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c0012a8:	63ff8c0c 	blt	$r0,$r12,-116(0x3ff8c) # 1c001234 <printbase+0xd0>
1c0012ac:	0015000c 	move	$r12,$r0
1c0012b0:	00150184 	move	$r4,$r12
1c0012b4:	2881b061 	ld.w	$r1,$r3,108(0x6c)
1c0012b8:	2881a076 	ld.w	$r22,$r3,104(0x68)
1c0012bc:	0281c063 	addi.w	$r3,$r3,112(0x70)
1c0012c0:	4c000020 	jirl	$r0,$r1,0

1c0012c4 <puts>:
puts():
1c0012c4:	02bf4063 	addi.w	$r3,$r3,-48(0xfd0)
1c0012c8:	2980b061 	st.w	$r1,$r3,44(0x2c)
1c0012cc:	2980a076 	st.w	$r22,$r3,40(0x28)
1c0012d0:	0280c076 	addi.w	$r22,$r3,48(0x30)
1c0012d4:	29bf72c4 	st.w	$r4,$r22,-36(0xfdc)
1c0012d8:	50003000 	b	48(0x30) # 1c001308 <puts+0x44>
1c0012dc:	283fbecd 	ld.b	$r13,$r22,-17(0xfef)
1c0012e0:	0280280c 	addi.w	$r12,$r0,10(0xa)
1c0012e4:	5c000dac 	bne	$r13,$r12,12(0xc) # 1c0012f0 <puts+0x2c>
1c0012e8:	02803404 	addi.w	$r4,$r0,13(0xd)
1c0012ec:	57fe3fff 	bl	-452(0xffffe3c) # 1c001128 <myputchar>
1c0012f0:	2a3fbecc 	ld.bu	$r12,$r22,-17(0xfef)
1c0012f4:	00150184 	move	$r4,$r12
1c0012f8:	57fe33ff 	bl	-464(0xffffe30) # 1c001128 <myputchar>
1c0012fc:	28bf72cc 	ld.w	$r12,$r22,-36(0xfdc)
1c001300:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001304:	29bf72cc 	st.w	$r12,$r22,-36(0xfdc)
1c001308:	28bf72cc 	ld.w	$r12,$r22,-36(0xfdc)
1c00130c:	2a00018c 	ld.bu	$r12,$r12,0
1c001310:	293fbecc 	st.b	$r12,$r22,-17(0xfef)
1c001314:	283fbecc 	ld.b	$r12,$r22,-17(0xfef)
1c001318:	47ffc59f 	bnez	$r12,-60(0x7fffc4) # 1c0012dc <puts+0x18>
1c00131c:	0015000c 	move	$r12,$r0
1c001320:	00150184 	move	$r4,$r12
1c001324:	2880b061 	ld.w	$r1,$r3,44(0x2c)
1c001328:	2880a076 	ld.w	$r22,$r3,40(0x28)
1c00132c:	0280c063 	addi.w	$r3,$r3,48(0x30)
1c001330:	4c000020 	jirl	$r0,$r1,0

1c001334 <myprintf>:
myprintf():
1c001334:	02be8063 	addi.w	$r3,$r3,-96(0xfa0)
1c001338:	2980f061 	st.w	$r1,$r3,60(0x3c)
1c00133c:	2980e076 	st.w	$r22,$r3,56(0x38)
1c001340:	02810076 	addi.w	$r22,$r3,64(0x40)
1c001344:	29bf32c4 	st.w	$r4,$r22,-52(0xfcc)
1c001348:	298012c5 	st.w	$r5,$r22,4(0x4)
1c00134c:	298022c6 	st.w	$r6,$r22,8(0x8)
1c001350:	298032c7 	st.w	$r7,$r22,12(0xc)
1c001354:	298042c8 	st.w	$r8,$r22,16(0x10)
1c001358:	298052c9 	st.w	$r9,$r22,20(0x14)
1c00135c:	298062ca 	st.w	$r10,$r22,24(0x18)
1c001360:	298072cb 	st.w	$r11,$r22,28(0x1c)
1c001364:	028082cc 	addi.w	$r12,$r22,32(0x20)
1c001368:	02bf918c 	addi.w	$r12,$r12,-28(0xfe4)
1c00136c:	29bf72cc 	st.w	$r12,$r22,-36(0xfdc)
1c001370:	28bf72cc 	ld.w	$r12,$r22,-36(0xfdc)
1c001374:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c001378:	29bfb2c0 	st.w	$r0,$r22,-20(0xfec)
1c00137c:	50033000 	b	816(0x330) # 1c0016ac <myprintf+0x378>
1c001380:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001384:	28bf32cd 	ld.w	$r13,$r22,-52(0xfcc)
1c001388:	001031ac 	add.w	$r12,$r13,$r12
1c00138c:	2a00018c 	ld.bu	$r12,$r12,0
1c001390:	293f8ecc 	st.b	$r12,$r22,-29(0xfe3)
1c001394:	283f8ecd 	ld.b	$r13,$r22,-29(0xfe3)
1c001398:	0280940c 	addi.w	$r12,$r0,37(0x25)
1c00139c:	5c02e5ac 	bne	$r13,$r12,740(0x2e4) # 1c001680 <myprintf+0x34c>
1c0013a0:	0280040c 	addi.w	$r12,$r0,1(0x1)
1c0013a4:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c0013a8:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0013ac:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0013b0:	28bf32cd 	ld.w	$r13,$r22,-52(0xfcc)
1c0013b4:	001031ac 	add.w	$r12,$r13,$r12
1c0013b8:	2800018c 	ld.b	$r12,$r12,0
1c0013bc:	02bf6d8c 	addi.w	$r12,$r12,-37(0xfdb)
1c0013c0:	02814c0d 	addi.w	$r13,$r0,83(0x53)
1c0013c4:	6802adac 	bltu	$r13,$r12,684(0x2ac) # 1c001670 <myprintf+0x33c>
1c0013c8:	0040898d 	slli.w	$r13,$r12,0x2
1c0013cc:	1c00002c 	pcaddu12i	$r12,1(0x1)
1c0013d0:	0291618c 	addi.w	$r12,$r12,1112(0x458)
1c0013d4:	001031ac 	add.w	$r12,$r13,$r12
1c0013d8:	2880018c 	ld.w	$r12,$r12,0
1c0013dc:	4c000180 	jirl	$r0,$r12,0
1c0013e0:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c0013e4:	2880018c 	ld.w	$r12,$r12,0
1c0013e8:	00150184 	move	$r4,$r12
1c0013ec:	57fedbff 	bl	-296(0xffffed8) # 1c0012c4 <puts>
1c0013f0:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c0013f4:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c0013f8:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c0013fc:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001400:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001404:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001408:	50029800 	b	664(0x298) # 1c0016a0 <myprintf+0x36c>
1c00140c:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001410:	2880018c 	ld.w	$r12,$r12,0
1c001414:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001418:	00150184 	move	$r4,$r12
1c00141c:	57fd0fff 	bl	-756(0xffffd0c) # 1c001128 <myputchar>
1c001420:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001424:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c001428:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c00142c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001430:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001434:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001438:	50026800 	b	616(0x268) # 1c0016a0 <myprintf+0x36c>
1c00143c:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001440:	2880018c 	ld.w	$r12,$r12,0
1c001444:	00150007 	move	$r7,$r0
1c001448:	02802806 	addi.w	$r6,$r0,10(0xa)
1c00144c:	28bf92c5 	ld.w	$r5,$r22,-28(0xfe4)
1c001450:	00150184 	move	$r4,$r12
1c001454:	57fd13ff 	bl	-752(0xffffd10) # 1c001164 <printbase>
1c001458:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c00145c:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c001460:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c001464:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001468:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c00146c:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001470:	50023000 	b	560(0x230) # 1c0016a0 <myprintf+0x36c>
1c001474:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001478:	2880018c 	ld.w	$r12,$r12,0
1c00147c:	02800407 	addi.w	$r7,$r0,1(0x1)
1c001480:	02802806 	addi.w	$r6,$r0,10(0xa)
1c001484:	28bf92c5 	ld.w	$r5,$r22,-28(0xfe4)
1c001488:	00150184 	move	$r4,$r12
1c00148c:	57fcdbff 	bl	-808(0xffffcd8) # 1c001164 <printbase>
1c001490:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001494:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c001498:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c00149c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0014a0:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0014a4:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c0014a8:	5001f800 	b	504(0x1f8) # 1c0016a0 <myprintf+0x36c>
1c0014ac:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c0014b0:	2880018c 	ld.w	$r12,$r12,0
1c0014b4:	00150007 	move	$r7,$r0
1c0014b8:	02802006 	addi.w	$r6,$r0,8(0x8)
1c0014bc:	28bf92c5 	ld.w	$r5,$r22,-28(0xfe4)
1c0014c0:	00150184 	move	$r4,$r12
1c0014c4:	57fca3ff 	bl	-864(0xffffca0) # 1c001164 <printbase>
1c0014c8:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c0014cc:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c0014d0:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c0014d4:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0014d8:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0014dc:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c0014e0:	5001c000 	b	448(0x1c0) # 1c0016a0 <myprintf+0x36c>
1c0014e4:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c0014e8:	2880018c 	ld.w	$r12,$r12,0
1c0014ec:	00150007 	move	$r7,$r0
1c0014f0:	02800806 	addi.w	$r6,$r0,2(0x2)
1c0014f4:	28bf92c5 	ld.w	$r5,$r22,-28(0xfe4)
1c0014f8:	00150184 	move	$r4,$r12
1c0014fc:	57fc6bff 	bl	-920(0xffffc68) # 1c001164 <printbase>
1c001500:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001504:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c001508:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c00150c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001510:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001514:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001518:	50018800 	b	392(0x188) # 1c0016a0 <myprintf+0x36c>
1c00151c:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001520:	2880018c 	ld.w	$r12,$r12,0
1c001524:	00150007 	move	$r7,$r0
1c001528:	02804006 	addi.w	$r6,$r0,16(0x10)
1c00152c:	28bf92c5 	ld.w	$r5,$r22,-28(0xfe4)
1c001530:	00150184 	move	$r4,$r12
1c001534:	57fc33ff 	bl	-976(0xffffc30) # 1c001164 <printbase>
1c001538:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c00153c:	0280118c 	addi.w	$r12,$r12,4(0x4)
1c001540:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c001544:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001548:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c00154c:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001550:	50015000 	b	336(0x150) # 1c0016a0 <myprintf+0x36c>
1c001554:	02809404 	addi.w	$r4,$r0,37(0x25)
1c001558:	57fbd3ff 	bl	-1072(0xffffbd0) # 1c001128 <myputchar>
1c00155c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001560:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001564:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001568:	50013800 	b	312(0x138) # 1c0016a0 <myprintf+0x36c>
1c00156c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001570:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001574:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001578:	29bf92c0 	st.w	$r0,$r22,-28(0xfe4)
1c00157c:	50003c00 	b	60(0x3c) # 1c0015b8 <myprintf+0x284>
1c001580:	28bf92cd 	ld.w	$r13,$r22,-28(0xfe4)
1c001584:	0280280c 	addi.w	$r12,$r0,10(0xa)
1c001588:	001c31ad 	mul.w	$r13,$r13,$r12
1c00158c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001590:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001594:	28bf32ce 	ld.w	$r14,$r22,-52(0xfcc)
1c001598:	001031cc 	add.w	$r12,$r14,$r12
1c00159c:	2800018c 	ld.b	$r12,$r12,0
1c0015a0:	02bf418c 	addi.w	$r12,$r12,-48(0xfd0)
1c0015a4:	001031ac 	add.w	$r12,$r13,$r12
1c0015a8:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c0015ac:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0015b0:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0015b4:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c0015b8:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0015bc:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0015c0:	28bf32cd 	ld.w	$r13,$r22,-52(0xfcc)
1c0015c4:	001031ac 	add.w	$r12,$r13,$r12
1c0015c8:	2800018d 	ld.b	$r13,$r12,0
1c0015cc:	0280c00c 	addi.w	$r12,$r0,48(0x30)
1c0015d0:	67fdd98d 	bge	$r12,$r13,-552(0x3fdd8) # 1c0013a8 <myprintf+0x74>
1c0015d4:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0015d8:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0015dc:	28bf32cd 	ld.w	$r13,$r22,-52(0xfcc)
1c0015e0:	001031ac 	add.w	$r12,$r13,$r12
1c0015e4:	2800018d 	ld.b	$r13,$r12,0
1c0015e8:	0280e40c 	addi.w	$r12,$r0,57(0x39)
1c0015ec:	67ff958d 	bge	$r12,$r13,-108(0x3ff94) # 1c001580 <myprintf+0x24c>
1c0015f0:	53fdbbff 	b	-584(0xffffdb8) # 1c0013a8 <myprintf+0x74>
1c0015f4:	29bf92c0 	st.w	$r0,$r22,-28(0xfe4)
1c0015f8:	50003c00 	b	60(0x3c) # 1c001634 <myprintf+0x300>
1c0015fc:	28bf92cd 	ld.w	$r13,$r22,-28(0xfe4)
1c001600:	0280280c 	addi.w	$r12,$r0,10(0xa)
1c001604:	001c31ad 	mul.w	$r13,$r13,$r12
1c001608:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c00160c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001610:	28bf32ce 	ld.w	$r14,$r22,-52(0xfcc)
1c001614:	001031cc 	add.w	$r12,$r14,$r12
1c001618:	2800018c 	ld.b	$r12,$r12,0
1c00161c:	02bf418c 	addi.w	$r12,$r12,-48(0xfd0)
1c001620:	001031ac 	add.w	$r12,$r13,$r12
1c001624:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c001628:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c00162c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001630:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001634:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001638:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c00163c:	28bf32cd 	ld.w	$r13,$r22,-52(0xfcc)
1c001640:	001031ac 	add.w	$r12,$r13,$r12
1c001644:	2800018d 	ld.b	$r13,$r12,0
1c001648:	0280c00c 	addi.w	$r12,$r0,48(0x30)
1c00164c:	67fd5d8d 	bge	$r12,$r13,-676(0x3fd5c) # 1c0013a8 <myprintf+0x74>
1c001650:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001654:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001658:	28bf32cd 	ld.w	$r13,$r22,-52(0xfcc)
1c00165c:	001031ac 	add.w	$r12,$r13,$r12
1c001660:	2800018d 	ld.b	$r13,$r12,0
1c001664:	0280e40c 	addi.w	$r12,$r0,57(0x39)
1c001668:	67ff958d 	bge	$r12,$r13,-108(0x3ff94) # 1c0015fc <myprintf+0x2c8>
1c00166c:	53fd3fff 	b	-708(0xffffd3c) # 1c0013a8 <myprintf+0x74>
1c001670:	02809404 	addi.w	$r4,$r0,37(0x25)
1c001674:	57fab7ff 	bl	-1356(0xffffab4) # 1c001128 <myputchar>
1c001678:	03400000 	andi	$r0,$r0,0x0
1c00167c:	50002400 	b	36(0x24) # 1c0016a0 <myprintf+0x36c>
1c001680:	283f8ecd 	ld.b	$r13,$r22,-29(0xfe3)
1c001684:	0280280c 	addi.w	$r12,$r0,10(0xa)
1c001688:	5c000dac 	bne	$r13,$r12,12(0xc) # 1c001694 <myprintf+0x360>
1c00168c:	02803404 	addi.w	$r4,$r0,13(0xd)
1c001690:	57fa9bff 	bl	-1384(0xffffa98) # 1c001128 <myputchar>
1c001694:	2a3f8ecc 	ld.bu	$r12,$r22,-29(0xfe3)
1c001698:	00150184 	move	$r4,$r12
1c00169c:	57fa8fff 	bl	-1396(0xffffa8c) # 1c001128 <myputchar>
1c0016a0:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0016a4:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0016a8:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c0016ac:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0016b0:	28bf32cd 	ld.w	$r13,$r22,-52(0xfcc)
1c0016b4:	001031ac 	add.w	$r12,$r13,$r12
1c0016b8:	2800018c 	ld.b	$r12,$r12,0
1c0016bc:	47fcc59f 	bnez	$r12,-828(0x7ffcc4) # 1c001380 <myprintf+0x4c>
1c0016c0:	0015000c 	move	$r12,$r0
1c0016c4:	00150184 	move	$r4,$r12
1c0016c8:	2880f061 	ld.w	$r1,$r3,60(0x3c)
1c0016cc:	2880e076 	ld.w	$r22,$r3,56(0x38)
1c0016d0:	02818063 	addi.w	$r3,$r3,96(0x60)
1c0016d4:	4c000020 	jirl	$r0,$r1,0

1c0016d8 <UART_SendData>:
UART_SendData():
1c0016d8:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c0016dc:	29807076 	st.w	$r22,$r3,28(0x1c)
1c0016e0:	02808076 	addi.w	$r22,$r3,32(0x20)
1c0016e4:	29bfb2c4 	st.w	$r4,$r22,-20(0xfec)
1c0016e8:	001500ac 	move	$r12,$r5
1c0016ec:	293faecc 	st.b	$r12,$r22,-21(0xfeb)
1c0016f0:	03400000 	andi	$r0,$r0,0x0
1c0016f4:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0016f8:	2a00158c 	ld.bu	$r12,$r12,5(0x5)
1c0016fc:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001700:	0340818c 	andi	$r12,$r12,0x20
1c001704:	43fff19f 	beqz	$r12,-16(0x7ffff0) # 1c0016f4 <UART_SendData+0x1c>
1c001708:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c00170c:	2a3faecd 	ld.bu	$r13,$r22,-21(0xfeb)
1c001710:	2900018d 	st.b	$r13,$r12,0
1c001714:	03400000 	andi	$r0,$r0,0x0
1c001718:	28807076 	ld.w	$r22,$r3,28(0x1c)
1c00171c:	02808063 	addi.w	$r3,$r3,32(0x20)
1c001720:	4c000020 	jirl	$r0,$r1,0

1c001724 <EnableInt>:
EnableInt():
1c001724:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001728:	29803076 	st.w	$r22,$r3,12(0xc)
1c00172c:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001730:	0380100c 	ori	$r12,$r0,0x4
1c001734:	0400018c 	csrxchg	$r12,$r12,0x0
1c001738:	03400000 	andi	$r0,$r0,0x0
1c00173c:	28803076 	ld.w	$r22,$r3,12(0xc)
1c001740:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001744:	4c000020 	jirl	$r0,$r1,0

1c001748 <Set_Timer_stop>:
Set_Timer_stop():
1c001748:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00174c:	29803076 	st.w	$r22,$r3,12(0xc)
1c001750:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001754:	04010420 	csrwr	$r0,0x41
1c001758:	03400000 	andi	$r0,$r0,0x0
1c00175c:	28803076 	ld.w	$r22,$r3,12(0xc)
1c001760:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001764:	4c000020 	jirl	$r0,$r1,0

1c001768 <Set_Timer_clear>:
Set_Timer_clear():
1c001768:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00176c:	29803076 	st.w	$r22,$r3,12(0xc)
1c001770:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001774:	0380040c 	ori	$r12,$r0,0x1
1c001778:	0401102c 	csrwr	$r12,0x44
1c00177c:	03400000 	andi	$r0,$r0,0x0
1c001780:	28803076 	ld.w	$r22,$r3,12(0xc)
1c001784:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001788:	4c000020 	jirl	$r0,$r1,0

1c00178c <EXTI_ClearITPendingBit>:
EXTI_ClearITPendingBit():
1c00178c:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c001790:	29807076 	st.w	$r22,$r3,28(0x1c)
1c001794:	02808076 	addi.w	$r22,$r3,32(0x20)
1c001798:	29bfb2c4 	st.w	$r4,$r22,-20(0xfec)
1c00179c:	29bfa2c5 	st.w	$r5,$r22,-24(0xfe8)
1c0017a0:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0017a4:	2880318d 	ld.w	$r13,$r12,12(0xc)
1c0017a8:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c0017ac:	001531ad 	or	$r13,$r13,$r12
1c0017b0:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0017b4:	2980318d 	st.w	$r13,$r12,12(0xc)
1c0017b8:	03400000 	andi	$r0,$r0,0x0
1c0017bc:	28807076 	ld.w	$r22,$r3,28(0x1c)
1c0017c0:	02808063 	addi.w	$r3,$r3,32(0x20)
1c0017c4:	4c000020 	jirl	$r0,$r1,0

1c0017c8 <WDG_DogFeed>:
WDG_DogFeed():
1c0017c8:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0017cc:	29803076 	st.w	$r22,$r3,12(0xc)
1c0017d0:	02804076 	addi.w	$r22,$r3,16(0x10)
1c0017d4:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0017d8:	154ab4ad 	lu12i.w	$r13,-371291(0xa55a5)
1c0017dc:	0396a9ad 	ori	$r13,$r13,0x5aa
1c0017e0:	2980d18d 	st.w	$r13,$r12,52(0x34)
1c0017e4:	03400000 	andi	$r0,$r0,0x0
1c0017e8:	28803076 	ld.w	$r22,$r3,12(0xc)
1c0017ec:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0017f0:	4c000020 	jirl	$r0,$r1,0

1c0017f4 <TIM_GetITStatus>:
TIM_GetITStatus():
1c0017f4:	02bf4063 	addi.w	$r3,$r3,-48(0xfd0)
1c0017f8:	2980b076 	st.w	$r22,$r3,44(0x2c)
1c0017fc:	0280c076 	addi.w	$r22,$r3,48(0x30)
1c001800:	29bf72c4 	st.w	$r4,$r22,-36(0xfdc)
1c001804:	29bfb2c0 	st.w	$r0,$r22,-20(0xfec)
1c001808:	157fda0c 	lu12i.w	$r12,-262448(0xbfed0)
1c00180c:	2880018d 	ld.w	$r13,$r12,0
1c001810:	28bf72cc 	ld.w	$r12,$r22,-36(0xfdc)
1c001814:	0014b1ac 	and	$r12,$r13,$r12
1c001818:	40001180 	beqz	$r12,16(0x10) # 1c001828 <TIM_GetITStatus+0x34>
1c00181c:	0280040c 	addi.w	$r12,$r0,1(0x1)
1c001820:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001824:	50000800 	b	8(0x8) # 1c00182c <TIM_GetITStatus+0x38>
1c001828:	29bfb2c0 	st.w	$r0,$r22,-20(0xfec)
1c00182c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001830:	00150184 	move	$r4,$r12
1c001834:	2880b076 	ld.w	$r22,$r3,44(0x2c)
1c001838:	0280c063 	addi.w	$r3,$r3,48(0x30)
1c00183c:	4c000020 	jirl	$r0,$r1,0

1c001840 <TIM_ClearIT>:
TIM_ClearIT():
1c001840:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c001844:	29807076 	st.w	$r22,$r3,28(0x1c)
1c001848:	02808076 	addi.w	$r22,$r3,32(0x20)
1c00184c:	29bfb2c4 	st.w	$r4,$r22,-20(0xfec)
1c001850:	157fda0c 	lu12i.w	$r12,-262448(0xbfed0)
1c001854:	2880018e 	ld.w	$r14,$r12,0
1c001858:	157fda0c 	lu12i.w	$r12,-262448(0xbfed0)
1c00185c:	28bfb2cd 	ld.w	$r13,$r22,-20(0xfec)
1c001860:	001535cd 	or	$r13,$r14,$r13
1c001864:	2980018d 	st.w	$r13,$r12,0
1c001868:	157fd40c 	lu12i.w	$r12,-262496(0xbfea0)
1c00186c:	03800d8c 	ori	$r12,$r12,0x3
1c001870:	2a00018c 	ld.bu	$r12,$r12,0
1c001874:	0067818d 	bstrpick.w	$r13,$r12,0x7,0x0
1c001878:	157fd40c 	lu12i.w	$r12,-262496(0xbfea0)
1c00187c:	03800d8c 	ori	$r12,$r12,0x3
1c001880:	038005ad 	ori	$r13,$r13,0x1
1c001884:	006781ad 	bstrpick.w	$r13,$r13,0x7,0x0
1c001888:	2900018d 	st.b	$r13,$r12,0
1c00188c:	03400000 	andi	$r0,$r0,0x0
1c001890:	28807076 	ld.w	$r22,$r3,28(0x1c)
1c001894:	02808063 	addi.w	$r3,$r3,32(0x20)
1c001898:	4c000020 	jirl	$r0,$r1,0

1c00189c <recv_dat_int>:
recv_dat_int():
1c00189c:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c0018a0:	29807061 	st.w	$r1,$r3,28(0x1c)
1c0018a4:	29806076 	st.w	$r22,$r3,24(0x18)
1c0018a8:	02808076 	addi.w	$r22,$r3,32(0x20)
1c0018ac:	0015008c 	move	$r12,$r4
1c0018b0:	293fbecc 	st.b	$r12,$r22,-17(0xfef)
1c0018b4:	1cc7ffcc 	pcaddu12i	$r12,409598(0x63ffe)
1c0018b8:	029d318c 	addi.w	$r12,$r12,1868(0x74c)
1c0018bc:	0280040d 	addi.w	$r13,$r0,1(0x1)
1c0018c0:	2980018d 	st.w	$r13,$r12,0
1c0018c4:	2a3fbecc 	ld.bu	$r12,$r22,-17(0xfef)
1c0018c8:	00150185 	move	$r5,$r12
1c0018cc:	1cc7ffc4 	pcaddu12i	$r4,409598(0x63ffe)
1c0018d0:	029ce084 	addi.w	$r4,$r4,1848(0x738)
1c0018d4:	54001800 	bl	24(0x18) # 1c0018ec <Buffer_write>
1c0018d8:	03400000 	andi	$r0,$r0,0x0
1c0018dc:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c0018e0:	28806076 	ld.w	$r22,$r3,24(0x18)
1c0018e4:	02808063 	addi.w	$r3,$r3,32(0x20)
1c0018e8:	4c000020 	jirl	$r0,$r1,0

1c0018ec <Buffer_write>:
Buffer_write():
1c0018ec:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c0018f0:	29807076 	st.w	$r22,$r3,28(0x1c)
1c0018f4:	02808076 	addi.w	$r22,$r3,32(0x20)
1c0018f8:	29bfb2c4 	st.w	$r4,$r22,-20(0xfec)
1c0018fc:	001500ac 	move	$r12,$r5
1c001900:	293faecc 	st.b	$r12,$r22,-21(0xfeb)
1c001904:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001908:	2880018c 	ld.w	$r12,$r12,0
1c00190c:	28bfb2cd 	ld.w	$r13,$r22,-20(0xfec)
1c001910:	288031ad 	ld.w	$r13,$r13,12(0xc)
1c001914:	0010358c 	add.w	$r12,$r12,$r13
1c001918:	2a3faecd 	ld.bu	$r13,$r22,-21(0xfeb)
1c00191c:	2900018d 	st.b	$r13,$r12,0
1c001920:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001924:	2880318c 	ld.w	$r12,$r12,12(0xc)
1c001928:	0280058d 	addi.w	$r13,$r12,1(0x1)
1c00192c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001930:	2980318d 	st.w	$r13,$r12,12(0xc)
1c001934:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001938:	2880318d 	ld.w	$r13,$r12,12(0xc)
1c00193c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001940:	2880118c 	ld.w	$r12,$r12,4(0x4)
1c001944:	60000dac 	blt	$r13,$r12,12(0xc) # 1c001950 <Buffer_write+0x64>
1c001948:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c00194c:	29803180 	st.w	$r0,$r12,12(0xc)
1c001950:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001954:	2880418c 	ld.w	$r12,$r12,16(0x10)
1c001958:	0280058d 	addi.w	$r13,$r12,1(0x1)
1c00195c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001960:	2980418d 	st.w	$r13,$r12,16(0x10)
1c001964:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001968:	2880418d 	ld.w	$r13,$r12,16(0x10)
1c00196c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001970:	2880118c 	ld.w	$r12,$r12,4(0x4)
1c001974:	6400458d 	bge	$r12,$r13,68(0x44) # 1c0019b8 <Buffer_write+0xcc>
1c001978:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c00197c:	2880118d 	ld.w	$r13,$r12,4(0x4)
1c001980:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001984:	2980418d 	st.w	$r13,$r12,16(0x10)
1c001988:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c00198c:	2880218c 	ld.w	$r12,$r12,8(0x8)
1c001990:	0280058d 	addi.w	$r13,$r12,1(0x1)
1c001994:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001998:	2980218d 	st.w	$r13,$r12,8(0x8)
1c00199c:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0019a0:	2880218d 	ld.w	$r13,$r12,8(0x8)
1c0019a4:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0019a8:	2880118c 	ld.w	$r12,$r12,4(0x4)
1c0019ac:	60000dac 	blt	$r13,$r12,12(0xc) # 1c0019b8 <Buffer_write+0xcc>
1c0019b0:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0019b4:	29802180 	st.w	$r0,$r12,8(0x8)
1c0019b8:	03400000 	andi	$r0,$r0,0x0
1c0019bc:	28807076 	ld.w	$r22,$r3,28(0x1c)
1c0019c0:	02808063 	addi.w	$r3,$r3,32(0x20)
1c0019c4:	4c000020 	jirl	$r0,$r1,0

1c0019c8 <main>:
main():
1c0019c8:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c0019cc:	29807061 	st.w	$r1,$r3,28(0x1c)
1c0019d0:	29806076 	st.w	$r22,$r3,24(0x18)
1c0019d4:	02808076 	addi.w	$r22,$r3,32(0x20)
1c0019d8:	57fd4fff 	bl	-692(0xffffd4c) # 1c001724 <EnableInt>
1c0019dc:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0019e0:	29bf82cc 	st.w	$r12,$r22,-32(0xfe0)
1c0019e4:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c0019e8:	2880018c 	ld.w	$r12,$r12,0
1c0019ec:	0380098d 	ori	$r13,$r12,0x2
1c0019f0:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c0019f4:	2980018d 	st.w	$r13,$r12,0
1c0019f8:	14001c6c 	lu12i.w	$r12,227(0xe3)
1c0019fc:	03bf918c 	ori	$r12,$r12,0xfe4
1c001a00:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c001a04:	50001400 	b	20(0x14) # 1c001a18 <main+0x50>
1c001a08:	03400000 	andi	$r0,$r0,0x0
1c001a0c:	03400000 	andi	$r0,$r0,0x0
1c001a10:	03400000 	andi	$r0,$r0,0x0
1c001a14:	03400000 	andi	$r0,$r0,0x0
1c001a18:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c001a1c:	02bffd8d 	addi.w	$r13,$r12,-1(0xfff)
1c001a20:	29bfb2cd 	st.w	$r13,$r22,-20(0xfec)
1c001a24:	47ffe59f 	bnez	$r12,-28(0x7fffe4) # 1c001a08 <main+0x40>
1c001a28:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001a2c:	2880018d 	ld.w	$r13,$r12,0
1c001a30:	02bff40c 	addi.w	$r12,$r0,-3(0xffd)
1c001a34:	0014b1ad 	and	$r13,$r13,$r12
1c001a38:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001a3c:	2980018d 	st.w	$r13,$r12,0
1c001a40:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001a44:	2880018c 	ld.w	$r12,$r12,0
1c001a48:	0380098d 	ori	$r13,$r12,0x2
1c001a4c:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001a50:	2980018d 	st.w	$r13,$r12,0
1c001a54:	14001c6c 	lu12i.w	$r12,227(0xe3)
1c001a58:	03bf918c 	ori	$r12,$r12,0xfe4
1c001a5c:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c001a60:	50001400 	b	20(0x14) # 1c001a74 <main+0xac>
1c001a64:	03400000 	andi	$r0,$r0,0x0
1c001a68:	03400000 	andi	$r0,$r0,0x0
1c001a6c:	03400000 	andi	$r0,$r0,0x0
1c001a70:	03400000 	andi	$r0,$r0,0x0
1c001a74:	28bfa2cc 	ld.w	$r12,$r22,-24(0xfe8)
1c001a78:	02bffd8d 	addi.w	$r13,$r12,-1(0xfff)
1c001a7c:	29bfa2cd 	st.w	$r13,$r22,-24(0xfe8)
1c001a80:	47ffe59f 	bnez	$r12,-28(0x7fffe4) # 1c001a64 <main+0x9c>
1c001a84:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001a88:	2880018d 	ld.w	$r13,$r12,0
1c001a8c:	02bff40c 	addi.w	$r12,$r0,-3(0xffd)
1c001a90:	0014b1ad 	and	$r13,$r13,$r12
1c001a94:	28bf82cc 	ld.w	$r12,$r22,-32(0xfe0)
1c001a98:	2980018d 	st.w	$r13,$r12,0
1c001a9c:	14001c6c 	lu12i.w	$r12,227(0xe3)
1c001aa0:	03bf918c 	ori	$r12,$r12,0xfe4
1c001aa4:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c001aa8:	50001400 	b	20(0x14) # 1c001abc <main+0xf4>
1c001aac:	03400000 	andi	$r0,$r0,0x0
1c001ab0:	03400000 	andi	$r0,$r0,0x0
1c001ab4:	03400000 	andi	$r0,$r0,0x0
1c001ab8:	03400000 	andi	$r0,$r0,0x0
1c001abc:	28bf92cc 	ld.w	$r12,$r22,-28(0xfe4)
1c001ac0:	02bffd8d 	addi.w	$r13,$r12,-1(0xfff)
1c001ac4:	29bf92cd 	st.w	$r13,$r22,-28(0xfe4)
1c001ac8:	47ffe59f 	bnez	$r12,-28(0x7fffe4) # 1c001aac <main+0xe4>
1c001acc:	53ff77ff 	b	-140(0xfffff74) # 1c001a40 <main+0x78>

1c001ad0 <exti_gpioa0_irq_handler>:
exti_gpioa0_irq_handler():
1c001ad0:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001ad4:	29803061 	st.w	$r1,$r3,12(0xc)
1c001ad8:	29802076 	st.w	$r22,$r3,8(0x8)
1c001adc:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001ae0:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001ae4:	0281a0c6 	addi.w	$r6,$r6,104(0x68)
1c001ae8:	02804c05 	addi.w	$r5,$r0,19(0x13)
1c001aec:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001af0:	02ba2084 	addi.w	$r4,$r4,-376(0xe88)
1c001af4:	57f843ff 	bl	-1984(0xffff840) # 1c001334 <myprintf>
1c001af8:	02800405 	addi.w	$r5,$r0,1(0x1)
1c001afc:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001b00:	03808184 	ori	$r4,$r12,0x20
1c001b04:	57fc8bff 	bl	-888(0xffffc88) # 1c00178c <EXTI_ClearITPendingBit>
1c001b08:	03400000 	andi	$r0,$r0,0x0
1c001b0c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001b10:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001b14:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001b18:	4c000020 	jirl	$r0,$r1,0

1c001b1c <exti_gpioa1_irq_handler>:
exti_gpioa1_irq_handler():
1c001b1c:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001b20:	29803061 	st.w	$r1,$r3,12(0xc)
1c001b24:	29802076 	st.w	$r22,$r3,8(0x8)
1c001b28:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001b2c:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001b30:	0280d0c6 	addi.w	$r6,$r6,52(0x34)
1c001b34:	02806005 	addi.w	$r5,$r0,24(0x18)
1c001b38:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001b3c:	02b8f084 	addi.w	$r4,$r4,-452(0xe3c)
1c001b40:	57f7f7ff 	bl	-2060(0xffff7f4) # 1c001334 <myprintf>
1c001b44:	02800805 	addi.w	$r5,$r0,2(0x2)
1c001b48:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001b4c:	03808184 	ori	$r4,$r12,0x20
1c001b50:	57fc3fff 	bl	-964(0xffffc3c) # 1c00178c <EXTI_ClearITPendingBit>
1c001b54:	03400000 	andi	$r0,$r0,0x0
1c001b58:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001b5c:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001b60:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001b64:	4c000020 	jirl	$r0,$r1,0

1c001b68 <exti_gpioa2_irq_handler>:
exti_gpioa2_irq_handler():
1c001b68:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001b6c:	29803061 	st.w	$r1,$r3,12(0xc)
1c001b70:	29802076 	st.w	$r22,$r3,8(0x8)
1c001b74:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001b78:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001b7c:	028000c6 	addi.w	$r6,$r6,0
1c001b80:	02807405 	addi.w	$r5,$r0,29(0x1d)
1c001b84:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001b88:	02b7c084 	addi.w	$r4,$r4,-528(0xdf0)
1c001b8c:	57f7abff 	bl	-2136(0xffff7a8) # 1c001334 <myprintf>
1c001b90:	02801005 	addi.w	$r5,$r0,4(0x4)
1c001b94:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001b98:	03808184 	ori	$r4,$r12,0x20
1c001b9c:	57fbf3ff 	bl	-1040(0xffffbf0) # 1c00178c <EXTI_ClearITPendingBit>
1c001ba0:	03400000 	andi	$r0,$r0,0x0
1c001ba4:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001ba8:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001bac:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001bb0:	4c000020 	jirl	$r0,$r1,0

1c001bb4 <exti_gpioa3_irq_handler>:
exti_gpioa3_irq_handler():
1c001bb4:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001bb8:	29803061 	st.w	$r1,$r3,12(0xc)
1c001bbc:	29802076 	st.w	$r22,$r3,8(0x8)
1c001bc0:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001bc4:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001bc8:	02bf30c6 	addi.w	$r6,$r6,-52(0xfcc)
1c001bcc:	02808805 	addi.w	$r5,$r0,34(0x22)
1c001bd0:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001bd4:	02b69084 	addi.w	$r4,$r4,-604(0xda4)
1c001bd8:	57f75fff 	bl	-2212(0xffff75c) # 1c001334 <myprintf>
1c001bdc:	02802005 	addi.w	$r5,$r0,8(0x8)
1c001be0:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001be4:	03808184 	ori	$r4,$r12,0x20
1c001be8:	57fba7ff 	bl	-1116(0xffffba4) # 1c00178c <EXTI_ClearITPendingBit>
1c001bec:	03400000 	andi	$r0,$r0,0x0
1c001bf0:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001bf4:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001bf8:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001bfc:	4c000020 	jirl	$r0,$r1,0

1c001c00 <exti_gpioa4_irq_handler>:
exti_gpioa4_irq_handler():
1c001c00:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001c04:	29803061 	st.w	$r1,$r3,12(0xc)
1c001c08:	29802076 	st.w	$r22,$r3,8(0x8)
1c001c0c:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001c10:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001c14:	02be60c6 	addi.w	$r6,$r6,-104(0xf98)
1c001c18:	02809c05 	addi.w	$r5,$r0,39(0x27)
1c001c1c:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001c20:	02b56084 	addi.w	$r4,$r4,-680(0xd58)
1c001c24:	57f713ff 	bl	-2288(0xffff710) # 1c001334 <myprintf>
1c001c28:	02804005 	addi.w	$r5,$r0,16(0x10)
1c001c2c:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001c30:	03808184 	ori	$r4,$r12,0x20
1c001c34:	57fb5bff 	bl	-1192(0xffffb58) # 1c00178c <EXTI_ClearITPendingBit>
1c001c38:	03400000 	andi	$r0,$r0,0x0
1c001c3c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001c40:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001c44:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001c48:	4c000020 	jirl	$r0,$r1,0

1c001c4c <exti_gpioa5_irq_handler>:
exti_gpioa5_irq_handler():
1c001c4c:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001c50:	29803061 	st.w	$r1,$r3,12(0xc)
1c001c54:	29802076 	st.w	$r22,$r3,8(0x8)
1c001c58:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001c5c:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001c60:	02bd90c6 	addi.w	$r6,$r6,-156(0xf64)
1c001c64:	0280b005 	addi.w	$r5,$r0,44(0x2c)
1c001c68:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001c6c:	02b43084 	addi.w	$r4,$r4,-756(0xd0c)
1c001c70:	57f6c7ff 	bl	-2364(0xffff6c4) # 1c001334 <myprintf>
1c001c74:	02808005 	addi.w	$r5,$r0,32(0x20)
1c001c78:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001c7c:	03808184 	ori	$r4,$r12,0x20
1c001c80:	57fb0fff 	bl	-1268(0xffffb0c) # 1c00178c <EXTI_ClearITPendingBit>
1c001c84:	03400000 	andi	$r0,$r0,0x0
1c001c88:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001c8c:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001c90:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001c94:	4c000020 	jirl	$r0,$r1,0

1c001c98 <exti_gpioa6_irq_handler>:
exti_gpioa6_irq_handler():
1c001c98:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001c9c:	29803061 	st.w	$r1,$r3,12(0xc)
1c001ca0:	29802076 	st.w	$r22,$r3,8(0x8)
1c001ca4:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001ca8:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001cac:	02bcc0c6 	addi.w	$r6,$r6,-208(0xf30)
1c001cb0:	0280c405 	addi.w	$r5,$r0,49(0x31)
1c001cb4:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001cb8:	02b30084 	addi.w	$r4,$r4,-832(0xcc0)
1c001cbc:	57f67bff 	bl	-2440(0xffff678) # 1c001334 <myprintf>
1c001cc0:	02810005 	addi.w	$r5,$r0,64(0x40)
1c001cc4:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001cc8:	03808184 	ori	$r4,$r12,0x20
1c001ccc:	57fac3ff 	bl	-1344(0xffffac0) # 1c00178c <EXTI_ClearITPendingBit>
1c001cd0:	03400000 	andi	$r0,$r0,0x0
1c001cd4:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001cd8:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001cdc:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001ce0:	4c000020 	jirl	$r0,$r1,0

1c001ce4 <exti_gpioa7_irq_handler>:
exti_gpioa7_irq_handler():
1c001ce4:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001ce8:	29803061 	st.w	$r1,$r3,12(0xc)
1c001cec:	29802076 	st.w	$r22,$r3,8(0x8)
1c001cf0:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001cf4:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001cf8:	02bbf0c6 	addi.w	$r6,$r6,-260(0xefc)
1c001cfc:	0280dc05 	addi.w	$r5,$r0,55(0x37)
1c001d00:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001d04:	02b1d084 	addi.w	$r4,$r4,-908(0xc74)
1c001d08:	57f62fff 	bl	-2516(0xffff62c) # 1c001334 <myprintf>
1c001d0c:	02820005 	addi.w	$r5,$r0,128(0x80)
1c001d10:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001d14:	03808184 	ori	$r4,$r12,0x20
1c001d18:	57fa77ff 	bl	-1420(0xffffa74) # 1c00178c <EXTI_ClearITPendingBit>
1c001d1c:	03400000 	andi	$r0,$r0,0x0
1c001d20:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001d24:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001d28:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001d2c:	4c000020 	jirl	$r0,$r1,0

1c001d30 <exti_gpiob0_irq_handler>:
exti_gpiob0_irq_handler():
1c001d30:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001d34:	29803061 	st.w	$r1,$r3,12(0xc)
1c001d38:	29802076 	st.w	$r22,$r3,8(0x8)
1c001d3c:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001d40:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001d44:	02bb20c6 	addi.w	$r6,$r6,-312(0xec8)
1c001d48:	0280f005 	addi.w	$r5,$r0,60(0x3c)
1c001d4c:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001d50:	02b0a084 	addi.w	$r4,$r4,-984(0xc28)
1c001d54:	57f5e3ff 	bl	-2592(0xffff5e0) # 1c001334 <myprintf>
1c001d58:	02840005 	addi.w	$r5,$r0,256(0x100)
1c001d5c:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001d60:	03808184 	ori	$r4,$r12,0x20
1c001d64:	57fa2bff 	bl	-1496(0xffffa28) # 1c00178c <EXTI_ClearITPendingBit>
1c001d68:	03400000 	andi	$r0,$r0,0x0
1c001d6c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001d70:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001d74:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001d78:	4c000020 	jirl	$r0,$r1,0

1c001d7c <exti_gpiob1_irq_handler>:
exti_gpiob1_irq_handler():
1c001d7c:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001d80:	29803061 	st.w	$r1,$r3,12(0xc)
1c001d84:	29802076 	st.w	$r22,$r3,8(0x8)
1c001d88:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001d8c:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001d90:	02ba50c6 	addi.w	$r6,$r6,-364(0xe94)
1c001d94:	02810805 	addi.w	$r5,$r0,66(0x42)
1c001d98:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001d9c:	02af7084 	addi.w	$r4,$r4,-1060(0xbdc)
1c001da0:	57f597ff 	bl	-2668(0xffff594) # 1c001334 <myprintf>
1c001da4:	02880005 	addi.w	$r5,$r0,512(0x200)
1c001da8:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001dac:	03808184 	ori	$r4,$r12,0x20
1c001db0:	57f9dfff 	bl	-1572(0xffff9dc) # 1c00178c <EXTI_ClearITPendingBit>
1c001db4:	03400000 	andi	$r0,$r0,0x0
1c001db8:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001dbc:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001dc0:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001dc4:	4c000020 	jirl	$r0,$r1,0

1c001dc8 <exti_gpiob2_irq_handler>:
exti_gpiob2_irq_handler():
1c001dc8:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001dcc:	29803061 	st.w	$r1,$r3,12(0xc)
1c001dd0:	29802076 	st.w	$r22,$r3,8(0x8)
1c001dd4:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001dd8:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001ddc:	02b980c6 	addi.w	$r6,$r6,-416(0xe60)
1c001de0:	02812005 	addi.w	$r5,$r0,72(0x48)
1c001de4:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001de8:	02ae4084 	addi.w	$r4,$r4,-1136(0xb90)
1c001dec:	57f54bff 	bl	-2744(0xffff548) # 1c001334 <myprintf>
1c001df0:	02900005 	addi.w	$r5,$r0,1024(0x400)
1c001df4:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001df8:	03808184 	ori	$r4,$r12,0x20
1c001dfc:	57f993ff 	bl	-1648(0xffff990) # 1c00178c <EXTI_ClearITPendingBit>
1c001e00:	03400000 	andi	$r0,$r0,0x0
1c001e04:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001e08:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001e0c:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001e10:	4c000020 	jirl	$r0,$r1,0

1c001e14 <exti_gpiob3_irq_handler>:
exti_gpiob3_irq_handler():
1c001e14:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001e18:	29803061 	st.w	$r1,$r3,12(0xc)
1c001e1c:	29802076 	st.w	$r22,$r3,8(0x8)
1c001e20:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001e24:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001e28:	02b8b0c6 	addi.w	$r6,$r6,-468(0xe2c)
1c001e2c:	02813805 	addi.w	$r5,$r0,78(0x4e)
1c001e30:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001e34:	02ad1084 	addi.w	$r4,$r4,-1212(0xb44)
1c001e38:	57f4ffff 	bl	-2820(0xffff4fc) # 1c001334 <myprintf>
1c001e3c:	03a00005 	ori	$r5,$r0,0x800
1c001e40:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001e44:	03808184 	ori	$r4,$r12,0x20
1c001e48:	57f947ff 	bl	-1724(0xffff944) # 1c00178c <EXTI_ClearITPendingBit>
1c001e4c:	03400000 	andi	$r0,$r0,0x0
1c001e50:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001e54:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001e58:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001e5c:	4c000020 	jirl	$r0,$r1,0

1c001e60 <exti_gpiob4_irq_handler>:
exti_gpiob4_irq_handler():
1c001e60:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001e64:	29803061 	st.w	$r1,$r3,12(0xc)
1c001e68:	29802076 	st.w	$r22,$r3,8(0x8)
1c001e6c:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001e70:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001e74:	02b7e0c6 	addi.w	$r6,$r6,-520(0xdf8)
1c001e78:	02814c05 	addi.w	$r5,$r0,83(0x53)
1c001e7c:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001e80:	02abe084 	addi.w	$r4,$r4,-1288(0xaf8)
1c001e84:	57f4b3ff 	bl	-2896(0xffff4b0) # 1c001334 <myprintf>
1c001e88:	14000025 	lu12i.w	$r5,1(0x1)
1c001e8c:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001e90:	03808184 	ori	$r4,$r12,0x20
1c001e94:	57f8fbff 	bl	-1800(0xffff8f8) # 1c00178c <EXTI_ClearITPendingBit>
1c001e98:	03400000 	andi	$r0,$r0,0x0
1c001e9c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001ea0:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001ea4:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001ea8:	4c000020 	jirl	$r0,$r1,0

1c001eac <exti_gpiob5_irq_handler>:
exti_gpiob5_irq_handler():
1c001eac:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001eb0:	29803061 	st.w	$r1,$r3,12(0xc)
1c001eb4:	29802076 	st.w	$r22,$r3,8(0x8)
1c001eb8:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001ebc:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001ec0:	02b710c6 	addi.w	$r6,$r6,-572(0xdc4)
1c001ec4:	02816005 	addi.w	$r5,$r0,88(0x58)
1c001ec8:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001ecc:	02aab084 	addi.w	$r4,$r4,-1364(0xaac)
1c001ed0:	57f467ff 	bl	-2972(0xffff464) # 1c001334 <myprintf>
1c001ed4:	14000045 	lu12i.w	$r5,2(0x2)
1c001ed8:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001edc:	03808184 	ori	$r4,$r12,0x20
1c001ee0:	57f8afff 	bl	-1876(0xffff8ac) # 1c00178c <EXTI_ClearITPendingBit>
1c001ee4:	03400000 	andi	$r0,$r0,0x0
1c001ee8:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001eec:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001ef0:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001ef4:	4c000020 	jirl	$r0,$r1,0

1c001ef8 <exti_gpiob6_irq_handler>:
exti_gpiob6_irq_handler():
1c001ef8:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001efc:	29803061 	st.w	$r1,$r3,12(0xc)
1c001f00:	29802076 	st.w	$r22,$r3,8(0x8)
1c001f04:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001f08:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001f0c:	02b640c6 	addi.w	$r6,$r6,-624(0xd90)
1c001f10:	02817805 	addi.w	$r5,$r0,94(0x5e)
1c001f14:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001f18:	02a98084 	addi.w	$r4,$r4,-1440(0xa60)
1c001f1c:	57f41bff 	bl	-3048(0xffff418) # 1c001334 <myprintf>
1c001f20:	14000085 	lu12i.w	$r5,4(0x4)
1c001f24:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001f28:	03808184 	ori	$r4,$r12,0x20
1c001f2c:	57f863ff 	bl	-1952(0xffff860) # 1c00178c <EXTI_ClearITPendingBit>
1c001f30:	03400000 	andi	$r0,$r0,0x0
1c001f34:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001f38:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001f3c:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001f40:	4c000020 	jirl	$r0,$r1,0

1c001f44 <exti_gpiob7_irq_handler>:
exti_gpiob7_irq_handler():
1c001f44:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001f48:	29803061 	st.w	$r1,$r3,12(0xc)
1c001f4c:	29802076 	st.w	$r22,$r3,8(0x8)
1c001f50:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001f54:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001f58:	02b570c6 	addi.w	$r6,$r6,-676(0xd5c)
1c001f5c:	02819005 	addi.w	$r5,$r0,100(0x64)
1c001f60:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001f64:	02a85084 	addi.w	$r4,$r4,-1516(0xa14)
1c001f68:	57f3cfff 	bl	-3124(0xffff3cc) # 1c001334 <myprintf>
1c001f6c:	14000105 	lu12i.w	$r5,8(0x8)
1c001f70:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001f74:	03808184 	ori	$r4,$r12,0x20
1c001f78:	57f817ff 	bl	-2028(0xffff814) # 1c00178c <EXTI_ClearITPendingBit>
1c001f7c:	03400000 	andi	$r0,$r0,0x0
1c001f80:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001f84:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001f88:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001f8c:	4c000020 	jirl	$r0,$r1,0

1c001f90 <exti_gpioc0_irq_handler>:
exti_gpioc0_irq_handler():
1c001f90:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001f94:	29803061 	st.w	$r1,$r3,12(0xc)
1c001f98:	29802076 	st.w	$r22,$r3,8(0x8)
1c001f9c:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001fa0:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001fa4:	02b4a0c6 	addi.w	$r6,$r6,-728(0xd28)
1c001fa8:	0281ac05 	addi.w	$r5,$r0,107(0x6b)
1c001fac:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001fb0:	02a72084 	addi.w	$r4,$r4,-1592(0x9c8)
1c001fb4:	57f383ff 	bl	-3200(0xffff380) # 1c001334 <myprintf>
1c001fb8:	14000205 	lu12i.w	$r5,16(0x10)
1c001fbc:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c001fc0:	03808184 	ori	$r4,$r12,0x20
1c001fc4:	57f7cbff 	bl	-2104(0xffff7c8) # 1c00178c <EXTI_ClearITPendingBit>
1c001fc8:	03400000 	andi	$r0,$r0,0x0
1c001fcc:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001fd0:	28802076 	ld.w	$r22,$r3,8(0x8)
1c001fd4:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001fd8:	4c000020 	jirl	$r0,$r1,0

1c001fdc <exti_gpioc1_irq_handler>:
exti_gpioc1_irq_handler():
1c001fdc:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001fe0:	29803061 	st.w	$r1,$r3,12(0xc)
1c001fe4:	29802076 	st.w	$r22,$r3,8(0x8)
1c001fe8:	02804076 	addi.w	$r22,$r3,16(0x10)
1c001fec:	1c000026 	pcaddu12i	$r6,1(0x1)
1c001ff0:	02b3d0c6 	addi.w	$r6,$r6,-780(0xcf4)
1c001ff4:	0281c405 	addi.w	$r5,$r0,113(0x71)
1c001ff8:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001ffc:	02a5f084 	addi.w	$r4,$r4,-1668(0x97c)
1c002000:	57f337ff 	bl	-3276(0xffff334) # 1c001334 <myprintf>
1c002004:	14000405 	lu12i.w	$r5,32(0x20)
1c002008:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c00200c:	03808184 	ori	$r4,$r12,0x20
1c002010:	57f77fff 	bl	-2180(0xffff77c) # 1c00178c <EXTI_ClearITPendingBit>
1c002014:	03400000 	andi	$r0,$r0,0x0
1c002018:	28803061 	ld.w	$r1,$r3,12(0xc)
1c00201c:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002020:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002024:	4c000020 	jirl	$r0,$r1,0

1c002028 <exti_gpioc2_irq_handler>:
exti_gpioc2_irq_handler():
1c002028:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00202c:	29803061 	st.w	$r1,$r3,12(0xc)
1c002030:	29802076 	st.w	$r22,$r3,8(0x8)
1c002034:	02804076 	addi.w	$r22,$r3,16(0x10)
1c002038:	1c000026 	pcaddu12i	$r6,1(0x1)
1c00203c:	02b300c6 	addi.w	$r6,$r6,-832(0xcc0)
1c002040:	0281dc05 	addi.w	$r5,$r0,119(0x77)
1c002044:	1c000024 	pcaddu12i	$r4,1(0x1)
1c002048:	02a4c084 	addi.w	$r4,$r4,-1744(0x930)
1c00204c:	57f2ebff 	bl	-3352(0xffff2e8) # 1c001334 <myprintf>
1c002050:	14000805 	lu12i.w	$r5,64(0x40)
1c002054:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002058:	03808184 	ori	$r4,$r12,0x20
1c00205c:	57f733ff 	bl	-2256(0xffff730) # 1c00178c <EXTI_ClearITPendingBit>
1c002060:	03400000 	andi	$r0,$r0,0x0
1c002064:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002068:	28802076 	ld.w	$r22,$r3,8(0x8)
1c00206c:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002070:	4c000020 	jirl	$r0,$r1,0

1c002074 <exti_gpioc3_irq_handler>:
exti_gpioc3_irq_handler():
1c002074:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002078:	29803061 	st.w	$r1,$r3,12(0xc)
1c00207c:	29802076 	st.w	$r22,$r3,8(0x8)
1c002080:	02804076 	addi.w	$r22,$r3,16(0x10)
1c002084:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002088:	02b230c6 	addi.w	$r6,$r6,-884(0xc8c)
1c00208c:	0281f405 	addi.w	$r5,$r0,125(0x7d)
1c002090:	1c000024 	pcaddu12i	$r4,1(0x1)
1c002094:	02a39084 	addi.w	$r4,$r4,-1820(0x8e4)
1c002098:	57f29fff 	bl	-3428(0xffff29c) # 1c001334 <myprintf>
1c00209c:	14001005 	lu12i.w	$r5,128(0x80)
1c0020a0:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0020a4:	03808184 	ori	$r4,$r12,0x20
1c0020a8:	57f6e7ff 	bl	-2332(0xffff6e4) # 1c00178c <EXTI_ClearITPendingBit>
1c0020ac:	03400000 	andi	$r0,$r0,0x0
1c0020b0:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0020b4:	28802076 	ld.w	$r22,$r3,8(0x8)
1c0020b8:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0020bc:	4c000020 	jirl	$r0,$r1,0

1c0020c0 <exti_gpioc4_irq_handler>:
exti_gpioc4_irq_handler():
1c0020c0:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0020c4:	29803061 	st.w	$r1,$r3,12(0xc)
1c0020c8:	29802076 	st.w	$r22,$r3,8(0x8)
1c0020cc:	02804076 	addi.w	$r22,$r3,16(0x10)
1c0020d0:	1c000026 	pcaddu12i	$r6,1(0x1)
1c0020d4:	02b160c6 	addi.w	$r6,$r6,-936(0xc58)
1c0020d8:	02820c05 	addi.w	$r5,$r0,131(0x83)
1c0020dc:	1c000024 	pcaddu12i	$r4,1(0x1)
1c0020e0:	02a26084 	addi.w	$r4,$r4,-1896(0x898)
1c0020e4:	57f253ff 	bl	-3504(0xffff250) # 1c001334 <myprintf>
1c0020e8:	14002005 	lu12i.w	$r5,256(0x100)
1c0020ec:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0020f0:	03808184 	ori	$r4,$r12,0x20
1c0020f4:	57f69bff 	bl	-2408(0xffff698) # 1c00178c <EXTI_ClearITPendingBit>
1c0020f8:	03400000 	andi	$r0,$r0,0x0
1c0020fc:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002100:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002104:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002108:	4c000020 	jirl	$r0,$r1,0

1c00210c <exti_gpioc5_irq_handler>:
exti_gpioc5_irq_handler():
1c00210c:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002110:	29803061 	st.w	$r1,$r3,12(0xc)
1c002114:	29802076 	st.w	$r22,$r3,8(0x8)
1c002118:	02804076 	addi.w	$r22,$r3,16(0x10)
1c00211c:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002120:	02b090c6 	addi.w	$r6,$r6,-988(0xc24)
1c002124:	02822005 	addi.w	$r5,$r0,136(0x88)
1c002128:	1c000024 	pcaddu12i	$r4,1(0x1)
1c00212c:	02a13084 	addi.w	$r4,$r4,-1972(0x84c)
1c002130:	57f207ff 	bl	-3580(0xffff204) # 1c001334 <myprintf>
1c002134:	14004005 	lu12i.w	$r5,512(0x200)
1c002138:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c00213c:	03808184 	ori	$r4,$r12,0x20
1c002140:	57f64fff 	bl	-2484(0xffff64c) # 1c00178c <EXTI_ClearITPendingBit>
1c002144:	03400000 	andi	$r0,$r0,0x0
1c002148:	28803061 	ld.w	$r1,$r3,12(0xc)
1c00214c:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002150:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002154:	4c000020 	jirl	$r0,$r1,0

1c002158 <exti_gpioc6_irq_handler>:
exti_gpioc6_irq_handler():
1c002158:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00215c:	29803061 	st.w	$r1,$r3,12(0xc)
1c002160:	29802076 	st.w	$r22,$r3,8(0x8)
1c002164:	02804076 	addi.w	$r22,$r3,16(0x10)
1c002168:	1c000026 	pcaddu12i	$r6,1(0x1)
1c00216c:	02afc0c6 	addi.w	$r6,$r6,-1040(0xbf0)
1c002170:	02823405 	addi.w	$r5,$r0,141(0x8d)
1c002174:	1c000024 	pcaddu12i	$r4,1(0x1)
1c002178:	02a00084 	addi.w	$r4,$r4,-2048(0x800)
1c00217c:	57f1bbff 	bl	-3656(0xffff1b8) # 1c001334 <myprintf>
1c002180:	14008005 	lu12i.w	$r5,1024(0x400)
1c002184:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002188:	03808184 	ori	$r4,$r12,0x20
1c00218c:	57f603ff 	bl	-2560(0xffff600) # 1c00178c <EXTI_ClearITPendingBit>
1c002190:	03400000 	andi	$r0,$r0,0x0
1c002194:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002198:	28802076 	ld.w	$r22,$r3,8(0x8)
1c00219c:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0021a0:	4c000020 	jirl	$r0,$r1,0

1c0021a4 <exti_gpioc7_irq_handler>:
exti_gpioc7_irq_handler():
1c0021a4:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0021a8:	29803061 	st.w	$r1,$r3,12(0xc)
1c0021ac:	29802076 	st.w	$r22,$r3,8(0x8)
1c0021b0:	02804076 	addi.w	$r22,$r3,16(0x10)
1c0021b4:	1c000026 	pcaddu12i	$r6,1(0x1)
1c0021b8:	02aef0c6 	addi.w	$r6,$r6,-1092(0xbbc)
1c0021bc:	02824c05 	addi.w	$r5,$r0,147(0x93)
1c0021c0:	1c000004 	pcaddu12i	$r4,0
1c0021c4:	029ed084 	addi.w	$r4,$r4,1972(0x7b4)
1c0021c8:	57f16fff 	bl	-3732(0xffff16c) # 1c001334 <myprintf>
1c0021cc:	14010005 	lu12i.w	$r5,2048(0x800)
1c0021d0:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0021d4:	03808184 	ori	$r4,$r12,0x20
1c0021d8:	57f5b7ff 	bl	-2636(0xffff5b4) # 1c00178c <EXTI_ClearITPendingBit>
1c0021dc:	03400000 	andi	$r0,$r0,0x0
1c0021e0:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0021e4:	28802076 	ld.w	$r22,$r3,8(0x8)
1c0021e8:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0021ec:	4c000020 	jirl	$r0,$r1,0

1c0021f0 <exti_gpiod0_irq_handler>:
exti_gpiod0_irq_handler():
1c0021f0:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0021f4:	29803061 	st.w	$r1,$r3,12(0xc)
1c0021f8:	29802076 	st.w	$r22,$r3,8(0x8)
1c0021fc:	02804076 	addi.w	$r22,$r3,16(0x10)
1c002200:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002204:	02ae20c6 	addi.w	$r6,$r6,-1144(0xb88)
1c002208:	02826405 	addi.w	$r5,$r0,153(0x99)
1c00220c:	1c000004 	pcaddu12i	$r4,0
1c002210:	029da084 	addi.w	$r4,$r4,1896(0x768)
1c002214:	57f123ff 	bl	-3808(0xffff120) # 1c001334 <myprintf>
1c002218:	14020005 	lu12i.w	$r5,4096(0x1000)
1c00221c:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002220:	03808184 	ori	$r4,$r12,0x20
1c002224:	57f56bff 	bl	-2712(0xffff568) # 1c00178c <EXTI_ClearITPendingBit>
1c002228:	03400000 	andi	$r0,$r0,0x0
1c00222c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002230:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002234:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002238:	4c000020 	jirl	$r0,$r1,0

1c00223c <exti_gpiod1_irq_handler>:
exti_gpiod1_irq_handler():
1c00223c:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002240:	29803061 	st.w	$r1,$r3,12(0xc)
1c002244:	29802076 	st.w	$r22,$r3,8(0x8)
1c002248:	02804076 	addi.w	$r22,$r3,16(0x10)
1c00224c:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002250:	02ad50c6 	addi.w	$r6,$r6,-1196(0xb54)
1c002254:	02827c05 	addi.w	$r5,$r0,159(0x9f)
1c002258:	1c000004 	pcaddu12i	$r4,0
1c00225c:	029c7084 	addi.w	$r4,$r4,1820(0x71c)
1c002260:	57f0d7ff 	bl	-3884(0xffff0d4) # 1c001334 <myprintf>
1c002264:	14040005 	lu12i.w	$r5,8192(0x2000)
1c002268:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c00226c:	03808184 	ori	$r4,$r12,0x20
1c002270:	57f51fff 	bl	-2788(0xffff51c) # 1c00178c <EXTI_ClearITPendingBit>
1c002274:	03400000 	andi	$r0,$r0,0x0
1c002278:	28803061 	ld.w	$r1,$r3,12(0xc)
1c00227c:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002280:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002284:	4c000020 	jirl	$r0,$r1,0

1c002288 <exti_gpiod2_irq_handler>:
exti_gpiod2_irq_handler():
1c002288:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00228c:	29803061 	st.w	$r1,$r3,12(0xc)
1c002290:	29802076 	st.w	$r22,$r3,8(0x8)
1c002294:	02804076 	addi.w	$r22,$r3,16(0x10)
1c002298:	1c000026 	pcaddu12i	$r6,1(0x1)
1c00229c:	02ac80c6 	addi.w	$r6,$r6,-1248(0xb20)
1c0022a0:	02829405 	addi.w	$r5,$r0,165(0xa5)
1c0022a4:	1c000004 	pcaddu12i	$r4,0
1c0022a8:	029b4084 	addi.w	$r4,$r4,1744(0x6d0)
1c0022ac:	57f08bff 	bl	-3960(0xffff088) # 1c001334 <myprintf>
1c0022b0:	14080005 	lu12i.w	$r5,16384(0x4000)
1c0022b4:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0022b8:	03808184 	ori	$r4,$r12,0x20
1c0022bc:	57f4d3ff 	bl	-2864(0xffff4d0) # 1c00178c <EXTI_ClearITPendingBit>
1c0022c0:	03400000 	andi	$r0,$r0,0x0
1c0022c4:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0022c8:	28802076 	ld.w	$r22,$r3,8(0x8)
1c0022cc:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0022d0:	4c000020 	jirl	$r0,$r1,0

1c0022d4 <exti_gpiod3_irq_handler>:
exti_gpiod3_irq_handler():
1c0022d4:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0022d8:	29803061 	st.w	$r1,$r3,12(0xc)
1c0022dc:	29802076 	st.w	$r22,$r3,8(0x8)
1c0022e0:	02804076 	addi.w	$r22,$r3,16(0x10)
1c0022e4:	1c000026 	pcaddu12i	$r6,1(0x1)
1c0022e8:	02abb0c6 	addi.w	$r6,$r6,-1300(0xaec)
1c0022ec:	0282ac05 	addi.w	$r5,$r0,171(0xab)
1c0022f0:	1c000004 	pcaddu12i	$r4,0
1c0022f4:	029a1084 	addi.w	$r4,$r4,1668(0x684)
1c0022f8:	57f03fff 	bl	-4036(0xffff03c) # 1c001334 <myprintf>
1c0022fc:	14100005 	lu12i.w	$r5,32768(0x8000)
1c002300:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002304:	03808184 	ori	$r4,$r12,0x20
1c002308:	57f487ff 	bl	-2940(0xffff484) # 1c00178c <EXTI_ClearITPendingBit>
1c00230c:	03400000 	andi	$r0,$r0,0x0
1c002310:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002314:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002318:	02804063 	addi.w	$r3,$r3,16(0x10)
1c00231c:	4c000020 	jirl	$r0,$r1,0

1c002320 <exti_gpiod4_irq_handler>:
exti_gpiod4_irq_handler():
1c002320:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002324:	29803061 	st.w	$r1,$r3,12(0xc)
1c002328:	29802076 	st.w	$r22,$r3,8(0x8)
1c00232c:	02804076 	addi.w	$r22,$r3,16(0x10)
1c002330:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002334:	02aae0c6 	addi.w	$r6,$r6,-1352(0xab8)
1c002338:	0282c405 	addi.w	$r5,$r0,177(0xb1)
1c00233c:	1c000004 	pcaddu12i	$r4,0
1c002340:	0298e084 	addi.w	$r4,$r4,1592(0x638)
1c002344:	57eff3ff 	bl	-4112(0xfffeff0) # 1c001334 <myprintf>
1c002348:	14200005 	lu12i.w	$r5,65536(0x10000)
1c00234c:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002350:	03808184 	ori	$r4,$r12,0x20
1c002354:	57f43bff 	bl	-3016(0xffff438) # 1c00178c <EXTI_ClearITPendingBit>
1c002358:	03400000 	andi	$r0,$r0,0x0
1c00235c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002360:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002364:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002368:	4c000020 	jirl	$r0,$r1,0

1c00236c <exti_gpiod5_irq_handler>:
exti_gpiod5_irq_handler():
1c00236c:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002370:	29803061 	st.w	$r1,$r3,12(0xc)
1c002374:	29802076 	st.w	$r22,$r3,8(0x8)
1c002378:	02804076 	addi.w	$r22,$r3,16(0x10)
1c00237c:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002380:	02aa10c6 	addi.w	$r6,$r6,-1404(0xa84)
1c002384:	0282e005 	addi.w	$r5,$r0,184(0xb8)
1c002388:	1c000004 	pcaddu12i	$r4,0
1c00238c:	0297b084 	addi.w	$r4,$r4,1516(0x5ec)
1c002390:	57efa7ff 	bl	-4188(0xfffefa4) # 1c001334 <myprintf>
1c002394:	14400005 	lu12i.w	$r5,131072(0x20000)
1c002398:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c00239c:	03808184 	ori	$r4,$r12,0x20
1c0023a0:	57f3efff 	bl	-3092(0xffff3ec) # 1c00178c <EXTI_ClearITPendingBit>
1c0023a4:	03400000 	andi	$r0,$r0,0x0
1c0023a8:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0023ac:	28802076 	ld.w	$r22,$r3,8(0x8)
1c0023b0:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0023b4:	4c000020 	jirl	$r0,$r1,0

1c0023b8 <exti_gpiod6_irq_handler>:
exti_gpiod6_irq_handler():
1c0023b8:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0023bc:	29803061 	st.w	$r1,$r3,12(0xc)
1c0023c0:	29802076 	st.w	$r22,$r3,8(0x8)
1c0023c4:	02804076 	addi.w	$r22,$r3,16(0x10)
1c0023c8:	1c000026 	pcaddu12i	$r6,1(0x1)
1c0023cc:	02a940c6 	addi.w	$r6,$r6,-1456(0xa50)
1c0023d0:	0282f805 	addi.w	$r5,$r0,190(0xbe)
1c0023d4:	1c000004 	pcaddu12i	$r4,0
1c0023d8:	02968084 	addi.w	$r4,$r4,1440(0x5a0)
1c0023dc:	57ef5bff 	bl	-4264(0xfffef58) # 1c001334 <myprintf>
1c0023e0:	14800005 	lu12i.w	$r5,262144(0x40000)
1c0023e4:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0023e8:	03808184 	ori	$r4,$r12,0x20
1c0023ec:	57f3a3ff 	bl	-3168(0xffff3a0) # 1c00178c <EXTI_ClearITPendingBit>
1c0023f0:	03400000 	andi	$r0,$r0,0x0
1c0023f4:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0023f8:	28802076 	ld.w	$r22,$r3,8(0x8)
1c0023fc:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002400:	4c000020 	jirl	$r0,$r1,0

1c002404 <exti_gpiod7_irq_handler>:
exti_gpiod7_irq_handler():
1c002404:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002408:	29803061 	st.w	$r1,$r3,12(0xc)
1c00240c:	29802076 	st.w	$r22,$r3,8(0x8)
1c002410:	02804076 	addi.w	$r22,$r3,16(0x10)
1c002414:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002418:	02a870c6 	addi.w	$r6,$r6,-1508(0xa1c)
1c00241c:	02831005 	addi.w	$r5,$r0,196(0xc4)
1c002420:	1c000004 	pcaddu12i	$r4,0
1c002424:	02955084 	addi.w	$r4,$r4,1364(0x554)
1c002428:	57ef0fff 	bl	-4340(0xfffef0c) # 1c001334 <myprintf>
1c00242c:	15000005 	lu12i.w	$r5,-524288(0x80000)
1c002430:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002434:	03808184 	ori	$r4,$r12,0x20
1c002438:	57f357ff 	bl	-3244(0xffff354) # 1c00178c <EXTI_ClearITPendingBit>
1c00243c:	03400000 	andi	$r0,$r0,0x0
1c002440:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002444:	28802076 	ld.w	$r22,$r3,8(0x8)
1c002448:	02804063 	addi.w	$r3,$r3,16(0x10)
1c00244c:	4c000020 	jirl	$r0,$r1,0

1c002450 <ext_handler>:
ext_handler():
1c002450:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c002454:	29807061 	st.w	$r1,$r3,28(0x1c)
1c002458:	29806076 	st.w	$r22,$r3,24(0x18)
1c00245c:	02808076 	addi.w	$r22,$r3,32(0x20)
1c002460:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002464:	0380f18c 	ori	$r12,$r12,0x3c
1c002468:	1402000d 	lu12i.w	$r13,4096(0x1000)
1c00246c:	2980018d 	st.w	$r13,$r12,0
1c002470:	1c000026 	pcaddu12i	$r6,1(0x1)
1c002474:	02a760c6 	addi.w	$r6,$r6,-1576(0x9d8)
1c002478:	0283c005 	addi.w	$r5,$r0,240(0xf0)
1c00247c:	1c000004 	pcaddu12i	$r4,0
1c002480:	0293e084 	addi.w	$r4,$r4,1272(0x4f8)
1c002484:	57eeb3ff 	bl	-4432(0xfffeeb0) # 1c001334 <myprintf>
1c002488:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c00248c:	0380818c 	ori	$r12,$r12,0x20
1c002490:	2880318c 	ld.w	$r12,$r12,12(0xc)
1c002494:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c002498:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c00249c:	0380818c 	ori	$r12,$r12,0x20
1c0024a0:	2880018c 	ld.w	$r12,$r12,0
1c0024a4:	29bf92cc 	st.w	$r12,$r22,-28(0xfe4)
1c0024a8:	28bfa2cd 	ld.w	$r13,$r22,-24(0xfe8)
1c0024ac:	28bf92cc 	ld.w	$r12,$r22,-28(0xfe4)
1c0024b0:	0014b1ac 	and	$r12,$r13,$r12
1c0024b4:	29bfa2cc 	st.w	$r12,$r22,-24(0xfe8)
1c0024b8:	03400000 	andi	$r0,$r0,0x0
1c0024bc:	29bfb2c0 	st.w	$r0,$r22,-20(0xfec)
1c0024c0:	50004000 	b	64(0x40) # 1c002500 <ext_handler+0xb0>
1c0024c4:	28bfa2cd 	ld.w	$r13,$r22,-24(0xfe8)
1c0024c8:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0024cc:	0017b1ac 	srl.w	$r12,$r13,$r12
1c0024d0:	0340058c 	andi	$r12,$r12,0x1
1c0024d4:	40002180 	beqz	$r12,32(0x20) # 1c0024f4 <ext_handler+0xa4>
1c0024d8:	1c00000d 	pcaddu12i	$r13,0
1c0024dc:	0296b1ad 	addi.w	$r13,$r13,1452(0x5ac)
1c0024e0:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0024e4:	0040898c 	slli.w	$r12,$r12,0x2
1c0024e8:	001031ac 	add.w	$r12,$r13,$r12
1c0024ec:	2880018c 	ld.w	$r12,$r12,0
1c0024f0:	4c000181 	jirl	$r1,$r12,0
1c0024f4:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c0024f8:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0024fc:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c002500:	28bfb2cd 	ld.w	$r13,$r22,-20(0xfec)
1c002504:	02807c0c 	addi.w	$r12,$r0,31(0x1f)
1c002508:	6fffbd8d 	bgeu	$r12,$r13,-68(0x3ffbc) # 1c0024c4 <ext_handler+0x74>
1c00250c:	03400000 	andi	$r0,$r0,0x0
1c002510:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c002514:	28806076 	ld.w	$r22,$r3,24(0x18)
1c002518:	02808063 	addi.w	$r3,$r3,32(0x20)
1c00251c:	4c000020 	jirl	$r0,$r1,0

1c002520 <TIMER_WAKE_INT>:
TIMER_WAKE_INT():
1c002520:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c002524:	29807061 	st.w	$r1,$r3,28(0x1c)
1c002528:	29806076 	st.w	$r22,$r3,24(0x18)
1c00252c:	02808076 	addi.w	$r22,$r3,32(0x20)
1c002530:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002534:	0380f18c 	ori	$r12,$r12,0x3c
1c002538:	1400020d 	lu12i.w	$r13,16(0x10)
1c00253c:	2980018d 	st.w	$r13,$r12,0
1c002540:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002544:	0380118c 	ori	$r12,$r12,0x4
1c002548:	2880018c 	ld.w	$r12,$r12,0
1c00254c:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c002550:	57f27bff 	bl	-3464(0xffff278) # 1c0017c8 <WDG_DogFeed>
1c002554:	03400000 	andi	$r0,$r0,0x0
1c002558:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c00255c:	28806076 	ld.w	$r22,$r3,24(0x18)
1c002560:	02808063 	addi.w	$r3,$r3,32(0x20)
1c002564:	4c000020 	jirl	$r0,$r1,0

1c002568 <TOUCH>:
TOUCH():
1c002568:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c00256c:	29807061 	st.w	$r1,$r3,28(0x1c)
1c002570:	29806076 	st.w	$r22,$r3,24(0x18)
1c002574:	02808076 	addi.w	$r22,$r3,32(0x20)
1c002578:	157fd68c 	lu12i.w	$r12,-262476(0xbfeb4)
1c00257c:	0380118c 	ori	$r12,$r12,0x4
1c002580:	2880018c 	ld.w	$r12,$r12,0
1c002584:	0044c18c 	srli.w	$r12,$r12,0x10
1c002588:	006f818c 	bstrpick.w	$r12,$r12,0xf,0x0
1c00258c:	037ffd8c 	andi	$r12,$r12,0xfff
1c002590:	297fbacc 	st.h	$r12,$r22,-18(0xfee)
1c002594:	157fd68c 	lu12i.w	$r12,-262476(0xbfeb4)
1c002598:	0380118c 	ori	$r12,$r12,0x4
1c00259c:	2880018c 	ld.w	$r12,$r12,0
1c0025a0:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0025a4:	03403d8c 	andi	$r12,$r12,0xf
1c0025a8:	293fb6cc 	st.b	$r12,$r22,-19(0xfed)
1c0025ac:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0025b0:	0380f18c 	ori	$r12,$r12,0x3c
1c0025b4:	1400040d 	lu12i.w	$r13,32(0x20)
1c0025b8:	2980018d 	st.w	$r13,$r12,0
1c0025bc:	157fd68c 	lu12i.w	$r12,-262476(0xbfeb4)
1c0025c0:	0380118c 	ori	$r12,$r12,0x4
1c0025c4:	02803c0d 	addi.w	$r13,$r0,15(0xf)
1c0025c8:	2980018d 	st.w	$r13,$r12,0
1c0025cc:	2a7fbacc 	ld.hu	$r12,$r22,-18(0xfee)
1c0025d0:	00150185 	move	$r5,$r12
1c0025d4:	1c000004 	pcaddu12i	$r4,0
1c0025d8:	028fa084 	addi.w	$r4,$r4,1000(0x3e8)
1c0025dc:	57ed5bff 	bl	-4776(0xfffed58) # 1c001334 <myprintf>
1c0025e0:	03400000 	andi	$r0,$r0,0x0
1c0025e4:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c0025e8:	28806076 	ld.w	$r22,$r3,24(0x18)
1c0025ec:	02808063 	addi.w	$r3,$r3,32(0x20)
1c0025f0:	4c000020 	jirl	$r0,$r1,0

1c0025f4 <UART2_INT>:
UART2_INT():
1c0025f4:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c0025f8:	29807076 	st.w	$r22,$r3,28(0x1c)
1c0025fc:	02808076 	addi.w	$r22,$r3,32(0x20)
1c002600:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002604:	0380f18c 	ori	$r12,$r12,0x3c
1c002608:	1400080d 	lu12i.w	$r13,64(0x40)
1c00260c:	2980018d 	st.w	$r13,$r12,0
1c002610:	157fd18c 	lu12i.w	$r12,-262516(0xbfe8c)
1c002614:	0380098c 	ori	$r12,$r12,0x2
1c002618:	2a00018c 	ld.bu	$r12,$r12,0
1c00261c:	293fbecc 	st.b	$r12,$r22,-17(0xfef)
1c002620:	03400000 	andi	$r0,$r0,0x0
1c002624:	28807076 	ld.w	$r22,$r3,28(0x1c)
1c002628:	02808063 	addi.w	$r3,$r3,32(0x20)
1c00262c:	4c000020 	jirl	$r0,$r1,0

1c002630 <BAT_FAIL>:
BAT_FAIL():
1c002630:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c002634:	29807061 	st.w	$r1,$r3,28(0x1c)
1c002638:	29806076 	st.w	$r22,$r3,24(0x18)
1c00263c:	02808076 	addi.w	$r22,$r3,32(0x20)
1c002640:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002644:	0380118c 	ori	$r12,$r12,0x4
1c002648:	2880018c 	ld.w	$r12,$r12,0
1c00264c:	0044cd8c 	srli.w	$r12,$r12,0x13
1c002650:	03407d8c 	andi	$r12,$r12,0x1f
1c002654:	29bfb2cc 	st.w	$r12,$r22,-20(0xfec)
1c002658:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c00265c:	0380118c 	ori	$r12,$r12,0x4
1c002660:	2880018e 	ld.w	$r14,$r12,0
1c002664:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c002668:	0380f18c 	ori	$r12,$r12,0x3c
1c00266c:	1401f00d 	lu12i.w	$r13,3968(0xf80)
1c002670:	0014b5cd 	and	$r13,$r14,$r13
1c002674:	2980018d 	st.w	$r13,$r12,0
1c002678:	28bfb2cd 	ld.w	$r13,$r22,-20(0xfec)
1c00267c:	0280400c 	addi.w	$r12,$r0,16(0x10)
1c002680:	6800718d 	bltu	$r12,$r13,112(0x70) # 1c0026f0 <BAT_FAIL+0xc0>
1c002684:	28bfb2cc 	ld.w	$r12,$r22,-20(0xfec)
1c002688:	0040898d 	slli.w	$r13,$r12,0x2
1c00268c:	1c00000c 	pcaddu12i	$r12,0
1c002690:	0291e18c 	addi.w	$r12,$r12,1144(0x478)
1c002694:	001031ac 	add.w	$r12,$r13,$r12
1c002698:	2880018c 	ld.w	$r12,$r12,0
1c00269c:	4c000180 	jirl	$r0,$r12,0
1c0026a0:	1c000004 	pcaddu12i	$r4,0
1c0026a4:	028cf084 	addi.w	$r4,$r4,828(0x33c)
1c0026a8:	57ec8fff 	bl	-4980(0xfffec8c) # 1c001334 <myprintf>
1c0026ac:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0026b0:	0380118c 	ori	$r12,$r12,0x4
1c0026b4:	29800180 	st.w	$r0,$r12,0
1c0026b8:	50003c00 	b	60(0x3c) # 1c0026f4 <BAT_FAIL+0xc4>
1c0026bc:	1c000004 	pcaddu12i	$r4,0
1c0026c0:	028d2084 	addi.w	$r4,$r4,840(0x348)
1c0026c4:	57ec73ff 	bl	-5008(0xfffec70) # 1c001334 <myprintf>
1c0026c8:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0026cc:	0380118c 	ori	$r12,$r12,0x4
1c0026d0:	2880018e 	ld.w	$r14,$r12,0
1c0026d4:	157fd60c 	lu12i.w	$r12,-262480(0xbfeb0)
1c0026d8:	0380118c 	ori	$r12,$r12,0x4
1c0026dc:	15fffeed 	lu12i.w	$r13,-9(0xffff7)
1c0026e0:	03bffdad 	ori	$r13,$r13,0xfff
1c0026e4:	0014b5cd 	and	$r13,$r14,$r13
1c0026e8:	2980018d 	st.w	$r13,$r12,0
1c0026ec:	50000800 	b	8(0x8) # 1c0026f4 <BAT_FAIL+0xc4>
1c0026f0:	03400000 	andi	$r0,$r0,0x0
1c0026f4:	03400000 	andi	$r0,$r0,0x0
1c0026f8:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c0026fc:	28806076 	ld.w	$r22,$r3,24(0x18)
1c002700:	02808063 	addi.w	$r3,$r3,32(0x20)
1c002704:	4c000020 	jirl	$r0,$r1,0

1c002708 <intc_handler>:
intc_handler():
1c002708:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c00270c:	29807061 	st.w	$r1,$r3,28(0x1c)
1c002710:	29806076 	st.w	$r22,$r3,24(0x18)
1c002714:	02808076 	addi.w	$r22,$r3,32(0x20)
1c002718:	157fd40c 	lu12i.w	$r12,-262496(0xbfea0)
1c00271c:	0380158c 	ori	$r12,$r12,0x5
1c002720:	2a00018c 	ld.bu	$r12,$r12,0
1c002724:	293fbecc 	st.b	$r12,$r22,-17(0xfef)
1c002728:	2a3fbecc 	ld.bu	$r12,$r22,-17(0xfef)
1c00272c:	0340058c 	andi	$r12,$r12,0x1
1c002730:	40002980 	beqz	$r12,40(0x28) # 1c002758 <intc_handler+0x50>
1c002734:	02840004 	addi.w	$r4,$r0,256(0x100)
1c002738:	57f0bfff 	bl	-3908(0xffff0bc) # 1c0017f4 <TIM_GetITStatus>
1c00273c:	0015008c 	move	$r12,$r4
1c002740:	40001980 	beqz	$r12,24(0x18) # 1c002758 <intc_handler+0x50>
1c002744:	02840004 	addi.w	$r4,$r0,256(0x100)
1c002748:	57f0fbff 	bl	-3848(0xffff0f8) # 1c001840 <TIM_ClearIT>
1c00274c:	1c000004 	pcaddu12i	$r4,0
1c002750:	028b7084 	addi.w	$r4,$r4,732(0x2dc)
1c002754:	57ebe3ff 	bl	-5152(0xfffebe0) # 1c001334 <myprintf>
1c002758:	2a3fbecc 	ld.bu	$r12,$r22,-17(0xfef)
1c00275c:	0340118c 	andi	$r12,$r12,0x4
1c002760:	40003580 	beqz	$r12,52(0x34) # 1c002794 <intc_handler+0x8c>
1c002764:	157fd10c 	lu12i.w	$r12,-262520(0xbfe88)
1c002768:	2a00018c 	ld.bu	$r12,$r12,0
1c00276c:	293fbacc 	st.b	$r12,$r22,-18(0xfee)
1c002770:	2a3fbacc 	ld.bu	$r12,$r22,-18(0xfee)
1c002774:	00150185 	move	$r5,$r12
1c002778:	1c000004 	pcaddu12i	$r4,0
1c00277c:	028b6084 	addi.w	$r4,$r4,728(0x2d8)
1c002780:	57ebb7ff 	bl	-5196(0xfffebb4) # 1c001334 <myprintf>
1c002784:	157fd40c 	lu12i.w	$r12,-262496(0xbfea0)
1c002788:	03800d8c 	ori	$r12,$r12,0x3
1c00278c:	0280100d 	addi.w	$r13,$r0,4(0x4)
1c002790:	2900018d 	st.b	$r13,$r12,0
1c002794:	2a3fbecc 	ld.bu	$r12,$r22,-17(0xfef)
1c002798:	0340218c 	andi	$r12,$r12,0x8
1c00279c:	40002d80 	beqz	$r12,44(0x2c) # 1c0027c8 <intc_handler+0xc0>
1c0027a0:	157fd00c 	lu12i.w	$r12,-262528(0xbfe80)
1c0027a4:	2a00018c 	ld.bu	$r12,$r12,0
1c0027a8:	293fb6cc 	st.b	$r12,$r22,-19(0xfed)
1c0027ac:	2a3fb6cc 	ld.bu	$r12,$r22,-19(0xfed)
1c0027b0:	00150184 	move	$r4,$r12
1c0027b4:	57f0ebff 	bl	-3864(0xffff0e8) # 1c00189c <recv_dat_int>
1c0027b8:	157fd40c 	lu12i.w	$r12,-262496(0xbfea0)
1c0027bc:	03800d8c 	ori	$r12,$r12,0x3
1c0027c0:	0280200d 	addi.w	$r13,$r0,8(0x8)
1c0027c4:	2900018d 	st.b	$r13,$r12,0
1c0027c8:	157fd40c 	lu12i.w	$r12,-262496(0xbfea0)
1c0027cc:	03800d8c 	ori	$r12,$r12,0x3
1c0027d0:	02bffc0d 	addi.w	$r13,$r0,-1(0xfff)
1c0027d4:	2900018d 	st.b	$r13,$r12,0
1c0027d8:	03400000 	andi	$r0,$r0,0x0
1c0027dc:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c0027e0:	28806076 	ld.w	$r22,$r3,24(0x18)
1c0027e4:	02808063 	addi.w	$r3,$r3,32(0x20)
1c0027e8:	4c000020 	jirl	$r0,$r1,0

1c0027ec <TIMER_HANDLER>:
TIMER_HANDLER():
1c0027ec:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0027f0:	29803061 	st.w	$r1,$r3,12(0xc)
1c0027f4:	29802076 	st.w	$r22,$r3,8(0x8)
1c0027f8:	02804076 	addi.w	$r22,$r3,16(0x10)
1c0027fc:	57ef6fff 	bl	-4244(0xfffef6c) # 1c001768 <Set_Timer_clear>
1c002800:	1c000004 	pcaddu12i	$r4,0
1c002804:	02899084 	addi.w	$r4,$r4,612(0x264)
1c002808:	57eb2fff 	bl	-5332(0xfffeb2c) # 1c001334 <myprintf>
1c00280c:	57ef3fff 	bl	-4292(0xfffef3c) # 1c001748 <Set_Timer_stop>
1c002810:	03400000 	andi	$r0,$r0,0x0
1c002814:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002818:	28802076 	ld.w	$r22,$r3,8(0x8)
1c00281c:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002820:	4c000020 	jirl	$r0,$r1,0

Disassembly of section .rodata:

1c002824 <Ext_IrqHandle-0x260>:
1c002824:	1c001554 	pcaddu12i	$r20,170(0xaa)
1c002828:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00282c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002830:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002834:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002838:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00283c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002840:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002844:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002848:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00284c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002850:	1c00156c 	pcaddu12i	$r12,171(0xab)
1c002854:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c002858:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c00285c:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c002860:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c002864:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c002868:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c00286c:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c002870:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c002874:	1c0015f4 	pcaddu12i	$r20,175(0xaf)
1c002878:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00287c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002880:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002884:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002888:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00288c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002890:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002894:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002898:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00289c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028a0:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028a4:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028a8:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028ac:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028b0:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028b4:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028b8:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028bc:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028c0:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028c4:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028c8:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028cc:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028d0:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028d4:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028d8:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028dc:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028e0:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028e4:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028e8:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028ec:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028f0:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028f4:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028f8:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c0028fc:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002900:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002904:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002908:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00290c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002910:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002914:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002918:	1c0014e4 	pcaddu12i	$r4,167(0xa7)
1c00291c:	1c00140c 	pcaddu12i	$r12,160(0xa0)
1c002920:	1c001474 	pcaddu12i	$r20,163(0xa3)
1c002924:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002928:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00292c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002930:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002934:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002938:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00293c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002940:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002944:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002948:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00294c:	1c0014ac 	pcaddu12i	$r12,165(0xa5)
1c002950:	1c00151c 	pcaddu12i	$r28,168(0xa8)
1c002954:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002958:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00295c:	1c0013e0 	pcaddu12i	$r0,159(0x9f)
1c002960:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002964:	1c00143c 	pcaddu12i	$r28,161(0xa1)
1c002968:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c00296c:	1c001670 	pcaddu12i	$r16,179(0xb3)
1c002970:	1c00151c 	pcaddu12i	$r28,168(0xa8)
1c002974:	3c200a0d 	0x3c200a0d
1c002978:	696c2020 	bltu	$r1,$r0,93216(0x16c20) # 1c019598 <_sidata+0x16744>
1c00297c:	203a656e 	ll.w	$r14,$r11,14948(0x3a64)
1c002980:	66206425 	bge	$r1,$r5,-122780(0x22064) # 1bfe49e4 <_start-0x1b61c>
1c002984:	3a636e75 	0x3a636e75
1c002988:	20207325 	ll.w	$r5,$r25,8304(0x2070)
1c00298c:	0a0d3e20 	0x0a0d3e20
1c002990:	00000000 	0x00000000
1c002994:	2e2e2e0a 	0x2e2e2e0a
1c002998:	2e2e2e2e 	0x2e2e2e2e
1c00299c:	2e2e2e2e 	0x2e2e2e2e
1c0029a0:	4f532e2e 	jirl	$r14,$r17,-44244(0x3532c)
1c0029a4:	495f5446 	bceqz	$fcc2,1662804(0x195f54) # 1c1988f8 <_sidata+0x195aa4>
1c0029a8:	2e2e544e 	0x2e2e544e
1c0029ac:	2e2e2e2e 	0x2e2e2e2e
1c0029b0:	2e2e2e2e 	0x2e2e2e2e
1c0029b4:	2e2e2e2e 	0x2e2e2e2e
1c0029b8:	00000d0a 	0x00000d0a
1c0029bc:	2d2d2d0a 	0x2d2d2d0a
1c0029c0:	63756f74 	blt	$r27,$r20,-35476(0x3756c) # 1bff9f2c <_start-0x60d4>
1c0029c4:	746e4968 	0x746e4968
1c0029c8:	79654b3a 	0x79654b3a
1c0029cc:	6e616843 	bgeu	$r2,$r3,-106136(0x26168) # 1bfe8b34 <_start-0x174cc>
1c0029d0:	3a6c656e 	0x3a6c656e
1c0029d4:	78257830 	0x78257830
1c0029d8:	0000000a 	0x0000000a
1c0029dc:	2e2e2e0a 	0x2e2e2e0a
1c0029e0:	2e2e2e2e 	0x2e2e2e2e
1c0029e4:	2e2e2e2e 	0x2e2e2e2e
1c0029e8:	41422e2e 	beqz	$r17,3752492(0x39422c) # 1c396c14 <_sidata+0x393dc0>
1c0029ec:	41465f54 	beqz	$r26,-3062180(0x51465c) # 1bd17048 <_start-0x2e8fb8>
1c0029f0:	2e2e4c49 	0x2e2e4c49
1c0029f4:	2e2e2e2e 	0x2e2e2e2e
1c0029f8:	2e2e2e2e 	0x2e2e2e2e
1c0029fc:	2e2e2e2e 	0x2e2e2e2e
1c002a00:	00000d0a 	0x00000d0a
1c002a04:	2e2e2e0a 	0x2e2e2e0a
1c002a08:	2e2e2e2e 	0x2e2e2e2e
1c002a0c:	2e2e2e2e 	0x2e2e2e2e
1c002a10:	44412e2e 	bnez	$r17,3686700(0x38412c) # 1c386b3c <_sidata+0x383ce8>
1c002a14:	2e2e2e43 	0x2e2e2e43
1c002a18:	2e2e2e2e 	0x2e2e2e2e
1c002a1c:	2e2e2e2e 	0x2e2e2e2e
1c002a20:	0a2e2e2e 	xvfmadd.d	$xr14,$xr17,$xr11,$xr28
1c002a24:	0000000d 	0x0000000d
1c002a28:	69726550 	bltu	$r10,$r16,94820(0x17264) # 1c019c8c <_sidata+0x16e38>
1c002a2c:	72656870 	0x72656870
1c002a30:	20736c61 	ll.w	$r1,$r3,29548(0x736c)
1c002a34:	656d6954 	bge	$r10,$r20,93544(0x16d68) # 1c01979c <_sidata+0x16948>
1c002a38:	6c632072 	bgeu	$r3,$r18,25376(0x6320) # 1c008d58 <_sidata+0x5f04>
1c002a3c:	20726165 	ll.w	$r5,$r11,29280(0x7260)
1c002a40:	65746e69 	bge	$r19,$r9,95340(0x1746c) # 1c019eac <_sidata+0x17058>
1c002a44:	70757272 	vmax.wu	$vr18,$vr19,$vr28
1c002a48:	0a2e2e74 	xvfmadd.d	$xr20,$xr19,$xr11,$xr28
1c002a4c:	00000000 	0x00000000
1c002a50:	74726175 	xvmin.b	$xr21,$xr11,$xr24
1c002a54:	65722031 	bge	$r1,$r17,94752(0x17220) # 1c019c74 <_sidata+0x16e20>
1c002a58:	303a7663 	0x303a7663
1c002a5c:	0a782578 	0x0a782578
1c002a60:	00000000 	0x00000000
1c002a64:	65726f43 	bge	$r26,$r3,94828(0x1726c) # 1c019cd0 <_sidata+0x16e7c>
1c002a68:	6d695420 	bgeu	$r1,$r0,92500(0x16954) # 1c0193bc <_sidata+0x16568>
1c002a6c:	63207265 	blt	$r19,$r5,-57232(0x32070) # 1bff4adc <_start-0xb524>
1c002a70:	7261656c 	0x7261656c
1c002a74:	746e6920 	0x746e6920
1c002a78:	75727265 	0x75727265
1c002a7c:	2e2e7470 	0x2e2e7470
1c002a80:	0000000a 	0x0000000a

1c002a84 <Ext_IrqHandle>:
1c002a84:	1c001ad0 	pcaddu12i	$r16,214(0xd6)
1c002a88:	1c001b1c 	pcaddu12i	$r28,216(0xd8)
1c002a8c:	1c001b68 	pcaddu12i	$r8,219(0xdb)
1c002a90:	1c001bb4 	pcaddu12i	$r20,221(0xdd)
1c002a94:	1c001c00 	pcaddu12i	$r0,224(0xe0)
1c002a98:	1c001c4c 	pcaddu12i	$r12,226(0xe2)
1c002a9c:	1c001c98 	pcaddu12i	$r24,228(0xe4)
1c002aa0:	1c001ce4 	pcaddu12i	$r4,231(0xe7)
1c002aa4:	1c001d30 	pcaddu12i	$r16,233(0xe9)
1c002aa8:	1c001d7c 	pcaddu12i	$r28,235(0xeb)
1c002aac:	1c001dc8 	pcaddu12i	$r8,238(0xee)
1c002ab0:	1c001e14 	pcaddu12i	$r20,240(0xf0)
1c002ab4:	1c001e60 	pcaddu12i	$r0,243(0xf3)
1c002ab8:	1c001eac 	pcaddu12i	$r12,245(0xf5)
1c002abc:	1c001ef8 	pcaddu12i	$r24,247(0xf7)
1c002ac0:	1c001f44 	pcaddu12i	$r4,250(0xfa)
1c002ac4:	1c001f90 	pcaddu12i	$r16,252(0xfc)
1c002ac8:	1c001fdc 	pcaddu12i	$r28,254(0xfe)
1c002acc:	1c002028 	pcaddu12i	$r8,257(0x101)
1c002ad0:	1c002074 	pcaddu12i	$r20,259(0x103)
1c002ad4:	1c0020c0 	pcaddu12i	$r0,262(0x106)
1c002ad8:	1c00210c 	pcaddu12i	$r12,264(0x108)
1c002adc:	1c002158 	pcaddu12i	$r24,266(0x10a)
1c002ae0:	1c0021a4 	pcaddu12i	$r4,269(0x10d)
1c002ae4:	1c0021f0 	pcaddu12i	$r16,271(0x10f)
1c002ae8:	1c00223c 	pcaddu12i	$r28,273(0x111)
1c002aec:	1c002288 	pcaddu12i	$r8,276(0x114)
1c002af0:	1c0022d4 	pcaddu12i	$r20,278(0x116)
1c002af4:	1c002320 	pcaddu12i	$r0,281(0x119)
1c002af8:	1c00236c 	pcaddu12i	$r12,283(0x11b)
1c002afc:	1c0023b8 	pcaddu12i	$r24,285(0x11d)
1c002b00:	1c002404 	pcaddu12i	$r4,288(0x120)
1c002b04:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b08:	1c0026a0 	pcaddu12i	$r0,309(0x135)
1c002b0c:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b10:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b14:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b18:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b1c:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b20:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b24:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b28:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b2c:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b30:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b34:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b38:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b3c:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b40:	1c0026f0 	pcaddu12i	$r16,311(0x137)
1c002b44:	1c0026bc 	pcaddu12i	$r28,309(0x135)

1c002b48 <__FUNCTION__.1504>:
1c002b48:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c019fc0 <_sidata+0x1716c>
1c002b4c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019bb0 <_sidata+0x16d5c>
1c002b50:	5f30616f 	bne	$r11,$r15,-53152(0x33060) # 1bff5bb0 <_start-0xa450>
1c002b54:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9cc4 <_start-0x633c>
1c002b58:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c0099b8 <_sidata+0x6b64>
1c002b5c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002b60 <__FUNCTION__.1508>:
1c002b60:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c019fd8 <_sidata+0x17184>
1c002b64:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019bc8 <_sidata+0x16d74>
1c002b68:	5f31616f 	bne	$r11,$r15,-52896(0x33160) # 1bff5cc8 <_start-0xa338>
1c002b6c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9cdc <_start-0x6324>
1c002b70:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c0099d0 <_sidata+0x6b7c>
1c002b74:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002b78 <__FUNCTION__.1512>:
1c002b78:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c019ff0 <_sidata+0x1719c>
1c002b7c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019be0 <_sidata+0x16d8c>
1c002b80:	5f32616f 	bne	$r11,$r15,-52640(0x33260) # 1bff5de0 <_start-0xa220>
1c002b84:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9cf4 <_start-0x630c>
1c002b88:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c0099e8 <_sidata+0x6b94>
1c002b8c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002b90 <__FUNCTION__.1516>:
1c002b90:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a008 <_sidata+0x171b4>
1c002b94:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019bf8 <_sidata+0x16da4>
1c002b98:	5f33616f 	bne	$r11,$r15,-52384(0x33360) # 1bff5ef8 <_start-0xa108>
1c002b9c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9d0c <_start-0x62f4>
1c002ba0:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009a00 <_sidata+0x6bac>
1c002ba4:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002ba8 <__FUNCTION__.1520>:
1c002ba8:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a020 <_sidata+0x171cc>
1c002bac:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019c10 <_sidata+0x16dbc>
1c002bb0:	5f34616f 	bne	$r11,$r15,-52128(0x33460) # 1bff6010 <_start-0x9ff0>
1c002bb4:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9d24 <_start-0x62dc>
1c002bb8:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009a18 <_sidata+0x6bc4>
1c002bbc:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002bc0 <__FUNCTION__.1524>:
1c002bc0:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a038 <_sidata+0x171e4>
1c002bc4:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019c28 <_sidata+0x16dd4>
1c002bc8:	5f35616f 	bne	$r11,$r15,-51872(0x33560) # 1bff6128 <_start-0x9ed8>
1c002bcc:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9d3c <_start-0x62c4>
1c002bd0:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009a30 <_sidata+0x6bdc>
1c002bd4:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002bd8 <__FUNCTION__.1528>:
1c002bd8:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a050 <_sidata+0x171fc>
1c002bdc:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019c40 <_sidata+0x16dec>
1c002be0:	5f36616f 	bne	$r11,$r15,-51616(0x33660) # 1bff6240 <_start-0x9dc0>
1c002be4:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9d54 <_start-0x62ac>
1c002be8:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009a48 <_sidata+0x6bf4>
1c002bec:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002bf0 <__FUNCTION__.1532>:
1c002bf0:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a068 <_sidata+0x17214>
1c002bf4:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019c58 <_sidata+0x16e04>
1c002bf8:	5f37616f 	bne	$r11,$r15,-51360(0x33760) # 1bff6358 <_start-0x9ca8>
1c002bfc:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9d6c <_start-0x6294>
1c002c00:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009a60 <_sidata+0x6c0c>
1c002c04:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002c08 <__FUNCTION__.1536>:
1c002c08:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a080 <_sidata+0x1722c>
1c002c0c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019c70 <_sidata+0x16e1c>
1c002c10:	5f30626f 	bne	$r19,$r15,-53152(0x33060) # 1bff5c70 <_start-0xa390>
1c002c14:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9d84 <_start-0x627c>
1c002c18:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009a78 <_sidata+0x6c24>
1c002c1c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002c20 <__FUNCTION__.1540>:
1c002c20:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a098 <_sidata+0x17244>
1c002c24:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019c88 <_sidata+0x16e34>
1c002c28:	5f31626f 	bne	$r19,$r15,-52896(0x33160) # 1bff5d88 <_start-0xa278>
1c002c2c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9d9c <_start-0x6264>
1c002c30:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009a90 <_sidata+0x6c3c>
1c002c34:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002c38 <__FUNCTION__.1544>:
1c002c38:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a0b0 <_sidata+0x1725c>
1c002c3c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019ca0 <_sidata+0x16e4c>
1c002c40:	5f32626f 	bne	$r19,$r15,-52640(0x33260) # 1bff5ea0 <_start-0xa160>
1c002c44:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9db4 <_start-0x624c>
1c002c48:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009aa8 <_sidata+0x6c54>
1c002c4c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002c50 <__FUNCTION__.1548>:
1c002c50:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a0c8 <_sidata+0x17274>
1c002c54:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019cb8 <_sidata+0x16e64>
1c002c58:	5f33626f 	bne	$r19,$r15,-52384(0x33360) # 1bff5fb8 <_start-0xa048>
1c002c5c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9dcc <_start-0x6234>
1c002c60:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009ac0 <_sidata+0x6c6c>
1c002c64:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002c68 <__FUNCTION__.1552>:
1c002c68:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a0e0 <_sidata+0x1728c>
1c002c6c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019cd0 <_sidata+0x16e7c>
1c002c70:	5f34626f 	bne	$r19,$r15,-52128(0x33460) # 1bff60d0 <_start-0x9f30>
1c002c74:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9de4 <_start-0x621c>
1c002c78:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009ad8 <_sidata+0x6c84>
1c002c7c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002c80 <__FUNCTION__.1556>:
1c002c80:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a0f8 <_sidata+0x172a4>
1c002c84:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019ce8 <_sidata+0x16e94>
1c002c88:	5f35626f 	bne	$r19,$r15,-51872(0x33560) # 1bff61e8 <_start-0x9e18>
1c002c8c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9dfc <_start-0x6204>
1c002c90:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009af0 <_sidata+0x6c9c>
1c002c94:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002c98 <__FUNCTION__.1560>:
1c002c98:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a110 <_sidata+0x172bc>
1c002c9c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019d00 <_sidata+0x16eac>
1c002ca0:	5f36626f 	bne	$r19,$r15,-51616(0x33660) # 1bff6300 <_start-0x9d00>
1c002ca4:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9e14 <_start-0x61ec>
1c002ca8:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009b08 <_sidata+0x6cb4>
1c002cac:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002cb0 <__FUNCTION__.1564>:
1c002cb0:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a128 <_sidata+0x172d4>
1c002cb4:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019d18 <_sidata+0x16ec4>
1c002cb8:	5f37626f 	bne	$r19,$r15,-51360(0x33760) # 1bff6418 <_start-0x9be8>
1c002cbc:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9e2c <_start-0x61d4>
1c002cc0:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009b20 <_sidata+0x6ccc>
1c002cc4:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002cc8 <__FUNCTION__.1568>:
1c002cc8:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a140 <_sidata+0x172ec>
1c002ccc:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019d30 <_sidata+0x16edc>
1c002cd0:	5f30636f 	bne	$r27,$r15,-53152(0x33060) # 1bff5d30 <_start-0xa2d0>
1c002cd4:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9e44 <_start-0x61bc>
1c002cd8:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009b38 <_sidata+0x6ce4>
1c002cdc:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002ce0 <__FUNCTION__.1572>:
1c002ce0:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a158 <_sidata+0x17304>
1c002ce4:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019d48 <_sidata+0x16ef4>
1c002ce8:	5f31636f 	bne	$r27,$r15,-52896(0x33160) # 1bff5e48 <_start-0xa1b8>
1c002cec:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9e5c <_start-0x61a4>
1c002cf0:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009b50 <_sidata+0x6cfc>
1c002cf4:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002cf8 <__FUNCTION__.1576>:
1c002cf8:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a170 <_sidata+0x1731c>
1c002cfc:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019d60 <_sidata+0x16f0c>
1c002d00:	5f32636f 	bne	$r27,$r15,-52640(0x33260) # 1bff5f60 <_start-0xa0a0>
1c002d04:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9e74 <_start-0x618c>
1c002d08:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009b68 <_sidata+0x6d14>
1c002d0c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002d10 <__FUNCTION__.1580>:
1c002d10:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a188 <_sidata+0x17334>
1c002d14:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019d78 <_sidata+0x16f24>
1c002d18:	5f33636f 	bne	$r27,$r15,-52384(0x33360) # 1bff6078 <_start-0x9f88>
1c002d1c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9e8c <_start-0x6174>
1c002d20:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009b80 <_sidata+0x6d2c>
1c002d24:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002d28 <__FUNCTION__.1584>:
1c002d28:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a1a0 <_sidata+0x1734c>
1c002d2c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019d90 <_sidata+0x16f3c>
1c002d30:	5f34636f 	bne	$r27,$r15,-52128(0x33460) # 1bff6190 <_start-0x9e70>
1c002d34:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9ea4 <_start-0x615c>
1c002d38:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009b98 <_sidata+0x6d44>
1c002d3c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002d40 <__FUNCTION__.1588>:
1c002d40:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a1b8 <_sidata+0x17364>
1c002d44:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019da8 <_sidata+0x16f54>
1c002d48:	5f35636f 	bne	$r27,$r15,-51872(0x33560) # 1bff62a8 <_start-0x9d58>
1c002d4c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9ebc <_start-0x6144>
1c002d50:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009bb0 <_sidata+0x6d5c>
1c002d54:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002d58 <__FUNCTION__.1592>:
1c002d58:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a1d0 <_sidata+0x1737c>
1c002d5c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019dc0 <_sidata+0x16f6c>
1c002d60:	5f36636f 	bne	$r27,$r15,-51616(0x33660) # 1bff63c0 <_start-0x9c40>
1c002d64:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9ed4 <_start-0x612c>
1c002d68:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009bc8 <_sidata+0x6d74>
1c002d6c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002d70 <__FUNCTION__.1596>:
1c002d70:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a1e8 <_sidata+0x17394>
1c002d74:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019dd8 <_sidata+0x16f84>
1c002d78:	5f37636f 	bne	$r27,$r15,-51360(0x33760) # 1bff64d8 <_start-0x9b28>
1c002d7c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9eec <_start-0x6114>
1c002d80:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009be0 <_sidata+0x6d8c>
1c002d84:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002d88 <__FUNCTION__.1600>:
1c002d88:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a200 <_sidata+0x173ac>
1c002d8c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019df0 <_sidata+0x16f9c>
1c002d90:	5f30646f 	bne	$r3,$r15,-53148(0x33064) # 1bff5df4 <_start-0xa20c>
1c002d94:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9f04 <_start-0x60fc>
1c002d98:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009bf8 <_sidata+0x6da4>
1c002d9c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002da0 <__FUNCTION__.1604>:
1c002da0:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a218 <_sidata+0x173c4>
1c002da4:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019e08 <_sidata+0x16fb4>
1c002da8:	5f31646f 	bne	$r3,$r15,-52892(0x33164) # 1bff5f0c <_start-0xa0f4>
1c002dac:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9f1c <_start-0x60e4>
1c002db0:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009c10 <_sidata+0x6dbc>
1c002db4:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002db8 <__FUNCTION__.1608>:
1c002db8:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a230 <_sidata+0x173dc>
1c002dbc:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019e20 <_sidata+0x16fcc>
1c002dc0:	5f32646f 	bne	$r3,$r15,-52636(0x33264) # 1bff6024 <_start-0x9fdc>
1c002dc4:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9f34 <_start-0x60cc>
1c002dc8:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009c28 <_sidata+0x6dd4>
1c002dcc:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002dd0 <__FUNCTION__.1612>:
1c002dd0:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a248 <_sidata+0x173f4>
1c002dd4:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019e38 <_sidata+0x16fe4>
1c002dd8:	5f33646f 	bne	$r3,$r15,-52380(0x33364) # 1bff613c <_start-0x9ec4>
1c002ddc:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9f4c <_start-0x60b4>
1c002de0:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009c40 <_sidata+0x6dec>
1c002de4:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002de8 <__FUNCTION__.1616>:
1c002de8:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a260 <_sidata+0x1740c>
1c002dec:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019e50 <_sidata+0x16ffc>
1c002df0:	5f34646f 	bne	$r3,$r15,-52124(0x33464) # 1bff6254 <_start-0x9dac>
1c002df4:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9f64 <_start-0x609c>
1c002df8:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009c58 <_sidata+0x6e04>
1c002dfc:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002e00 <__FUNCTION__.1620>:
1c002e00:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a278 <_sidata+0x17424>
1c002e04:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019e68 <_sidata+0x17014>
1c002e08:	5f35646f 	bne	$r3,$r15,-51868(0x33564) # 1bff636c <_start-0x9c94>
1c002e0c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9f7c <_start-0x6084>
1c002e10:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009c70 <_sidata+0x6e1c>
1c002e14:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002e18 <__FUNCTION__.1624>:
1c002e18:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a290 <_sidata+0x1743c>
1c002e1c:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019e80 <_sidata+0x1702c>
1c002e20:	5f36646f 	bne	$r3,$r15,-51612(0x33664) # 1bff6484 <_start-0x9b7c>
1c002e24:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9f94 <_start-0x606c>
1c002e28:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009c88 <_sidata+0x6e34>
1c002e2c:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002e30 <__FUNCTION__.1628>:
1c002e30:	69747865 	bltu	$r3,$r5,95352(0x17478) # 1c01a2a8 <_sidata+0x17454>
1c002e34:	6970675f 	bltu	$r26,$r31,94308(0x17064) # 1c019e98 <_sidata+0x17044>
1c002e38:	5f37646f 	bne	$r3,$r15,-51356(0x33764) # 1bff659c <_start-0x9a64>
1c002e3c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # 1bff9fac <_start-0x6054>
1c002e40:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009ca0 <_sidata+0x6e4c>
1c002e44:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

1c002e48 <__FUNCTION__.1637>:
1c002e48:	5f747865 	bne	$r3,$r5,-35720(0x37478) # 1bffa2c0 <_start-0x5d40>
1c002e4c:	646e6168 	bge	$r11,$r8,28256(0x6e60) # 1c009cac <_sidata+0x6e58>
1c002e50:	0072656c 	bstrins.w	$r12,$r11,0x12,0x19

Disassembly of section .bss.g_recv_flag:

80000000 <g_recv_flag>:
80000000:	00000000 	0x00000000

Disassembly of section .bss.g_recvBuff:

80000004 <g_recvBuff>:
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	0x3a434347
   4:	4e472820 	jirl	$r0,$r1,-112856(0x24728)
   8:	38202955 	ldx.bu	$r21,$r10,$r10
   c:	302e332e 	vldrepl.w	$vr14,$r25,-464(0xe30)
	...
