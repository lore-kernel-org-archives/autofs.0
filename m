From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 13:33:09 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404091319060.5256@raven.themaw.net>
References: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Thu, 8 Apr 2004, Raymond Prach wrote:

> 
> 1. The script reads from the home directories of a large number of users
> 2. Users' home directories, by and large, are located on their 
> workstations, which are AIX 5.1

I'm curious. Does the AIX 5 automounter still polute the mount table with 
heaps of entries if you have a large direct mount table (as it did in AIX 
4)?

> 3. Thus, via autofs, the server mounts a whole bunch of home directories 
> using NFS (v2, over UDP, if that matters) from a whole bunch of AIX 
> workstations -- say 20 at a time
> 4. Eventually, the script attempts to mount a home directory from a 
> workstation that is down or has been removed from the network, so it waits 
> around for a long time for the mount attempt to time out
> 5. While it is waiting for this mount attempt to fail, a bunch of mounts 
> that autofs previously mounted time out due to inactivity, so autofs 
> unmounts them
> 6. At this point, the "self destruct" message appears in the syslog
> 7. Lather, rinse, repeat.
> 
> I hope that is somewhat helpful, or at least informative.

I've tried to duplicate this just now and am having trouble.

First, the version of mount that I'm using doesn't seem to hang the way it 
used to. What version of util-linux (or mount) are you using? I have 
2.11y.

Second thing I notice is that autofs-4.1.2 discovers the bogus mount very 
quickly (<1 sec) and so even with a stop watch I can't get the mount to 
be active at the same time as the expire.

Hopefully some of this info will help.

Ian
