From: Joe Pruett <joey@clean.q7.com>
Subject: Re: latest autofs from centos 4
Date: Tue, 18 Nov 2008 11:02:00 -0800 (PST)
Message-ID: <alpine.LRH.2.00.0811181056070.18255@q7.q7.com>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
	<1221668372.3001.28.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
	<1221669383.3001.35.camel@raven.themaw.net>
	<x49od2m7m88.fsf@segfault.boston.devel.redhat.com>
	<alpine.LRH.2.00.0809171021540.12947@q7.q7.com>
	<x49prn2br6i.fsf@segfault.boston.devel.redhat.com>
	<alpine.LRH.2.00.0809171049520.12947@q7.q7.com>
	<x49d4j2bqft.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49d4j2bqft.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Wed, 17 Sep 2008, Jeff Moyer wrote:

> Joe Pruett <joey@clean.q7.com> writes:
>
>>>> well, it's a production box and only seems to show the problem at boot
>>>> time.  from looking at the logs, i think this is the underlying
>>>> culprit:
>>>>
>>>> Sep 17 09:18:08 hyperion kernel: RPC: Can't bind to reserved port (98).
>>>> Sep 17 09:18:08 hyperion kernel: RPC: can't bind to reserved port.
>>>> Sep 17 09:18:08 hyperion kernel: RPC: error 5 connecting to server jupiter.spiretech.com
>>>> Sep 17 09:18:08 hyperion kernel: RPC: Can't bind to reserved port (98).
>>>> Sep 17 09:18:08 hyperion kernel: RPC: can't bind to reserved port.
>>>> Sep 17 09:18:08 hyperion kernel: RPC: error 5 connecting to server jupiter.spiretech.com
>>>
>>>> that is from the client trying to talk to the server.
>>>
>>> That's strange.  Errno 98 is EADDRINUSE.  So, this means that you cycled
>>> through the entire port range and all of the ports were bound.  Do you
>>> do a lot of mounts upon boot?  Can you try tweaking sunrpc.min_resvport
>>> and sunrpc.max_resvport?  Max can't be more than 1023.  Try pushing min
>>> down to 500 or so.
>>
>> i have run into this kind of problem in the past (running out of
>> privileged ports).  i found some code in glibc that seemed to be the
>> biggest problem and never got around to trying to fix it.  i'll look
>> at what my current settings are and see about tweaking them.
>
> Details would be welcome.  The biggest offender we found was that the
> portmapper interfaces would use reserved ports.  That is simply not
> necessary, and those issues have been fixed in autofs and mount.nfs.  In
> fact, we've got regression tests that make sure that this is the case.

since i had my hang last night i have dug back into this.  the big culprit 
is getgrouplist (or so it seems) that opens the group.byname map with a yp 
all call and it does that from a privileged port.  watching my mail 
server, i see it burn through priv ports at quite a rapid clip (5 per 
second or so).  i am going to see why it doesn't use the netid map.  it 
could just be glibc not having that feature.
