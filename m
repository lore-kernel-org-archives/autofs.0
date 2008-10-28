From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 4/6] autofs4 - make autofs type usage explicit
Date: Tue, 28 Oct 2008 09:24:00 -0400
Message-ID: <x49tzaw6efj.fsf@segfault.boston.devel.redhat.com>
References: <20081023023513.4508.54940.stgit@raven.themaw.net>
	<20081023023532.4508.56823.stgit@raven.themaw.net>
	<20081027134050.c85a28dd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20081027134050.c85a28dd.akpm@linux-foundation.org> (Andrew
	Morton's message of "Mon, 27 Oct 2008 13:40:50 -0700")
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 23 Oct 2008 10:35:32 +0800
> Ian Kent <raven@themaw.net> wrote:
>
>> This patch further improves autofs mount type usage and provides
>> supplementry explanation of the changes made in the previous patch
>> "autofs4 - cleanup autofs mount type usage".
>> 
>> Changes introduced in "autofs4 - cleanup autofs mount type usage":
>> 
>> - the type assigned at mount when no type is given is changed
>>   from 0 to AUTOFS_TYPE_INDIRECT. This was done because 0 and
>>   AUTOFS_TYPE_INDIRECT were being treated implicitly as the same
>>   type.
>> 
>> - previously, an offset mount had it's type set to
>>   AUTOFS_TYPE_DIRECT|AUTOFS_TYPE_OFFSET but the mount control
>>   re-implementation needs to be able distinguish all three types.
>>   So this was changed to make the type setting explicit.
>> 
>> - a type AUTOFS_TYPE_ANY was added for use by the re-implementation
>>   when checking if a given path is a mountpoint. It's not really a
>>   type as we use this to ask if a given path is a mountpoint in the
>>   autofs_dev_ioctl_ismountpoint() function.
>> 
>> Changes introduced in this patch:
>> 
>> - macros to set and test the autofs mount types have been added to
>>   improve readability and make the type usage explicit.
>
>     ^^^^^^^^^^^^^^^^^^^  <<-- ??

Just for some background, I requested a change here.  The reason is that
I ran into problems in the user space daemon where there was this notion
of a bitfield that wasn't always treated as a bitfield.  So
AUTOFS_TYPE_ANY should be all bits set, right?  Nope.  Some places in
the code tested with binary operators, others with ==.  It was confusing
and error-prone.  The accessor functions at least normalize the interface.

Cheers,

Jeff
