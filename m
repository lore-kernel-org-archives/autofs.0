From: Howard Wilkinson <howard@cohtech.com>
Subject: NFS4 problem with kernel 2.6.22.1-41 from fedora 7.
Date: Wed, 08 Aug 2007 13:51:14 +0100
Message-ID: <46B9BC42.50509@cohtech.com>
Reply-To: For users of Fedora <fedora-list@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1592253283=="
Return-path: <fedora-list-bounces@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/fedora-list>,
	<mailto:fedora-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-list>
List-Post: <mailto:fedora-list@redhat.com>
List-Help: <mailto:fedora-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/fedora-list>,
	<mailto:fedora-list-request@redhat.com?subject=subscribe>
Sender: fedora-list-bounces@redhat.com
Errors-To: fedora-list-bounces@redhat.com
To: autofs@linux.kernel.org, fedora-list@redhat.com, nfsv4@linux-nfs.org

This is a multi-part message in MIME format.
--===============1592253283==
Content-Type: multipart/alternative;
	boundary="------------020900070802010008090900"

This is a multi-part message in MIME format.
--------------020900070802010008090900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have been struggling to update my machines to fedora 7 with the latest 
kernel. We are getting a crash of the kernel as shown below.

This happens when we run a "yum upgrade" operation. Our repositories are 
available on the local LAN segment and mounted via Autofs 5 over NFS4. 
The system is generally stable using this configuration for other 
purposes although we occasionally see the same failure when other 
operations are running. I have been unable to find any reference to this 
failure in association with this version of the kernel, although similar 
failures were reported about six months ago for 2.6.17 pre-release kernels.

Does anybody have any idea what is causing the failure, whether this is 
something that there is a fix for, and whether other people are seeing 
it and if so what work rounds they have used.

Traceback on the console is as follows:

    BUG: unable to handle kernel NULL pointer dereference at virtual
    address 0000000                      c
     printing eip:
    f8cea941
    *pde = 24fd0067
    *pte = 00000000
    Oops: 0000 [#1]
    SMP
    last sysfs file: /kernel/uevent_seqnum
    Modules linked in: appletalk nfs nfsd exportfs lockd nfs_acl autofs4
    rpcsec_gss_                      krb5 auth_rpcgss des sunrpc bonding
    ipv6 ext2 loop video sbs button dock battery                      
    ac sr_mod cdrom ata_generic e100 mii parport_pc parport ata_piix
    i2c_piix4 seri                      o_raw rtc_cmos libata i2c_core
    e1000 floppy sg dm_snapshot dm_zero dm_mirror
    dm_                      mod sym53c8xx scsi_transport_spi sd_mod
    scsi_mod raid456 xor raid1 ext3 jbd mbca                      che
    ehci_hcd ohci_hcd uhci_hcd
    CPU:    2
    EIP:    0060:[<f8cea941>]    Not tainted VLI
    EFLAGS: 00210246   (2.6.22.1-41.fc7 #1)
    EIP is at nfs_update_inode+0xba/0x649 [nfs]
    eax: 00000000   ebx: 000081a4   ecx: 000081a4   edx: 00008000
    esi: e999eb40   edi: f40ccab0   ebp: edd108c8   esp: deb91de4
    ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
    Process umount.nfs4 (pid: 22737, ti=deb91000 task=f5058c00
    task.ti=deb91000)
    Stack: c300034c eddc9740 00000004 00000000 f5058c00 c0436fe2
    deb91dfc 00000000
           f40ccab0 edd10798 00cd4f8f c042f18c eddc96c0 00000000
    edd108c8 f40ccab0
           eddc96c0 edd108c8 f8cebf0d f40cca00 00000000 f8cf8465
    f40cca00 df2fd010
    Call Trace:
     [<c0436fe2>] wake_bit_function+0x0/0x3c
     [<c042f18c>] sigprocmask+0xa1/0xbe
     [<f8cebf0d>] nfs_post_op_update_inode+0x27/0x33 [nfs]
     [<f8cf8465>] nfs4_proc_delegreturn+0x131/0x172 [nfs]
     [<f8d02b85>] nfs_do_return_delegation+0xf/0x1d [nfs]
     [<f8ce9364>] nfs_dentry_iput+0x1d/0x60 [nfs]
     [<c0487922>] shrink_dcache_for_umount_subtree+0x194/0x1de
     [<c04742f2>] add_partial+0x19/0x20
     [<c0474fbb>] __slab_free+0x5c/0x235
     [<c04774e8>] percpu_depopulate+0x10/0x1a
     [<c048834a>] shrink_dcache_for_umount+0x2a/0x36
     [<c047a8ee>] generic_shutdown_super+0x15/0xb7
     [<c047a9b4>] kill_anon_super+0x9/0x2f
     [<f8ceca03>] nfs_kill_super+0xc/0x14 [nfs]
     [<c047aa43>] deactivate_super+0x52/0x65
     [<c048b983>] expire_mount_list+0xf0/0x125
     [<c048c8c3>] shrink_submounts+0x32/0xab
     [<c048baab>] sys_umount+0xf3/0x21a
     [<c04527db>] audit_syscall_entry+0x10d/0x137
     [<c048bbe9>] sys_oldumount+0x17/0x1a
     [<c0404f8e>] syscall_call+0x7/0xb
     =======================
    Code: 20 0f b7 5d 6e 89 c8 89 da 25 00 f0 00 00 81 e2 00 f0 00 00 39
    c2 0f 85 92                       04 00 00 8b 85 9c 00 00 00 8b b0
    64 01 00 00 8b 40 38 <3b> 68 0c 75 52 83 c7 44                      
    89 7c 24 30 8b 7c 24 20 8d 46 78 89 44
    EIP: [<f8cea941>] nfs_update_inode+0xba/0x649 [nfs] SS:ESP 0068:deb91de4

Regards, Howard

-- 

Howard Wilkinson

	

Phone:

	

+44(20)76907075

Coherent Technology Limited

	

Fax:

	

 

23 Northampton Square,

	

Mobile:

	

+44(7980)639379

United Kingdom, EC1V 0HL

	

Email:

	

howard@cohtech.com

 


--------------020900070802010008090900
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I have been struggling to update my machines to fedora 7 with the
latest kernel. We are getting a crash of the kernel as shown below.<br>
<br>
This happens when we run a "yum upgrade" operation. Our repositories
are available on the local LAN segment and mounted via Autofs 5 over
NFS4. The system is generally stable using this configuration for other
purposes although we occasionally see the same failure when other
operations are running. I have been unable to find any reference to
this failure in association with this version of the kernel, although
similar failures were reported about six months ago for 2.6.17
pre-release kernels.<br>
<br>
Does anybody have any idea what is causing the failure, whether this is
something that there is a fix for, and whether other people are seeing
it and if so what work rounds they have used.<br>
<br>
Traceback on the console is as follows:<br>
<blockquote>BUG: unable to handle kernel NULL pointer dereference at
virtual address 0000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c<br>
&nbsp;printing eip:<br>
f8cea941<br>
*pde = 24fd0067<br>
*pte = 00000000<br>
Oops: 0000 [#1]<br>
SMP<br>
last sysfs file: /kernel/uevent_seqnum<br>
Modules linked in: appletalk nfs nfsd exportfs lockd nfs_acl autofs4
rpcsec_gss_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; krb5 auth_rpcgss des sunrpc bonding
ipv6 ext2 loop video sbs button dock battery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ac
sr_mod cdrom ata_generic e100 mii parport_pc parport ata_piix i2c_piix4
seri&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o_raw rtc_cmos libata i2c_core e1000 floppy
sg dm_snapshot dm_zero dm_mirror dm_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mod sym53c8xx
scsi_transport_spi sd_mod scsi_mod raid456 xor raid1 ext3 jbd
mbca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; che ehci_hcd ohci_hcd uhci_hcd<br>
CPU:&nbsp;&nbsp;&nbsp; 2<br>
EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;f8cea941&gt;]&nbsp;&nbsp;&nbsp; Not tainted VLI<br>
EFLAGS: 00210246&nbsp;&nbsp; (2.6.22.1-41.fc7 #1)<br>
EIP is at nfs_update_inode+0xba/0x649 [nfs]<br>
eax: 00000000&nbsp;&nbsp; ebx: 000081a4&nbsp;&nbsp; ecx: 000081a4&nbsp;&nbsp; edx: 00008000<br>
esi: e999eb40&nbsp;&nbsp; edi: f40ccab0&nbsp;&nbsp; ebp: edd108c8&nbsp;&nbsp; esp: deb91de4<br>
ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; fs: 00d8&nbsp; gs: 0033&nbsp; ss: 0068<br>
Process umount.nfs4 (pid: 22737, ti=deb91000 task=f5058c00
task.ti=deb91000)<br>
Stack: c300034c eddc9740 00000004 00000000 f5058c00 c0436fe2 deb91dfc
00000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f40ccab0 edd10798 00cd4f8f c042f18c eddc96c0 00000000 edd108c8
f40ccab0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eddc96c0 edd108c8 f8cebf0d f40cca00 00000000 f8cf8465 f40cca00
df2fd010<br>
Call Trace:<br>
&nbsp;[&lt;c0436fe2&gt;] wake_bit_function+0x0/0x3c<br>
&nbsp;[&lt;c042f18c&gt;] sigprocmask+0xa1/0xbe<br>
&nbsp;[&lt;f8cebf0d&gt;] nfs_post_op_update_inode+0x27/0x33 [nfs]<br>
&nbsp;[&lt;f8cf8465&gt;] nfs4_proc_delegreturn+0x131/0x172 [nfs]<br>
&nbsp;[&lt;f8d02b85&gt;] nfs_do_return_delegation+0xf/0x1d [nfs]<br>
&nbsp;[&lt;f8ce9364&gt;] nfs_dentry_iput+0x1d/0x60 [nfs]<br>
&nbsp;[&lt;c0487922&gt;] shrink_dcache_for_umount_subtree+0x194/0x1de<br>
&nbsp;[&lt;c04742f2&gt;] add_partial+0x19/0x20<br>
&nbsp;[&lt;c0474fbb&gt;] __slab_free+0x5c/0x235<br>
&nbsp;[&lt;c04774e8&gt;] percpu_depopulate+0x10/0x1a<br>
&nbsp;[&lt;c048834a&gt;] shrink_dcache_for_umount+0x2a/0x36<br>
&nbsp;[&lt;c047a8ee&gt;] generic_shutdown_super+0x15/0xb7<br>
&nbsp;[&lt;c047a9b4&gt;] kill_anon_super+0x9/0x2f<br>
&nbsp;[&lt;f8ceca03&gt;] nfs_kill_super+0xc/0x14 [nfs]<br>
&nbsp;[&lt;c047aa43&gt;] deactivate_super+0x52/0x65<br>
&nbsp;[&lt;c048b983&gt;] expire_mount_list+0xf0/0x125<br>
&nbsp;[&lt;c048c8c3&gt;] shrink_submounts+0x32/0xab<br>
&nbsp;[&lt;c048baab&gt;] sys_umount+0xf3/0x21a<br>
&nbsp;[&lt;c04527db&gt;] audit_syscall_entry+0x10d/0x137<br>
&nbsp;[&lt;c048bbe9&gt;] sys_oldumount+0x17/0x1a<br>
&nbsp;[&lt;c0404f8e&gt;] syscall_call+0x7/0xb<br>
&nbsp;=======================<br>
Code: 20 0f b7 5d 6e 89 c8 89 da 25 00 f0 00 00 81 e2 00 f0 00 00 39 c2
0f 85 92&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 04 00 00 8b 85 9c 00 00 00 8b b0 64 01
00 00 8b 40 38 &lt;3b&gt; 68 0c 75 52 83 c7 44&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89
7c 24 30 8b 7c 24 20 8d 46 78 89 44<br>
EIP: [&lt;f8cea941&gt;] nfs_update_inode+0xba/0x649 [nfs] SS:ESP
0068:deb91de4<br>
  <br>
</blockquote>
Regards, Howard<br>
<br>
<div class="moz-signature">-- <br>
<title>Signature</title>
<div class="Section1">
<table class="MsoNormalTable" style="width: 100%;" border="0"
 cellpadding="0" width="100%">
  <tbody>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Howard Wilkinson</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Phone:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">+44(20)76907075</p>
      </td>
    </tr>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Coherent Technology Limited</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Fax:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">&nbsp;</p>
      </td>
    </tr>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">23 Northampton Square,</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Mobile:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">+44(7980)639379</p>
      </td>
    </tr>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">United Kingdom, EC1V 0HL</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Email:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal"><a name="howardcohtech.com"></a><a class="moz-txt-link-abbreviated" href="mailto:howard@cohtech.com">howard@cohtech.com</a></p>
      </td>
    </tr>
  </tbody>
</table>
<p class="MsoNormal">&nbsp;</p>
</div>
</div>
</body>
</html>

--------------020900070802010008090900--


--===============1592253283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
fedora-list mailing list
fedora-list@redhat.com
To unsubscribe: https://www.redhat.com/mailman/listinfo/fedora-list
--===============1592253283==--

