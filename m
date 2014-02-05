From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [Bug 53951] race condition on mounting local disks with autofs
Date: Wed, 5 Feb 2014 12:49:17 -0500
Message-ID: <20140205174917.GH11667@thunk.org>
References: <bug-53951-13602@https.bugzilla.kernel.org/>
 <bug-53951-13602-54xc3ri31k@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Return-path: <linux-ext4-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thunk.org; s=mail;
	t=1391622557; bh=PFa+ydjdMDh/2sP+dqyncoCMmJ1Iv/Fv6Yn+a67wB3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpNFAr1yeRO2FXw9b4YIyE8x4BAWiHmwETt/J92gt9xDQPp/CfWDKwxhsZMxYlFH5
	 3+6uCty0P7MYjsT29/hEWcgZScidjKN0XZyVLJ2gwZh0mMdYiwEgV194au7Sd67OjM
	 TKu0MKsrH8L6YwBz9NdJfJJf2y0CFGlXffjXjEA0=
Content-Disposition: inline
In-Reply-To: <bug-53951-13602-54xc3ri31k@https.bugzilla.kernel.org/>
Sender: linux-ext4-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ext4@vger.kernel.org, autofs@vger.kernel.org

On Wed, Feb 05, 2014 at 05:03:53PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=53951
> 
> --- Comment #1 from Harald Dunkel <harri@afaics.de> ---
> This problem is still in (using 3.12.8):
> 
> % find /misc/data6 | wc -l; find /misc/data6 | wc -l
> 17
> find: `/misc/data6/lost+found': Permission denied
> 341

Hi Harald,

There isn't an autofs bugzilla component, and it's unlikely that the
autofs folks are reading the ext4 mailing list.  Since this bug is
almost certainly an autofs problem, using bugzilla might not be the
best way to report the bug in a way that get the attention of the
right people.

I've cc'ed the autofs folks; hopefully they can help you out.

     	       	      	     	       - Ted


Original bug report, from https://bugzilla.kernel.org/show_bug.cgi?id=53951:

Harald Dunkel 2013-02-16 15:55:40 UTC

I am using autofs to mount a local disk to /misc/data6 on
request. Problem: It seems that the first access silently fails, if
the disk is not yet mounted.


Below is an example. Before running it I had umounted /misc/data6 and
restarted autofs.

% find /misc/data6 | wc -l; find /misc/data6 | wc -l
18
find: `/misc/data6/lost+found': Permission denied
358


As you can see, the first "find" sees just a subset of the directory
entries. The second "find" stumbles over lost+found (as expected) and
finds all entries.

Kernel is 3.7.7. There is no error message in kernel.log, only a line
to mention the mount:

EXT4-fs (sdd1): mounted filesystem with ordered data mode. Opts: (null)


/etc/auto.master:
/misc   /etc/auto.misc

/etc/auto.misc:
data1   -fstype=auto,noatime    :/dev/disk/by-label/data1
data2   -fstype=auto,noatime    :/dev/disk/by-label/data2
data3   -fstype=auto,noatime    :/dev/disk/by-label/data3
data4   -fstype=auto,noatime    :/dev/disk/by-label/data4
data5   -fstype=auto,noatime    :/dev/disk/by-label/data5
data6   -fstype=auto,noatime    :/dev/disk/by-label/data6
data7   -fstype=auto,noatime    :/dev/disk/by-label/data7
data8   -fstype=auto,noatime    :/dev/disk/by-label/data8


The problem is reproducible, as it seems. Please mail if I can help to track this down.

Regards
Harri
