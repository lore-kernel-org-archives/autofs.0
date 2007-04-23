From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Strange issue with autofs5/fc6
Date: Mon, 23 Apr 2007 12:56:24 -0400
Message-ID: <x49zm4zni6f.fsf@segfault.boston.devel.redhat.com>
References: <46264599.90105@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46264599.90105@kmaclub.com> (michael@kmaclub.com's message of
	"Wed, 18 Apr 2007 09:21:45 -0700")
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
To: Michael <michael@kmaclub.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> On Wed, 18 Apr 2007 09:21:45 -0700, Michael <michael@kmaclub.com> said:

michael> I am seeing some weird behavior with
michael> autofs/mount. /proc/mounts, mounts, and auto.master don't
michael> seem to agree.

michael> /proc/mounts: filer:/export/users/mythtv /home/mythtv nfs
michael> rw,vers=3,rsize=262144,wsize=262144,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=filer
michael> 0 0

michael> mount: filer:/export/users/mythtv on /home/mythtv type nfs
michael> (rw,addr=192.168.101.1)

michael> Here is my auto.master ypcat -k auto.master /home auto.home
michael> bg,hard,intr,retry=10000,rsize=8192,wsize=8192,acregmin=3,acregmax=60,acdirmin=30,acdirmax=60,timeo=600,retrans=5,nfsvers=3,tcp

michael> The 262144 size is strange and I don't have any idea where
michael> that is coming from.

Can you send along an automount debug log?  Perhaps automount is not
passing the [rw]size parameters to mount.  For information on
gathering debug logs, see:
  http://people.redhat.com/jmoyer/

-Jeff
