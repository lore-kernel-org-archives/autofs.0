From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: autofs scalability
Date: Wed, 3 Dec 2003 13:19:27 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991DE22E18@slexch2.sugarland.unocal.com>
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
To: Ian Kent <raven@themaw.net>, Chris Croswhite <csc@cadence.com>
Cc: autofs@linux.kernel.org


> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
> Sent: Tuesday, December 02, 2003 7:49 AM
> To: Chris Croswhite
> Cc: autofs@linux.kernel.org
> Subject: RE: [autofs] making the mountpoints visible all the 
> time (fwd)
> 
> Hi guys,
> 
> I have some 2.6 patches.
> They can be found at 
> http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6
> Apply them in number order please.
> 
> Please leave out the max_anon_2.patch initially. We need to establish
what 
> the status of the kernel module is before trying this patch. It was 
> written by Mike Waychison to increase the number of anonymous devices.

> Once the status patches is established it would be good to how the 
> max_anon patch goes with over 255 mounts and less than about 790 (rpc 
> doesn't allow more than that at the moment).
> 
... <snip>

Hello all,
I was reading through Joe Pranevich's "Wonderful World of Linux 2.6" and
I came across this, I thought you might find it interesting. (source:
http://kniggit.net/wwol26.html)  The "Network Filesystems" section makes
for interesting reading as well.  If I am reading this correctly, the
'unnamed device' limit has been raised from 256 to 4096 in kernel 2.6,
can anyone confirm this?  If this is the case the only barrier left to
remove is the RPC port limitation of ~800 open ports.  If the
connections were multiplexed such that all connections to a given server
used the same port then 800 ports would stretch a lot farther than they
do now...

"Another major scalability improvement in Linux 2.6 is that the kernel
itself can now not only support more types of devices, but also support
more devices of a single type. Under all iterations of Linux (and
indeed, most UNIX-derived operating systems), users and applications
running on a system communicate with the attached hardware using
numbered device nodes. (The entries in the "/dev" directory.) These
device nodes were limited to 255 "major" devices (generally, one type of
device gets one or more device nodes) and 255 "minor" numbers
(generally, specific devices of that type.) For example, the "/dev/sda2"
device (the second partition on the first detected SCSI disk), gets a
major number of 8, common for all SCSI devices, and a minor number of 2
to indicate the second partition. Different device types allocate their
major and minor numbers differently, so it can't be said with assurance
how many devices you can have on a Linux system. Unfortunately, this
system breaks down badly on large systems where it would be possible,
for example, to have many more than 255 of any specific device in a
system. (Think large storage arrays, print farms, etc.) Under Linux 2.6,
these limitations have been eased to allow for 4095 major device types
and a more than a million subdevices per type. This increase should be
more than adequate to support high-end systems for the time being."
