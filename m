From: "Keeler, Wayne T \(Wayne\)" <wtkeeler@agere.com>
Subject: RE: Replicated hosts in autofs
Date: Mon, 15 Nov 2004 09:03:57 -0500
Message-ID: <69612FDB757A504ABA194C8B3AC7FED994E0E8@pauex2ku06.agere.com>
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Thanks Ian.

From the Solaris mount_nfs man page:

    Replicated file systems and failover
           resource can list multiple read-only file  systems  to
           be  used  to  provide  data. These file systems should
           contain equivalent directory structures and  identical
           files.  It is also recommended that they be created by
           a utility such as rdist(1). The file  systems  may  be
           specified   either  with  a  comma-separated  list  of
           host:/pathname entries and/or NFS URL entries, or with
           a  comma  -separated list of hosts, if all file system
           names are the same. If multiple file systems are named
           and  the  first  server  in the list is down, failover
           will use the next alternate server to access files. If
           the  read-only  option is not chosen, replication will
           be disabled. File access will block on the original if
           NFS locks are active for that file.

Wayne

-----Original Message-----
From: raven@themaw.net [mailto:raven@themaw.net] 
Sent: Monday, November 15, 2004 8:34 AM
To: Keeler, Wayne T (Wayne)
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Replicated hosts in autofs 

On Fri, 12 Nov 2004, Keeler, Wayne T (Wayne) wrote:

> 
> Hi,
> 
> I have read many threads regarding replicated hosts for autofs v3 and
> v4. 
> 
> Here is my scenario:
> 
> On a linux host (Opteron running RHEL 3 WS kernel 2.4.21-20.ELsmp, I
> have the following automount configured:
> 
> mountpoint -fstype=nfs,-proto=tcp,ro host1,host2:/tmp/ro
> 
> The goal in my implementation is that after the initial mount occurs
to
> host1 or host2, if that particular host fails, nfs will pick up the
> mount on the alternate host. Note that since both mount points are
read
> only, this serves as a lower cost, higher availability solution. This
> works on Solaris.

Nop. Not available in Linux.

> 
> I have had no success with this on Linux. It seems that the
replication
> only works on the initial mount/rpc call. Once the initial mount
occurs,
> it doesn't appear there is any fail-over capability.

Yep. I believe you are correct.

> 
> I have even installed RedHat's Beta version of E4 (kernel
> 2.6.9-1.648_ELsmp). The result is the same. If I crash the machine
that
> originally had the mount-point, the end result is a hung mount and
> fail-over never occurs.
> 
> I can't seem to find any information that indicates that this should
or
> should not work by design.
> 
> Can someone please definitively tell me if the capability I am seeking
> is available via the autofs supplied by RedHat in Enterprise 3?

I don't think that this is practicle to do in autofs.

This is the source of statements like "this functionality belongs in NFS

or mount". The limited implementation in autofs is there because of the 
lack of it in NFS.

The question then is "does autofs or mount/NFS handle this in Solaris"?

Mike?

Ian
