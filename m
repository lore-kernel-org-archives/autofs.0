From: "Burke, Alan" <Alan.Burke@analog.com>
Subject: RE: Newbie needs help with automounter.
Date: Mon, 11 Oct 2004 14:27:21 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <8FDC0F9BE1F91D44BE964AA54AAA67B60E65E8D6@wilmexm3.ad.analog.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: jmoyer@redhat.com, Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org


We're running RH8 2.4.20-20.0 kernel
NFS-utils 1.0.1-2
Autofs4.1.2


-- 
Alan J. Burke		Engineering IS Manager
Analog Devices		Email: alan.burke@analog.com
804 Woburn St.		Phone: (781) 937-2980                  
Wilmington, MA		Fax:   (781) 937-1014			  



-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Jeff Moyer
Sent: Monday, October 11, 2004 1:20 PM
To: Mike Waychison
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Newbie needs help with automounter.

==> Regarding Re: [autofs] Newbie needs help with automounter.; Mike
Waychison <Michael.Waychison@sun.com> adds:

Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1

Michael.Waychison> William.Crocker wrote:
Hello:
>> I am new to autofs/automounter and need help understanding the
following
>> messages which I found in /var/log/messages.
>> 
>> These messages appeared when I tried to change directory to
/proj/asic
>> on cfl30.
>> 
>> If I stop and then start autofs it will work for a while and then
start
>> failing again.
>> 
>> Thanks in advance.
>> 
>> Bill
>> 
>> ------------- /var/log/messages -------------
>> 
>> Oct 9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
Oct
>> 9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.  Oct 9
>> 18:30:31 cfl30 kernel: nfs warning: mount version older than kernel
Oct
>> 9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).  Oct
9
>> 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.  Oct 9
18:30:31
>> cfl30 automount[14622]: >> mount: wrong fs type, bad option, bad
>> superblock on 831ntap:/vol/vol0/proj/asic, Oct 9 18:30:31 cfl30
>> automount[14622]: >> or too many mounted file systems Oct 9 18:30:31
>> cfl30 automount[14622]: mount(nfs): nfs: mount failure
>> 831ntap:/vol/vol0/proj/asic on /proj/asic Oct 9 18:30:31 cfl30
>> automount[14622]: failed to mount /proj/asic Oct 9 18:30:31 cfl30
>> kernel: RPC: Can't bind to reserved port (98).  Oct 9 18:30:31 cfl30
>> kernel: NFS: cannot create RPC transport.  Oct 9 18:30:31 cfl30
kernel:
>> nfs warning: mount version older than kernel Oct 9 18:30:31 cfl30
>> kernel: RPC: Can't bind to reserved port (98).  Oct 9 18:30:31 cfl30
>> automount[14624]: >> mount: wrong fs type, bad option, bad superblock
on
>> 831ntap:/vol/vol0/proj/asic, Oct 9 18:30:31 cfl30 kernel: NFS: cannot
>> create RPC transport.  Oct 9 18:30:31 cfl30 automount[14624]: >> or
too
>> many mounted file systems Oct 9 18:30:31 cfl30 automount[14624]:
>> mount(nfs): nfs: mount failure 831ntap:/vol/vol0/proj/asic on
/proj/asic
>> Oct 9 18:30:31 cfl30 automount[14624]: failed to mount /proj/asic
>> 

Michael.Waychison> This occurs when the kernel can't bind to a reserved
Michael.Waychison> port (<1024) when building the rpc transport.  In
fact,
Michael.Waychison> the rpc code further limits the available ports to
Michael.Waychison> 1-800.  You can try upping the value of
Michael.Waychison> XPRT_MAX_RESVPORT in net/sunrpc/xprt.c to 1024, or
Michael.Waychison> higher if your nfs servers don't care what port the
Michael.Waychison> client is connecting from.

Michael.Waychison> This said, this is likely a symptom of one of two
Michael.Waychison> things:

Make that three things:

Michael.Waychison> - - You are mounting hundreds of nfs filesystems (the
Michael.Waychison> current code does not multiplex rpc connections at
all).
Michael.Waychison> - - Automounter ran wild and is mounting filesystems
Michael.Waychison> that are not getting freed/umounnted properly.

- The automounter has a socket descriptor leak.

Bill, please indicate the version of the automounter you are using.
We've
fixed one socket descriptor leak.  I could be convinced there is
another.

Thanks,

Jeff

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
