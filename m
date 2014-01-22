From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Segmentation fault in st_queue_handler()
Date: Tue, 21 Jan 2014 23:59:48 -0200
Message-ID: <CAEySpB5oKye2KJ5H_J=a5YoTBVvPEBW7CN5o6HU+FTmmqh2u5g@mail.gmail.com>
References: <CAEySpB5YrZdPtv=DPXYKf759k7BtCF7JMfK5rmZNDCMs5CuvUw@mail.gmail.com>
	<1322007510.3340.14.camel@perseus.themaw.net>
	<CAEySpB6K3RffsKbnDPMW9Evu_3gayrmm59jdTKMoZd7sqfYL5A@mail.gmail.com>
	<CAEySpB7z0Wy88MLJ-L6CHoRdgGoozmPqF8RqEeHOAG6KO01uZw@mail.gmail.com>
	<CAEySpB4rf8JvSY2yoGX6jhRr3nUQExTGX3pxAodwO0AgHi8ZZA@mail.gmail.com>
	<1322786402.2171.30.camel@perseus.themaw.net>
	<CAEySpB6rq5wU+45_+0BHR3zXVZUhGKbmW-pB4ZN31oubXP9zAA@mail.gmail.com>
	<1390265483.2541.50.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0160c4b0cd65a304f0857aa8
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IeF6eBsRDC+cv2aY+e03zkjytkTD3TB2FxZVfjSvVoc=;
        b=ubjg6gLGXpVQ+7OOebmJKxjO1lscHtTqsKbNPHEuhMT8KLpMU+C4vmuRTqdgXrwde9
         2+UBCSI0PVvEN3B7VNNJjpUMR1ag2suK8hd9QzgpKO/6JxcDbAo4bTnMf9sIZL1aZzeJ
         /wgdCtJRn9rr1JCFR9TR7mSm6+kAon5ZQv4a6WoAnRGODAOXyO1B9zJCyPjV6OVOLewb
         Nx/4rZKt923zeBIVJfUkUOdQIbwaNqFrG7W6GnMEjJFSuOCrtzVC0eQP4tDX0hMxO5mu
         mnLWrfJTgu7Uu9/p9ONVO2jz3wzBL0ZcKuayuvZs4V/Req6RJrTR7/r8LgojKgpTXIg1
         ESGw==
In-Reply-To: <1390265483.2541.50.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

--089e0160c4b0cd65a304f0857aa8
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 20, 2014 at 10:51 PM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2014-01-20 at 14:42 -0200, Leonardo Chiquitto wrote:
>> On Thu, Dec 1, 2011 at 10:40 PM, Ian Kent <raven@themaw.net> wrote:
>> > On Thu, 2011-12-01 at 13:00 -0300, Leonardo Chiquitto wrote:
>> >> On Thu, Nov 24, 2011 at 3:06 PM, Leonardo Chiquitto
>> >> <leonardo.lists@gmail.com> wrote:
>> >> > On Wed, Nov 23, 2011 at 7:14 AM, Leonardo Chiquitto
>> >> > <leonardo.lists@gmail.com> wrote:
>> >> >> On Tue, Nov 22, 2011 at 9:18 PM, Ian Kent <raven@themaw.net> wrote:
>> >> >>> On Tue, 2011-11-22 at 16:34 -0300, Leonardo Chiquitto wrote:
>> >> >>>> Hello,
>> >> >>>>
>> >> >>>> We received a bug report describing a segfault in automount, more
>> >> >>>> specifically at st_queue_handler():
>> >> >>>>
>> >> >>>> 1140 remove:
>> >> >>>> 1141         /* No more tasks for this queue */
>> >> >>>> 1142         if (list_empty(&task->pending)) {
>> >> >>>> 1143           list_del(&task->list);
>> >> >>>> 1144           free(task);
>> >> >>>> 1145           continue;
>> >> >>>> 1146         }
>> >> >>>> 1147
>> >> >>>> 1148         /* Next task */
>> >> >>>> 1149         next = list_entry((&task->pending)->next,
>> >> >>>> 1150               struct state_queue, pending);
>> >> >>>> 1151
>> >> >>>> 1152         list_del(&task->list);
>> >> >>>> 1153         free(task);
>> >> >>>> 1154
>> >> >>>> 1155         list_del_init(&next->pending);     <== SEGV
>> >> >>>> 1156         list_add_tail(&next->list, head);
>> >> >>>> 1157         if (p == head)
>> >> >>>> 1158           p = head->next;
>> >> >>>> 1159       }
>> >> >>>> 1160
>> >> >>>> 1161       if (list_empty(head))
>> >> >>>> 1162         break;
>> >> >>>>
>> >> >>>> The crash happens because we're trying to remove an element from an empty
>> >> >>>> list (next->pending):
>> >> >>>>
>> >> >>>> (gdb) print next
>> >> >>>> $38 = (struct state_queue *) 0x2aaaad1003b0
>> >> >>>>
>> >> >>>> (gdb) print *next
>> >> >>>> $39 = {thid = 0, list = {next = 0x2aaaad1003b8, prev = 0x2aaaad1003b8},
>> >> >>>>   pending = {next = 0x2aaaad500048, prev = 0x2aaaad500048},
>> >> >>>>   ap = 0x55555569d1e0, state = ST_READMAP, busy = 0, done = 0, cancel = 0}
>> >> >>>>
>> >> >>>> (gdb) print next->pending
>> >> >>>> $40 = {next = 0x2aaaad500048, prev = 0x2aaaad500048}  <== Empty
>> >> >>>>
>> >> >>>> (gdb) print *next->pending->next
>> >> >>>> Cannot access memory at address 0x2aaaad500048
>> >> >>>>
>> >> >>>> Should it be testing if the list is not empty before trying to remove the
>> >> >>>> element or this condition should never happen?
>> >> >>>
>> >> >>> There's definitely something fishy going on.
>> >> >>>
>> >> >>> Above, at line 1142 the pending list is checked to see if it is empty so
>> >> >>> it can't be empty if we manage to get to the list_del_init() at line
>> >> >>> 1155 since the list mutex is held during these operations.
>> >> >>
>> >> >> Ah, thanks for pointing this.
>> >> >>
>> >> >>>> Unfortunately I don't have the debug logs, only verbose:
>> >> >>>>
>> >> >>>> Oct 27 16:15:56 host automount[4621]: 83 remaining in /-
>> >> >>>> Oct 27 16:16:03 host automount[4621]: 15 remaining in /usr2
>> >> >>>> Oct 27 16:16:51 host automount[4621]: 83 remaining in /-
>> >> >>>> Oct 27 16:19:10 host automount[4621]: 15 remaining in /usr2
>> >> >>>> Oct 27 16:20:03 host automount[4621]: 83 remaining in /-
>> >> >>>> Oct 27 16:20:03 host automount[4621]: 15 remaining in /usr2
>> >> >>>> Oct 27 16:20:04 host automount[4621]: re-reading master map auto_master
>> >> >>>> Oct 27 16:20:04 host automount[4621]: 83 remaining in /-
>> >> >>>> Oct 27 16:20:04 host kernel: automount[4623]: segfault at
>> >> >>>> 00002aaaad500050 rip 000055555556c9fb rsp 0000000040021190 error 6
>> >> >>>
>> >> >>> I have had recent reports of overlap of tasks.
>> >> >>>
>> >> >>> For example expire not completing before continuing (but only relevant
>> >> >>> for submounts) and read map tasks starting before a current task is
>> >> >>> done.
>> >> >>>
>> >> >>> I have a couple of patches but they've seen little testing since I can't
>> >> >>> reproduce the problems at will.
>> >> >>>
>> >> >>>>
>> >> >>>> And here is the full call trace, for reference:
>> >> >>>>
>> >> >>>> Thread 8 (Thread 4621):
>> >> >>>> #0  do_sigwait (set=0x7fffb4737710, sig=0x7fffb473782c)
>> >> >>>>     at ../nptl/sysdeps/unix/sysv/linux/../../../../../sysdeps/unix/sysv/linux/sigwait.c:65
>> >> >>>> #1  0x00002b1a096c9aed in __sigwait (set=0x7fffb4737710, sig=0x7fffb473782c)
>> >> >>>>     at ../nptl/sysdeps/unix/sysv/linux/../../../../../sysdeps/unix/sysv/linux/sigwait.c:100
>> >> >>>> #2  0x0000555555560b96 in statemachine (argc=<value optimized out>,
>> >> >>>>     argv=<value optimized out>) at automount.c:1327
>> >> >>>> #3  main (argc=<value optimized out>, argv=<value optimized out>)
>> >> >>>>     at automount.c:2142
>> >> >>>>
>> >> >>>> Thread 7 (Thread 4622):
>> >> >>>> #0  0x00002b1a096c6517 in pthread_cond_timedwait@@GLIBC_2.3.2 ()
>> >> >>>>     from /lib64/libpthread.so.0
>> >> >>>> #1  0x0000555555573812 in alarm_handler (arg=<value optimized out>)
>> >> >>>>     at alarm.c:206
>> >> >>>> #2  0x00002b1a096c2193 in start_thread (arg=<value optimized out>)
>> >> >>>>     at pthread_create.c:306
>> >> >>>> #3  0x00002b1a09e480dd in clone () from /lib64/libc.so.6
>> >> >>>>
>> >> >>>> Thread 6 (Thread 4626):
>> >> >>>> #0  0x00002b1a09e3fdc6 in __poll (fds=0x40822150, nfds=3, timeout=-1)
>> >> >>>>     at ../sysdeps/unix/sysv/linux/poll.c:87
>> >> >>>> #1  0x000055555555f2a9 in get_pkt (arg=<value optimized out>)
>> >> >>>>     at automount.c:882
>> >> >>>> #2  handle_packet (arg=<value optimized out>) at automount.c:1019
>> >> >>>> #3  handle_mounts (arg=<value optimized out>) at automount.c:1551
>> >> >>>> #4  0x00002b1a096c2193 in start_thread (arg=<value optimized out>)
>> >> >>>>     at pthread_create.c:306
>> >> >>>> #5  0x00002b1a09e480dd in clone () from /lib64/libc.so.6
>> >> >>>>
>> >> >>>> Thread 5 (Thread 4629):
>> >> >>>> #0  0x00002b1a09e3fdc6 in __poll (fds=0x41023150, nfds=3, timeout=-1)
>> >> >>>>     at ../sysdeps/unix/sysv/linux/poll.c:87
>> >> >>>> #1  0x000055555555f2a9 in get_pkt (arg=<value optimized out>)
>> >> >>>>     at automount.c:882
>> >> >>>> #2  handle_packet (arg=<value optimized out>) at automount.c:1019
>> >> >>>> #3  handle_mounts (arg=<value optimized out>) at automount.c:1551
>> >> >>>> #4  0x00002b1a096c2193 in start_thread (arg=<value optimized out>)
>> >> >>>>     at pthread_create.c:306
>> >> >>>> #5  0x00002b1a09e480dd in clone () from /lib64/libc.so.6
>> >> >>>>
>> >> >>>> Thread 4 (Thread 4630):
>> >> >>>> #0  0x00002b1a09e3fdc6 in __poll (fds=0x41824150, nfds=3, timeout=-1)
>> >> >>>>     at ../sysdeps/unix/sysv/linux/poll.c:87
>> >> >>>> #1  0x000055555555f2a9 in get_pkt (arg=<value optimized out>)
>> >> >>>>     at automount.c:882
>> >> >>>> #2  handle_packet (arg=<value optimized out>) at automount.c:1019
>> >> >>>> #3  handle_mounts (arg=<value optimized out>) at automount.c:1551
>> >> >>>> #4  0x00002b1a096c2193 in start_thread (arg=<value optimized out>)
>> >> >>>>     at pthread_create.c:306
>> >> >>>> #5  0x00002b1a09e480dd in clone () from /lib64/libc.so.6
>> >> >>>>
>> >> >>>> Thread 3 (Thread 23927):
>> >> >>>> #0  _IO_vfscanf_internal (s=0x41921820, format=<value optimized out>,
>> >> >>>>     argptr=0x41921940, errp=0x0) at vfscanf.c:1534
>> >> >>>> #1  0x00002b1a09de6bd5 in _IO_vsscanf (string=0x41921ef8 "0 0",
>> >> >>>>     format=0x2b1a09e91adf " %d %d ", args=0x41921940) at iovsscanf.c:45
>> >> >>>> #2  0x00002b1a09de1e98 in __sscanf (s=0xa <Address 0xa out of bounds>,
>> >> >>>>     format=0x41921100 "0") at sscanf.c:34
>> >> >>>> #3  0x00002b1a09e433e5 in __getmntent_r (stream=0x55555596aa20, mp=0x41924e80,
>> >> >>>>     buffer=0x41921ef8 "0 0", bufsiz=12288) at mntent_r.c:170
>> >> >>>> #4  0x0000555555571429 in get_mnt_list (table=<value optimized out>,
>> >> >>>>     path=0x55555569d610 "/net", include=0) at mounts.c:227
>> >> >>>> #5  0x0000555555561ed9 in expire_proc_indirect (arg=<value optimized out>)
>> >> >>>>     at indirect.c:554
>> >> >>>> #6  0x00002b1a096c2193 in start_thread (arg=<value optimized out>)
>> >> >>>>     at pthread_create.c:306
>> >> >>>> #7  0x00002b1a09e480dd in clone () from /lib64/libc.so.6
>> >> >>>>
>> >> >>>> Thread 2 (Thread 23928):
>> >> >>>> #0  0x00002b1a09e3a91b in read () from /lib64/libc.so.6
>> >> >>>> #1  0x00002b1a09defca2 in _IO_new_file_underflow (fp=0x555555989470)
>> >> >>>>     at fileops.c:590
>> >> >>>> #2  0x00002b1a09df042e in _IO_default_uflow (fp=0x67) at genops.c:435
>> >> >>>> #3  0x00002b1a09de56e4 in _IO_getline_info (fp=0x555555989470,
>> >> >>>>     buf=0x41a22e80 "auto.projects /a/b/c/d autofs
>> >> >>>> rw,fd=7,pgrp=4621,timeout=86400,minproto=5,maxproto=5,direct=5,maxproto=5,direct",
>> >> >>>> n=12184,
>> >> >>>>     delim=10, extract_delim=1, eof=0x0) at iogetline.c:74
>> >> >>>> #4  0x00002b1a09dedec9 in fgets_unlocked (
>> >> >>>>     buf=0x41a22e80 "auto.projects /a/b/c/d autofs
>> >> >>>> rw,fd=7,pgrp=4621,timeout=86400,minproto=5,maxproto=5,direct=5,maxproto=5,direct",
>> >> >>>>     at fileops.c:590
>> >> >>>> #2  0x00002b1a09df042e in _IO_default_uflow (fp=0x67) at genops.c:435
>> >> >>>> #3  0x00002b1a09de56e4 in _IO_getline_info (fp=0x555555989470,
>> >> >>>>     buf=0x41a22e80 "auto.projects /a/b/c/d autofs
>> >> >>>> rw,fd=7,pgrp=4621,timeout=86400,minproto=5,maxproto=5,direct=5,maxproto=5,direct",
>> >> >>>> n=12184,
>> >> >>>>     delim=10, extract_delim=1, eof=0x0) at iogetline.c:74
>> >> >>>> #4  0x00002b1a09dedec9 in fgets_unlocked (
>> >> >>>>     buf=0x41a22e80 "auto.projects /a/b/c/d autofs
>> >> >>>> rw,fd=7,pgrp=4621,timeout=86400,minproto=5,maxproto=5,direct=5,maxproto=5,direct",
>> >> >>>>     n=<value optimized out>, fp=0x555555989470) at iofgets_u.c:56
>> >> >>>> #5  0x00002b1a09e43252 in __getmntent_r (stream=0x555555989470, mp=0x41a25e80,
>> >> >>>>     buffer=0x41a22e80 "auto.projects /a/b/c/d autofs
>> >> >>>> rw,fd=7,pgrp=4621,timeout=86400,minproto=5,maxproto=5,direct=5,maxproto=5,direct",
>> >> >>>>     bufsiz=12288) at mntent_r.c:133
>> >> >>>> #6  0x0000555555571429 in get_mnt_list (table=<value optimized out>,
>> >> >>>>     path=0x55555569d960 "/usr2", include=0) at mounts.c:227
>> >> >>>> #7  0x0000555555561ed9 in expire_proc_indirect (arg=<value optimized out>)
>> >> >>>>     at indirect.c:554
>> >> >>>> #8  0x00002b1a096c2193 in start_thread (arg=<value optimized out>)
>> >> >>>>     at pthread_create.c:306
>> >> >>>> #9  0x00002b1a09e480dd in clone () from /lib64/libc.so.6
>> >> >>>>
>> >> >>>> Thread 1 (Thread 4623):
>> >> >>>> #0  st_queue_handler (arg=<value optimized out>) at ../include/list.h:79
>> >> >>>> #1  0x00002b1a096c2193 in start_thread (arg=<value optimized out>)
>> >> >>>>     at pthread_create.c:306
>> >> >>>> #2  0x00002b1a09e480dd in clone () from /lib64/libc.so.6
>> >> >>>
>> >> >>> So the SEGV is in thread 1?
>> >> >>
>> >> >> Yes.
>> >> >>
>> >> >>> Now did you work out the location of the SEGV from this backtrace?
>> >> >>
>> >> >> I cross checked some facts. This is what gdb prints when I open the core
>> >> >> dump:
>> >> >>
>> >> >>  Core was generated by `/usr/sbin/automount -p /var/run/automount.pid'.
>> >> >>  Program terminated with signal 11, Segmentation fault.
>> >> >>  #0  st_queue_handler (arg=<value optimized out>) at ../include/list.h:79
>> >> >>  79            next->prev = prev;
>> >> >>
>> >> >> And this is the segfault message printed by the kernel:
>> >> >>
>> >> >>  Oct 27 16:20:04 host kernel: automount[4623]: segfault at
>> >> >>  00002aaaad500050 rip 000055555556c9fb rsp 0000000040021190 error 6
>> >> >>
>> >> >> Disassembling %RIP confirms the function st_queue_handler() was running:
>> >> >>
>> >> >>  (gdb) disassemble 0x000055555556c9fb
>> >> >>  Dump of assembler code for function st_queue_handler:
>> >> >>     0x000055555556c860 <+0>:   push   %r13
>> >> >> (...)
>> >> >>  => 0x000055555556c9fb <+411>: mov    %rdx,0x8(%rcx)
>> >> >>
>> >> >>  %RCX is 0x2aaaad500048 and the SEGV happened when it tried to deref
>> >> >>  0x2aaaad500048+0x8 (0x2aaaad500050).
>> >> >>
>> >> >> Figuring out where exactly inside st_queue_handler() the crash happened
>> >> >> was a bit trickier because all these list functions are inlined by the compiler,
>> >> >> so the assembly code gets more complicated.
>> >> >>
>> >> >>> We can't be sure this is really the source of the SEGV.
>> >> >>> Does your customer see a different failure location on other occurrences
>> >> >>> of the SEGV?
>> >> >>
>> >> >> So far it occurred only once.
>> >> >
>> >> > Ian,
>> >> >
>> >> > Another idea:
>> >> >
>> >> > 1140 remove:
>> >> > 1141         /* No more tasks for this queue */
>> >> > 1142         if (list_empty(&task->pending)) {
>> >> > 1143           list_del(&task->list);
>> >> > 1144           free(task);
>> >> > 1145           continue;
>> >> > 1146         }
>> >> >
>> >> > As you said, at this point &task->pending has at least one element.
>> >> >
>> >> > 1148         /* Next task */
>> >> > 1149         next = list_entry((&task->pending)->next,
>> >> > 1150               struct state_queue, pending);
>> >> >
>> >> > Now what could be happening here is that (&task->pending)->next == task.
>> >
>> > Anything is possible but if there is anything on the pending list it
>> > should not have had a task started, since it is pending. We would need
>> > to work out if there is a case where a task is taken from the pending
>> > list, started and not moved to the task list or just copied not deleted
>> > from the pending list. On the face of it, it doesn't look like that can
>> > happen.
>> >
>> >> >
>> >> > 1152         list_del(&task->list);
>> >> > 1153         free(task);
>> >> >
>> >> > Since we free task here, &next won't be valid anymore in the next line:
>> >> >
>> >> > 1155         list_del_init(&next->pending);
>> >> > 1156         list_add_tail(&next->list, head);
>> >> > 1157         if (p == head)
>> >> > 1158           p = head->next;
>> >> >
>> >> > Proposed fix:
>> >> >
>> >> > diff --git a/daemon/state.c b/daemon/state.c
>> >> > index 51809a1..0015618 100644
>> >> > --- a/daemon/state.c
>> >> > +++ b/daemon/state.c
>> >> > @@ -1150,12 +1150,12 @@ remove:
>> >> >                                                        struct state_queue, pending);
>> >> >
>> >> >                                list_del(&task->list);
>> >> > -                               free(task);
>> >> >
>> >> >                                list_del_init(&next->pending);
>> >> >                                list_add_tail(&next->list, head);
>> >> >                                if (p == head)
>> >> >                                        p = head->next;
>> >> > +                               free(task);
>> >> >                        }
>> >> >
>> >> >                        if (list_empty(head))
>> >> >
>> >> >
>> >> > Before commit 6273ab63c, task was being freed after the call to list_del_init().
>> >> > What do you think?
>> >
>> > We can try it but since the problem is so infrequent it will be hard to
>> > confirm.
>> >
>> > The real problem is that we don't really know the root cause.
>> > It could be late reporting or an indirect fail caused by something in
>> > another place in the code. This sort of bug is really difficult to
>> > diagnose.
>> >
>> >>
>> >> Ian,
>> >>
>> >> Do you think this makes sense or is it just masking a symptom of a
>> >> more generic bug?
>> >
>> > It's probably a symptom of something else, *sigh*.
>> >
>> > btw, the git repo is now available at kernel.org.
>> > Check http://git.kernel.org/ and search for autofs.
>> > I haven't committed any updates yet and probably won't until some time
>> > after I have posted a message to the new autofs mailing list telling
>> > everyone about it.
>> >
>> >>
>> >> Thanks,
>> >> Leonardo
>>
>> Hello Ian,
>>
>> Sorry to resurrect such an old thread. We're still carrying this patch
>> in our package and I'd like to get rid of it, preferably by getting it
>> accepted upstream :-)
>>
>> As described above, the core dump analysis really pointed to an
>> use after free condition when (&task->pending)->next == task. It's
>> unfortunate that we received such report only once and had no
>> specific info about the circumstances that could trigger the problem.
>>
>> In any case, moving free(task) to the end of the block should be
>> safe and is actually how it was done before commit 6273ab63c. Do
>> you think you can accept the patch as is?
>
> I didn't see a patch in the previous thread.
> Presumably you have a patch with a description you could post.
>
> TBH, I don't think it's worth perusing this further since the change
> looks safe enough I can just add it to my commit queue for the next time
> I commit changes.

Sure! Please see the patch attached (for some reason Gmail is no
longer expanding tabs here).

Thanks,
Leonardo

--089e0160c4b0cd65a304f0857aa8
Content-Type: text/x-patch; charset=US-ASCII; name="autofs-5.0.8-task-use-after-free.patch"
Content-Disposition: attachment; 
	filename="autofs-5.0.8-task-use-after-free.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqpy2dwt0

QW5hbHlzaXMgb2YgYSBjb3JlIGR1bXAgZ2VuZXJhdGVkIGJ5IGEgc2VnbWVudGF0aW9uIGZhdWx0
IGluCmF1dG9tb3VudCBzaG93cyBhIHBvc3NpYmxlIHVzZS1hZnRlci1mcmVlIGluIHN0X3F1ZXVl
X2hhbmRsZXIoKQp3aGVuICgmdGFzay0+cGVuZGluZyktPm5leHQgPT0gdGFzazoKCjExNjkgICAg
ICAgICAvKiBOZXh0IHRhc2sgKi8KMTE3MCAgICAgICAgIG5leHQgPSBsaXN0X2VudHJ5KCgmdGFz
ay0+cGVuZGluZyktPm5leHQsCjExNzEgICAgICAgICAgICAgICBzdHJ1Y3Qgc3RhdGVfcXVldWUs
IHBlbmRpbmcpOwoxMTcyIAoxMTczICAgICAgICAgbGlzdF9kZWwoJnRhc2stPmxpc3QpOwoxMTc0
ICAgICAgICAgZnJlZSh0YXNrKTsJCQoKVGhlIG1lbW9yeSBpbiAqdGFzayBpcyBmcmVlZCBidXQg
bmV4dCBzdGlsbCBwb2ludHMgdG8gaXQsIHJlc3VsdGluZwppbiBhIGNyYXNoIHdoZW4gdHJ5aW5n
IHRvIGRlcmVmZXJlbmNlIG5leHQtPnBlbmRpbmc6CgoxMTc2ICAgICAgICAgbGlzdF9kZWxfaW5p
dCgmbmV4dC0+cGVuZGluZyk7CT0+IFNFR1YKMTE3NyAgICAgICAgIGxpc3RfYWRkX3RhaWwoJm5l
eHQtPmxpc3QsIGhlYWQpOwoxMTc4ICAgICAgICAgaWYgKHAgPT0gaGVhZCkKMTE3OSAgICAgICAg
ICAgcCA9IGhlYWQtPm5leHQ7CjExODAgICAgICAgfQoKQmVmb3JlIGNvbW1pdCA2MjczYWI2M2Ms
IHRhc2sgd2FzIGJlaW5nIGZyZWVkIGFmdGVyIHRoZSBjYWxsIHRvCmxpc3RfZGVsX2luaXQoKS4g
IFRoaXMgcGF0Y2ggcmVpbnRyb2R1Y2VzIHRoaXMgYmVoYXZpb3IgYnkgbW92aW5nCnRoZSBjYWxs
IHRvIGZyZWUoKSB0byB0aGUgZW5kIG9mIHRoZSBibG9jay4KSW5kZXg6IGF1dG9mcy9kYWVtb24v
c3RhdGUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Ci0tLSBhdXRvZnMub3JpZy9kYWVtb24vc3RhdGUuYworKysgYXV0
b2ZzL2RhZW1vbi9zdGF0ZS5jCkBAIC0xMTcxLDEyICsxMTcxLDEyIEBAIHJlbW92ZToKIAkJCQkJ
CQlzdHJ1Y3Qgc3RhdGVfcXVldWUsIHBlbmRpbmcpOwogCiAJCQkJbGlzdF9kZWwoJnRhc2stPmxp
c3QpOwotCQkJCWZyZWUodGFzayk7CiAKIAkJCQlsaXN0X2RlbF9pbml0KCZuZXh0LT5wZW5kaW5n
KTsKIAkJCQlsaXN0X2FkZF90YWlsKCZuZXh0LT5saXN0LCBoZWFkKTsKIAkJCQlpZiAocCA9PSBo
ZWFkKQogCQkJCQlwID0gaGVhZC0+bmV4dDsKKwkJCQlmcmVlKHRhc2spOwogCQkJfQogCiAJCQlp
ZiAobGlzdF9lbXB0eShoZWFkKSkK
--089e0160c4b0cd65a304f0857aa8--
