From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Re: A weird autofs problem
Date: 17 Aug 2007 13:57:07 -0500
Message-ID: <ufay7ga7zwc.fsf@epithumia.math.uh.edu>
References: <ufa1we3xcw5.fsf@epithumia.math.uh.edu>
	<1187320655.3560.2.camel@raven.themaw.net>
	<ufalkcack3k.fsf@epithumia.math.uh.edu>
	<1187376057.3560.19.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1187376057.3560.19.camel@raven.themaw.net>
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

>>>>> "IK" == Ian Kent <raven@themaw.net> writes:

IK> What about the output of an ls as you referred bogus entries being
IK> listed.

No, the filesystem is completely inaccessible at this point.

However, I have another hint which seems to let autofs off the hook:

These happened on the NFS server around the time of the first report
of problems:
Aug 15 11:34:36 nas01 nscd: 14741 Error getting context of nscd
Aug 15 11:34:47 nas01 last message repeated 18 times
Aug 15 11:34:47 nas01 nscd: nscd shutdown succeeded
Aug 15 11:34:47 nas01 nscd: 21046 Access Vector Cache (AVC) started
Aug 15 11:34:47 nas01 nscd: nscd startup succeeded

(actually the first line has been appearing in the logs for ages; I
assume it's just more selinux stuff which I still don't understand.)

And then this morning:

Aug 17 10:16:12 nas01 kernel: nscd[14745]: segfault at 0000002afed9e933 rip 000000552aab7cf2 rsp 0000000040c00750 error 4
Aug 17 10:16:27 nas01 kernel: nscd[21050]: segfault at 0000002b99607280 rip 000000552aab7d08 rsp 0000000040c00750 error 4

so nscd definitely screwed up in some manner.  I restarted it:

Aug 17 10:30:27 nas01 nscd: 22346 Access Vector Cache (AVC) started
Aug 17 10:30:27 nas01 nscd: nscd startup succeeded
Aug 17 10:30:27 nas01 nscd: 22346 invalid persistent database file "/var/db/nscd/passwd": verification failed

and so far no reports of problems.

Sorry to try to lay any blame on autofs.  Just another tribute to how
impenetrable NFS can be.

 - J<
