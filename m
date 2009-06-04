From: Ian Kent <raven@themaw.net>
Subject: Re: /tmp/autoXXXXXX artifacts in /etc/mtab
Date: Thu, 04 Jun 2009 12:21:08 +0800
Message-ID: <4A274BB4.2080500@themaw.net>
References: <3BE3DD53E8C764428441BEFE7FE94F163DF67D2B@MAILSJ4.global.cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3BE3DD53E8C764428441BEFE7FE94F163DF67D2B@MAILSJ4.global.cadence.com>
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
To: Jim Dennis <jdennis@cadence.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

Jim Dennis wrote:
> 
>  All,
> 
>  Running autofs version 5 (versions from RHEL4u7, RHEL5 and the upstream 5.0.4 with almost
>  all of the patches applied) we're seeing quite a few issues with stray /tmp/auto* entries being
>  left in the /etc/mtab file.

But what OS are you using for this and what autofs v5 revisions are you
using?

We know RHEL-4 has a broken move mount and a util-linux dependency has
been added in later revisions. RHEL-4 U7 will be a problem with
autofs-5.0.4 without an updated util-linux.

Anyway, you can check.

From the bug for this:

Steps to Reproduce:
1. mkdir /tmp/mnt /tmp/tmp
2. mount <server>:/<path> /tmp/tmp
3. mount --move /tmp/tmp /tmp/mnt

Actual results:
After the steps above /etc/matb has:
<server>:/<path> /tmp/tmp nfs ....
/tmp/tmp /tmp/mnt none ...

but /proc/mounts has:
<server>:/<path> /tmp/mnt nfs ....

Expected results:
/etc/matb should have a single entry
<server>:/<path> /tmp/mnt nfs ....

> 
>  The symptom is lots of error messages from df commands.
> 
>  Looking through the sources I see that autofs version 5 seems to implement its own internal
>  mount handling (it's not just spawning process to run the /sbin/mount external command
>  for any of the types of mounts for which it has a .so module).  I noticed that there are  three
>  different places in the code which use tempfile template strings matching /tmp/autoXXXXXX.
> 
>  I haven't get been able to track the issue down further ... but I suspect there's a bug in the
>  code that's updating /etc/mtab and which is supposed to be cleaning out these entries.
>  We have a horrendously busy and complex automount infrastucture and we've uncovered
>  locking issues on /etc/mtab in the past (from the /sbin/mount code as well as during the
>  period of time when autofs4 was trying to wrap its own locking around its calls to the external
>  mount command.
> 
>  I'll try to get a more detailed formal bug report together in the next week or so.  However, I
>  figured I should put out an early message in case others are seeing this or already working on it.
> 
> 
> --
> Jim Dennis,
> Senior Staff Linux Engineer, IT
> Cadence Design Systems, Inc.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
