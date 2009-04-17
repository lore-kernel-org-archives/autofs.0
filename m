From: Ian Kent <raven@themaw.net>
Subject: Re: Negative caching of failed mount attempts
Date: Fri, 17 Apr 2009 19:40:44 +0800
Message-ID: <49E86ABC.70706@themaw.net>
References: <c2d0b6ec0904161339j3573f25em3b6a1ac1168fa032@mail.gmail.com>	
	<49E7E544.8070609@themaw.net>
	<c2d0b6ec0904170328k54fd9068h883434b6be217dd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <c2d0b6ec0904170328k54fd9068h883434b6be217dd9@mail.gmail.com>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

Leonardo Chiquitto wrote:
>>> Three years ago, commit 2d753e62b8 removed kernel-side caching
>>> of mount attempts that returns -ENOENT. Apparently it wasn't
>>> working as it should.
>> It stopped working when 2.6 was released due to changes in the VFS.
>> These changes made it extremely hard to do in the kernel module. Efforts
>> to do it in the kernel module have been abandoned at this stage.
> 
> Thanks for the details.
> 
>> I guess that's what it amounts to, since all the effort is going into v5.
>>
>> I have a bunch of patches for v4 from Jeff Moyer that I've not got
>> around to looking closely at and applying. We didn't get as far as the
>> negative lookup caching patch though. In fact I don't think it had been
>> written then.
> 
> I just checked that Jeff implemented it for RHEL 4. I'll take a look.
> 
>> What version of autofs?
> 
> autofs-4.1.4
> 
>> Do you have any other patches applied to it?
> 
> Yes, I have all patches released after 4.1.4 (SLES 10 autofs package).

So what do you have, 4.1.4 will all the patches from kernel.org or the
SLES 10 package, or an SLES 10 update of some sort?

> 
> Thanks,
> Leonardo
