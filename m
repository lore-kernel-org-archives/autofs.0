From: Ian Kent <raven@themaw.net>
Subject: Re: How to determine a path is a mountpoint.
Date: Wed, 17 Feb 2010 01:29:00 +0800
Message-ID: <4B7AD5DC.3010307@themaw.net>
References: <201002152253.46863.stef@bononline.nl> <4B7A0B31.30200@themaw.net>
	<201002161420.44885.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <201002161420.44885.stef@bononline.nl>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On 02/16/2010 09:20 PM, Stef Bon wrote:
> On Tuesday 16 February 2010 04:04:17 Ian Kent wrote:
>> On 02/16/2010 05:53 AM, Stef Bon wrote:
>>> Hello,
>>>
> 
>>
>> Yes, checking /proc/mounts is slow but is the only way when using older
>> versions of the kernel module.
>>
>> In a recent source tree, have a look at lib/mounts.c:is_mounted() and
>> lib/dev-ioctl-lib.c, and in particular dev_ioctl_ismountpoint().
>>
>> Ian
> 
> Thanks for you fast answer.
> 
> I've checked the code and found the functions you're pointed, they are indeed 
> what I'm looking for.
> 
> The function is_mounted looks like an internal function. It makes use of a 
> struct ioctl_ops, which is initialised with get_ioctl_ops.  I do not 
> understand this, cause this function does not use any parameter (like path!) 
> so how does this function determine it's a mountpoint?

Read lib/dev-ioctl-lib.c, that's why I mentioned it, it's not that long.

It implements a set of functions for autofs control operations.

Many of them can't be called by just any process but the
dev_ioctl_ismountpoint() function can. It may not look that simple but
if you take some time to understand what it is doing you can take the
bits you need and that will end up being fairly simple.

The one problem you do have is that if the kernel doesn't have the new
device ioctl interface you will need to scan /proc/mounts, the same as
is done by the is_mounted() function if it sees the new functionality
isn't available.

Ian
