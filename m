From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/3] autofs4 - expiring filesystem from under process
Date: Sun, 10 Apr 2005 15:28:11 -0700
Message-ID: <20050410152811.66b569a8.akpm@osdl.org>
References: <Pine.LNX.4.62.0504102030350.540@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504102030350.540@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: linux-fsdevel@vger.kernel.org, jmoyer@redhat.com, michael@kmaclub.com, autofs@linux.kernel.org

raven@themaw.net wrote:
>
>  A problem with tree mounts expiring from under a process has uncovered a
>  couple of problems with the autofs4 module. These patches are a result of 
>  the investigation.

- All three email had the same Subject:.  Please don't do that.  See
  http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

- The patches add trailing whitespace, which I removed.

- For some weird reason which I can't bother diagnosing, all of the
  patches got 100% rejects, which were fixed by using `patch -l'.

- One patch still threw a reject in fs/autofs4/autofs_i.h, which I fixed.


