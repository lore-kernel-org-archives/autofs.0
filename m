From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs hang, centos 4.4
Date: Thu, 16 Nov 2006 11:57:02 -0500
Message-ID: <x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>
References: <455C8BA8.9070609@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <455C8BA8.9070609@soe.ucsc.edu> (Erich Weiler's message of "Thu,
	16 Nov 2006 08:02:48 -0800")
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
To: Erich Weiler <weiler@soe.ucsc.edu>
Cc: autofs@linux.kernel.org

==> On Thu, 16 Nov 2006 08:02:48 -0800, Erich Weiler <weiler@soe.ucsc.edu> said:

Erich> Hi All- I'm having this problem with autofs under CentOS 4.4
Erich> linux that I was hoping someone could shed some light on...

The version of autofs would be a bit more useful than the version of
CentOS you are using.

Erich> Basically I have a bunch of auto.* tables set up in /etc.  They
Erich> work fine.  What does not work fine is that when someone tries
Erich> to automount a directory that doesn't exist, the command hangs
Erich> forever, and has to be killed.  For instance:

Erich> % cd /projects/foo [hangs]

Erich> because /projects/foo is unavailable.  Now let me make it a bit
Erich> more complex: The machine I'm mounting on is on a private
Erich> network (10.x.x.x), the nfs server is on a public network.
Erich> There is no NAT routing to the public network.  I was assuming
Erich> that because the machine could not reach the NFS server it
Erich> would just fail or timeout, not hang the terminal...

Erich> I know this is an odd setup, but it is the way it is and I'm
Erich> trying to deal with it.  :) Am I out of luck?  Or can I tweak
Erich> something to make this just fail or timeout?  Any advice would
Erich> be greatly appreciated!!

Add the mount options "hard" and "intr" to your map.  Most likely that
will take care of the problem by allowing you to hit Ctrl-C.  If it
doesn't, then please consult http://people.redhat.com/jmoyer for a
list of things we need to diagnose problems.

Thanks,

Jeff
