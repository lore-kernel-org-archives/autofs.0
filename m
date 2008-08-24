From: Ian Kent <raven@themaw.net>
Subject: Re: something changed from 4 to 5
Date: Sun, 24 Aug 2008 13:27:08 +0800
Message-ID: <48B0F12C.1070006@themaw.net>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>	<1218596289.3148.8.camel@raven.themaw.net>	<alpine.LRH.1.10.0808230743560.25167@q7.q7.com>
	<48B0E98E.8090709@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48B0E98E.8090709@themaw.net>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> Joe Pruett wrote:
>   
>> i had one of my servers get into the mode where automount is hung up doing 
>> something.  i started attaching to each one and doing the gdb stack trace 
>> you asked for.  here are the results.  after looking at the third one, 
>> things cleared up.  hopefully we can figure something out on this.
>>
>> Script started on Fri 22 Aug 2008 01:11:35 PM PDT
>> [root@titan ~]# ps axf | grep auto
>>   1741 ?        Ssl  116:45 automount
>> 16772 ?        S      0:00  \_ automount
>> 16777 ?        S      0:00  \_ automount
>> 20963 ?        S      0:00  \_ automount
>> 21865 ?        S      0:00  \_ automount
>> 23136 ?        S      0:00  \_ automount
>> 25322 pts/0    S+     0:00                  \_ grep auto
>> [root@titan ~]# gdb -p 1741 /usr/sbin/automount
>>   
>>     
>
> snip ...
>
>   
>> Attaching to program: /usr/sbin/automount, process 1741
>> Loaded symbols for /usr/sbin/automount
>> Reading symbols from /lib/libpthread.so.0...done.
>> [Thread debugging using libthread_db enabled]
>> [New Thread -1208218944 (LWP 1741)]
>> [New Thread -1228944496 (LWP 23135)]
>> [New Thread -1212564592 (LWP 21864)]
>> [New Thread -1222640752 (LWP 20962)]
>> [New Thread -1218868336 (LWP 18488)]
>> [New Thread -1216767088 (LWP 16774)]
>> [New Thread -1214665840 (LWP 16773)]
>> [New Thread -1224742000 (LWP 16771)]
>> [New Thread -1210463344 (LWP 1749)]
>> [New Thread -1208362096 (LWP 1746)]
>> [New Thread -1208292464 (LWP 1743)]
>> [New Thread -1208222832 (LWP 1742)]
>>   
>>     
>
> snip ...
>
>   
>> 0x002ba402 in __kernel_vsyscall ()
>> (gdb) thr a a bt
>>   
>>     
>
> snip ...
>
>   
>> Thread 7 (Thread -1214665840 (LWP 16773)):
>> #0  0x002ba402 in __kernel_vsyscall ()
>> #1  0x00711e2b in read () from /lib/libpthread.so.0
>> #2  0x0024ef62 in do_spawn (logopt=0, options=0, prog=0xb7996bdd "/bin/mount",
>>      argv=0xb7996b60) at /usr/include/bits/unistd.h:35
>> #3  0x0024f8f5 in spawn_mount (logopt=0) at spawn.c:301
>> #4  0x0068bb4d in mount_mount (ap=0x8c651b8, root=0x8c65298 "/disks",
>>      name=0xb7996dd0 "hyperion.0", name_len=10, 
>> ---Type <return> to continue, or q <return> to quit---
>>      what=0xb7996da0 "hyperion.spiretech.com:/disk/0", fstype=0x1379e4 "nfs",
>>      options=0xb7996df0 "udp,rsize=32768,wsize=32768", context=0x215280)
>>      at mount_nfs.c:259
>> #5  0x00128b85 in sun_mount (ap=0x8c651b8, root=0x8c65298 "/disks",
>>      name=0xb7999108 "hyperion.0", namelen=10,
>>      loc=0x8cd0420 "hyperion.spiretech.com:/disk/0", loclen=30,
>>      options=0x8cd00e0 "udp,rsize=32768,wsize=32768", ctxt=0x8c5db38)
>>      at parse_sun.c:638
>> #6  0x00129ebc in parse_mount (ap=0x8c651b8, name=0xb7999108 "hyperion.0",
>>      name_len=10,
>>      mapent=0xb7999080 "-udp,rsize=32768,wsize=32768 hyperion.spiretech.com:/disk/0", context=0x8c5db38) at parse_sun.c:1452
>> #7  0x00ce8c6c in lookup_mount (ap=0x8c651b8, name=0x8ccfb50 "hyperion.0",
>>      name_len=10, context=0x8c5db08) at lookup_yp.c:646
>> #8  0x00250d99 in do_lookup_mount (ap=0x8c651b8, map=0x8c5dac0,
>>      name=0x8ccfb50 "hyperion.0", name_len=10) at lookup.c:669
>> #9  0x00251f13 in lookup_nss_mount (ap=0x8c651b8, source=0x0,
>>      name=0x8ccfb50 "hyperion.0", name_len=10) at lookup.c:731
>> #10 0x00249e9a in do_mount_indirect (arg=0x8ccfaf0) at indirect.c:835
>> #11 0x0070b46b in start_thread () from /lib/libpthread.so.0
>> #12 0x00424dbe in clone () from /lib/libc.so.6
>>   
>>     
>
> It looks like this is what's blocking the rest and it looks OK.
> AFAICT there's no evidence in the backtrace that autofs itself is 
> deadlocked or waiting on a completion message that has been missed.
> If mount(8) is waiting for a mount that's higher up in the tree then 
> everything else should also wait.
> Without more information I'd have to say there's not much autofs can do 
> here.
>   

Or this may be a different example of a kernel lookup bug I've worked on 
recently and I've just not seen it in this context before.
Perhaps a debug log of this happening would provide more info.

Ian
