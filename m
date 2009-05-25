From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: AutoFS expire/timeout semantics
Date: Mon, 25 May 2009 10:08:03 -0300
Message-ID: <c2d0b6ec0905250608w159e5630xf77c470d192c09e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hello,

I'm running some tests against AutoFS 5 and when I set a mount
point with a short expire timeout (let's say 2 minutes), I'm observing
the following behavior:

- Keeping an open file in the mount point will prevent it to expire.
  This is expected, of course, as the file system is busy.
- Setting a cron job to run "ls" or read some file from the mount point
  won't prevent the file system to expire and be unmounted after
  the 2 minutes timeout. This comes a bit as a surprise to me, as
  I was expecting every access to files in the mount point to reset
  the expire timeout.

Question is: what operations (if any) resets the expiration timeout?

Thanks,
Leonardo
