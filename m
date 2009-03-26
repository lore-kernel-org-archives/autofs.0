From: Ian Kent <raven@themaw.net>
Subject: Re: make an executable map rerun.
Date: Thu, 26 Mar 2009 12:13:05 +0900
Message-ID: <49CAF2C1.1080401@themaw.net>
References: <49C9F7A0.80603@bononline.nl>	<x498wmtkayg.fsf@segfault.boston.devel.redhat.com>	<49CA5F43.6070408@bononline.nl>
	<x493ad1jz0m.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x493ad1jz0m.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> Stef Bon <stef@bononline.nl> writes:
> 
>> Jeff Moyer wrote:
>>> Stef Bon <stef@bononline.nl> writes:
>>>
>>>   
>>>> Hello,
>>>>
>>>> I've been working on a solution to make networkresources available
>>>> via autofs on a dynamic way. After login with help
>>>> from ConsoleKit a mountpoint is added to the master file of the
>>>> automounter. This mountpoint is in the homedirectory of the user
>>>> logging in.
>>>>
>>>> This way I've a browseable network map in my home directory for
>>>> Windows Networks (via cifs), FTP (via curlftpfs/FUSE) and SSH (with
>>>> sshfs/FUSE). Others, like Novell should be possible.
>>>>     
>>> This sounds like interesting work.  Do you have it posted somewhere?
>>>   
>> Yes, look at:
>>
>> http://linux.bononline.nl/linux/automountsmbshares/index.php
>>>   
>>>> It works with executable maps. Now for some reasons I would like
>>>> some control over rerrunning the executable map, to make the
>>>> automounter refresh the autofs data. Now I do not see how to do
>>>> that. I reload signal does not do that.
>>>>
>>>> Is there a way to do this?
>>>>     
>>> No caching is done for program maps.  They are consulted for every
>>> single lookup, so you shouldn't have to do anything special.  Is this
>>> not the behaviour you are observing?
>>>   
>> No,
>>
>> after activating the executable map once, the data provided by the
>> executable map is kept. I've tested this by
>> letting the executable map write to an logfile, and it's running seldom.
>>
>> I can look at the contents of /proc/mounts and here I see the autofs
>> tree, which is kept. So I do not understand your remark
>> saying it is consulted every single lookup. Does the option -browse
>> mather here? I'm using that and because this forces the automounter to
>> remember the data right?

It just means that autofs won't delete mount point directories after
they expire. Actually, this case looks like another problem, in that
we'll get directories that being retained that are no longer valid. Oh
well, that's something for another day.

Anyway, if the entry isn't a multi-mount (in which case it must not be
forgotten until it expires away) then it will be deleted from the cache
and the program map consulted again if the cache entry is older than the
negative timeout. Maybe making the negative timeout smaller would do
what you need, hopefully without causing other issues. The default
negative timeout is 60 seconds.

> 
> OK, I was wrong.  Sorry about that (I was confused with the fact that
> program maps don't support the -browse option, since they can't support
> map enumeration).  I admit I am not up to speed on v5.  However, it
> looks to me like a HUP signal will not cause the service thread for your
> mount point to restart unless the actual program map changed.  This
> means the cache will still be in tact, as you observed.  I suspect we
> should probably clear the cache for any maptype that does not support
> enumeration upon receiving a HUP signal.  Ian, what do you think?

Not really, due to possible active multi-mounts.
The multi-mounts entries are the reason we have to wait until the mount
isn't busy.

Ian
