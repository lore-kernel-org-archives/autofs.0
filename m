From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Newbie needs help with automounter.
Date: Mon, 11 Oct 2004 13:19:33 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16746.49317.692245.710715@segfault.boston.redhat.com>
References: <200410100037.i9A0bA020600@novus.adsdesign.analog.com>
	<416ABECE.2010701@sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <416ABECE.2010701@sun.com>
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
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Newbie needs help with automounter.; Mike Waychison <Michael.Waychison@sun.com> adds:

Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1

Michael.Waychison> William.Crocker wrote:
Hello:
>> I am new to autofs/automounter and need help understanding the following
>> messages which I found in /var/log/messages.
>> 
>> These messages appeared when I tried to change directory to /proj/asic
>> on cfl30.
>> 
>> If I stop and then start autofs it will work for a while and then start
>> failing again.
>> 
>> Thanks in advance.
>> 
>> Bill
>> 
>> ------------- /var/log/messages -------------
>> 
>> Oct 9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).  Oct
>> 9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.  Oct 9
>> 18:30:31 cfl30 kernel: nfs warning: mount version older than kernel Oct
>> 9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).  Oct 9
>> 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.  Oct 9 18:30:31
>> cfl30 automount[14622]: >> mount: wrong fs type, bad option, bad
>> superblock on 831ntap:/vol/vol0/proj/asic, Oct 9 18:30:31 cfl30
>> automount[14622]: >> or too many mounted file systems Oct 9 18:30:31
>> cfl30 automount[14622]: mount(nfs): nfs: mount failure
>> 831ntap:/vol/vol0/proj/asic on /proj/asic Oct 9 18:30:31 cfl30
>> automount[14622]: failed to mount /proj/asic Oct 9 18:30:31 cfl30
>> kernel: RPC: Can't bind to reserved port (98).  Oct 9 18:30:31 cfl30
>> kernel: NFS: cannot create RPC transport.  Oct 9 18:30:31 cfl30 kernel:
>> nfs warning: mount version older than kernel Oct 9 18:30:31 cfl30
>> kernel: RPC: Can't bind to reserved port (98).  Oct 9 18:30:31 cfl30
>> automount[14624]: >> mount: wrong fs type, bad option, bad superblock on
>> 831ntap:/vol/vol0/proj/asic, Oct 9 18:30:31 cfl30 kernel: NFS: cannot
>> create RPC transport.  Oct 9 18:30:31 cfl30 automount[14624]: >> or too
>> many mounted file systems Oct 9 18:30:31 cfl30 automount[14624]:
>> mount(nfs): nfs: mount failure 831ntap:/vol/vol0/proj/asic on /proj/asic
>> Oct 9 18:30:31 cfl30 automount[14624]: failed to mount /proj/asic
>> 

Michael.Waychison> This occurs when the kernel can't bind to a reserved
Michael.Waychison> port (<1024) when building the rpc transport.  In fact,
Michael.Waychison> the rpc code further limits the available ports to
Michael.Waychison> 1-800.  You can try upping the value of
Michael.Waychison> XPRT_MAX_RESVPORT in net/sunrpc/xprt.c to 1024, or
Michael.Waychison> higher if your nfs servers don't care what port the
Michael.Waychison> client is connecting from.

Michael.Waychison> This said, this is likely a symptom of one of two
Michael.Waychison> things:

Make that three things:

Michael.Waychison> - - You are mounting hundreds of nfs filesystems (the
Michael.Waychison> current code does not multiplex rpc connections at all).
Michael.Waychison> - - Automounter ran wild and is mounting filesystems
Michael.Waychison> that are not getting freed/umounnted properly.

- The automounter has a socket descriptor leak.

Bill, please indicate the version of the automounter you are using.  We've
fixed one socket descriptor leak.  I could be convinced there is another.

Thanks,

Jeff
