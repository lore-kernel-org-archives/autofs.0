From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: Automounter losing track of mounts...
Date: Thu, 14 Aug 2008 11:24:24 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A58D0@hqemmail01.nvidia.com>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
	<1218691003.27280.92.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58C9@hqemmail01.nvidia.com>
	<1218735745.3216.13.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218735745.3216.13.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Some additional info:

automount[30947]: >> /bin/mount: error while loading shared libraries:
libc.so.6: cannot map zero-fill pages: Cannot allocate memory
automount[30947]: spawn_mount: mount failed with error code 16, retrying
with the -f option

This is happening with interspersed expiry going on.

The specific mount error above does not happen all the time.  I have
more "spawn_mount: mount failed" errors than I have "/bin/mount: error"
lines.

Yes, I know that we are running an ancient version of libc.  In any
case, it looks like the '-f' version succeeded but the automounter
didn't notice and continued in failure mode.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
