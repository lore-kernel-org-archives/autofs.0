From: Chris Feist <cfeist@redhat.com>
Subject: get_best_mounts fixes.
Date: Fri, 04 Feb 2005 11:32:51 -0600
Message-ID: <4203B1C3.30303@redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org, raven@themaw.net

I'm working on a patch to get the get_best_mounts function (in 
modules/mount_nfs.c) work a little better and handle a few end cases.

What was the skiplocal variable intended to do?

It seems that if it is not 0, the only thing that get_best_mount does is 
check and see if the 'what' string is null & if it isn't return 0.  And 
the only time the get_best_mounts function is called with skiplocal set 
to 1. is when it is calling itself when all the hosts have not responded 
within 100ms.

Is it reasonable to completely remove this variable?
