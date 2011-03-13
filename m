From: Ian Kent <raven@themaw.net>
Subject: Re: Recovering from the loss of a NFS Server
Date: Sun, 13 Mar 2011 17:17:52 +0800
Message-ID: <1300007872.2906.17.camel@perseus>
References: <4A961A51CBE84C429C56E5734477BD1F2DBB789448@EXCHAMRS03.na.blkint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=O0CU0DInthXp/Ljks1/emsToKe0=;
	b=Sn2O5JxoiIsqAYhdZPXdLITqK25wbnkAac/SWJuydS0oAqXAX14R8LZcosDbi1Um8WMDZ9Omf4TQFjUkowYAoXOJr2dlTRpHwN84oyV/CZmmcWE+9oaRQkpxMQw86hzFZ4Aj3G4F7HTgWWIKBNm/dei8eU+SQs7lSwxQFhhiEnM=
In-Reply-To: <4A961A51CBE84C429C56E5734477BD1F2DBB789448@EXCHAMRS03.na.blkint.com>
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
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

On Sat, 2011-03-12 at 23:27 -0500, Breitman, Jason wrote:
> OS
> 	Linux hostname 2.6.18-238.el5 #1 SMP Sun Dec 19 14:22:44 EST 2010 x86_64 x86_64 x86_64 GNU/Linux
> 
> autofs package
> 	autofs-5.0.1-0.rc2.148.bz579312.1.el5
> 
> Mount options
> 	$ cat /etc/auto.master
> 	# Master map for automounter
> 	#
> 	/home             auto_home               -hard,intr,retry=10
> 
> 	$ cat /etc/sysconfig/autofs
> 	TIMEOUT=86400 - we have a long TIMEOUT to avoid mount storms.
> 
> What am I trying to do?
> 	Prior to a disaster recovery test, my home directory will be mounted from my-nfs-server.domainname:/home/jbreitma.
> 	At this point my-nfs-server.domainname points to 1.1.1.1.
> 	There are active reads and writes to my home directory.
> 	Lets say I have a subdirectory called htdocs and am running apache.
> 
> 	Now we are cutoff from 1.1.1.1 because the Data Center where 1.1.1.1 lives is no longer accessible.
> 	We simulate this with an ACL.
> 	We now repoint my-nfs-server.domainname to 2.2.2.2.
> 
> 	The NFS Clients where /home/jbreitma is mounted are now confused.
> 
> 	What is my best coarse of action?
> 		umount -l /home/jbreitma
> 		/etc/init.d/autofs restart
> 		fuser -k /home/jbreitma
> 		kill -USR1 `pgrep automount`
> 		etc ...

That's about all you can do.

The "umount -l" has it's own set of problems.
In particular any process that has an active mount must do a "cd ." (I
believe that will work) to recover from the changed mount otherwise
getcwd(3) will fail and /proc/<pid>/cwd will point to "/" instead of a
valid working directory.

Also, there is pretty much no way to get the RPC layer to give up on
those outstanding IOs which will cause ongoing problems.

> 
> 	How do I recover from this situation?	

There's not much you can do for read/write mounts and even read only
fail over hasn't been implemented within the Linux kernel NFS client.

> 	I am open to a new approach if that is required.

The only way I think high availability NFS can work today is when the
backend deals with the change such as in Clustered environments.

> 
> 
> I have had some success with umount -l /home/jbreitma followed by
> a /etc/init.d/autofs restart, but this does not always work.
> I specifically fail when active writes and or reads are occurring
> to /home/jbreitma.
> 		
> 
> Jason Breitman
> A&T-Tech-GTI
> Jason.Breitman@blackrock.com
> BlackRock
> 
> THIS MESSAGE AND ANY ATTACHMENTS ARE CONFIDENTIAL, PROPRIETARY, AND MAY BE PRIVILEGED.  If this message was misdirected, BlackRock, Inc. and its subsidiaries, ("BlackRock") does not waive any confidentiality or privilege.  If you are not the intended recipient, please notify us immediately and destroy the message without disclosing its contents to anyone.  Any distribution, use or copying of this e-mail or the information it contains by other than an intended recipient is unauthorized.  The views and opinions expressed in this e-mail message are the author's own and may not reflect the views and opinions of BlackRock, unless the author is authorized by BlackRock to express such views or opinions on its behalf.  All email sent to or from this address is subject to electronic storage and r
 eview by BlackRock.  Although BlackRock operates anti-virus programs, it does not accept responsibility for any damage whatsoever caused by viruses being passed.
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
