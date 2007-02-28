From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: module development
Date: Wed, 28 Feb 2007 10:46:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702280942280.528@simba.math.ucla.edu>
References: <45E4AC36.3060707@cesca.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45E4AC36.3060707@cesca.es>
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
To: Jordi Prats <jprats@cesca.es>
Cc: autofs@linux.kernel.org

On Tue, 27 Feb 2007, Jordi Prats wrote:

> I'm new to this list. I need to develop a module for autofs for a custom
> fs type, but I'm not really familiar with autofs. I'm supposing to do
> this I need to do a module like modules/mount_generic.c but with my
> custom stuff. For the mounting process it's all right, but to umount the
> fs I also need to do some operations.

Special operations connected with mount or umount are a royal pain for the 
system administrator, not just for autofs but for boot-time mounting too, 
and hotplug mounting.  I wonder if the custom filesystem could be modified 
to be easier to use?  The ideal is if a submodule of mount can handle all 
the special operations and system call argument formatting, guided by the 
mount options.  /sbin/mount.cifs is an example.  Another possibility is if 
the filesystem driver, upon (un)mounting, starts a kernel thread that does 
whatever userspace activities and then exits.

But autofs does the mount system call itself because of the performance hit 
of forking mount(1) every time.  Here's a modest proposal:  autofs knows 
how to do NFS mounts and generic mounts (ext3, reiser, iso9660, etc. with 
only standard options).  How about a mount option to be interpreted by 
autofs, -nonstandard, which gives control to a module that spawns mount(1) 
and accepts the performance hit?

In the interesting case of Samba/CIFS and NFSv4 mounts, a password or a 
user's Kerberos credential is needed for non-world-readable content.  How 
could autofs (or better, mount(1) spawned by autofs) reach back to the 
user's context and figure out the credential cache (there could be several) 
or run a password requesting program using the correct .Xauthority file, 
e.g. /tmp/gdm.QwErTy?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
