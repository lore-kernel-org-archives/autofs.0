From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Autofs v5 (RHEL4) kernel panics
Date: Mon, 20 Oct 2008 17:15:30 +0200
Message-ID: <48FCA092.1070706@s3group.cz>
References: <A3D12FAD74FC8B46991703F40C182BABFAB91B@permls102.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A3D12FAD74FC8B46991703F40C182BABFAB91B@permls102.wde.woodside.com.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

As of me, RHEL4 ships with autofs 4xxx series. My system says
autofs-4.1.3-234.
The autofs5-5.0.1-0.rc2.88 is a part of RHEL5.
If I were you I would go for autofs which is shipped with the OS.
Ondrej

Coe, Colin C. (Unix Engineer) wrote:
> Hi Ian and all
>
> Using RHEL4 WS with the latest kernel (kernel-smp-2.6.9-78.0.5.EL) and autofs (autofs5-5.0.1-0.rc2.88) rpms, I can reliably crash (read "kernel panic") the OS.
> To crash,
> 1) open a couple of terminals (I logged on to tty1 and tty2)
> 2) in one terminal run "while :; do ls -lR /autofs/point/mount/* ; done"
> 3) in the other run "while :; do service autofs5 restart; done"
> 4) profit!
>
> While this is a contrived scenario we noticed the panic on a couple of cluster nodes (run RHEL 4u7 WS) when they didn't pick up some new autofs map entries.  Service autofs5 reload didn't help so I did a service autofs5 restart and panics soon followed.
>
> I've setup diskdump and now have a vmcore file.  Running 'crash /boot/System.map-2.6.9-78.0.5.ELsmp /usr/lib/debug/lib/modules/2.6.9-78.0.5.ELsmp/vmlinux /var/crash/127.0.0.1-2008-10-20-09\:44/vmcore' shows:
> ---
> crash 4.0-5.0.0.1
> Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008  Red Hat, Inc.
> Copyright (C) 2004, 2005, 2006  IBM Corporation
> Copyright (C) 1999-2006  Hewlett-Packard Co
> Copyright (C) 2005, 2006  Fujitsu Limited
> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
> Copyright (C) 2005  NEC Corporation
> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
> This program is free software, covered by the GNU General Public License,
> and you are welcome to change it and/or distribute copies of it under
> certain conditions.  Enter "help copying" to see the conditions.
> This program has absolutely no warranty.  Enter "help warranty" for details.
>
> GNU gdb 6.1
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "x86_64-unknown-linux-gnu"...
>
>   SYSTEM MAP: /boot/System.map-2.6.9-78.0.5.ELsmp
> DEBUG KERNEL: /usr/lib/debug/lib/modules/2.6.9-78.0.5.ELsmp/vmlinux (2.6.9-78.0.5.ELsmp)
>     DUMPFILE: /var/crash/127.0.0.1-2008-10-20-09:44/vmcore  [PARTIAL DUMP]
>         CPUS: 2
>         DATE: Mon Oct 20 09:44:24 2008
>       UPTIME: 00:04:26
> LOAD AVERAGE: 0.24, 0.22, 0.10
>        TASKS: 95
>     NODENAME: lws075
>      RELEASE: 2.6.9-78.0.5.ELsmp
>      VERSION: #1 SMP Wed Sep 24 05:40:24 EDT 2008
>      MACHINE: x86_64  (2133 Mhz)
>       MEMORY: 4 GB
>        PANIC: "Oops: 0002 [1] SMP " (check log for details)
>          PID: 23840
>      COMMAND: "automount5"
>         TASK: 101205e1030  [THREAD_INFO: 1011a692000]
>          CPU: 0
>        STATE: TASK_RUNNING (PANIC)
>
> crash> bt
> PID: 23840  TASK: 101205e1030       CPU: 0   COMMAND: "automount5"
>  #0 [1011a693d20] start_disk_dump at ffffffffa01b1377
>  #1 [1011a693d50] try_crashdump at ffffffff8014cda9
>  #2 [1011a693d60] do_page_fault at ffffffff80124ae8
>  #3 [1011a693e40] error_exit at ffffffff80110e1d
>     [exception RIP: fput]
>     RIP: ffffffff8017ca06  RSP: 000001011a693ef0  RFLAGS: 00010246
>     RAX: 0000000000000002  RBX: 0000000000009362  RCX: 0000000000000000
>     RDX: 0000000000009362  RSI: 00000101198b8bc0  RDI: 0000000000000000
>     RBP: 0000000000000000   R8: 0000000000000000   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000009362  R12: 00000101199218c0
>     R13: 00000101198b8bc0  R14: 0000010119837270  R15: 0000000000000003
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #4 [1011a693ef0] autofs4_catatonic_mode at ffffffffa0a45df2
>  #5 [1011a693f10] autofs4_root_ioctl at ffffffffa0a45b74
>  #6 [1011a693f40] sys_ioctl at ffffffff8018dc6d
>  #7 [1011a693f80] system_call at ffffffff801102f6
>     RIP: 0000002a95946f59  RSP: 0000000040621a98  RFLAGS: 00000246
>     RAX: 0000000000000010  RBX: ffffffff801102f6  RCX: 0000002a95677486
>     RDX: 0000000000000000  RSI: 0000000000009362  RDI: 0000000000000003
>     RBP: 000000552abfc930   R8: 0000000000000000   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000000246  R12: 000000552abfbe10
>     R13: 000000552abfbe10  R14: 0000000000000000  R15: 000000552ac17390
>     ORIG_RAX: 0000000000000010  CS: 0033  SS: 002b
> crash> ps 23840
>    PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>   
>> 23840      1   0     101205e1030    RU   0.0   23036   1820  automount5
>>     
> Crash> log
> Bootdata ok (command line is ro root=LABEL=/ quiet reboot=h ide=nodma vga=1 bfsort swiotlb=65536)
> Linux version 2.6.9-78.0.5.ELsmp (brewbuilder@ls20-bc2-14.build.redhat.com) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-10)) #1 SMP Wed Sep 24 05:40:24 EDT 2
> 008
> BIOS-provided physical RAM map:
>
> snip
>
> MSI INIT SUCCESS
> tg3: eth0: Link is up at 1000 Mbps, full duplex.
> tg3: eth0: Flow control is off for TX and off for RX.
> nvidia: module license 'NVIDIA' taints kernel.
> ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
> PCI: Setting latency timer of device 0000:01:00.0 to 64
> NVRM: loading NVIDIA UNIX x86_64 Kernel Module  169.09  Fri Jan 11 14:04:37 PST 2008
> Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
> <ffffffff8017ca06>{fput+0}
> PML4 119d23067 PGD 0
> Oops: 0002 [1] SMP
> CPU 0
> Modules linked in: autofs4 nvidia(U) i2c_core cpufreq_powersave ide_dump scsi_dump diskdump zlib_deflate dm_mirror dm_multipath joydev dm_mod button battery
>  ac uhci_hcd ehci_hcd snd_hda_intel snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc tg3 floppy ext3 jbd ata_piix libata sd_mod scsi
> _mod
> Pid: 23840, comm: automount5 Tainted: P      2.6.9-78.0.5.ELsmp
> RIP: 0010:[<ffffffff8017ca06>] <ffffffff8017ca06>{fput+0}
> RSP: 0018:000001011a693ef0  EFLAGS: 00010246
> RAX: 0000000000000002 RBX: 0000000000009362 RCX: 0000000000000000
> RDX: 0000000000009362 RSI: 00000101198b8bc0 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000009362 R12: 00000101199218c0
> R13: 00000101198b8bc0 R14: 0000010119837270 R15: 0000000000000003
> FS:  0000000040624960(005b) GS:ffffffff8050d200(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000000000000028 CR3: 0000000000101000 CR4: 00000000000006e0
> Process automount5 (pid: 23840, threadinfo 000001011a692000, task 00000101205e1030)
> Stack: ffffffffa0a45df2 0000000000009362 0000000000000000 00000101199218c0
>        ffffffffa0a45b74 0000000000009362 0000000000000000 0000000000000000
>        00000101198b8bc0 00000000ffffffe7
> Call Trace:<ffffffffa0a45df2>{:autofs4:autofs4_catatonic_mode+94}
>        <ffffffffa0a45b74>{:autofs4:autofs4_root_ioctl+300}
>        <ffffffff8018dc6d>{sys_ioctl+853} <ffffffff801102f6>{system_call+126}
>
>
> Code: f0 ff 4f 28 0f 94 c0 84 c0 74 05 e9 a6 fe ff ff c3 41 55 41
> RIP <ffffffff8017ca06>{fput+0} RSP <000001011a693ef0>
> CR2: 0000000000000028
> ---
>
> There is pretty much nothing useful in /var/log/messages or /var/log/daemon
>
> What additional info can I provide to help with this?
>
> CC
>
> NOTICE: This email and any attachments are confidential. 
> They may contain legally privileged information or 
> copyright material. You must not read, copy, use or 
> disclose them without authorisation. If you are not an 
> intended recipient, please contact us at once by return 
> email and then delete both messages and all attachments.
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>   
