From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mounts drives that should not be mounted.
Date: Thu, 21 Sep 2006 11:24:52 +0800
Message-ID: <1158809093.3148.34.camel@raven.themaw.net>
References: <loom.20060920T144018-489@post.gmane.org>
	<loom.20060920T152128-874@post.gmane.org>
	<1158762835.19382.37.camel@raven.themaw.net>
	<loom.20060920T165402-267@post.gmane.org>
	<1158765912.19382.42.camel@raven.themaw.net>
	<loom.20060920T200107-929@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <loom.20060920T200107-929@post.gmane.org>
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
To: jack snodgrass <mylinuxguy+autofs@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2006-09-20 at 18:05 +0000, jack snodgrass wrote:
> Ian Kent <raven <at> themaw.net> writes:
> 
> > 
> > Yep. That will certainly mount /myth/store, as it should, but I don't
> > know why the other mounts are being mounted.
> > 
> > I don't have any other similar reports and the autofs version you are
> > using has been current for quite a while now.
> > 
> > As for the kernel, the autofs4 stuff in it has also been there for quite
> > a while.
> > 
> > I'll have a go at trying to reproduce it as soon as I get some time.
> > Sorry I can't be more helpful.
> > 
> > Ian
> > 
> 
> 
> I did some testing on a FC5 vmware image I had. The mounts only occur 
> for real ( or virtual ) drives and not just file-system mount points or
> NFS mount points. if I have :/dev/hdX in a auto.map file, nfs tries to 
> mount all of those devices.  I am pretty sure that this is some sort 
> of NFS 'feature'. 
> 
> I've moved my stuff over to samba ( -tcifs ) and it seems like samba
> is going to allow me to have :/dev/hdX references in my auto.map files
> and not mount them unless I use them. 

That sounds like it's just avoiding what sounds like a fairly serious
bug. It would be better if we could get to the bottom of it.

Could you get me a dedug log please.
See http://people.redhat.com/jmoyer to verify you have syslog setup to
capture the output.

Ian
