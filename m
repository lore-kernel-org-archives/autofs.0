From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: running out of mount points
Date: Mon, 19 Jan 2004 11:11:12 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6C00@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Greg Bradner <gregb@rhythm.com>, autofs@linux.kernel.org


> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Greg Bradner
> Sent: Monday, January 19, 2004 9:49 AM
> To: autofs@linux.kernel.org
> Subject: [autofs] running out of mount points
> 
> 
> I wanted to repost this plea. I am really in a bind and could use some

> help. I need to mount these users on the mail server.
> BTW: this is with autofs 4.1.0
> 

Hello Greg,
I have run into this problem as well, actually it isn't autofs but the
kernel itself.
The kernel hackers can explain the details but the simplified version is
that
the kernel runs out of 'unnamed devices' and when it does it cannot make
any additional
NFS mounts.  You can get around this by applying a patch or using a
kernel that already
has the patch applied.  RedHat's kernels (updates.redhat.com) have this
patch and more,
I have had good results with them.  You can grab the source RPM and
apply the autofs 4.1.0
patch to it to get the functionality you want.  The 'unnamed devices'
patch used by
RedHat is supposed to allow around 1200 simultaneous NFS mounts.
Without this patch the
kernel has an 8-bit address space for unnamed devices so you hit the
limit at 255 mounts.

Once you get past this hurdle you may run into another problem, you may
find (as I did)
that you can't actually mount 1200 filesystems... RPC will start running
into problems
around 800 mounts or slightly less.  I've been told that this happens
because RPC is using
a separate port for each NFS mount, it starts at port 800 and counts
down to 1, so when the
system runs out of ports it is once again unable to mount anything.
Supposedly there is
some work being done to rewire linux RPC so that it uses one port *per
server* rather than
one port per NFS mount, that change would fix the problem for any
reasonable configuration.

hope this helps,
aaron
