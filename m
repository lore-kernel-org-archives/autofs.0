From: jack snodgrass <mylinuxguy+autofs@gmail.com>
Subject: Re: autofs mounts drives that should not be mounted.
Date: Wed, 20 Sep 2006 18:05:06 +0000 (UTC)
Message-ID: <loom.20060920T200107-929@post.gmane.org>
References: <loom.20060920T144018-489@post.gmane.org>
	<loom.20060920T152128-874@post.gmane.org>
	<1158762835.19382.37.camel@raven.themaw.net>
	<loom.20060920T165402-267@post.gmane.org>
	<1158765912.19382.42.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Ian Kent <raven <at> themaw.net> writes:

> 
> Yep. That will certainly mount /myth/store, as it should, but I don't
> know why the other mounts are being mounted.
> 
> I don't have any other similar reports and the autofs version you are
> using has been current for quite a while now.
> 
> As for the kernel, the autofs4 stuff in it has also been there for quite
> a while.
> 
> I'll have a go at trying to reproduce it as soon as I get some time.
> Sorry I can't be more helpful.
> 
> Ian
> 


I did some testing on a FC5 vmware image I had. The mounts only occur 
for real ( or virtual ) drives and not just file-system mount points or
NFS mount points. if I have :/dev/hdX in a auto.map file, nfs tries to 
mount all of those devices.  I am pretty sure that this is some sort 
of NFS 'feature'. 

I've moved my stuff over to samba ( -tcifs ) and it seems like samba
is going to allow me to have :/dev/hdX references in my auto.map files
and not mount them unless I use them. 

Not sure about the preformance yet ( this is all on a private, giga-bit, 
jumbo-frame lan ) but at least I can leave my drives in sleep mode 
and only power them up when needed. 

Thanks - jack 
