From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: A weird autofs problem
Date: 16 Aug 2007 18:44:58 -0500
Message-ID: <ufa1we3xcw5.fsf@epithumia.math.uh.edu>
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

I'm trying to debug a very weird problem I've started seeing with
autofs over the last couple of days.  The machines I'm seeing this on
are all running Fedora Core 5 i386, fully updated (autofs 4.1.4-33 and
kernel-smp 2.6.20-1.2320.fc5).  Yes, I'm in the process of rolling out
F7, but that will still take at least a couple of weeks and in the
meantime I'd like to get to the bottom of this if possible.

We use autofs to automount user home directories under /home.  Some
users are reporting that their home directories are just disappearing
out from under them; attempts to write to them result in "permission
denied".  Only once have I seen a system in this state (users keep
rebooting the machines) and I don't have a screen capture, but I
recall that df showed the user directory as being "there" but showed
dashes instead of numbers for the capacity figures.  Unfortunately I
don't recall what showed up in the Filesystem column.

I can't think of anything which has changed on the affected systems.
Since they're running FC5 nothing is getting updated.  The automount
maps are served via LDAP and as far as I can tell the queries aren't
failing.  The server doesn't report any problems.  Nothing has changed
recently on either the LDAP servers or the NFS servers.

So I'm at a complete loss here.  If I can access a system while the
problem is manifesting I'm sure I can find some more useful
information but until then I was hoping that either someone might have
seen something liks this and had an idea of what might be causing it
or someone might have some idea of how I might go about debugging
this.  I have debugging turned on but haven't seen anything useful
yet.

 - J<
