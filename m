From: jack snodgrass <mylinuxguy+autofs@gmail.com>
Subject: Re: autofs mounts drives that should not be mounted.
Date: Wed, 20 Sep 2006 13:25:28 +0000 (UTC)
Message-ID: <loom.20060920T152128-874@post.gmane.org>
References: <loom.20060920T144018-489@post.gmane.org>
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

jack snodgrass <mylinuxguy+autofs <at> gmail.com> writes:

> 
> I am having an issue with autofs mouting drives that should not be mounted.
> It may be a kernel or FC5 or somethng else.... what ever it is... I need to 
> resovle the issue....
> 
> I have:
> Fedora Core release 5 (Bordeaux)
> It's a base install... no hal, no nautilis, no vfs, no graphics, etc.
> 

more info and thoughts... 

uname -a shows: 
Linux nas 2.6.17-1.2174_FC5smp #1 SMP Tue Aug 8 16:00:39 
EDT 2006 i686 i686 i386 GNU/Linux

rpm -qa autofs
autofs-4.1.4-29

... I wonder if this is a NFS / Kernel / Cache issue of some sort....
if so... how would I narrow this down? There is still this 15 minute
cycle that it goes through. 

Thanks again - jack
