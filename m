From: Robert Kuropkat <robert.a.kuropkat@saic.com>
Subject: Re: autofs-5.0.1-0.rc2.55.el5.3 core dump
Date: Tue, 22 Apr 2008 17:52:10 -0400
Message-ID: <480E5E0A.2050702@saic.com>
References: <47FF8D07.7080208@schrodinger.com>	<x49iqyo9x8i.fsf@segfault.boston.devel.redhat.com>	<47FF9443.4020305@schrodinger.com>
	<1207970551.3138.9.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1207970551.3138.9.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

Ian,

Here is the output based on our latest core file from gdb as you asked.
 autofs-debuginfo was installed after the core file was created.  I
happen to have several other, older core files also.

Hope this all means something to you.  If not, please tell me what I can
do to provide something more useful.

Robert Kuropkat

P.S.  I cut in on somebody else's thread here.  The version I am running is:

autofs.i386                              1:5.0.1-0.rc3.33
autofs-debuginfo.i386                    1:5.0.1-0.rc3.33

On Fedora Core 6.




gdb -c /core.26360 /usr/sbin/automount
GNU gdb Red Hat Linux (6.5-15.fc6rh)
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host
libthread_db library "/lib/libthread_db.so.1".


warning: Can't read pathname for load map: Input/output error.
Loaded symbols for /usr/sbin/automount
Reading symbols from /lib/libpthread.so.0...done.
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libgcc_s.so.1...done.
Loaded symbols for /lib/libgcc_s.so.1
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /lib/libnss_files.so.2...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /usr/lib/autofs/lookup_ldap.so...Reading symbols
from /usr/lib/debug/usr/lib/autofs/lookup_ldap.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/lookup_ldap.so
Reading symbols from /usr/lib/libldap_r-2.3.so.0...done.
Loaded symbols for /usr/lib/libldap_r-2.3.so.0
Reading symbols from /usr/lib/liblber-2.3.so.0...done.
Loaded symbols for /usr/lib/liblber-2.3.so.0
Reading symbols from /lib/libresolv.so.2...done.
Loaded symbols for /lib/libresolv.so.2
Reading symbols from /usr/lib/libsasl2.so.2...done.
Loaded symbols for /usr/lib/libsasl2.so.2
Reading symbols from /usr/lib/libxml2.so.2...done.
Loaded symbols for /usr/lib/libxml2.so.2
Reading symbols from /usr/lib/libz.so.1...done.
Loaded symbols for /usr/lib/libz.so.1
Reading symbols from /lib/libm.so.6...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /lib/libssl.so.6...done.
Loaded symbols for /lib/libssl.so.6
Reading symbols from /lib/libcrypto.so.6...done.
Loaded symbols for /lib/libcrypto.so.6
Reading symbols from /lib/libcrypt.so.1...done.
Loaded symbols for /lib/libcrypt.so.1
Reading symbols from /usr/lib/libgssapi_krb5.so.2...done.
Loaded symbols for /usr/lib/libgssapi_krb5.so.2
Reading symbols from /usr/lib/libkrb5.so.3...done.
Loaded symbols for /usr/lib/libkrb5.so.3
Reading symbols from /lib/libcom_err.so.2...done.
Loaded symbols for /lib/libcom_err.so.2
Reading symbols from /usr/lib/libk5crypto.so.3...done.
Loaded symbols for /usr/lib/libk5crypto.so.3
Reading symbols from /usr/lib/libkrb5support.so.0...done.
Loaded symbols for /usr/lib/libkrb5support.so.0
Reading symbols from /usr/lib/autofs/parse_sun.so...Reading symbols from
/usr/lib/debug/usr/lib/autofs/parse_sun.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/parse_sun.so
Reading symbols from /lib/libnsl.so.1...done.
Loaded symbols for /lib/libnsl.so.1
Reading symbols from /usr/lib/autofs/mount_nfs.so...Reading symbols from
/usr/lib/debug/usr/lib/autofs/mount_nfs.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_nfs.so
Reading symbols from /usr/lib/autofs/mount_bind.so...Reading symbols
from /usr/lib/debug/usr/lib/autofs/mount_bind.so.debug...done.
done.
Loaded symbols for /usr/lib/autofs/mount_bind.so
Reading symbols from /usr/lib/libnss_ldap.so.2...done.
Loaded symbols for /usr/lib/libnss_ldap.so.2
Core was generated by `automount'.
Program terminated with signal 6, Aborted.
#0  0x0012b402 in __kernel_vsyscall ()
(gdb) thr a a bt

Thread 7 (process 26360):
#0  0x0012b402 in __kernel_vsyscall ()
#1  0x00138f6e in do_sigwait () from /lib/libpthread.so.0
#2  0x0013900f in sigwait () from /lib/libpthread.so.0
#3  0x80005928 in statemachine (arg=<value optimized out>) at
automount.c:1023
#4  0x80006aa4 in main (argc=1, argv=<value optimized out>) at
automount.c:1651

Thread 6 (process 26361):
#0  0x0012b402 in __kernel_vsyscall ()
#1  0x001354dc in pthread_cond_timedwait@@GLIBC_2.3.2 () from
/lib/libpthread.so.0
#2  0x8001cae3 in alarm_handler (arg=0x0) at alarm.c:227
#3  0x0013145b in start_thread () from /lib/libpthread.so.0
#4  0x0022123e in clone () from /lib/libc.so.6

Thread 5 (process 26362):
#0  0x0012b402 in __kernel_vsyscall ()
#1  0x001354dc in pthread_cond_timedwait@@GLIBC_2.3.2 () from
/lib/libpthread.so.0
#2  0x8001638e in st_queue_handler (arg=0x0) at state.c:913
#3  0x0013145b in start_thread () from /lib/libpthread.so.0
#4  0x0022123e in clone () from /lib/libc.so.6

Thread 4 (process 26365):
#0  0x0012b402 in __kernel_vsyscall ()
#1  0x00217643 in poll () from /lib/libc.so.6
#2  0x800084d4 in handle_mounts (arg=0x80f67900) at automount.c:634
#3  0x0013145b in start_thread () from /lib/libpthread.so.0
#4  0x0022123e in clone () from /lib/libc.so.6

Thread 3 (process 26380):
#0  0x0012b402 in __kernel_vsyscall ()
#1  0x00217643 in poll () from /lib/libc.so.6
#2  0x800084d4 in handle_mounts (arg=0x80f67f18) at automount.c:634
#3  0x0013145b in start_thread () from /lib/libpthread.so.0
#4  0x0022123e in clone () from /lib/libc.so.6

Thread 2 (process 27373):
#0  0x0055a3f6 in bn_sqr_comba8 () from /lib/libcrypto.so.6
#1  0x00558b73 in bn_sqr_recursive () from /lib/libcrypto.so.6
Previous frame inner to this frame (corrupt stack?)

Thread 1 (process 27374):
#0  0x0012b402 in __kernel_vsyscall ()
#1  0x0017bba0 in raise () from /lib/libc.so.6
#2  0x0017d4b1 in abort () from /lib/libc.so.6
#3  0x001b1dfb in __libc_message () from /lib/libc.so.6
#4  0x001b9a96 in _int_free () from /lib/libc.so.6
#5  0x001bcfb0 in free () from /lib/libc.so.6
#6  0x0052748a in CRYPTO_free () from /lib/libcrypto.so.6
#7  0x0057c858 in ERR_unload_strings () from /lib/libcrypto.so.6
#8  0x0057d47f in ERR_get_state () from /lib/libcrypto.so.6
#9  0x0057dafb in ERR_clear_error () from /lib/libcrypto.so.6
#10 0x004cd79d in ssl23_connect () from /lib/libssl.so.6
#11 0x004d900a in SSL_connect () from /lib/libssl.so.6
#12 0x002f3a3c in ldap_int_tls_start () from /usr/lib/libldap_r-2.3.so.0
#13 0x002f3dcc in ldap_start_tls_s () from /usr/lib/libldap_r-2.3.so.0
#14 0x00298b61 in init_ldap_connection (ctxt=0x80f30518) at
lookup_ldap.c:150
#15 0x00298eb4 in do_connect (ctxt=0x0) at lookup_ldap.c:178
#16 0x00299e66 in lookup_one (ap=0x80f67900, qKey=0x80f85b58 "ataylor",
qKey_len=<value optimized out>, ctxt=0x80f30518) at lookup_ldap.c:1369
#17 0x0029a9cb in lookup_mount (ap=0x80f67900, name=0xb7a00738
"ataylor", name_len=7, context=0x80f30518) at lookup_ldap.c:1550
#18 0x800125a9 in do_lookup_mount (ap=0x80f67900, map=0x80f679e0,
name=0xb7a00738 "ataylor", name_len=7) at lookup.c:623
#19 0x8001353d in lookup_nss_mount (ap=0x80f67900, source=0x0,
name=0xb7a00738 "ataylor", name_len=7) at lookup.c:791
---Type <return> to continue, or q <return> to quit---
#20 0x8000b591 in do_mount_indirect (arg=0xb7a006d8) at indirect.c:887
#21 0x0013145b in start_thread () from /lib/libpthread.so.0
#22 0x0022123e in clone () from /lib/libc.so.6
(gdb)




Ian Kent wrote:
> On Fri, 2008-04-11 at 09:39 -0700, Simon Gao wrote:
>> Jeff Moyer wrote:
>>> Simon Gao <gao@schrodinger.com> writes:
>>>
>>>   
>>>> Hi,
>>>>
>>>> We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of 
>>>> them have core dump files related to autofs. The autofs package is
>>>> autofs-5.0.1-0.rc2.55.el5.3.
>>>>     
>>>   
>>>> # strings core.2594 | head
>>>>     
>>> You can use the 'file' command to determine to what program a core
>>> belongs:
>>>
>>> $ file /tmp/core.2350 
>>> /tmp/core.2350: ELF 32-bit LSB core file Intel 80386, version 1 (SYSV), SVR4-style, from 'automount'
>>>
>>> Anyway, we won't be able to tell why it dumped core without at least a
>>> stack trace, and preferrably the core file itself.
>>>
>>> Cheers,
>>>
>>> Jeff
>>>   
>> I can provide a core file if you let me know to where I can upload the file?
> 
> Maybe I'm a bit slow and maybe there's something I just don't know but I
> always have trouble setting up an environment that can get useful
> information from a supplied core file.
> 
> How about you provide a gdb backtrace for the core?
> That would be far easier and quicker for everyone.
> 
> You can get what we need by installing the corresponding
> autofs-debuginfo package and running:
> 
> gdb -c /tmp/core.2350 /usr/sbin/automount
> gdb> thr a a bt
> 
> and then posting that output. This should tell us if what you've seen is
> something that has been seen before and has been fixed or if it's
> something new.
> 
> The output is useless without at least the autofs-debuginfo package
> installed.
> 
> Ian
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
