From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 13:04:51 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40045D73.4010103@zytor.com>
References: <200401132042.i0DKgDR0001085265@anw.zk3.dec.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200401132042.i0DKgDR0001085265@anw.zk3.dec.com>
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
To: Eric Werme USG <werme@zk3.dec.com>
Cc: autofs@linux.kernel.org, alexander.marx@hp.com

Eric Werme USG wrote:
> 
> Ah.  Back to automount/autofs.  I made many fixes to Sun's old automount,
> one of them was to rummage among all the NICs looking to see if the
> FS was really a local mount and provide the appropriate symlink.  The
> cluster folks didn't realize I also checked the alias addresses too,
> so I had to add an option to disable that to force a real NFS call.
> 

Perhaps I should clarify the algorithm used by autofs: it actually goes
through and creates a socket and connects it to each of the IP addresses
for a server (it uses a UDP socket, so it doesn't actually cause any
network traffic.)  Then it queries that socket to see what the local and
remote addresses the kernel chose for the socket.  If for any of the
possible addresses <local address == remote address> then the address is
deemed local and autofs will bind-mount.  It is thus strictly based on
what the kernel would choose as the local address.  If you can force the
local address to be something other than the remote address -- as you
need for relocatability anyway -- then autofs will quite correctly avoid
bind-mounting it.

Mike raised the at least theoretical issue of what about synthetic NFS
servers in userspace and similar issues.  I'm not convinced this is an
issue in practice, but we came up with the suggestion of making an
*explicit* -fstype=nfs force NFS mounting regardless.  This has the
advantage that it cleans up the daemon somewhat; instead of:


	parse_sun
	    |
	mount_nfs
            |
	mount_bind

one would have:

	parse_sun
	    |
	mount_default
	/	\
   mount_nfs  mount_bind


	-hpa
