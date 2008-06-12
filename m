From: Stef Bon <stef@bononline.nl>
Subject: Very good the patches.
Date: Thu, 12 Jun 2008 09:58:36 +0200
Message-ID: <4850D72C.8000301@bononline.nl>
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

Hello,

thanks for the patches.

I experienced some problems with my construction on autofs managed 
network maps:

- still problems on not wanting to run when auto.master file is empty, 
and the included /var/run/autofs.auto.master is not found
- unmounting everything when sutting down with the signal USR2 (and 
compiled with the enable-forcesd-shutdown) does not what it's supposed to do
- when I've got two networks, I've got two toplevel directories on my 
mountpoint. When both are expired and there are no mounts, one will 
disappear. This is not what I want. The best for my construction is that 
the toplevel directories (for example "Windows Network" and "SSH hosts")
will remain.


Well anyway,

I'll try the patches. Can I actually apply them? I've been looking in 
the source, and the latest patch is from may...

Stef Bon
