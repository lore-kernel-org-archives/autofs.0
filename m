From: Ian Kent <raven@themaw.net>
Subject: Re: correct format for mounting cifs/smbfs shares
Date: Wed, 7 Sep 2005 23:57:56 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0509072356350.2552@donald.themaw.net>
References: <17182.62683.375367.892022@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17182.62683.375367.892022@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 7 Sep 2005, Jeff Moyer wrote:

> Hi,
> 
> I had a user report a bug as follows:

Jehan got it.
Remember the : Sun escape for map entries starting with /.

> 
> ---
> Description of problem:
> automount does not understand //hostname in its config files, which is needed by mount.cifs and mount.smbfs
> I found a "solution", but I don't like it:
> use \/\/hostname in /etc/auto.misc file
> 
> 
> Version-Release number of selected component (if applicable):
> autofs-4.1.3-114
> samba-client-3.0.14a-2.1.fc3.kde
> 
> How reproducible:
> Always
> 
> Steps to Reproduce:
> 1. put following line in /etc/auto.misc file:
> share  -fstype=cifs                                                                                                     //HOST/SHARE
> (of course, I hope that you have host HOST with share SHARE and you can make
> mount -t cifs //HOST/SHARE /misc/share)
> 
> 2. ls /misc/share 
>   
> 
> Actual Results:  in /var/log/messages:
> automount[1624]: mount(generic): failed to mount  (type cifs) on /misc/share/HOST/share
> 
> Expected Results:  //HOST/SHARE mounted in /misc/share
> ;-)
> 
> Additional info:
> 
> Same results with -fstype=smb
> ---
> 
> I have no experience with this.  What is the expected configuration to get
> this to work?
> 
> Thanks,
> 
> Jeff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
