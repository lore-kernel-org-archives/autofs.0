From: Peter Staubach <staubach@redhat.com>
Subject: Re: Kernel patch to better support bind-mounts
Date: Wed, 05 Mar 2008 09:19:37 -0500
Message-ID: <47CEABF9.8090108@redhat.com>
References: <1199788697.26268.24.camel@srss>	 <1204634872.11825.79.camel@srss>
	<47CD4DC9.2030703@redhat.com>
	<1204685216.3081.7.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1204685216.3081.7.camel@raven.themaw.net>
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
> On Tue, 2008-03-04 at 08:25 -0500, Peter Staubach wrote:
>   
>> Lukas Kolbe wrote:
>>     
>>> Hi Ian!
>>>
>>> Ping? :)
>>>
>>> We use this patch now for several servers and clients (debian etch with
>>> 2.6.18, ubuntu feisty with 2.6.20 and some test systems with 2.6.23),
>>> and have seen no regression so far, only working automounts :)
>>> I'd love to see this change upstream, so that I don't have to worry
>>> about constantly patching my own kernel anymore :)
>>>       
>> Why does adding mount on access(2) make things work better?  What works 
>> better?
>>     
>
> Lucas has recursive maps.
> For these mounts to work, we need to ensure that there aren't dependent
> mounts in the mount point path itself before proceeding. We've used the
> access system call, made just prior to performing the mount, to make
> this happen. In this case, however, the lookup flags in the kernel where
> not triggering the mount.

And this does not trigger mounts by other applications, such as ls, too?

    Thanx...

       ps
