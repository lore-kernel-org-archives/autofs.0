From: Stef Bon <stef@bononline.nl>
Subject: Re: make an executable map rerun.
Date: Thu, 26 Mar 2009 09:35:03 +0100
Message-ID: <49CB3E37.4050604@bononline.nl>
References: <49C9F7A0.80603@bononline.nl>	<x498wmtkayg.fsf@segfault.boston.devel.redhat.com>	<49CA5F43.6070408@bononline.nl>
	<x493ad1jz0m.fsf@segfault.boston.devel.redhat.com>
	<49CAF2C1.1080401@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49CAF2C1.1080401@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
>>> No,
>>>
>>> after activating the executable map once, the data provided by the
>>> executable map is kept. I've tested this by
>>> letting the executable map write to an logfile, and it's running seldom.
>>>
>>> I can look at the contents of /proc/mounts and here I see the autofs
>>> tree, which is kept. So I do not understand your remark
>>> saying it is consulted every single lookup. Does the option -browse
>>> mather here? I'm using that and because this forces the automounter to
>>> remember the data right?
>>>       
>
> It just means that autofs won't delete mount point directories after
> they expire. Actually, this case looks like another problem, in that
> we'll get directories that being retained that are no longer valid. Oh
> well, that's something for another day.
>   
I'm checking I understand your reaction. You point at the browse option 
which forces autofs to
not delete mount point directories.
> Anyway, if the entry isn't a multi-mount (in which case it must not be
> forgotten until it expires away) then it will be deleted from the cache
> and the program map consulted again if the cache entry is older than the
> negative timeout. Maybe making the negative timeout smaller would do
> what you need, hopefully without causing other issues. The default
> negative timeout is 60 seconds.
>   
I will try this, but I'm using executable maps which produce a 
multi-mount map.
>   
>> OK, I was wrong.  Sorry about that (I was confused with the fact that
>> program maps don't support the -browse option, since they can't support
>> map enumeration).  I admit I am not up to speed on v5.  However, it
>> looks to me like a HUP signal will not cause the service thread for your
>> mount point to restart unless the actual program map changed.  This
>> means the cache will still be in tact, as you observed.  I suspect we
>> should probably clear the cache for any maptype that does not support
>> enumeration upon receiving a HUP signal.  Ian, what do you think?
>>     
>
> Not really, due to possible active multi-mounts.
> The multi-mounts entries are the reason we have to wait until the mount
> isn't busy.
>   
Ok, checking again here. You mean the case that one of the mountentries, 
part of the multi-mount map
is used (is: mounted) makes that the whole map is not refreshed.

Thanks for your reaction,

Stef Bon
