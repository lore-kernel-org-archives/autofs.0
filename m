From: Matthew Mitchell <matthew@geodev.com>
Subject: Re: "simultaneous" mounts causing weird behavior
Date: Wed, 05 Nov 2003 10:57:43 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1068051462.2640.181.camel@aluminum>
References: <Pine.LNX.4.33.0311050836180.8092-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311050836180.8092-100000@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tue, 2003-11-04 at 18:46, Ian Kent wrote:

> The /tmp entry is caused by mount failing to handle overlapping requests.
> Aaron Ogden and I have been there recently with autofs v4.
> 
> The overlapping mount problem is likely causing the other problem as well.
> I put some altogether ugly code, which shouldn't work at all, but seems
> to, into autofs v4 to deal with this. In fact I hated it so much, I
> removed it at one point and Aaron was horrified to find everything broken
> again.

Looking at the 4.1.0-beta2 code, I don't see any mutex-looking code in
handle_packet_missing.  Isn't that where it should be?  Or are you
taking care of it elsewhere?  (Or are you allowing the bind mounts to go
through in the odd case where you get past the lstat() test while still
waiting on the lookup_mount to finish?)

My memory of signal gymnastics is fuzzy, but would this work?

(pseudocode)

if (lstat tests fail) {
  if (mount is pending) {
    /* someone is already trying to mount this path */
    spin && retry from start;
  } else {
    set mount is pending;
    f = fork();
    if (f == -1) { couldn't fork, error case; }
    if (!f) {
	/* child */
	close fds;
	attempt mount;
	if (mount succeeds) { exit 0 };
	else if (mount fails) { exit 1 };
    }
    else {
      /* parent */
      success = wait(f);
      unset mount is pending;
    }
} else {
  /* already there */
}

I just am not seeing how you can properly guarantee that you don't end
up with an unnecessary bind mount without waiting to see if the mount
succeeds or not.  I do realize you might not want to wait forever if
there is a problem mounting the device...

Am I missing something?

-m
