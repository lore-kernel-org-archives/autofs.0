From: Marcel De Boer <marcel.de_boer@nokia.com>
Subject: Re: Near-simultaneous automount of multiple directories fails
Date: Fri, 8 Apr 2016 13:37:40 +0200
Message-ID: <alpine.LRH.2.11.1604081231040.26210@carrot.ant.ipd.priv>
References: <alpine.LRH.2.11.1604080846130.26210@carrot.ant.ipd.priv>  <1460105679.2979.2.camel@themaw.net> <1460108794.2979.22.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1460108794.2979.22.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: EXT Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hi!

>> Whatever the problem is it isn't access to either of these two 
>> variables or the lists they may represent.
>>
>> They are both local variables of the mount_mount() function and so
>> cannot be accessed simultaneously by any other function.

Too bad... that means my changes probably just mixed up the timing enough 
to avoid the problem.

> Btw, there has been no actual RHEL release of revision 115.
>
> Only 113 in RHEL-6.7 and (probably) revision 122 will be RHEL-6.8.
> So I wonder what else went into revision 115.
<...>
> We probably shouldn't work with revision 122 yet so may be we should
> work with revision 113, not sure about that though.

Ah wait... because it was just for local testing, I also changed the 
patchlevel so yum wouldn't complain. Judging from the build machine 
history, it actually is -113. Postponing writing this mail for too long 
made me forget too much...

> I'm not sure I could reproduce this because I have a stress test (used
> for RHEL) that uses (IIRC) 8 concurrent threads to test mount
> concurrency and to test for mount to expire races.
>
> The maps used are somewhat more complex than what you have here so
> perhaps I missed this point with that test.

The configuration for the server uses indirect maps from the local 
filesystem. All other machines get a slightly different config through 
NIS.

> However, I've recently written another RHEL test (based on this test)
> that uses a simple indirect map with the 8 concurrent threads to try and
> duplicate a different problem.
>
> I would have though this test would expose this sort of problem but
> after (I can't actually remember the longest run) about three days of
> continuous running I didn't see any problems.
>
> Granted it was a different scenario to yours though.

Of course it also looks timing-related, so there's no telling in exactly 
which configuration it'll pop up. For the machine I used for testing (not 
the same hardware as the server), the issue already disappeared when I 
locally rebuilt the same RPM as the one that was already installed.

I already noticed changes in the frequency when I changed the versions of 
supporting packages (libtirpc) or ran it in the foreground or with 
debugging.

> So I think we need to narrow down where this is occurring.
>
> To start with I'd add mutexes around just the parse_location() and
> prune_host_list() functions and then if that also resolves the problem
> drill down from there.

I'll see if I can do that next week (even though the server is busy, it's 
not a disaster if it happens, but I prefer to be around to unwedge it.)

Thanks!

Kind regards,
 	Marcel de Boer

-- 
Marcel de Boer
Test engineer, Service Routing R&D, IP/Optical Networks
Nokia, Antwerp, Belgium

On Fri, 8 Apr 2016, EXT Ian Kent wrote:

> On Fri, 2016-04-08 at 16:54 +0800, Ian Kent wrote:
>> On Fri, 2016-04-08 at 09:55 +0200, Marcel De Boer wrote:
>>> Hi!
>>>
>>> I've already reported this on the CentOS bug tracker a while ago,
>>> but
>>> I
>>> thought I'd report it here too.
>>>
>>> https://bugs.centos.org/view.php?id=9835
>>>
>>> Summarized (there's more information on the bug report): on one of
>>> our
>>> servers we initially saw that every few days one home directory
>>> became
>>> inaccessible. This happened to two different homedirectories (but
>>> only
>>> one
>>> at a time) out of the couple hundred we have. We traced this to
>>> simultaneously scheduled cron scripts running out of the affected
>>> homedirectories, which caused both directories to be mounted nearly
>>> simultaneously.
>>>
>>> A test setup on a different machine (the primary description from
>>> the
>>> bug
>>> report, as the server was not stock CentOS) also showed that if we
>>> had
>>> cron simultaneously mount four directories every 10 minutes, only
>>> half
>>> of
>>> them would get mounted every time. On this machine an RPM rebuild of
>>> autofs made the issue disappear, but it was much more persistent on
>>> the
>>> server.
>>>
>>> Eventually it seems that there is an issue in mount_mount() from
>>> mount_nfs.c; to my untrained eye, it looks like it can get called
>>> simultaneously from different threads, where they change shared
>>> information, probably the 'hosts' or 'tmp' lists.
>>
>> Whatever the problem is it isn't access to either of these two
>> variables
>> or the lists they may represent.
>>
>> They are both local variables of the mount_mount() function and so
>> cannot be accessed simultaneously by any other function.
>
> Btw, there has been no actual RHEL release of revision 115.
>
> Only 113 in RHEL-6.7 and (probably) revision 122 will be RHEL-6.8.
> So I wonder what else went into revision 115.
>
> AFAICS revision 115, if it is truly from RHEL, is a mid debug
> development revision and really shouldn't be used unless provided by
> RedHat support, to get development feedback from testing.
>
> We probably shouldn't work with revision 122 yet so may be we should
> work with revision 113, not sure about that though.
>
> Anyway it could be function calls to some other shared library causing a
> problem.
>
> AFAICS the autofs code called in this region is re-entrant in the same
> way as the hosts and tmp variables are in mount_mount(), so there's
> something else going on.
>
> I'm not sure I could reproduce this because I have a stress test (used
> for RHEL) that uses (IIRC) 8 concurrent threads to test mount
> concurrency and to test for mount to expire races.
>
> The maps used are somewhat more complex than what you have here so
> perhaps I missed this point with that test.
>
> However, I've recently written another RHEL test (based on this test)
> that uses a simple indirect map with the 8 concurrent threads to try and
> duplicate a different problem.
>
> I would have though this test would expose this sort of problem but
> after (I can't actually remember the longest run) about three days of
> continuous running I didn't see any problems.
>
> Granted it was a different scenario to yours though.
>
> So I think we need to narrow down where this is occurring.
>
> To start with I'd add mutexes around just the parse_location() and
> prune_host_list() functions and then if that also resolves the problem
> drill down from there.
>
> Something like (totally untested):
>
> debug
>
> From: Ian Kent <raven@themaw.net>
>
>
> ---
> modules/mount_nfs.c |    9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
> index 84f7bda..95df40f 100644
> --- a/modules/mount_nfs.c
> +++ b/modules/mount_nfs.c
> @@ -54,6 +54,8 @@ int mount_init(void **context)
> 	return !mount_bind;
> }
>
> +static pthread_mutex_t host_list_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> int mount_mount(struct autofs_point *ap, const char *root, const char *name, int name_len,
> 		const char *what, const char *fstype, const char *options,
> 		void *context)
> @@ -190,16 +192,20 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
> 		      nfsoptions, nobind, nosymlink, ro);
> 	}
>
> +	pthread_mutex_lock(&host_list_mutex);
> 	if (!parse_location(ap->logopt, &hosts, what, flags)) {
> 		info(ap->logopt, MODPREFIX "no hosts available");
> +		pthread_mutex_unlock(&host_list_mutex);
> 		return 1;
> 	}
> 	/*
> 	 * We can't probe protocol rdma so leave it to mount.nfs(8)
> 	 * and and suffer the delay if a server isn't available.
> 	 */
> -	if (rdma)
> +	if (rdma) {
> +		pthread_mutex_unlock(&host_list_mutex);
> 		goto dont_probe;
> +	}
>
> 	/*
> 	 * If this is a singleton mount, and NFSv4 only hasn't been asked
> @@ -232,6 +238,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
> 	} else {
> 		prune_host_list(ap->logopt, &hosts, vers, port);
> 	}
> +	pthread_mutex_unlock(&host_list_mutex);
>
> dont_probe:
> 	if (!hosts) {
>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
