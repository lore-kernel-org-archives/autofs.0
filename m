From: raven@themaw.net
Subject: Re: autofs 4.1.2 cannot use option:
	username=mydomain\\myuserid
Date: Wed, 14 Jul 2004 22:47:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407142246120.1633@donald.themaw.net>
References: <40F49F90.6040707@anstat.com.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40F49F90.6040707@anstat.com.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: George Hansper <georgeh@anstat.com.au>
Cc: autofs@linux.kernel.org

On Wed, 14 Jul 2004, George Hansper wrote:

> Hi,
> 
> I've just upgraded to Fedora Core 2, and the autofs has changed from 3.1.7 to 4.1.2.
> Previously, I would automount Windows shares using an auto.smb file with an entry:
> 
> myshare  -fstype=smbfs,username=mydomain\\myuserid,password=insecure,uid=500,gid=500,fmask=775 ://winsvr/myshare
> 
> In the new autofs 4.1.2 package, the above entry provokes a bug which was not present before.
> Windows requires the username to be of the form:
> 
> 	mydomain\myuserid
> 
> The problem is that the new autofs strips ALL backslashes from the options, and supplies
> mount.smb with:
> 
> 	username=mydomainmyuserid

Odd. That's not what I thought it did.

I'll check as soon as I get a chance.

Thanks
Ian
