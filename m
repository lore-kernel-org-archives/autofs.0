From: Ian Kent <raven@themaw.net>
Subject: Re: automount restart required
Date: Thu, 05 Nov 2009 09:48:32 +0800
Message-ID: <4AF22EF0.6060501@themaw.net>
References: <5FAC3462B446C244A45ED5303B614911119209EC@NYCPEXV005.na.blkint.com>	<4AF0DF1A.5020006@themaw.net>
	<5FAC3462B446C244A45ED5303B61491111920A20@NYCPEXV005.na.blkint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <5FAC3462B446C244A45ED5303B61491111920A20@NYCPEXV005.na.blkint.com>
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
To: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Cc: autofs@linux.kernel.org

Breitman, Jason wrote:
> Am I reading the version number wrong or is there a different numbering
> scheme inside of RHEL then in Fedora?

Don't be difficult.

All the important fixes are included in the RHEL-5 revision.
In fact, a lot of the time the fixes in the upstream package come from
work on RHEL reported bugs. Admittedly, it can be a while before they
make it into a RHEL release due to the process but the RHEL-5 version
you are using is very close to the Fedora version.

> 	
> http://mirrors.kernel.org/fedora/releases/11/Everything/i386/os/Packages
> /autofs-5.0.4-24.i586.rpm  
> 
> I will work on submitting a bug.
> 
> All I meant by issues is that I would rather deal with losing my
> official Redhat Support by using a Redhat unapproved, yet more stable,
> version of autofs then continue to use the Redhat approved autofs
> package and have automount issues.  Hopefully that makes sense.
> 
> 
> Jason Breitman
> jason.breitman@blackrock.com
> 
> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Tuesday, November 03, 2009 8:56 PM
> To: Breitman, Jason
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] automount restart required
> 
> Breitman, Jason wrote:
>> Operating System: RHEL 5.3 (32 bit)
>>
>> kernel package: kernel-2.6.18-128.el5
>>
>> autofs package: autofs-5.0.1-0.rc2.131.el5_4.1
>>
>> nfs-utils package: nfs-utils-1.0.9-40.el5
>>
>> Map Type: Direct Map stored in NIS
>>
>> Issue:
>> Users and applications will not be able to get into one of the
>> directories in the direct map.
>> The system reports no such file or directory.
>> I can get to the mount point, but not any further.
>>
>> * I can not reproduce the issue on demand.
>> ** The issue does happen on multiple hosts with the same build.
>>
>> Resolution:
>> /etc/init.d/autofs restart
>>
>> Question:
>> I noticed much later versions of autofs on Fedora.  (autofs-5.0.4-XXX)
>> I also read the changelog and there are many fixes that might be
>> considered a solution to my problem.
> 
> I doubt it.
> The RHEL version you have is actually quite close to the Fedora version.
> 
>> Bottom line is what is the most stable package of autofs that I should
>> be using on my RHEL 5.3 Systems.
> 
> The version you have is the latest RHEL version.
> I'm not aware of the problem you describe so log a bug and include your
> maps, a debug log showing the problem and any other information like how
> often it happens.
> 
>> I understand that RHEL support may be affected, but would be willing
> to
>> deal with those issues.
> 
> So now there is more than one issue, what are the other issues?
> 
>> Thanks.
>>
>> Jason Breitman
>> jason.breitman@blackrock.com
>>
>> THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE
> PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM
> DISCLOSURE. If the reader of this message is not the intended recipient,
> you are hereby notified that any dissemination, distribution, copying or
> use of this message and any attachment is strictly prohibited. If you
> have received this message in error, please notify us immediately by
> replying to the message and permanently delete it from your computer and
> destroy any printout thereof.
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
> 
> 
> THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM DISCLOSURE. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution, copying or use of this message and any attachment is strictly prohibited. If you have received this message in error, please notify us immediately by replying to the message and permanently delete it from your computer and destroy any printout thereof.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
