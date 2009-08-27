From: Aaron Straus <aaron@merfinllc.com>
Subject: autofs does not umount
Date: Thu, 27 Aug 2009 15:28:26 -0700
Message-ID: <20090827222825.GA23043@merfinllc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

Hi all,

  I was testing kernel 2.6.31-rc7 and noticed that autofs4 doesn't seem
to be umounting file systems anymore.  

  In particular after the timeout expires file systems seem to stay
mounted.  Furthermore if I do a umount of the file system by hand it
works i.e. the file system isn't busy.  Also sending a USR1 signal to
the automount process does not cause an umount either.

  I've initially observed this behavior with NFS mounts, but set up just
a single, local bind mount (in the automount tables) and the bad
behavior is still there.

  I reverted to 2.6.30.5 and automount works as expected.  This is on a
Ubuntu Hardy system running the autofs 4.1.4+debian-2.1ubuntu1 package.

  Anybody else having this problem?  Any additional info I can provide?

					Thanks,
					=a=


 
-- 
===================
Aaron Straus
aaron@merfinllc.com
