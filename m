From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release
Date: Thu, 14 Apr 2005 08:10:42 -0400
Message-ID: <16990.24002.650785.141049@segfault.boston.redhat.com>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
	<Pine.LNX.4.62.0504112324510.6384@donald.themaw.net>
	<16989.52849.68024.30163@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0504141357180.7872@wombat.indigo.net.au>
	<Pine.LNX.4.58.0504141410190.8227@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504141410190.8227@wombat.indigo.net.au>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release; Ian Kent <raven@themaw.net> adds:

raven> On Thu, 14 Apr 2005, Ian Kent wrote:
>> On Wed, 13 Apr 2005, Jeff Moyer wrote:
>> 
>> > 
>> > This new version has regressed since beta2 for /net mounts in my 
>> environment.  A simple ls of /net/<filer> will now show the contents of
>> > /net/<filer>/exporteddir.  So, for example, we have devfiler which
>> exports /vol/vol1.  When I do an ls of /net/devfiler, I get the
>> contents of devfiler:/vol/vol1.
>> > 
>> > Okay, after further debugging, it seems we're not identifying this as
>> a multimount entry.  It's getting late, so I'm going to turn this over
>> to you.  I think that the checking of first_chunk is bogus.  For
>> instance, with the below change, everything works as expected for me.
>>
>> 
>> Cool, I'll check this out and get back.

raven> Could I have the example map entry that breaks the parse please.

Sheesh, you'd think that I could generate a bug report by now... I'll blame
it on the late night thing.  =)

This is an auto.net entry.  Here's what auto.net spits out for this
particular host:

-fstype=nfs,hard,intr,nodev,nosuid \
        /vol/vol1 devfiler:/vol/vol1

I'm guessing you didn't test auto.net against a host that only exported one
dir?  Just a guess.  Below are the debug logs.

Thanks,

Jeff

automount[595]: starting automounter version 4.1.4, path = /net, maptype = program, mapname = /etc/auto.net
autofs: automount startup succeeded
automount[595]: mount(bind): bind_works = 1 
automount[595]: using kernel protocol version 4.05
automount[595]: using timeout 300 seconds; freq 75 secs
automount[595]: handle_packet: type = 0 
automount[595]: handle_packet_missing: token 41, name devfiler 
automount[595]: attempting to mount entry /net/devfiler
automount[603]: lookup(program): looking up devfiler
automount[603]: lookup(program): devfiler -> -fstype=nfs,hard,intr,nodev,nosuid  ^I/vol/vol1 devfiler:/vol/vol1
automount[603]: parse(sun): expanded entry: -fstype=nfs,hard,intr,nodev,nosuid  ^I/vol/vol1 devfiler:/vol/vol1
automount[603]: parse(sun): dequote("fstype=nfs,hard,intr,nodev,nosuid") -> fstype=nfs,hard,intr,nodev,nosuid
automount[603]: parse(sun): gathered options: fstype=nfs,hard,intr,nodev,nosuid
automount[603]: parse(sun): dequote("/vol/vol1") -> /vol/vol1
automount[603]: parse(sun): dequote("devfiler:/vol/vol1") -> devfiler:/vol/vol1
automount[603]: parse(sun): core of entry: options=fstype=nfs,hard,intr,nodev,nosuid, loc=/vol/vol1 devfiler:/vol/vol1
automount[603]: parse(sun): mounting root /net, mountpoint devfiler, what /vol/vol1 devfiler:/vol/vol1, fstype nfs, options hard,intr,nodev,nosuid 
automount[603]: mount(nfs): root=/net name=devfiler what=/vol/vol1 devfiler:/vol/vol1, fstype=nfs, options=hard,intr,nodev,nosuid
automount[603]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
automount[603]: mount(nfs): host /vol/vol1: lookup failure
automount[603]: mount(nfs): winner = devfiler local = 0
automount[603]: mount(nfs): from /vol/vol1 devfiler:/vol/vol1 elected devfiler:/vol/vol1
automount[603]: mount(nfs): calling mkdir_path /net/devfiler
automount[603]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid devfiler:/vol/vol1 /net/devfiler
automount[603]: mount(nfs): mounted devfiler:/vol/vol1 on /net/devfiler
automount[595]: handle_child: got pid 603, sig 0 (0), stat 0 
automount[595]: sig_child: found pending iop pid 603: signalled 0 (sig 0), exit status 0
automount[595]: send_ready: token=41 
automount[595]: sig 12 switching from 1 to 5
automount[595]: get_pkt: state 1, next 5
automount[595]: prep_shutdown: state = 1 
automount[595]: signal_children: send 12 to process group 595
automount[595]: expire_proc: exp_proc=738
automount[595]: prep_shutdown: expire returns 1 
automount[595]: handle_packet: type = 2 
automount[595]: handle_packet_expire_multi: token 42, name devfiler 
automount[739]: expiring path /net/devfiler
automount[739]: umount_multi: path=/net/devfiler incl=1 
automount[739]: umount_multi: unmounting dir=/net/devfiler 
automount[739]: rm_unwanted: /net/devfiler 
automount[739]: expired /net/devfiler
automount[595]: handle_child: got pid 739, sig 0 (0), stat 0 
automount[595]: sig_child: found pending iop pid 739: signalled 0 (sig 0), exit status 0
automount[595]: send_ready: token=42 
automount[595]: handle_child: got pid 738, sig 0 (0), stat 0 
automount[595]: sigchld: exp 738 finished, switching from 5 to 6
automount[595]: get_pkt: state 5, next 6
automount[595]: umount_multi: path=/net incl=0 
automount[595]: umount_multi: no mounts found under /net
automount[595]: shut down, path = /net
autofs: automount shutdown succeeded
