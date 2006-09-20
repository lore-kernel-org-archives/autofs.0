From: jack snodgrass <mylinuxguy+autofs@gmail.com>
Subject: Re: autofs mounts drives that should not be mounted.
Date: Wed, 20 Sep 2006 15:00:54 +0000 (UTC)
Message-ID: <loom.20060920T165402-267@post.gmane.org>
References: <loom.20060920T144018-489@post.gmane.org>
	<loom.20060920T152128-874@post.gmane.org>
	<1158762835.19382.37.camel@raven.themaw.net>
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


> Don't think so.
> Do you have any monitoring on this box.
> I've had situations where health monitoring (network monitoring believe
> it or not) was scanning directories.
> 
> Do you have hal installed?
> What version is it?
> 
> Does the problem go away if you do a
> /etc/init.d/hald stop
> 
> Basically we need to find out what is causing accesses to the
> filesystems.
> 
> Ian
> 

There are two issues... I should not have mentioned the 15 minute 
thing.... the first / main issue was posted in my first message 
today... you'll see i tested this on a stand-a-lone box and I 
mounted /opt ( which was not part of my autofs stuff ) and all 
of my autofs mounts were mounted.  ... I did a bit more checking
and there is a symbolic link on /opt: 
/opt/store/link_to_autofs_fs_directory
that would ( maybe ) explain why one of the autofs mounts gets
mounted when I mount /opt. It doesn't explain why ALL of the autofs
mounts occur. 

I have: 
/opt/store/1014_20060913200000.mpg -> /myth/store/1014_20060913200000.mpg
so the /myth/store mount point might have happened because of this...
but why the rest of the autofs /myth/* mounts? They are NOT referenced
in /opt. 

jack 
