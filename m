From: Stef Bon <stef@bononline.nl>
Subject: Re: make an executable map rerun.
Date: Wed, 25 Mar 2009 18:47:50 +0100
Message-ID: <49CA6E46.1050307@bononline.nl>
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
>>
>> I can look at the contents of /proc/mounts and here I see the autofs
>> tree, which is kept. So I do not understand your remark
>> saying it is consulted every single lookup. Does the option -browse
>> mather here? I'm using that and because this forces the automounter to
>> remember the data right?
>>     
>
> OK, I was wrong.  Sorry about that (I was confused with the fact that
> program maps don't support the -browse option, since they can't support
> map enumeration).  I admit I am not up to speed on v5.  However, it
> looks to me like a HUP signal will not cause the service thread for your
> mount point to restart unless the actual program map changed.  This
> means the cache will still be in tact, as you observed.  I suspect we
> should probably clear the cache for any maptype that does not support
> enumeration upon receiving a HUP signal.  Ian, what do you think?
>
> Cheers,
> Jeff
Ok,

question: how does the automounter determine that the acual program map 
has changed?

Futher, it may be a good thing to develop an utility which manages 
mountpoints and related maps.
(like autofsctl)

One of the things is to make executable maps run again and let the 
automounter read the data.
Reloading the configuration is another task.

Stef
