From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Automounter losing track of mounts...
Date: Wed, 13 Aug 2008 09:42:37 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

I am running Linux kernel version 2.6.24 and automounter 5.0.3 with all
patches from the kernel.org repository as of 29 June 2008 (Actually 30
June 2008 due to international date issues with Ian being in Australia
and me in the USA).

We came across a strange issue where the automounter seems to report an
automounted mount point being expired and unmounted without problems and
the directory is removed, but the next time it tries to remount it, the
remount fails because it says it's already mounted... But the directory
isn't there.  "umount -a" clears up this problem.

FWIW, there is also this error:
"spawn_mount: mount failed with error code 16, retrying with the -f
option"

This seems to indicate failure to lock /etc/mtab (??) and then failing
to retry correctly, but setting its mount table as if it succeeded.

Is this already in a patch somewhere or is this a fresh bug?
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
