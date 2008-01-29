From: Ian Kent <raven@themaw.net>
Subject: Re: first access fails with ENOENT after autofs started
Date: Wed, 30 Jan 2008 00:28:24 +0900
Message-ID: <1201620505.3435.6.camel@raven.themaw.net>
References: <479EF388.5080805@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <479EF388.5080805@oracle.com>
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
To: wengang wang <wen.gang.wang@oracle.com>
Cc: autofs@linux.kernel.org


On Tue, 2008-01-29 at 17:36 +0800, wengang wang wrote:
> Hi experts,
> 
> In RHEL kernel 2.6.18-53 and mainline kernel 2.6.24,

This was a known problem due to a couple of missing patches in the
RHEL-5 kernel revision 53.

I'm not aware of a problem with 2.6.24.

> in function autofs4_lookup() in fs/autofs4/root.c,
> if dentry is not found in function autofs4_lookup_unhashed(),
> a d_instantiate() is done on the dentry passed as parameter instead of 
> d_add().

d_instantiate is used to delay hashing the dentry until the following
mkdir as this prevents a potential deadlock.

> 
> seems this cause a problem that the first access just after autofs 
> started to
> /path/to/<autofsMountPoint>/<nfsMountPoint> fail with the error ENOENT.
> 
> If I rolled back to use d_add(), there is no such problem.
> Is this a bug or I omitted something?

Considering there's virtually no information to go on here I have no
idea but this hasn't been seen to be a problem other than in the RHEL
kernel above.

You will need to provide a lot more information than this if you want me
to investigate.

Ian
